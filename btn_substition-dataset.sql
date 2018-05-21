DELETE FROM btn_substitute;
DELETE FROM btn_article_store;
DELETE FROM btn_article;

-- original article for substitution
INSERT INTO btn_article (id, art_no, grp_no, grp_descr, grp_type, vat, active, descr, marketing_name_cz, cont_sell_unit, std_factor, art_weight, created_initiator, created_ts)
VALUES
  (seq_btn_article.nextval, 123456, 1, 'FIRST', 'ART', 21, 'A', 'AAA', 'AAA', 1, 1, 1, 'subst_dataset', sysdate);

INSERT INTO btn_article_store (id, store_no, btn_article_id, sell_price, art_qty, active, art_status, created_initiator)
VALUES (seq_btn_article_store.nextval, 6, (SELECT id
                                           FROM btn_article
                                           WHERE art_no = 123456), '100||G|GMS|1|10||||', '0', 'A', '9_3_0', 'subst_dataset');

-- aro article
INSERT INTO btn_article (id, art_no, grp_no, grp_descr, grp_type, vat, active, descr, marketing_name_cz, cont_sell_unit, std_factor, art_weight, created_initiator, created_ts)
VALUES
  (seq_btn_article.nextval, 223456, 1, 'FIRST', 'ART', 21, 'A', 'BBB', 'BBB', 1, 1, 1, 'subst_dataset', sysdate);

INSERT INTO btn_article_store (id, store_no, btn_article_id, sell_price, art_qty, active, art_status, created_initiator)
VALUES (seq_btn_article_store.nextval, 6, (SELECT id
                                           FROM btn_article
                                           WHERE art_no = 223456), '110||G|GMS|1|10||||', '36', 'A', '9_3_0', 'subst_dataset');

INSERT INTO btn_substitute (id, region_id, cust_store_no, cust_no, btn_article_id, substitute_btn_article_id, substitute_descr, substitute_type, alternative_type, date_from, date_to, usage_count, version, created_initiator, created_ts, created_user_info, last_modif_user_ts, last_modif_initiator, last_modified_ts, last_modif_user_info)
VALUES
  ((seq_btn_substitute.nextval), NULL, 6, 150775, (SELECT id
                                                   FROM btn_article
                                                   WHERE art_no = 223456), (SELECT id
                                                                            FROM btn_article
                                                                            WHERE art_no = 123456), NULL, 'C', 'P',
                                 NULL, NULL, NULL, 0, NULL, NULL, NULL,
   NULL, NULL, NULL, NULL);

UPDATE btn_article_store
SET art_qty = 36
WHERE id = 448545360;

UPDATE btn_article
SET manual_block = 'A'
WHERE art_no = '311972';

UPDATE btn_article
SET active = 'A'
WHERE art_no = '310939';
UPDATE btn_article_store
SET manual_block = 'A'
WHERE btn_article_id = '291334';
UPDATE btn_article_store
SET block_ind = '0', manual_block = 'A'
WHERE btn_article_id = '291335';
UPDATE btn_article_store
SET block_ind = NULL, manual_block = NULL
WHERE btn_article_id = '290319';
UPDATE btn_article_store
SET active = 'N'
WHERE btn_article_id = '292836';

DELETE FROM btn_substitute;

INSERT INTO btn_substitute (id, region_id, cust_store_no, cust_no, btn_article_id, substitute_btn_article_id, substitute_descr, substitute_type, alternative_type, date_from, date_to, usage_count, version, created_initiator, created_ts, created_user_info, last_modif_user_ts, last_modif_initiator, last_modified_ts, last_modif_user_info)
VALUES
  (seq_btn_substitute.nextval, 34, NULL, NULL, 292391, 292388, NULL, 'A', NULL, NULL, NULL, NULL, 1,
   'WAPL_LOCK/BTN_APL', to_timestamp('19-DEC-17 02.48.14.066000000 PM', 'DD-MON-RR HH.MI.SSXFF AM'), '6382', NULL, NULL,
   NULL, NULL);
INSERT INTO btn_substitute (id, region_id, cust_store_no, cust_no, btn_article_id, substitute_btn_article_id, substitute_descr, substitute_type, alternative_type, date_from, date_to, usage_count, version, created_initiator, created_ts, created_user_info, last_modif_user_ts, last_modif_initiator, last_modified_ts, last_modif_user_info)
VALUES
  ((seq_btn_substitute.nextval), NULL, 6, 224559, 290286, 290402, NULL, 'C', 'P', NULL, NULL, NULL, 0, NULL, NULL, NULL,
   NULL, NULL, NULL, NULL);
