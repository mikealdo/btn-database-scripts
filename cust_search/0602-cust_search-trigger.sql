connect BTN4_JMSADMIN/BTN4_JMSADMIN

-- example triggers (content can be used within single table triggers)

-- BT_CUST
CREATE OR REPLACE TRIGGER BTN4_JMSADMIN.BT_CUST_SEARCH_AIUR_TRG
AFTER INSERT OR UPDATE OR DELETE
ON BT_OWNER.BT_CUST
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
  operation VARCHAR2(8);
BEGIN
  IF INSERTING THEN
    operation := 'CREATE';
  ELSIF UPDATING THEN
    operation := 'UPDATE';
  ELSIF DELETING THEN
    operation := 'DELETE';
  ELSE
    operation := 'ERROR';
  END IF;

  sync_search_btc(operation, :NEW.id, :NEW.store_no, :NEW.cust_record_type, :NEW.card_type,
      :NEW.cust_status, :NEW.place_status, :NEW.cust_no, :NEW.place_no,
      :OLD.id, :OLD.store_no, :OLD.cust_record_type, :OLD.card_type,
      :OLD.cust_status, :OLD.place_status, :OLD.cust_no, :OLD.place_no);
END;
/

ALTER TRIGGER BTN4_JMSADMIN.BT_CUST_SEARCH_AIUR_TRG ENABLE;

-- BT_CUST_Z
CREATE OR REPLACE TRIGGER BTN4_JMSADMIN.BT_CUST_Z_SEARCH_AIUR_TRG
AFTER INSERT OR UPDATE OR DELETE
ON BT_OWNER.BT_CUST_Z
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
  operation VARCHAR2(8);
BEGIN
  IF INSERTING THEN
    operation := 'CREATE';
  ELSIF UPDATING THEN
    operation := 'UPDATE';
  ELSIF DELETING THEN
    operation := 'DELETE';
  ELSE
    operation := 'ERROR';
  END IF;

  sync_search_btcz(operation, :NEW.bt_cust_id, :NEW.store_no, :NEW.cust_no,
      :NEW.cust_full_name,
      :OLD.bt_cust_id, :OLD.cust_full_name);
END;
/

ALTER TRIGGER BTN4_JMSADMIN.BT_CUST_Z_SEARCH_AIUR_TRG ENABLE;

-- BT_CUST_P
CREATE OR REPLACE TRIGGER BTN4_JMSADMIN.BT_CUST_P_SEARCH_AIUR_TRG
AFTER INSERT OR UPDATE OR DELETE
ON BT_OWNER.BT_CUST_P
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
  operation VARCHAR2(8);
BEGIN
  IF INSERTING THEN
    operation := 'CREATE';
  ELSIF UPDATING THEN
    operation := 'UPDATE';
  ELSIF DELETING THEN
    operation := 'DELETE';
  ELSE
    operation := 'ERROR';
  END IF;

  sync_search_btcp(operation, :NEW.bt_cust_id, :NEW.place_name,
      :OLD.bt_cust_id, :OLD.place_name);
END;
/

ALTER TRIGGER BTN4_JMSADMIN.BT_CUST_P_SEARCH_AIUR_TRG ENABLE;

-- MD_CUST_OWNER.CUST
CREATE OR REPLACE TRIGGER BTN4_JMSADMIN.MD_CUST_SEARCH_AIUR_TRG
AFTER INSERT OR UPDATE OR DELETE
ON MD_CUST_OWNER.CUST
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
  operation VARCHAR2(8);
BEGIN
  IF INSERTING THEN
    operation := 'CREATE';
  ELSIF UPDATING THEN
    operation := 'UPDATE';
  ELSIF DELETING THEN
    operation := 'DELETE';
  ELSE
    operation := 'ERROR';
  END IF;

  sync_search_mdc(operation, :NEW.cust_id, :NEW.store_no, :NEW.cust_no,
      :NEW.cust_reg_no,
      :OLD.cust_id, :OLD.cust_reg_no);
END;
/

ALTER TRIGGER BTN4_JMSADMIN.MD_CUST_SEARCH_AIUR_TRG ENABLE;

-- MD_CUST_OWNER.CUST_ADDRESS_PLACE
CREATE OR REPLACE TRIGGER BTN4_JMSADMIN.MD_CUST_AD_PL_SEARCH_AIUR_TRG
AFTER INSERT OR UPDATE OR DELETE
ON MD_CUST_OWNER.CUST_ADDRESS_PLACE
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
  operation VARCHAR2(8);
BEGIN
  IF INSERTING THEN
    operation := 'CREATE';
  ELSIF UPDATING THEN
    operation := 'UPDATE';
  ELSIF DELETING THEN
    operation := 'DELETE';
  ELSE
    operation := 'ERROR';
  END IF;

  sync_search_mdcap(operation, :NEW.cust_id, :NEW.town, :NEW.address, :NEW.post_cd_addr,
      :OLD.cust_id, :OLD.town, :OLD.address, :OLD.post_cd_addr);
END;
/

ALTER TRIGGER BTN4_JMSADMIN.MD_CUST_AD_PL_SEARCH_AIUR_TRG ENABLE;

-- MD_CUST_OWNER.CUST_ACQ
CREATE OR REPLACE TRIGGER BTN4_JMSADMIN.BT_CUST_A_SEARCH_AIUR_TRG
AFTER INSERT OR UPDATE OR DELETE
ON MD_CUST_OWNER.CUST_ACQ
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
  operation VARCHAR2(8);
BEGIN
  IF INSERTING THEN
    operation := 'CREATE';
  ELSIF UPDATING THEN
    operation := 'UPDATE';
  ELSIF DELETING THEN
    operation := 'DELETE';
  ELSE
    operation := 'ERROR';
  END IF;

  sync_search_mdca(operation, :NEW.bt_cust_id, :NEW.cust_full_name,
      :NEW.name, :NEW.town, :NEW.address, :NEW.post_cd,
      :NEW.cust_reg_no,
      :OLD.bt_cust_id, :OLD.cust_full_name,
      :OLD.name, :OLD.town, :OLD.address, :OLD.post_cd,
      :OLD.cust_reg_no);
END;
/

ALTER TRIGGER BTN4_JMSADMIN.BT_CUST_SEARCH_AIUR_TRG ENABLE;

-- MD_CUST_OWNER.CUST_NOM
CREATE OR REPLACE TRIGGER BTN4_JMSADMIN.MD_CUST_N_SEARCH_AIUR_TRG
AFTER INSERT OR UPDATE OR DELETE
ON MD_CUST_OWNER.CUST_NOM
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
  operation VARCHAR2(8);
BEGIN
  IF INSERTING THEN
    operation := 'CREATE';
  ELSIF UPDATING THEN
    operation := 'UPDATE';
  ELSIF DELETING THEN
    operation := 'DELETE';
  ELSE
    operation := 'ERROR';
  END IF;

  sync_search_mdcn(operation, :NEW.bt_cust_id, :NEW.place_name,
      :OLD.bt_cust_id, :OLD.place_name);
END;
/

ALTER TRIGGER BTN4_JMSADMIN.MD_CUST_N_SEARCH_AIUR_TRG ENABLE;
