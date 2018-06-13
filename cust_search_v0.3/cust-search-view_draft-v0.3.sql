-- View of all fields used in customer search
CREATE OR REPLACE FORCE VIEW "BT_OWNER"."BT_CUST_SEARCH_V" ("BT_CUST_ID", "CUST_NO", "STORE_NO", "PLACE_NO", "CUST_CC", "CUST_CC_STORE_NO", "CUST_FULL_NAME", "CUST_RECORD_TYPE", "PLACE_NAME", "CUST_REG_NO", "ADVISOR_ID", "CUST_STATUS", "PLACE_STATUS", "ORDER_STORE", "PLACE_ADDRESS", "PLACE_TOWN", "PLACE_POST_CD", "CARD_TYPE") AS
SELECT cu.bt_cust_id, btc.cust_no, btc.store_no, btc.place_no,
  cu.cust_cc, cu.cust_cc_store_no, cu.cust_full_name, btc.cust_record_type,
  cu.place_name, cu.cust_reg_no, cu.advisor_id,
  btc.cust_status, btc.place_status, cu.order_store,
  NVL(adrp.address, cu.address) place_address, NVL(adrp.town, cu.town) place_town,
  NVL(adrp.post_cd_addr, post_cd) place_post_cd, btc.card_type
FROM (
SELECT z.bt_cust_id, z.cust_cc, z.cust_cc_store_no, z.cust_full_name,
  NULL place_name, z.cust_address_id, mc.cust_reg_no, mc.advisor_id,
  NULL address, NULL town, NULL post_cd,
  NULL order_store
 FROM BT_OWNER.BT_CUST_Z z
   INNER JOIN MD_CUST_OWNER.CUST mc ON (z.bt_cust_id=mc.cust_id)
UNION ALL
SELECT bt_cust_id, cust_cc, cust_cc_store_no, cust_full_name,
  name place_name, NULL cust_address_id, cust_reg_no, advisor_id,
  address, town, post_cd,
  NULL order_store
 FROM MD_CUST_OWNER.CUST_ACQ
UNION ALL
SELECT p.bt_cust_id, z.cust_cc, z.cust_cc_store_no, z.cust_full_name,
  p.name place_name, p.cust_address_id, mc.cust_reg_no, mc.advisor_id,
  NULL address, NULL town, NULL post_cd,
  p.order_store
 FROM BT_OWNER.BT_CUST_P p
   INNER JOIN BT_OWNER.BT_CUST_Z z ON (p.store_no=z.store_no AND p.cust_no=z.cust_no)
   INNER JOIN MD_CUST_OWNER.CUST mc ON (z.bt_cust_id=mc.cust_id)
UNION ALL
SELECT n.bt_cust_id, z.cust_cc, z.cust_cc_store_no, z.cust_full_name,
  n.name place_name, n.cust_address_id, mc.cust_reg_no, mc.advisor_id,
  NULL address, NULL town, NULL post_cd,
  n.order_store
 FROM MD_CUST_OWNER.CUST_NOM n
   LEFT JOIN BT_OWNER.BT_CUST_Z z ON (n.store_no=z.store_no AND n.cust_no=z.cust_no)
   LEFT JOIN MD_CUST_OWNER.CUST mc ON (z.bt_cust_id=mc.cust_id)
) cu
    INNER JOIN BT_OWNER.BT_CUST btc ON (cu.bt_cust_id=btc.id)
    LEFT JOIN MD_CUST_OWNER.CUST_ADDRESS adr ON (cu.cust_address_id=adr.cust_address_id)
    LEFT JOIN MD_CUST_OWNER.CUST_ADDRESS_PLACE adrp ON (adr.cust_address_place_id=adrp.cust_address_place_id);