INSERT INTO btn_substitute (id, region_id, cust_store_no, cust_no, btn_article_id, substitute_btn_article_id, substitute_descr, substitute_type, alternative_type, date_from, date_to, usage_count, version, created_initiator, created_ts, created_user_info, last_modif_user_ts, last_modif_initiator, last_modified_ts, last_modif_user_info)
VALUES
  ((seq_btn_substitute.nextval), NULL, 6, 224559, 290402, 290234, NULL, 'C', 'P', NULL, NULL, NULL, 0, NULL, NULL, NULL,
   NULL, NULL, NULL, NULL);
INSERT INTO btn_substitute (id, region_id, cust_store_no, cust_no, btn_article_id, substitute_btn_article_id, substitute_descr, substitute_type, alternative_type, date_from, date_to, usage_count, version, created_initiator, created_ts, created_user_info, last_modif_user_ts, last_modif_initiator, last_modified_ts, last_modif_user_info)
VALUES
  ((seq_btn_substitute.nextval), NULL, 6, 224559, 291837, 290285, NULL, 'C', 'P', NULL, NULL, NULL, 0, NULL, NULL, NULL,
   NULL, NULL, NULL, NULL);
INSERT INTO btn_substitute (id, region_id, cust_store_no, cust_no, btn_article_id, substitute_btn_article_id, substitute_descr, substitute_type, alternative_type, date_from, date_to, usage_count, version, created_initiator, created_ts, created_user_info, last_modif_user_ts, last_modif_initiator, last_modified_ts, last_modif_user_info)
VALUES
  ((seq_btn_substitute.nextval), NULL, 6, 224559, 291838, 290220, NULL, 'C', 'P', NULL, NULL, NULL, 0, NULL, NULL, NULL,
   NULL, NULL, NULL, NULL);
INSERT INTO btn_substitute (id, region_id, cust_store_no, cust_no, btn_article_id, substitute_btn_article_id, substitute_descr, substitute_type, alternative_type, date_from, date_to, usage_count, version, created_initiator, created_ts, created_user_info, last_modif_user_ts, last_modif_initiator, last_modified_ts, last_modif_user_info)
VALUES
  ((seq_btn_substitute.nextval), NULL, 6, 224559, 291839, 290402, NULL, 'C', 'P', NULL, NULL, NULL, 0, NULL, NULL, NULL,
   NULL, NULL, NULL, NULL);
INSERT INTO btn_substitute (id, region_id, cust_store_no, cust_no, btn_article_id, substitute_btn_article_id, substitute_descr, substitute_type, alternative_type, date_from, date_to, usage_count, version, created_initiator, created_ts, created_user_info, last_modif_user_ts, last_modif_initiator, last_modified_ts, last_modif_user_info)
VALUES
  ((seq_btn_substitute.nextval), NULL, 6, 224559, 291837, 290232, NULL, 'C', 'P', NULL, NULL, NULL, 0, NULL, NULL, NULL,
   NULL, NULL, NULL, NULL);
INSERT INTO btn_substitute (id, region_id, cust_store_no, cust_no, btn_article_id, substitute_btn_article_id, substitute_descr, substitute_type, alternative_type, date_from, date_to, usage_count, version, created_initiator, created_ts, created_user_info, last_modif_user_ts, last_modif_initiator, last_modified_ts, last_modif_user_info)
VALUES
  ((seq_btn_substitute.nextval), NULL, 2, 302161, 291072, 290834, NULL, 'C', 'P', NULL, NULL, NULL, 1, NULL, NULL, NULL,
   NULL, NULL, NULL, NULL);
INSERT INTO btn_substitute (id, region_id, cust_store_no, cust_no, btn_article_id, substitute_btn_article_id, substitute_descr, substitute_type, alternative_type, date_from, date_to, usage_count, version, created_initiator, created_ts, created_user_info, last_modif_user_ts, last_modif_initiator, last_modified_ts, last_modif_user_info)
VALUES
  ((seq_btn_substitute.nextval), NULL, 2, 299417, 291837, 290220, NULL, 'C', 'B', NULL, NULL, NULL, 0, NULL, NULL, NULL,
   NULL, NULL, NULL, NULL);
INSERT INTO btn_substitute (id, region_id, cust_store_no, cust_no, btn_article_id, substitute_btn_article_id, substitute_descr, substitute_type, alternative_type, date_from, date_to, usage_count, version, created_initiator, created_ts, created_user_info, last_modif_user_ts, last_modif_initiator, last_modified_ts, last_modif_user_info)
VALUES
  ((seq_btn_substitute.nextval), NULL, 6, 224559, 291410, 291489, NULL, 'C', 'P', NULL, NULL, NULL, 0, NULL, NULL, NULL,
   NULL, NULL, NULL, NULL);

