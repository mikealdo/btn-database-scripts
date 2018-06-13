DELETE FROM btn_substitute where created_initiator = 'subst_dataset';
DELETE FROM btn_article_store where created_initiator = 'subst_dataset';
DELETE FROM BTN_SALE_CUST_ARTICLE where created_initiator = 'subst_dataset';
DELETE FROM btn_article where created_initiator = 'subst_dataset';

-- CFA-PARENT
INSERT INTO btn_article (id, art_no, grp_no, grp_descr, grp_type, DPT_NO, vat, active, descr, marketing_name_cz, art_unit, cont_sell_unit, std_factor, art_weight, art_weight_mean, created_initiator, created_ts, CFA_TYPE)
VALUES
  (seq_btn_article.nextval, 11, 1, 'FOR_SUBST', 'ART', 1, 21, 'A', 'CFA-P1', 'CFA-P1', 'MU', 1, 1, 1, 1, 'subst_dataset', sysdate, 'P');

INSERT INTO btn_article_store (id, store_no, btn_article_id, sell_price, art_qty, active, art_status, created_initiator)
VALUES (seq_btn_article_store.nextval, 6, (SELECT id
                                           FROM btn_article
                                           WHERE art_no = 11), '101||G|GMS|1|10||||', '1', 'A', '9_3_0', 'subst_dataset');

-- AAA - original article for substitution, part of CFA-P1
INSERT INTO btn_article (id, art_no, grp_no, grp_descr, grp_type, DPT_NO, vat, active, descr, marketing_name_cz, art_unit, cont_sell_unit, std_factor, art_weight, art_weight_mean, created_initiator, created_ts, CFA_PARENT_ID, CFA_TYPE)
VALUES
  (seq_btn_article.nextval, 1, 1, 'FOR_SUBST', 'ART', 1, 21, 'A', 'AAA', 'AAA', 'MU', 1, 1, 1, 1, 'subst_dataset', sysdate, (SELECT id
                                           FROM btn_article
                                           WHERE art_no = 11), 'C');

INSERT INTO btn_article_store (id, store_no, btn_article_id, sell_price, art_qty, active, art_status, created_initiator)
VALUES (seq_btn_article_store.nextval, 6, (SELECT id
                                           FROM btn_article
                                           WHERE art_no = 1), '100||G|GMS|1|10||||', '1', 'A', '9_3_0', 'subst_dataset');

-- BBB (ARO)
INSERT INTO btn_article (id, art_no, grp_no, grp_descr, grp_type, DPT_NO, vat, active, descr, marketing_name_cz, art_unit, cont_sell_unit, std_factor, art_weight, art_weight_mean, created_initiator, created_ts, ARO_ARTICLE_NEW)
VALUES
  (seq_btn_article.nextval, 2, 1, 'FOR_SUBST', 'ART', 1, 21, 'A', 'BBB', 'BBB', 'MU', 1, 1, 1, 1, 'subst_dataset', sysdate, 3);

INSERT INTO btn_article_store (id, store_no, btn_article_id, sell_price, art_qty, active, art_status, created_initiator)
VALUES (seq_btn_article_store.nextval, 6, (SELECT id
                                           FROM btn_article
                                           WHERE art_no = 2), '110||G|GMS|1|10||||', '6', 'A', '9_3_0', 'subst_dataset');

-- CCC
INSERT INTO btn_article (id, art_no, grp_no, grp_descr, grp_type, DPT_NO, vat, active, descr, marketing_name_cz, art_unit, cont_sell_unit, std_factor, art_weight, art_weight_mean, created_initiator, created_ts)
VALUES
  (seq_btn_article.nextval, 3, 1, 'FOR_SUBST', 'ART', 1, 21, 'A', 'CCC', 'CCC', 'MU', 1, 1, 1, 1, 'subst_dataset', sysdate);

INSERT INTO btn_article_store (id, store_no, btn_article_id, sell_price, art_qty, active, art_status, created_initiator)
VALUES (seq_btn_article_store.nextval, 6, (SELECT id
                                           FROM btn_article
                                           WHERE art_no = 3), '80||G|GMS|1|10||||', '6', 'A', '9_3_0', 'subst_dataset');

