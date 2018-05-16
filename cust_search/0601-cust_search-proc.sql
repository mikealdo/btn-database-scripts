connect BTN4_JMSADMIN/BTN4_JMSADMIN

-- add message to jms queue
-- NOTE: uses syntax compatible with Oracle XE for development and testing
CREATE OR REPLACE PROCEDURE enqueue_cust_search_jms(message_body IN VARCHAR2)
IS
  message SYS.AQ$_JMS_TEXT_MESSAGE;
  message_hdr SYS.AQ$_JMS_HEADER;
  message_agent SYS.AQ$_AGENT;
  message_proparray SYS.AQ$_JMS_USERPROPARRAY;
  message_property SYS.AQ$_JMS_USERPROPERTY;
  queue_options sys.DBMS_AQ.ENQUEUE_OPTIONS_T;
  message_props sys.DBMS_AQ.MESSAGE_PROPERTIES_T;
  message_id RAW(16);
BEGIN
  message_agent := SYS.AQ$_AGENT(' ', null, 0);
  message_proparray := SYS.AQ$_JMS_USERPROPARRAY();
  message_proparray.EXTEND(1);
  message_property := SYS.AQ$_JMS_USERPROPERTY('JMS_OracleDeliveryMode', 100, '2', NULL, 27);
  message_proparray(1) := message_property;

  message_hdr := SYS.AQ$_JMS_HEADER(message_agent, null, '<USERNAME>', null, null, null, message_proparray);
  message := SYS.AQ$_JMS_TEXT_MESSAGE(message_hdr, null, null, null);

  message.text_vc := message_body;
  message.text_len := length(message.text_vc);

  sys.DBMS_AQ.ENQUEUE(queue_name => 'BTN4_JMSADMIN.jms_cust_search_queue',
                      enqueue_options => queue_options,
                      message_properties => message_props,
                      payload => message,
                      msgid => message_id);
END;
/


-- format delete request as json for consumer
-- NOTE: it is assumed that any delete would cascade through the object
-- graph and so it is only handled on BT_CUST as central location
CREATE OR REPLACE PROCEDURE build_jms_delete(
  operation IN VARCHAR2,
  old_bt_cust_id IN BT_OWNER.BT_CUST.ID%TYPE,
  message_body OUT VARCHAR2)
IS
BEGIN
  message_body := '{'
    || '"id": "' || old_bt_cust_id || '"'
    || ', "operation": "' || operation || '"'
    || '}';
END;
/


-- handle BT_CUST changes

-- format insert/update fields as json for consumer
CREATE OR REPLACE PROCEDURE build_jms_msg_btc(
  operation IN VARCHAR2,
  new_bt_cust_id IN BT_OWNER.BT_CUST.ID%TYPE,
  new_store_no IN BT_OWNER.BT_CUST.STORE_NO%TYPE,
  new_cust_record_type IN BT_OWNER.BT_CUST.CUST_RECORD_TYPE%TYPE,
  new_card_type IN BT_OWNER.BT_CUST.CARD_TYPE%TYPE,
  new_cust_status IN BT_OWNER.BT_CUST.CUST_STATUS%TYPE,
  new_place_status IN BT_OWNER.BT_CUST.PLACE_STATUS%TYPE,
  new_cust_no IN BT_OWNER.BT_CUST.CUST_NO%TYPE,
  new_place_no IN BT_OWNER.BT_CUST.PLACE_NO%TYPE,
  message_body OUT VARCHAR2)