-- DDD
INSERT INTO btn_article (id, art_no, grp_no, grp_descr, grp_type, DPT_NO, vat, active, descr, marketing_name_cz, art_unit, cont_sell_unit, std_factor, art_weight, art_weight_mean, created_initiator, created_ts)
VALUES
  (seq_btn_article.nextval, 4, 1, 'FOR_SUBST', 'ART', 1, 21, 'A', 'DDD', 'DDD', 'MU', 1, 1, 1, 1, 'subst_dataset', sysdate);

INSERT INTO btn_article_store (id, store_no, btn_article_id, sell_price, art_qty, active, art_status, created_initiator)
VALUES (seq_btn_article_store.nextval, 6, (SELECT id
                                           FROM btn_article
                                           WHERE art_no = 4), '120||G|GMS|1|10||||', '6', 'A', '9_3_0', 'subst_dataset');

-- EEE
INSERT INTO btn_article (id, art_no, grp_no, grp_descr, grp_type, DPT_NO, vat, active, descr, marketing_name_cz, art_unit, cont_sell_unit, std_factor, art_weight, art_weight_mean, created_initiator, created_ts)
VALUES
  (seq_btn_article.nextval, 5, 1, 'FOR_SUBST', 'ART', 1, 21, 'A', 'EEE', 'EEE', 'MU', 1, 1, 1, 1, 'subst_dataset', sysdate);

INSERT INTO btn_article_store (id, store_no, btn_article_id, sell_price, art_qty, active, art_status, created_initiator)
VALUES (seq_btn_article_store.nextval, 6, (SELECT id
                                           FROM btn_article
                                           WHERE art_no = 5), '75||G|GMS|1|10||||', '6', 'A', '9_3_0', 'subst_dataset');

-- FFF
INSERT INTO btn_article (id, art_no, grp_no, grp_descr, grp_type, DPT_NO, vat, active, descr, marketing_name_cz, art_unit, cont_sell_unit, std_factor, art_weight, art_weight_mean, created_initiator, created_ts)
VALUES
  (seq_btn_article.nextval, 6, 1, 'FOR_SUBST', 'ART', 1, 21, 'A', 'FFF', 'FFF', 'MU', 1, 1, 1, 1, 'subst_dataset', sysdate);

INSERT INTO btn_article_store (id, store_no, btn_article_id, sell_price, art_qty, active, art_status, created_initiator)
VALUES (seq_btn_article_store.nextval, 6, (SELECT id
                                           FROM btn_article
                                           WHERE art_no = 6), '103||G|GMS|1|10||||', '6', 'A', '9_3_0', 'subst_dataset');

-- GGG
INSERT INTO btn_article (id, art_no, grp_no, grp_descr, grp_type, DPT_NO, vat, active, descr, marketing_name_cz, art_unit, cont_sell_unit, std_factor, art_weight, art_weight_mean, created_initiator, created_ts)
VALUES
  (seq_btn_article.nextval, 7, 1, 'FOR_SUBST', 'ART', 1, 21, 'A', 'GGG', 'GGG', 'MU', 1, 1, 1, 1, 'subst_dataset', sysdate);

INSERT INTO btn_article_store (id, store_no, btn_article_id, sell_price, art_qty, active, art_status, created_initiator)
VALUES (seq_btn_article_store.nextval, 6, (SELECT id
                                           FROM btn_article
                                           WHERE art_no = 7), '99||G|GMS|1|10||||', '6', 'A', '9_3_0', 'subst_dataset');

-- HHH
INSERT INTO btn_article (id, art_no, grp_no, grp_descr, grp_type, DPT_NO, vat, active, descr, marketing_name_cz, art_unit, cont_sell_unit, std_factor, art_weight, art_weight_mean, created_initiator, created_ts)
VALUES
  (seq_btn_article.nextval, 8, 1, 'FOR_SUBST', 'ART', 1, 21, 'A', 'HHH', 'HHH', 'MU', 1, 1, 1, 1, 'subst_dataset', sysdate);