IS
BEGIN
  message_body := '{'
    || '"id": "' || new_bt_cust_id || '"'
    || ', "operation": "' || operation || '"'
    || ', "storeNo": "' || new_store_no || '"'
    || ', "custRecordType": "' || new_cust_record_type || '"'
    || ', "isOnlyDelivery": "' || (CASE WHEN new_card_type = 'D' THEN 1 ELSE 0 END) || '"'
    || ', "status": "' || (CASE WHEN new_cust_record_type = 'Z' THEN new_cust_status ELSE new_place_status END) || '"'
    || ', "custNo": "' || new_cust_no || '"'
    || ', "placeNo": "' || replace(replace(new_place_no, '"'), '\') || '"'
    || '}';
END;
/


-- change detection (on update only queue when relevant fields change)
CREATE OR REPLACE PROCEDURE has_search_diff_btc(
  new_bt_cust_id IN BT_OWNER.BT_CUST.ID%TYPE,
  new_store_no IN BT_OWNER.BT_CUST.STORE_NO%TYPE,
  new_cust_record_type IN BT_OWNER.BT_CUST.CUST_RECORD_TYPE%TYPE,
  new_card_type IN BT_OWNER.BT_CUST.CARD_TYPE%TYPE,
  new_cust_status IN BT_OWNER.BT_CUST.CUST_STATUS%TYPE,
  new_place_status IN BT_OWNER.BT_CUST.PLACE_STATUS%TYPE,
  new_cust_no IN BT_OWNER.BT_CUST.CUST_NO%TYPE,
  new_place_no IN BT_OWNER.BT_CUST.PLACE_NO%TYPE,
  old_store_no IN BT_OWNER.BT_CUST.STORE_NO%TYPE,
  old_cust_record_type IN BT_OWNER.BT_CUST.CUST_RECORD_TYPE%TYPE,
  old_card_type IN BT_OWNER.BT_CUST.CARD_TYPE%TYPE,
  old_cust_status IN BT_OWNER.BT_CUST.CUST_STATUS%TYPE,
  old_place_status IN BT_OWNER.BT_CUST.PLACE_STATUS%TYPE,
  old_cust_no IN BT_OWNER.BT_CUST.CUST_NO%TYPE,
  old_place_no IN BT_OWNER.BT_CUST.PLACE_NO%TYPE,
  is_equal OUT BOOLEAN)
IS
BEGIN
  IF (
    ((new_cust_status IS NOT NULL AND old_cust_status IS NULL) OR
     (new_cust_status IS NULL AND old_cust_status IS NOT NULL) OR
     (new_cust_status != old_cust_status)
    ) OR
    ((new_place_status IS NOT NULL AND old_place_status IS NULL) OR
     (new_place_status IS NULL AND old_place_status IS NOT NULL) OR
     (new_place_status != old_place_status)
    ) OR
    ((new_place_no IS NOT NULL AND old_place_no IS NULL) OR
     (new_place_no IS NULL AND old_place_no IS NOT NULL) OR
     (new_place_no != old_place_no)
    )
  ) THEN
    is_equal := FALSE;
  ELSE
    is_equal := TRUE;
  END IF;
END;
/


-- entrypoint for customer search sync for BT_CUST
CREATE OR REPLACE PROCEDURE sync_search_btc(
  operation IN VARCHAR2,
  new_bt_cust_id IN BT_OWNER.BT_CUST.ID%TYPE,
  new_store_no IN BT_OWNER.BT_CUST.STORE_NO%TYPE,
  new_cust_record_type IN BT_OWNER.BT_CUST.CUST_RECORD_TYPE%TYPE,
  new_card_type IN BT_OWNER.BT_CUST.CARD_TYPE%TYPE,
  new_cust_status IN BT_OWNER.BT_CUST.CUST_STATUS%TYPE,
  new_place_status IN BT_OWNER.BT_CUST.PLACE_STATUS%TYPE,
  new_cust_no IN BT_OWNER.BT_CUST.CUST_NO%TYPE,
  new_place_no IN BT_OWNER.BT_CUST.PLACE_NO%TYPE,
  old_bt_cust_id IN BT_OWNER.BT_CUST.ID%TYPE,
  old_store_no IN BT_OWNER.BT_CUST.STORE_NO%TYPE,
  old_cust_record_type IN BT_OWNER.BT_CUST.CUST_RECORD_TYPE%TYPE,
  old_card_type IN BT_OWNER.BT_CUST.CARD_TYPE%TYPE,
  old_cust_status IN BT_OWNER.BT_CUST.CUST_STATUS%TYPE,
  old_place_status IN BT_OWNER.BT_CUST.PLACE_STATUS%TYPE,
  old_cust_no IN BT_OWNER.BT_CUST.CUST_NO%TYPE,
  old_place_no IN BT_OWNER.BT_CUST.PLACE_NO%TYPE)
IS
  jms_message_body VARCHAR2(4096);
  is_equal BOOLEAN;
BEGIN
  IF (operation = 'UPDATE') THEN
    has_search_diff_btc(new_bt_cust_id, new_store_no, new_cust_record_type, new_card_type,
      new_cust_status, new_place_status, new_cust_no, new_place_no,
      old_store_no, old_cust_record_type, old_card_type,
      old_cust_status, old_place_status, old_cust_no, old_place_no,
      is_equal);
  ELSE
    is_equal := FALSE;
  END IF;

  IF (operation = 'DELETE') THEN
      build_jms_delete(operation,
        old_bt_cust_id,
        jms_message_body);
      enqueue_cust_search_jms(jms_message_body);
  ELSIF (operation != 'ERROR') THEN
    IF (is_equal = FALSE) THEN
      build_jms_msg_btc(operation,
        new_bt_cust_id, new_store_no, new_cust_record_type, new_card_type,
        new_cust_status, new_place_status, new_cust_no, new_place_no,
        jms_message_body);
      enqueue_cust_search_jms(jms_message_body);
    END IF;
  END IF;
END;
/



-- handle MD_CUST_OWNER.CUST_ADDRESS_PLACE changes

-- format insert/update fields as json for consumer
CREATE OR REPLACE PROCEDURE build_jms_msg_mdcap(
  operation IN VARCHAR2,
  new_bt_cust_id IN MD_CUST_OWNER.CUST_ADDRESS_PLACE.CUST_ID%TYPE,
  new_place_town IN MD_CUST_OWNER.CUST_ADDRESS_PLACE.TOWN%TYPE,
  new_place_address IN MD_CUST_OWNER.CUST_ADDRESS_PLACE.ADDRESS%TYPE,
  new_place_post_cd IN MD_CUST_OWNER.CUST_ADDRESS_PLACE.POST_CD_ADDR%TYPE,
  message_body OUT VARCHAR2)
IS
BEGIN
  message_body := '{'
    || '"id": "' || new_bt_cust_id || '"'
    || ', "operation": "' || operation || '"'
    || ', "placeTown": "' || replace(replace(new_place_town, '"'), '\') || '"'
    || ', "placeAddress": "' || replace(replace(new_place_address, '"'), '\') || '"'
    || ', "placePostCd": "' || replace(replace(new_place_post_cd, '"'), '\') || '"'
    || '}';
END;
/


-- change detection (on update only queue when relevant fields change)
CREATE OR REPLACE PROCEDURE has_search_diff_mdcap(
  new_bt_cust_id IN MD_CUST_OWNER.CUST_ADDRESS_PLACE.CUST_ID%TYPE,
  new_place_town IN MD_CUST_OWNER.CUST_ADDRESS_PLACE.TOWN%TYPE,
  new_place_address IN MD_CUST_OWNER.CUST_ADDRESS_PLACE.ADDRESS%TYPE,
  new_place_post_cd IN MD_CUST_OWNER.CUST_ADDRESS_PLACE.POST_CD_ADDR%TYPE,
  old_place_town IN MD_CUST_OWNER.CUST_ADDRESS_PLACE.TOWN%TYPE,
  old_place_address IN MD_CUST_OWNER.CUST_ADDRESS_PLACE.ADDRESS%TYPE,
  old_place_post_cd IN MD_CUST_OWNER.CUST_ADDRESS_PLACE.POST_CD_ADDR%TYPE,
  is_equal OUT BOOLEAN)
IS
BEGIN
  IF (
    ((new_place_town IS NOT NULL AND old_place_town IS NULL) OR
     (new_place_town IS NULL AND old_place_town IS NOT NULL) OR
     (new_place_town != old_place_town)
    ) OR
    ((new_place_address IS NOT NULL AND old_place_address IS NULL) OR
     (new_place_address IS NULL AND old_place_address IS NOT NULL) OR
     (new_place_address != old_place_address)
    ) OR
    ((new_place_post_cd IS NOT NULL AND old_place_post_cd IS NULL) OR
     (new_place_post_cd IS NULL AND old_place_post_cd IS NOT NULL) OR
     (new_place_post_cd != old_place_post_cd)
    )
  ) THEN
    is_equal := FALSE;
  ELSE
    is_equal := TRUE;
  END IF;
END;
/


-- entrypoint for customer search sync for MD_CUST_OWNER.CUST_ADDRESS_PLACE
CREATE OR REPLACE PROCEDURE sync_search_mdcap(
  operation IN VARCHAR2,
  new_bt_cust_id IN MD_CUST_OWNER.CUST_ADDRESS_PLACE.CUST_ID%TYPE,
  new_place_town IN MD_CUST_OWNER.CUST_ADDRESS_PLACE.TOWN%TYPE,
  new_place_address IN MD_CUST_OWNER.CUST_ADDRESS_PLACE.ADDRESS%TYPE,
  new_place_post_cd IN MD_CUST_OWNER.CUST_ADDRESS_PLACE.POST_CD_ADDR%TYPE,
  old_bt_cust_id IN MD_CUST_OWNER.CUST_ADDRESS_PLACE.CUST_ID%TYPE,
  old_place_town IN MD_CUST_OWNER.CUST_ADDRESS_PLACE.TOWN%TYPE,
  old_place_address IN MD_CUST_OWNER.CUST_ADDRESS_PLACE.ADDRESS%TYPE,
  old_place_post_cd IN MD_CUST_OWNER.CUST_ADDRESS_PLACE.POST_CD_ADDR%TYPE)
IS
  jms_message_body VARCHAR2(4096);
  is_equal BOOLEAN;
BEGIN
  IF (operation = 'UPDATE') THEN
    has_search_diff_mdcap(new_bt_cust_id, new_place_town, new_place_address, new_place_post_cd,
      old_place_town, old_place_address, old_place_post_cd,
      is_equal);
  ELSE
    is_equal := FALSE;
  END IF;

  IF (operation != 'ERROR' AND operation != 'DELETE') THEN
    IF (is_equal = FALSE) THEN
      build_jms_msg_mdcap(operation,
        new_bt_cust_id, new_place_town, new_place_address, new_place_post_cd,
        jms_message_body);
      enqueue_cust_search_jms(jms_message_body);
    END IF;
  END IF;
END;
/


-- handle BT_CUST_P

-- format insert/update fields as json for consumer
CREATE OR REPLACE PROCEDURE build_jms_msg_btcp(
  operation IN VARCHAR2,
  new_bt_cust_id IN BT_OWNER.BT_CUST_P.BT_CUST_ID%TYPE,
  new_place_name IN BT_OWNER.BT_CUST_P.PLACE_NAME%TYPE,
  message_body OUT VARCHAR2)
IS
BEGIN
  message_body := '{'
    || '"id": "' || new_bt_cust_id || '"'
    || ', "operation": "' || operation || '"'
    || ', "placeName": "' || replace(replace(new_place_name, '"'), '\') || '"'
    || '}';
END;
/


-- change detection (on update only queue when relevant fields change)
CREATE OR REPLACE PROCEDURE has_search_diff_btcp(
  new_bt_cust_id IN BT_OWNER.BT_CUST_P.BT_CUST_ID%TYPE,
  new_place_name IN BT_OWNER.BT_CUST_P.PLACE_NAME%TYPE,
  old_place_name IN BT_OWNER.BT_CUST_P.PLACE_NAME%TYPE,
  is_equal OUT BOOLEAN)
IS
BEGIN
  IF (
    ((new_place_name IS NOT NULL AND old_place_name IS NULL) OR
     (new_place_name IS NULL AND old_place_name IS NOT NULL) OR
     (new_place_name != old_place_name)
    )
  ) THEN
    is_equal := FALSE;
  ELSE
    is_equal := TRUE;
  END IF;
END;
/


-- entrypoint for customer search sync for CUST_P
CREATE OR REPLACE PROCEDURE sync_search_btcp(
  operation IN VARCHAR2,
  new_bt_cust_id IN BT_OWNER.BT_CUST_P.BT_CUST_ID%TYPE,
  new_place_name IN BT_OWNER.BT_CUST_P.PLACE_NAME%TYPE,
  old_bt_cust_id IN BT_OWNER.BT_CUST_P.BT_CUST_ID%TYPE,
  old_place_name IN BT_OWNER.BT_CUST_P.PLACE_NAME%TYPE)
IS
  jms_message_body VARCHAR2(4096);
  is_equal BOOLEAN;
BEGIN
  IF (operation = 'UPDATE') THEN
    has_search_diff_btcp(new_bt_cust_id,
      new_place_name,
      old_place_name,
      is_equal);
  ELSE
    is_equal := FALSE;
  END IF;

  IF (operation != 'ERROR' AND operation != 'DELETE') THEN
    IF (is_equal = FALSE) THEN
      build_jms_msg_btcp(operation,
        new_bt_cust_id,
        new_place_name,
        jms_message_body);
      enqueue_cust_search_jms(jms_message_body);
    END IF;
  END IF;
END;
/


-- handle MD_CUST_OWNER.CUST_NOM

-- format insert/update fields as json for consumer
CREATE OR REPLACE PROCEDURE build_jms_msg_mdcn(
  operation IN VARCHAR2,
  new_bt_cust_id IN MD_CUST_OWNER.CUST_NOM.BT_CUST_ID%TYPE,
  new_place_name IN MD_CUST_OWNER.CUST_NOM.PLACE_NAME%TYPE,
  message_body OUT VARCHAR2)
IS
BEGIN
  message_body := '{'
    || '"id": "' || new_bt_cust_id || '"'
    || ', "operation": "' || operation || '"'
    || ', "placeName": "' || replace(replace(new_place_name, '"'), '\') || '"'
    || '}';
END;
/


-- change detection (on update only queue when relevant fields change)
CREATE OR REPLACE PROCEDURE has_search_diff_mdcn(
  new_bt_cust_id IN MD_CUST_OWNER.CUST_NOM.BT_CUST_ID%TYPE,
  new_place_name IN MD_CUST_OWNER.CUST_NOM.PLACE_NAME%TYPE,
  old_place_name IN MD_CUST_OWNER.CUST_NOM.PLACE_NAME%TYPE,
  is_equal OUT BOOLEAN)
IS
BEGIN
  IF (
    ((new_place_name IS NOT NULL AND old_place_name IS NULL) OR
     (new_place_name IS NULL AND old_place_name IS NOT NULL) OR
     (new_place_name != old_place_name)
    )
  ) THEN
    is_equal := FALSE;
  ELSE
    is_equal := TRUE;
  END IF;
END;
/


-- entrypoint for customer search sync for MD_CUST_OWNER.CUST_NOM
CREATE OR REPLACE PROCEDURE sync_search_mdcn(
  operation IN VARCHAR2,
  new_bt_cust_id IN MD_CUST_OWNER.CUST_NOM.BT_CUST_ID%TYPE,
  new_place_name IN MD_CUST_OWNER.CUST_NOM.PLACE_NAME%TYPE,
  old_bt_cust_id IN MD_CUST_OWNER.CUST_NOM.BT_CUST_ID%TYPE,
  old_place_name IN MD_CUST_OWNER.CUST_NOM.PLACE_NAME%TYPE)
IS
  jms_message_body VARCHAR2(4096);
  is_equal BOOLEAN;
BEGIN
  IF (operation = 'UPDATE') THEN
    has_search_diff_mdcn(new_bt_cust_id,
      new_place_name,
      old_place_name,
      is_equal);
  ELSE
    is_equal := FALSE;
  END IF;

  IF (operation != 'ERROR' AND operation != 'DELETE') THEN
    IF (is_equal = FALSE) THEN
      build_jms_msg_mdcn(operation,
        new_bt_cust_id,
        new_place_name,
        jms_message_body);
      enqueue_cust_search_jms(jms_message_body);
    END IF;
  END IF;
END;
/


-- handle MD_CUST_OWNER.CUST

-- format insert/update fields as json for consumer
CREATE OR REPLACE PROCEDURE build_jms_msg_mdc(
  operation IN VARCHAR2,
  new_bt_cust_id IN MD_CUST_OWNER.CUST.CUST_ID%TYPE,
  new_cust_reg_no IN MD_CUST_OWNER.CUST.CUST_REG_NO%TYPE,
  message_body OUT VARCHAR2)
IS
BEGIN
  message_body := '{'
    || '"id": "' || new_bt_cust_id || '"'
    || ', "operation": "' || operation || '"'
    || ', "custRegNo": "' || replace(replace(new_cust_reg_no, '"'), '\') || '"'
    || '}';
END;
/


-- change detection (on update only queue when relevant fields change)
CREATE OR REPLACE PROCEDURE has_search_diff_mdc(
  new_bt_cust_id IN MD_CUST_OWNER.CUST.CUST_ID%TYPE,
  new_cust_reg_no IN MD_CUST_OWNER.CUST.CUST_REG_NO%TYPE,
  old_cust_reg_no IN MD_CUST_OWNER.CUST.CUST_REG_NO%TYPE,
  is_equal OUT BOOLEAN)
IS
BEGIN
  IF (
    ((new_cust_reg_no IS NOT NULL AND old_cust_reg_no IS NULL) OR
     (new_cust_reg_no IS NULL AND old_cust_reg_no IS NOT NULL) OR
     (new_cust_reg_no != old_cust_reg_no)
    )
  ) THEN
    is_equal := FALSE;
  ELSE
    is_equal := TRUE;
  END IF;
END;
/


-- entrypoint for customer search sync for MD_CUST_OWNER.CUST
CREATE OR REPLACE PROCEDURE sync_search_mdc(
  operation IN VARCHAR2,
  new_bt_cust_id IN MD_CUST_OWNER.CUST.CUST_ID%TYPE,
  new_store_no IN MD_CUST_OWNER.CUST.STORE_NO%TYPE,
  new_cust_no IN MD_CUST_OWNER.CUST.CUST_NO%TYPE,
  new_cust_reg_no IN MD_CUST_OWNER.CUST.CUST_REG_NO%TYPE,
  old_bt_cust_id IN MD_CUST_OWNER.CUST.CUST_ID%TYPE,
  old_cust_reg_no IN MD_CUST_OWNER.CUST.CUST_REG_NO%TYPE)
IS
  jms_message_body VARCHAR2(4096);
  is_equal BOOLEAN;
BEGIN
  IF (operation = 'UPDATE') THEN
    has_search_diff_mdc(new_bt_cust_id,
      new_cust_reg_no,
      old_cust_reg_no,
      is_equal);
  ELSE
    is_equal := FALSE;
  END IF;

  IF (operation != 'ERROR' AND operation != 'DELETE') THEN
    IF (is_equal = FALSE) THEN
      build_jms_msg_mdc(operation,
        new_bt_cust_id,
        new_cust_reg_no,
        jms_message_body);
      enqueue_cust_search_jms(jms_message_body);

      -- apply to P children
      FOR custp IN (SELECT p.bt_cust_id FROM BT_OWNER.BT_CUST_P p WHERE p.store_no=new_store_no AND p.cust_no=new_cust_no)
      LOOP
        build_jms_msg_mdc(operation,
          custp.bt_cust_id,
          new_cust_reg_no,
          jms_message_body);
        enqueue_cust_search_jms(jms_message_body);
      END LOOP;
    END IF;
  END IF;
END;
/


-- handle MD_CUST_OWNER.CUST_ACQ

-- format insert/update fields as json for consumer
CREATE OR REPLACE PROCEDURE build_jms_msg_mdca(
  operation IN VARCHAR2,
  new_bt_cust_id IN MD_CUST_OWNER.CUST_ACQ.BT_CUST_ID%TYPE,
  new_cust_full_name IN MD_CUST_OWNER.CUST_ACQ.CUST_FULL_NAME%TYPE,
  new_place_name IN MD_CUST_OWNER.CUST_ACQ.NAME%TYPE,
  new_place_town IN MD_CUST_OWNER.CUST_ACQ.TOWN%TYPE,
  new_place_address IN MD_CUST_OWNER.CUST_ACQ.ADDRESS%TYPE,
  new_place_post_cd IN MD_CUST_OWNER.CUST_ACQ.POST_CD%TYPE,
  new_cust_reg_no IN MD_CUST_OWNER.CUST_ACQ.CUST_REG_NO%TYPE,
  message_body OUT VARCHAR2)
IS
BEGIN
  message_body := '{'
    || '"id": "' || new_bt_cust_id || '"'
    || ', "operation": "' || operation || '"'
    || ', "custFullName": "' || replace(replace(new_cust_full_name, '"'), '\') || '"'
    || ', "placeName": "' || replace(replace(new_place_name, '"'), '\') || '"'
    || ', "placeTown": "' || replace(replace(new_place_town, '"'), '\') || '"'
    || ', "placeAddress": "' || replace(replace(new_place_address, '"'), '\') || '"'
    || ', "placePostCd": "' || replace(replace(new_place_post_cd, '"'), '\') || '"'
    || ', "custRegNo": "' || replace(replace(new_cust_reg_no, '"'), '\') || '"'
    || '}';
END;
/


-- change detection (on update only queue when relevant fields change)
CREATE OR REPLACE PROCEDURE has_search_diff_mdca(
  new_bt_cust_id IN MD_CUST_OWNER.CUST_ACQ.BT_CUST_ID%TYPE,
  new_cust_full_name IN MD_CUST_OWNER.CUST_ACQ.CUST_FULL_NAME%TYPE,
  new_place_name IN MD_CUST_OWNER.CUST_ACQ.NAME%TYPE,
  new_place_town IN MD_CUST_OWNER.CUST_ACQ.TOWN%TYPE,
  new_place_address IN MD_CUST_OWNER.CUST_ACQ.ADDRESS%TYPE,
  new_place_post_cd IN MD_CUST_OWNER.CUST_ACQ.POST_CD%TYPE,
  new_cust_reg_no IN MD_CUST_OWNER.CUST_ACQ.CUST_REG_NO%TYPE,
  old_cust_full_name IN MD_CUST_OWNER.CUST_ACQ.CUST_FULL_NAME%TYPE,
  old_place_name IN MD_CUST_OWNER.CUST_ACQ.NAME%TYPE,
  old_place_town IN MD_CUST_OWNER.CUST_ACQ.TOWN%TYPE,
  old_place_address IN MD_CUST_OWNER.CUST_ACQ.ADDRESS%TYPE,
  old_place_post_cd IN MD_CUST_OWNER.CUST_ACQ.POST_CD%TYPE,
  old_cust_reg_no IN MD_CUST_OWNER.CUST_ACQ.CUST_REG_NO%TYPE,
  is_equal OUT BOOLEAN)
IS
BEGIN
  IF (
    ((new_cust_full_name IS NOT NULL AND old_cust_full_name IS NULL) OR
     (new_cust_full_name IS NULL AND old_cust_full_name IS NOT NULL) OR
     (new_cust_full_name != old_cust_full_name)
    ) OR
    ((new_place_name IS NOT NULL AND old_place_name IS NULL) OR
     (new_place_name IS NULL AND old_place_name IS NOT NULL) OR
     (new_place_name != old_place_name)
    ) OR
    ((new_place_town IS NOT NULL AND old_place_town IS NULL) OR
     (new_place_town IS NULL AND old_place_town IS NOT NULL) OR
     (new_place_town != old_place_town)
    ) OR
    ((new_place_address IS NOT NULL AND old_place_address IS NULL) OR
     (new_place_address IS NULL AND old_place_address IS NOT NULL) OR
     (new_place_address != old_place_address)
    ) OR
    ((new_place_post_cd IS NOT NULL AND old_place_post_cd IS NULL) OR
     (new_place_post_cd IS NULL AND old_place_post_cd IS NOT NULL) OR
     (new_place_post_cd != old_place_post_cd)
    ) OR
    ((new_cust_reg_no IS NOT NULL AND old_cust_reg_no IS NULL) OR
     (new_cust_reg_no IS NULL AND old_cust_reg_no IS NOT NULL) OR
     (new_cust_reg_no != old_cust_reg_no)
    )
  ) THEN
    is_equal := FALSE;
  ELSE
    is_equal := TRUE;
  END IF;
END;
/


-- entrypoint for customer search sync for MD_CUST_OWNER.CUST_ACQ
CREATE OR REPLACE PROCEDURE sync_search_mdca(
  operation IN VARCHAR2,
  new_bt_cust_id IN MD_CUST_OWNER.CUST_ACQ.BT_CUST_ID%TYPE,
  new_cust_full_name IN MD_CUST_OWNER.CUST_ACQ.CUST_FULL_NAME%TYPE,
  new_place_name IN MD_CUST_OWNER.CUST_ACQ.NAME%TYPE,
  new_place_town IN MD_CUST_OWNER.CUST_ACQ.TOWN%TYPE,
  new_place_address IN MD_CUST_OWNER.CUST_ACQ.ADDRESS%TYPE,
  new_place_post_cd IN MD_CUST_OWNER.CUST_ACQ.POST_CD%TYPE,
  new_cust_reg_no IN MD_CUST_OWNER.CUST_ACQ.CUST_REG_NO%TYPE,
  old_bt_cust_id IN MD_CUST_OWNER.CUST_ACQ.BT_CUST_ID%TYPE,
  old_cust_full_name IN MD_CUST_OWNER.CUST_ACQ.CUST_FULL_NAME%TYPE,
  old_place_name IN MD_CUST_OWNER.CUST_ACQ.NAME%TYPE,
  old_place_town IN MD_CUST_OWNER.CUST_ACQ.TOWN%TYPE,
  old_place_address IN MD_CUST_OWNER.CUST_ACQ.ADDRESS%TYPE,
  old_place_post_cd IN MD_CUST_OWNER.CUST_ACQ.POST_CD%TYPE,
  old_cust_reg_no IN MD_CUST_OWNER.CUST_ACQ.CUST_REG_NO%TYPE)
IS
  jms_message_body VARCHAR2(4096);
  is_equal BOOLEAN;
BEGIN
  IF (operation = 'UPDATE') THEN
    has_search_diff_mdca(new_bt_cust_id, new_cust_full_name,
      new_place_name, new_place_town, new_place_address, new_place_post_cd,
      new_cust_reg_no,
      old_cust_full_name,
      old_place_name, old_place_town, old_place_address, old_place_post_cd,
      old_cust_reg_no,
      is_equal);
  ELSE
    is_equal := FALSE;
  END IF;

  IF (operation != 'ERROR' AND operation != 'DELETE') THEN
    IF (is_equal = FALSE) THEN
      build_jms_msg_mdca(operation,
        new_bt_cust_id, new_cust_full_name,
        new_place_name, new_place_town, new_place_address, new_place_post_cd,
        new_cust_reg_no,
        jms_message_body);
      enqueue_cust_search_jms(jms_message_body);
    END IF;
  END IF;
END;
/


-- handle BT_CUST_Z

-- format insert/update fields as json for consumer
CREATE OR REPLACE PROCEDURE build_jms_msg_btcz(
  operation IN VARCHAR2,
  new_bt_cust_id IN BT_OWNER.BT_CUST_Z.BT_CUST_ID%TYPE,
  new_cust_full_name IN BT_OWNER.BT_CUST_Z.CUST_FULL_NAME%TYPE,
  message_body OUT VARCHAR2)
IS
BEGIN
  message_body := '{'
    || '"id": "' || new_bt_cust_id || '"'
    || ', "operation": "' || operation || '"'
    || ', "custFullName": "' || replace(replace(new_cust_full_name, '"'), '\') || '"'
    || '}';
END;
/


-- change detection (on update only queue when relevant fields change)
CREATE OR REPLACE PROCEDURE has_search_diff_btcz(
  new_bt_cust_id IN BT_OWNER.BT_CUST_Z.BT_CUST_ID%TYPE,
  new_cust_full_name IN BT_OWNER.BT_CUST_Z.CUST_FULL_NAME%TYPE,
  old_cust_full_name IN BT_OWNER.BT_CUST_Z.CUST_FULL_NAME%TYPE,
  is_equal OUT BOOLEAN)
IS
BEGIN
  IF (
    ((new_cust_full_name IS NOT NULL AND old_cust_full_name IS NULL) OR
     (new_cust_full_name IS NULL AND old_cust_full_name IS NOT NULL) OR
     (new_cust_full_name != old_cust_full_name)
    )
  ) THEN
    is_equal := FALSE;
  ELSE
    is_equal := TRUE;
  END IF;
END;
/


-- entrypoint for customer search sync for BT_CUST_Z
CREATE OR REPLACE PROCEDURE sync_search_btcz(
  operation IN VARCHAR2,
  new_bt_cust_id IN BT_OWNER.BT_CUST_Z.BT_CUST_ID%TYPE,
  new_store_no IN BT_OWNER.BT_CUST_Z.STORE_NO%TYPE,
  new_cust_no IN BT_OWNER.BT_CUST_Z.CUST_NO%TYPE,
  new_cust_full_name IN BT_OWNER.BT_CUST_Z.CUST_FULL_NAME%TYPE,
  old_bt_cust_id IN BT_OWNER.BT_CUST_Z.BT_CUST_ID%TYPE,
  old_cust_full_name IN BT_OWNER.BT_CUST_Z.CUST_FULL_NAME%TYPE)
IS
  jms_message_body VARCHAR2(4096);
  is_equal BOOLEAN;
BEGIN
  IF (operation = 'UPDATE') THEN
    has_search_diff_btcz(new_bt_cust_id, new_cust_full_name,
      old_cust_full_name,
      is_equal);
  ELSE
    is_equal := FALSE;
  END IF;

  IF (operation != 'ERROR' AND operation != 'DELETE') THEN
    IF (is_equal = FALSE) THEN
      build_jms_msg_btcz(operation,
        new_bt_cust_id, new_cust_full_name,
        jms_message_body);
      enqueue_cust_search_jms(jms_message_body);

      -- apply to P children
      FOR custp IN (SELECT p.bt_cust_id FROM BT_OWNER.BT_CUST_P p WHERE p.store_no=new_store_no AND p.cust_no=new_cust_no)
      LOOP
        build_jms_msg_btcz(operation,
          custp.bt_cust_id, new_cust_full_name,
            jms_message_body);
          enqueue_cust_search_jms(jms_message_body);
      END LOOP;
    END IF;
  END IF;
END;
/