INSERT INTO btn_article_store (id, store_no, btn_article_id, sell_price, art_qty, active, art_status, created_initiator)
VALUES (seq_btn_article_store.nextval, 6, (SELECT id
                                           FROM btn_article
                                           WHERE art_no = 8), '100||G|GMS|1|10||||', '6', 'A', '9_3_0', 'subst_dataset');

-- III
INSERT INTO btn_article (id, art_no, grp_no, grp_descr, grp_type, DPT_NO, vat, active, descr, marketing_name_cz, art_unit, cont_sell_unit, std_factor, art_weight, art_weight_mean, created_initiator, created_ts, CFA_PARENT_ID, CFA_TYPE)
VALUES
  (seq_btn_article.nextval, 9, 1, 'FOR_SUBST', 'ART', 1, 21, 'A', 'III', 'III', 'MU', 1, 1, 1, 1, 'subst_dataset', sysdate, (SELECT id
                                           FROM btn_article
                                           WHERE art_no = 11), 'U');

INSERT INTO btn_article_store (id, store_no, btn_article_id, sell_price, art_qty, active, art_status, created_initiator)
VALUES (seq_btn_article_store.nextval, 6, (SELECT id
                                           FROM btn_article
                                           WHERE art_no = 9), '125||G|GMS|1|10||||', '6', 'A', '9_3_0', 'subst_dataset');

-- JJJ
INSERT INTO btn_article (id, art_no, grp_no, grp_descr, grp_type, DPT_NO, vat, active, descr, marketing_name_cz, art_unit, cont_sell_unit, std_factor, art_weight, art_weight_mean, created_initiator, created_ts, CFA_PARENT_ID, CFA_TYPE)
VALUES
  (seq_btn_article.nextval, 10, 1, 'FOR_SUBST', 'ART', 1, 21, 'A', 'JJJ', 'JJJ', 'MU', 1, 1, 1, 1, 'subst_dataset', sysdate, (SELECT id
                                           FROM btn_article
                                           WHERE art_no = 11), 'C');

INSERT INTO btn_article_store (id, store_no, btn_article_id, sell_price, art_qty, active, art_status, created_initiator)
VALUES (seq_btn_article_store.nextval, 6, (SELECT id
                                           FROM btn_article
                                           WHERE art_no = 10), '101||G|GMS|1|10||||', '6', 'A', '9_3_0', 'subst_dataset');



-- defined substitutions

-- Customer's substitutions
-- AAA > BBB
INSERT INTO btn_substitute (id, region_id, cust_store_no, cust_no, btn_article_id, substitute_btn_article_id, substitute_descr, substitute_type, alternative_type, date_from, date_to, usage_count, version, created_initiator, created_ts, created_user_info, last_modif_user_ts, last_modif_initiator, last_modified_ts, last_modif_user_info)
VALUES
  ((seq_btn_substitute.nextval), NULL, 6, 702332, (SELECT id
                                                   FROM btn_article
                                                   WHERE descr = 'AAA'), (SELECT id
                                                                          FROM btn_article
                                                                          WHERE descr = 'BBB'), 'DEFINED', 'C', 'P', NULL, NULL, NULL, 0, 'subst_dataset', NULL, NULL, NULL, NULL, NULL, NULL);

-- AAA > CCC
INSERT INTO btn_substitute (id, region_id, cust_store_no, cust_no, btn_article_id, substitute_btn_article_id, substitute_descr, substitute_type, alternative_type, date_from, date_to, usage_count, version, created_initiator, created_ts, created_user_info, last_modif_user_ts, last_modif_initiator, last_modified_ts, last_modif_user_info)
VALUES
  ((seq_btn_substitute.nextval), NULL, 6, 702332, (SELECT id
                                                   FROM btn_article
                                                   WHERE descr = 'AAA'), (SELECT id
                                                                          FROM btn_article
                                                                          WHERE descr = 'CCC'), 'DEFINED', 'C', 'P', NULL, NULL, NULL, 0, 'subst_dataset', NULL, NULL, NULL, NULL, NULL, NULL);

-- BBB > DDD
INSERT INTO btn_substitute (id, region_id, cust_store_no, cust_no, btn_article_id, substitute_btn_article_id, substitute_descr, substitute_type, alternative_type, date_from, date_to, usage_count, version, created_initiator, created_ts, created_user_info, last_modif_user_ts, last_modif_initiator, last_modified_ts, last_modif_user_info)
VALUES
  ((seq_btn_substitute.nextval), NULL, 6, 702332, (SELECT id
                                                   FROM btn_article
                                                   WHERE descr = 'BBB'), (SELECT id
                                                                          FROM btn_article
                                                                          WHERE descr = 'DDD'), 'DEFINED', 'C', 'P', NULL, NULL, NULL, 0, 'subst_dataset', NULL, NULL, NULL, NULL, NULL, NULL);

-- Global substitutions
-- AAA > EEE
INSERT INTO btn_substitute (id, region_id, cust_store_no, cust_no, btn_article_id, substitute_btn_article_id, substitute_descr, substitute_type, alternative_type, date_from, date_to, usage_count, version, created_initiator, created_ts, created_user_info, last_modif_user_ts, last_modif_initiator, last_modified_ts, last_modif_user_info)
VALUES
  ((seq_btn_substitute.nextval), 5, NULL, NULL, (SELECT id
                                                   FROM btn_article
                                                   WHERE descr = 'AAA'), (SELECT id
                                                                          FROM btn_article
                                                                          WHERE descr = 'EEE'), 'DEFINED', 'V', NULL, NULL, NULL, NULL, 0, 'subst_dataset', NULL, NULL, NULL, NULL, NULL, NULL);

-- BBB > FFF
INSERT INTO btn_substitute (id, region_id, cust_store_no, cust_no, btn_article_id, substitute_btn_article_id, substitute_descr, substitute_type, alternative_type, date_from, date_to, usage_count, version, created_initiator, created_ts, created_user_info, last_modif_user_ts, last_modif_initiator, last_modified_ts, last_modif_user_info)
VALUES
  ((seq_btn_substitute.nextval), 5, NULL, NULL, (SELECT id
                                                   FROM btn_article
                                                   WHERE descr = 'BBB'), (SELECT id
                                                                          FROM btn_article
                                                                          WHERE descr = 'FFF'), 'DEFINED', 'V', NULL, NULL, NULL, NULL, 0, 'subst_dataset', NULL, NULL, NULL, NULL, NULL, NULL);

-- CCC > GGG
INSERT INTO btn_substitute (id, region_id, cust_store_no, cust_no, btn_article_id, substitute_btn_article_id, substitute_descr, substitute_type, alternative_type, date_from, date_to, usage_count, version, created_initiator, created_ts, created_user_info, last_modif_user_ts, last_modif_initiator, last_modified_ts, last_modif_user_info)
VALUES
  ((seq_btn_substitute.nextval), 5, NULL, NULL, (SELECT id
                                                   FROM btn_article
                                                   WHERE descr = 'CCC'), (SELECT id
                                                                          FROM btn_article
                                                                          WHERE descr = 'GGG'), 'DEFINED', 'V', NULL, NULL, NULL, NULL, 0, 'subst_dataset', NULL, NULL, NULL, NULL, NULL, NULL);

-- DDD > HHH
INSERT INTO btn_substitute (id, region_id, cust_store_no, cust_no, btn_article_id, substitute_btn_article_id, substitute_descr, substitute_type, alternative_type, date_from, date_to, usage_count, version, created_initiator, created_ts, created_user_info, last_modif_user_ts, last_modif_initiator, last_modified_ts, last_modif_user_info)
VALUES
  ((seq_btn_substitute.nextval), 5, NULL, NULL, (SELECT id
                                                   FROM btn_article
                                                   WHERE descr = 'DDD'), (SELECT id
                                                                          FROM btn_article
                                                                          WHERE descr = 'HHH'), 'DEFINED', 'V', NULL, NULL, NULL, NULL, 0, 'subst_dataset', NULL, NULL, NULL, NULL, NULL, NULL);
