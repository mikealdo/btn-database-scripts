DELETE FROM BTN_SUBSTITUTE
where CREATED_INITIATOR = 'subst_dataset';
DELETE FROM BTN_ARTICLE_STORE
where CREATED_INITIATOR = 'subst_dataset';
delete from BTN_ARTICLE_STORE where btn_article_id in (select id from btn_article where art_no LIKE '-%');
DELETE FROM BTN_SALE_CUST_ARTICLE
where CREATED_INITIATOR = 'subst_dataset';
DELETE FROM BTN_XY_STORE
where CREATED_INITIATOR = 'subst_dataset';
DELETE FROM BTN_XY
where CREATED_INITIATOR = 'subst_dataset';
DELETE FROM BTN_ARTICLE
where CREATED_INITIATOR = 'subst_dataset';

-- CFA-PARENT
INSERT INTO BTN_ARTICLE (ID, ART_NO, GRP_NO, GRP_DESCR, GRP_TYPE, DPT_NO, VAT, ACTIVE, DESCR, MARKETING_NAME_CZ, SEARCH_TEXT1, SEARCH_TEXT2, ART_UNIT, CONT_SELL_UNIT, STD_FACTOR, ART_WEIGHT, ART_WEIGHT_MEAN, CREATED_INITIATOR, CREATED_TS, CFA_TYPE, LEADING_NO)
VALUES
  (SEQ_BTN_ARTICLE.NEXTVAL, -999911, 1, 'FOR_SUBST', 'ART', 1, 21, 'A', 'CFA-P1', 'CFA-P1', 'CFA-P1', 'CFA-P1', 'MU', 1, 1,
   1, 1, 'subst_dataset', sysdate, 'P', 'CFA123456');

INSERT INTO BTN_ARTICLE_STORE (ID, STORE_NO, BTN_ARTICLE_ID, SELL_PRICE, ART_QTY, ACTIVE, ART_STATUS, CREATED_INITIATOR)
VALUES (SEQ_BTN_ARTICLE_STORE.NEXTVAL, 6, (SELECT ID
                                           FROM BTN_ARTICLE
                                           WHERE DESCR = 'CFA-P1'), '101||G|GMS|1|10||||', '1', 'A', '9_3_0',
        'subst_dataset');

-- AAA - original article for substitution, part of CFA-P1
INSERT INTO BTN_ARTICLE (ID, ART_NO, GRP_NO, GRP_DESCR, GRP_TYPE, DPT_NO, VAT, ACTIVE, DESCR, MARKETING_NAME_CZ, SEARCH_TEXT1, SEARCH_TEXT2, ART_UNIT, CONT_SELL_UNIT, STD_FACTOR, ART_WEIGHT, ART_WEIGHT_MEAN, CREATED_INITIATOR, CREATED_TS, CFA_PARENT_ID, CFA_TYPE, LEADING_NO)
VALUES
  (SEQ_BTN_ARTICLE.NEXTVAL, -99991, 1, 'FOR_SUBST', 'ART', 1, 21, 'A', 'AAA', 'AAA', 'AAA', 'AAA', 'MU', 1, 1, 1, 1,
    'subst_dataset', sysdate, (SELECT ID
                               FROM BTN_ARTICLE
                               WHERE DESCR = 'CFA-P1'), 'C', 'CFA123456');

INSERT INTO BTN_ARTICLE_STORE (ID, STORE_NO, BTN_ARTICLE_ID, SELL_PRICE, ART_QTY, ACTIVE, ART_STATUS, CREATED_INITIATOR)
VALUES (SEQ_BTN_ARTICLE_STORE.NEXTVAL, 6, (SELECT ID
                                           FROM BTN_ARTICLE
                                           WHERE DESCR = 'AAA'), '100||G|GMS|1|10||||', '1', 'A', '9_3_0',
        'subst_dataset');

-- BBB (ARO)
INSERT INTO BTN_ARTICLE (ID, ART_NO, GRP_NO, GRP_DESCR, GRP_TYPE, DPT_NO, VAT, ACTIVE, DESCR, MARKETING_NAME_CZ, SEARCH_TEXT1, SEARCH_TEXT2, ART_UNIT, CONT_SELL_UNIT, STD_FACTOR, ART_WEIGHT, ART_WEIGHT_MEAN, CREATED_INITIATOR, CREATED_TS, ARO_ARTICLE_NEW)
VALUES
  (SEQ_BTN_ARTICLE.NEXTVAL, -99992, 1, 'FOR_SUBST', 'ART', 1, 21, 'A', 'BBB', 'BBB', 'BBB', 'BBB', 'MU', 1, 1, 1, 1,
   'subst_dataset', sysdate, 3);

INSERT INTO BTN_ARTICLE_STORE (ID, STORE_NO, BTN_ARTICLE_ID, SELL_PRICE, ART_QTY, ACTIVE, ART_STATUS, CREATED_INITIATOR)
VALUES (SEQ_BTN_ARTICLE_STORE.NEXTVAL, 6, (SELECT ID
                                           FROM BTN_ARTICLE
                                           WHERE DESCR = 'BBB'), '110||G|GMS|1|10||||', '6', 'A', '9_3_0',
        'subst_dataset');

-- CCC
INSERT INTO BTN_ARTICLE (ID, ART_NO, GRP_NO, GRP_DESCR, GRP_TYPE, DPT_NO, VAT, ACTIVE, DESCR, MARKETING_NAME_CZ, SEARCH_TEXT1, SEARCH_TEXT2, ART_UNIT, CONT_SELL_UNIT, STD_FACTOR, ART_WEIGHT, ART_WEIGHT_MEAN, CREATED_INITIATOR, CREATED_TS)
VALUES
  (SEQ_BTN_ARTICLE.NEXTVAL, -99993, 1, 'FOR_SUBST', 'ART', 1, 21, 'A', 'CCC', 'CCC', 'CCC', 'CCC', 'MU', 1, 1, 1, 1,
   'subst_dataset', sysdate);

INSERT INTO BTN_ARTICLE_STORE (ID, STORE_NO, BTN_ARTICLE_ID, SELL_PRICE, ART_QTY, ACTIVE, ART_STATUS, CREATED_INITIATOR)
VALUES (SEQ_BTN_ARTICLE_STORE.NEXTVAL, 6, (SELECT ID
                                           FROM BTN_ARTICLE
                                           WHERE DESCR = 'CCC'), '80||G|GMS|1|10||||', '6', 'A', '9_3_0', 'subst_dataset');

-- DDD
INSERT INTO BTN_ARTICLE (ID, ART_NO, GRP_NO, GRP_DESCR, GRP_TYPE, DPT_NO, VAT, ACTIVE, DESCR, MARKETING_NAME_CZ, SEARCH_TEXT1, SEARCH_TEXT2, ART_UNIT, CONT_SELL_UNIT, STD_FACTOR, ART_WEIGHT, ART_WEIGHT_MEAN, CREATED_INITIATOR, CREATED_TS)
VALUES
  (SEQ_BTN_ARTICLE.NEXTVAL, -99994, 1, 'FOR_SUBST', 'ART', 1, 21, 'A', 'DDD', 'DDD', 'DDD', 'DDD', 'MU', 1, 1, 1, 1,
   'subst_dataset', sysdate);

INSERT INTO BTN_ARTICLE_STORE (ID, STORE_NO, BTN_ARTICLE_ID, SELL_PRICE, ART_QTY, ACTIVE, ART_STATUS, CREATED_INITIATOR)
VALUES (SEQ_BTN_ARTICLE_STORE.NEXTVAL, 6, (SELECT ID
                                           FROM BTN_ARTICLE
                                           WHERE DESCR = 'DDD'), '120||G|GMS|1|10||||', '6', 'A', '9_3_0',
        'subst_dataset');

-- EEE
INSERT INTO BTN_ARTICLE (ID, ART_NO, GRP_NO, GRP_DESCR, GRP_TYPE, DPT_NO, VAT, ACTIVE, DESCR, MARKETING_NAME_CZ, SEARCH_TEXT1, SEARCH_TEXT2, ART_UNIT, CONT_SELL_UNIT, STD_FACTOR, ART_WEIGHT, ART_WEIGHT_MEAN, CREATED_INITIATOR, CREATED_TS)
VALUES
  (SEQ_BTN_ARTICLE.NEXTVAL, -99995, 1, 'FOR_SUBST', 'ART', 1, 21, 'A', 'EEE', 'EEE', 'EEE', 'EEE', 'MU', 1, 1, 1, 1,
   'subst_dataset', sysdate);

INSERT INTO BTN_ARTICLE_STORE (ID, STORE_NO, BTN_ARTICLE_ID, SELL_PRICE, ART_QTY, ACTIVE, ART_STATUS, CREATED_INITIATOR)
VALUES (SEQ_BTN_ARTICLE_STORE.NEXTVAL, 6, (SELECT ID
                                           FROM BTN_ARTICLE
                                           WHERE DESCR = 'EEE'), '75||G|GMS|1|10||||', '6', 'A', '9_3_0',
        'subst_dataset');

-- FFF
INSERT INTO BTN_ARTICLE (ID, ART_NO, GRP_NO, GRP_DESCR, GRP_TYPE, DPT_NO, VAT, ACTIVE, DESCR, MARKETING_NAME_CZ, SEARCH_TEXT1, SEARCH_TEXT2, ART_UNIT, CONT_SELL_UNIT, STD_FACTOR, ART_WEIGHT, ART_WEIGHT_MEAN, CREATED_INITIATOR, CREATED_TS)
VALUES
  (SEQ_BTN_ARTICLE.NEXTVAL, -99996, 1, 'FOR_SUBST', 'ART', 1, 21, 'A', 'FFF', 'FFF', 'FFF', 'FFF', 'MU', 1, 1, 1, 1,
   'subst_dataset', sysdate);

INSERT INTO BTN_ARTICLE_STORE (ID, STORE_NO, BTN_ARTICLE_ID, SELL_PRICE, ART_QTY, ACTIVE, ART_STATUS, CREATED_INITIATOR)
VALUES (SEQ_BTN_ARTICLE_STORE.NEXTVAL, 6, (SELECT ID
                                           FROM BTN_ARTICLE
                                           WHERE DESCR = 'FFF'), '103||G|GMS|1|10||||', '6', 'A', '9_3_0',
        'subst_dataset');

-- GGG
INSERT INTO BTN_ARTICLE (ID, ART_NO, GRP_NO, GRP_DESCR, GRP_TYPE, DPT_NO, VAT, ACTIVE, DESCR, MARKETING_NAME_CZ, SEARCH_TEXT1, SEARCH_TEXT2, ART_UNIT, CONT_SELL_UNIT, STD_FACTOR, ART_WEIGHT, ART_WEIGHT_MEAN, CREATED_INITIATOR, CREATED_TS)
VALUES
  (SEQ_BTN_ARTICLE.NEXTVAL, -99997, 1, 'FOR_SUBST', 'ART', 1, 21, 'A', 'GGG', 'GGG', 'GGG', 'GGG', 'MU', 1, 1, 1, 1,
   'subst_dataset', sysdate);

INSERT INTO BTN_ARTICLE_STORE (ID, STORE_NO, BTN_ARTICLE_ID, SELL_PRICE, ART_QTY, ACTIVE, ART_STATUS, CREATED_INITIATOR)
VALUES (SEQ_BTN_ARTICLE_STORE.NEXTVAL, 6, (SELECT ID
                                           FROM BTN_ARTICLE
                                           WHERE DESCR = 'GGG'), '99||G|GMS|1|10||||', '6', 'A', '9_3_0',
        'subst_dataset');

-- HHH
INSERT INTO BTN_ARTICLE (ID, ART_NO, GRP_NO, GRP_DESCR, GRP_TYPE, DPT_NO, VAT, ACTIVE, DESCR, MARKETING_NAME_CZ, SEARCH_TEXT1, SEARCH_TEXT2, ART_UNIT, CONT_SELL_UNIT, STD_FACTOR, ART_WEIGHT, ART_WEIGHT_MEAN, CREATED_INITIATOR, CREATED_TS)
VALUES
  (SEQ_BTN_ARTICLE.NEXTVAL, -99998, 1, 'FOR_SUBST', 'ART', 1, 21, 'A', 'HHH', 'HHH', 'HHH', 'HHH', 'MU', 1, 1, 1, 1,
   'subst_dataset', sysdate);

INSERT INTO BTN_ARTICLE_STORE (ID, STORE_NO, BTN_ARTICLE_ID, SELL_PRICE, ART_QTY, ACTIVE, ART_STATUS, CREATED_INITIATOR)
VALUES (SEQ_BTN_ARTICLE_STORE.NEXTVAL, 6, (SELECT ID
                                           FROM BTN_ARTICLE
                                           WHERE DESCR = 'HHH'), '100||G|GMS|1|10||||', '6', 'A', '9_3_0',
        'subst_dataset');

-- III
INSERT INTO BTN_ARTICLE (ID, ART_NO, GRP_NO, GRP_DESCR, GRP_TYPE, DPT_NO, VAT, ACTIVE, DESCR, MARKETING_NAME_CZ, SEARCH_TEXT1, SEARCH_TEXT2, ART_UNIT, CONT_SELL_UNIT, STD_FACTOR, ART_WEIGHT, ART_WEIGHT_MEAN, CREATED_INITIATOR, CREATED_TS, CFA_PARENT_ID, CFA_TYPE, LEADING_NO)
VALUES
  (SEQ_BTN_ARTICLE.NEXTVAL, -99999, 1, 'FOR_SUBST', 'ART', 1, 21, 'A', 'III', 'III', 'III', 'III', 'MU', 1, 1, 1, 1,
    'subst_dataset', sysdate, (SELECT ID
                               FROM BTN_ARTICLE
                               WHERE DESCR = 'CFA-P1'), 'U', 'CFA123456');

INSERT INTO BTN_ARTICLE_STORE (ID, STORE_NO, BTN_ARTICLE_ID, SELL_PRICE, ART_QTY, ACTIVE, ART_STATUS, CREATED_INITIATOR)
VALUES (SEQ_BTN_ARTICLE_STORE.NEXTVAL, 6, (SELECT ID
                                           FROM BTN_ARTICLE
                                           WHERE DESCR = 'III'), '125||G|GMS|1|10||||', '6', 'A', '9_3_0',
        'subst_dataset');

-- JJJ
INSERT INTO BTN_ARTICLE (ID, ART_NO, GRP_NO, GRP_DESCR, GRP_TYPE, DPT_NO, VAT, ACTIVE, DESCR, MARKETING_NAME_CZ, SEARCH_TEXT1, SEARCH_TEXT2, ART_UNIT, CONT_SELL_UNIT, STD_FACTOR, ART_WEIGHT, ART_WEIGHT_MEAN, CREATED_INITIATOR, CREATED_TS, CFA_PARENT_ID, CFA_TYPE, LEADING_NO)
VALUES
  (SEQ_BTN_ARTICLE.NEXTVAL, -999910, 1, 'FOR_SUBST', 'ART', 1, 21, 'A', 'JJJ', 'JJJ', 'JJJ', 'JJJ', 'MU', 1, 1, 1, 1,
    'subst_dataset', sysdate, (SELECT ID
                               FROM BTN_ARTICLE
                               WHERE DESCR = 'CFA-P1'), 'C', 'CFA123456');

INSERT INTO BTN_ARTICLE_STORE (ID, STORE_NO, BTN_ARTICLE_ID, SELL_PRICE, ART_QTY, ACTIVE, ART_STATUS, CREATED_INITIATOR)
VALUES (SEQ_BTN_ARTICLE_STORE.NEXTVAL, 6, (SELECT ID
                                           FROM BTN_ARTICLE
                                           WHERE DESCR = 'JJJ'), '101||G|GMS|1|10||||', '6', 'A', '9_3_0',
        'subst_dataset');

-- KKK - XY leading article
INSERT INTO BTN_ARTICLE (ID, ART_NO, GRP_NO, GRP_DESCR, GRP_TYPE, DPT_NO, VAT, ACTIVE, DESCR, MARKETING_NAME_CZ, SEARCH_TEXT1, SEARCH_TEXT2, ART_UNIT, CONT_SELL_UNIT, STD_FACTOR, ART_WEIGHT, ART_WEIGHT_MEAN, CREATED_INITIATOR, CREATED_TS, EXTRA_TYPE, XY)
VALUES
  (SEQ_BTN_ARTICLE.NEXTVAL, -999912, 1, 'FOR_SUBST', 'ART', 1, 21, 'A', 'KKK', 'KKK', 'KKK', 'KKK', 'MU', 1, 1, 1, 1,
    'subst_dataset', sysdate, 'Y', 'A');

INSERT INTO BTN_ARTICLE_STORE (ID, STORE_NO, BTN_ARTICLE_ID, SELL_PRICE, ART_QTY, ACTIVE, ART_STATUS, CREATED_INITIATOR)
VALUES (SEQ_BTN_ARTICLE_STORE.NEXTVAL, 6, (SELECT ID
                                           FROM BTN_ARTICLE
                                           WHERE DESCR = 'KKK'), '111||G|GMS|1|10||||', '12', 'A', '9_3_0',
        'subst_dataset');

-- LLL - XY child article 1
INSERT INTO BTN_ARTICLE (ID, ART_NO, GRP_NO, GRP_DESCR, GRP_TYPE, DPT_NO, VAT, ACTIVE, DESCR, MARKETING_NAME_CZ, SEARCH_TEXT1, SEARCH_TEXT2, ART_UNIT, CONT_SELL_UNIT, STD_FACTOR, ART_WEIGHT, ART_WEIGHT_MEAN, CREATED_INITIATOR, CREATED_TS, EXTRA_TYPE, XY)
VALUES
  (SEQ_BTN_ARTICLE.NEXTVAL, -999913, 1, 'FOR_SUBST', 'ART', 1, 21, 'A', 'LLL', 'LLL', 'LLL', 'LLL', 'MU', 1, 1, 1, 1,
    'subst_dataset', sysdate, null, null);

INSERT INTO BTN_ARTICLE_STORE (ID, STORE_NO, BTN_ARTICLE_ID, SELL_PRICE, ART_QTY, ACTIVE, ART_STATUS, CREATED_INITIATOR)
VALUES (SEQ_BTN_ARTICLE_STORE.NEXTVAL, 6, (SELECT ID
                                           FROM BTN_ARTICLE
                                           WHERE DESCR = 'LLL'), '13||G|GMS|1|10||||', '13', 'A', '9_3_0',
        'subst_dataset');

-- DP1 - deposit for MMM
INSERT INTO BTN_ARTICLE (ID, ART_NO, GRP_NO, GRP_DESCR, GRP_TYPE, DPT_NO, VAT, ACTIVE, DESCR, MARKETING_NAME_CZ, SEARCH_TEXT1, SEARCH_TEXT2, ART_UNIT, CONT_SELL_UNIT, STD_FACTOR, ART_WEIGHT, ART_WEIGHT_MEAN, CREATED_INITIATOR, CREATED_TS, EXTRA_TYPE, XY)
VALUES
  (SEQ_BTN_ARTICLE.NEXTVAL, -999915, 1, 'FOR_SUBST', 'ART', 1, 21, 'A', 'DP1', 'DP1', 'DP1', 'DP1', 'MU', 1, 1, 1, 1,
    'subst_dataset', sysdate, null, null);

INSERT INTO BTN_ARTICLE_STORE (ID, STORE_NO, BTN_ARTICLE_ID, SELL_PRICE, ART_QTY, ACTIVE, ART_STATUS, CREATED_INITIATOR)
VALUES (SEQ_BTN_ARTICLE_STORE.NEXTVAL, 6, (SELECT ID
                                           FROM BTN_ARTICLE
                                           WHERE DESCR = 'DP1'), '15||G|GMS|1|10||||', '15', 'A', '9_3_0',
        'subst_dataset');

-- MMM - XY child article 2
INSERT INTO BTN_ARTICLE (ID, ART_NO, GRP_NO, GRP_DESCR, GRP_TYPE, DPT_NO, VAT, ACTIVE, DESCR, MARKETING_NAME_CZ, SEARCH_TEXT1, SEARCH_TEXT2, ART_UNIT, CONT_SELL_UNIT, STD_FACTOR, ART_WEIGHT, ART_WEIGHT_MEAN, CREATED_INITIATOR, CREATED_TS, ART_NO_DEPOSIT)
VALUES
  (SEQ_BTN_ARTICLE.NEXTVAL, -999914, 1, 'FOR_SUBST', 'ART', 1, 21, 'A', 'MMM', 'MMM', 'MMM', 'MMM', 'MU', 1, 1, 1, 1,
   'subst_dataset', sysdate, (SELECT ART_NO
                              FROM BTN_ARTICLE
                              WHERE DESCR = 'DP1'));

INSERT INTO BTN_ARTICLE_STORE (ID, STORE_NO, BTN_ARTICLE_ID, SELL_PRICE, ART_QTY, ACTIVE, ART_STATUS, CREATED_INITIATOR)
VALUES (SEQ_BTN_ARTICLE_STORE.NEXTVAL, 6, (SELECT ID
                                           FROM BTN_ARTICLE
                                           WHERE DESCR = 'MMM'), '14||G|GMS|1|10||||', '14', 'A', '9_3_0',
        'subst_dataset');

-- XY ACTION
insert into BTN_XY (ID, NAME, DESCR, PICKING_NOTE, BTN_ARTICLE_ID_LEAD, ART_DESCR_LEAD, BTN_ARTICLE_ID_1, ART_DESCR_1, QUANTITY_1, SELL_PRICE_1, BTN_ARTICLE_ID_2, ART_DESCR_2, QUANTITY_2, SELL_PRICE_2, MAX_QUANTITY, DATE_FROM, DATE_TO, ACTIVE, LAST_USED_TS, CREATED_INITIATOR)
values (SEQ_BTN_XY.NEXTVAL, 'KKK > LLL + MMM', 'Test XY for substitutions', 'Picking note', (SELECT ID
                                                                                             FROM BTN_ARTICLE
                                                                                             WHERE DESCR = 'KKK'),
                            'KKK is lead', (SELECT ID
                                            FROM BTN_ARTICLE
                                            WHERE DESCR = 'MMM'), 'MMM is child 1', '10', '13', (SELECT ID
                                                                                                 FROM BTN_ARTICLE
                                                                                                 WHERE DESCR = 'LLL'),
        'LLL is child 2', '5', '14', '5', sysdate - interval '1' day,
        sysdate + interval '30' day, 'A', null, 'subst_dataset');

INSERT INTO BTN_XY_STORE (ID, BTN_XY_ID, COD_STORE, CREATED_INITIATOR)
values (SEQ_BTN_XY_STORE.NEXTVAL, (select ID
                                   from BTN_XY
                                   where NAME = 'KKK > LLL + MMM'), 6, 'subst_dataset');

-- NNN - XY leading article
INSERT INTO BTN_ARTICLE (ID, ART_NO, GRP_NO, GRP_DESCR, GRP_TYPE, DPT_NO, VAT, ACTIVE, DESCR, MARKETING_NAME_CZ, SEARCH_TEXT1, SEARCH_TEXT2, ART_UNIT, CONT_SELL_UNIT, STD_FACTOR, ART_WEIGHT, ART_WEIGHT_MEAN, CREATED_INITIATOR, CREATED_TS, EXTRA_TYPE, XY)
VALUES
  (SEQ_BTN_ARTICLE.NEXTVAL, -999916, 1, 'FOR_SUBST', 'ART', 1, 21, 'A', 'NNN', 'NNN', 'NNN', 'NNN', 'MU', 1, 1, 1, 1,
    'subst_dataset', sysdate, 'Y', 'A');

INSERT INTO BTN_ARTICLE_STORE (ID, STORE_NO, BTN_ARTICLE_ID, SELL_PRICE, ART_QTY, ACTIVE, ART_STATUS, CREATED_INITIATOR)
VALUES (SEQ_BTN_ARTICLE_STORE.NEXTVAL, 6, (SELECT ID
                                           FROM BTN_ARTICLE
                                           WHERE DESCR = 'NNN'), '111||G|GMS|1|10||||', '12', 'A', '9_3_0',
        'subst_dataset');

-- OOO - XY child article 1
INSERT INTO BTN_ARTICLE (ID, ART_NO, GRP_NO, GRP_DESCR, GRP_TYPE, DPT_NO, VAT, ACTIVE, DESCR, MARKETING_NAME_CZ, SEARCH_TEXT1, SEARCH_TEXT2, ART_UNIT, CONT_SELL_UNIT, STD_FACTOR, ART_WEIGHT, ART_WEIGHT_MEAN, CREATED_INITIATOR, CREATED_TS, EXTRA_TYPE, XY)
VALUES
  (SEQ_BTN_ARTICLE.NEXTVAL, -999917, 1, 'FOR_SUBST', 'ART', 1, 21, 'A', 'OOO', 'OOO', 'OOO', 'OOO', 'MU', 1, 1, 1, 1,
    'subst_dataset', sysdate, null, null);

INSERT INTO BTN_ARTICLE_STORE (ID, STORE_NO, BTN_ARTICLE_ID, SELL_PRICE, ART_QTY, ACTIVE, ART_STATUS, CREATED_INITIATOR)
VALUES (SEQ_BTN_ARTICLE_STORE.NEXTVAL, 6, (SELECT ID
                                           FROM BTN_ARTICLE
                                           WHERE DESCR = 'OOO'), '13||G|GMS|1|10||||', '13', 'A', '9_3_0',
        'subst_dataset');

-- DP2 - deposit for PPP
INSERT INTO BTN_ARTICLE (ID, ART_NO, GRP_NO, GRP_DESCR, GRP_TYPE, DPT_NO, VAT, ACTIVE, DESCR, MARKETING_NAME_CZ, SEARCH_TEXT1, SEARCH_TEXT2, ART_UNIT, CONT_SELL_UNIT, STD_FACTOR, ART_WEIGHT, ART_WEIGHT_MEAN, CREATED_INITIATOR, CREATED_TS, EXTRA_TYPE, XY)
VALUES
  (SEQ_BTN_ARTICLE.NEXTVAL, -999919, 1, 'FOR_SUBST', 'ART', 1, 21, 'A', 'DP2', 'DP2', 'DP2', 'DP2', 'MU', 1, 1, 1, 1,
    'subst_dataset', sysdate, null, null);

INSERT INTO BTN_ARTICLE_STORE (ID, STORE_NO, BTN_ARTICLE_ID, SELL_PRICE, ART_QTY, ACTIVE, ART_STATUS, CREATED_INITIATOR)
VALUES (SEQ_BTN_ARTICLE_STORE.NEXTVAL, 6, (SELECT ID
                                           FROM BTN_ARTICLE
                                           WHERE DESCR = 'DP2'), '15||G|GMS|1|10||||', '15', 'A', '9_3_0',
        'subst_dataset');

-- PPP - XY child article 2
INSERT INTO BTN_ARTICLE (ID, ART_NO, GRP_NO, GRP_DESCR, GRP_TYPE, DPT_NO, VAT, ACTIVE, DESCR, MARKETING_NAME_CZ, SEARCH_TEXT1, SEARCH_TEXT2, ART_UNIT, CONT_SELL_UNIT, STD_FACTOR, ART_WEIGHT, ART_WEIGHT_MEAN, CREATED_INITIATOR, CREATED_TS, ART_NO_DEPOSIT)
VALUES
  (SEQ_BTN_ARTICLE.NEXTVAL, -999918, 1, 'FOR_SUBST', 'ART', 1, 21, 'A', 'PPP', 'PPP', 'PPP', 'PPP', 'MU', 1, 1, 1, 1,
   'subst_dataset', sysdate, (SELECT ART_NO
                              FROM BTN_ARTICLE
                              WHERE DESCR = 'DP2'));

INSERT INTO BTN_ARTICLE_STORE (ID, STORE_NO, BTN_ARTICLE_ID, SELL_PRICE, ART_QTY, ACTIVE, ART_STATUS, CREATED_INITIATOR)
VALUES (SEQ_BTN_ARTICLE_STORE.NEXTVAL, 6, (SELECT ID
                                           FROM BTN_ARTICLE
                                           WHERE DESCR = 'PPP'), '14||G|GMS|1|10||||', '14', 'A', '9_3_0',
        'subst_dataset');

-- XY ACTION
insert into BTN_XY (ID, NAME, DESCR, PICKING_NOTE, BTN_ARTICLE_ID_LEAD, ART_DESCR_LEAD, BTN_ARTICLE_ID_1, ART_DESCR_1, QUANTITY_1, SELL_PRICE_1, BTN_ARTICLE_ID_2, ART_DESCR_2, QUANTITY_2, SELL_PRICE_2, MAX_QUANTITY, DATE_FROM, DATE_TO, ACTIVE, LAST_USED_TS, CREATED_INITIATOR)
values (SEQ_BTN_XY.NEXTVAL, 'NNN > MMM + PPP', 'Test XY for substitutions', 'Picking note', (SELECT ID
                                                                                             FROM BTN_ARTICLE
                                                                                             WHERE DESCR = 'NNN'),
                            'NNN is lead', (SELECT ID
                                            FROM BTN_ARTICLE
                                            WHERE DESCR = 'MMM'), 'MMM is child 1', '10', '13', (SELECT ID
                                                                                                 FROM BTN_ARTICLE
                                                                                                 WHERE DESCR = 'PPP'),
        'PPP is child 2', '5', '14', '5', sysdate - interval '1' day,
        sysdate + interval '30' day, 'A', null, 'subst_dataset');

INSERT INTO BTN_XY_STORE (ID, BTN_XY_ID, COD_STORE, CREATED_INITIATOR)
values (SEQ_BTN_XY_STORE.NEXTVAL, (select ID
                                   from BTN_XY
                                   where NAME = 'NNN > MMM + PPP'), 6, 'subst_dataset');

-- defined substitutions

-- Customer's substitutions
-- AAA > BBB
INSERT INTO BTN_SUBSTITUTE (ID, REGION_ID, CUST_STORE_NO, CUST_NO, BTN_ARTICLE_ID, SUBSTITUTE_BTN_ARTICLE_ID, SUBSTITUTE_DESCR, SUBSTITUTE_TYPE, ALTERNATIVE_TYPE, DATE_FROM, DATE_TO, USAGE_COUNT, VERSION, CREATED_INITIATOR, CREATED_TS, CREATED_USER_INFO, LAST_MODIF_USER_TS, LAST_MODIF_INITIATOR, LAST_MODIFIED_TS, LAST_MODIF_USER_INFO)
VALUES
  ((SEQ_BTN_SUBSTITUTE.NEXTVAL), NULL, 6, 702332, (SELECT ID
                                                   FROM BTN_ARTICLE
                                                   WHERE DESCR = 'AAA'), (SELECT ID
                                                                          FROM BTN_ARTICLE
                                                                          WHERE DESCR = 'BBB'), 'DEFINED', 'C', 'P',
                                 NULL, NULL, NULL, 0, 'subst_dataset', NULL, NULL, NULL, NULL, NULL, NULL);

-- AAA > CCC
INSERT INTO BTN_SUBSTITUTE (ID, REGION_ID, CUST_STORE_NO, CUST_NO, BTN_ARTICLE_ID, SUBSTITUTE_BTN_ARTICLE_ID, SUBSTITUTE_DESCR, SUBSTITUTE_TYPE, ALTERNATIVE_TYPE, DATE_FROM, DATE_TO, USAGE_COUNT, VERSION, CREATED_INITIATOR, CREATED_TS, CREATED_USER_INFO, LAST_MODIF_USER_TS, LAST_MODIF_INITIATOR, LAST_MODIFIED_TS, LAST_MODIF_USER_INFO)
VALUES
  ((SEQ_BTN_SUBSTITUTE.NEXTVAL), NULL, 6, 702332, (SELECT ID
                                                   FROM BTN_ARTICLE
                                                   WHERE DESCR = 'AAA'), (SELECT ID
                                                                          FROM BTN_ARTICLE
                                                                          WHERE DESCR = 'CCC'), 'DEFINED', 'C', 'P',
                                 NULL, NULL, NULL, 0, 'subst_dataset', NULL, NULL, NULL, NULL, NULL, NULL);

-- BBB > DDD
INSERT INTO BTN_SUBSTITUTE (ID, REGION_ID, CUST_STORE_NO, CUST_NO, BTN_ARTICLE_ID, SUBSTITUTE_BTN_ARTICLE_ID, SUBSTITUTE_DESCR, SUBSTITUTE_TYPE, ALTERNATIVE_TYPE, DATE_FROM, DATE_TO, USAGE_COUNT, VERSION, CREATED_INITIATOR, CREATED_TS, CREATED_USER_INFO, LAST_MODIF_USER_TS, LAST_MODIF_INITIATOR, LAST_MODIFIED_TS, LAST_MODIF_USER_INFO)
VALUES
  ((SEQ_BTN_SUBSTITUTE.NEXTVAL), NULL, 6, 702332, (SELECT ID
                                                   FROM BTN_ARTICLE
                                                   WHERE DESCR = 'BBB'), (SELECT ID
                                                                          FROM BTN_ARTICLE
                                                                          WHERE DESCR = 'DDD'), 'DEFINED', 'C', 'P',
                                 NULL, NULL, NULL, 0, 'subst_dataset', NULL, NULL, NULL, NULL, NULL, NULL);

-- Global substitutions
-- AAA > EEE
INSERT INTO BTN_SUBSTITUTE (ID, REGION_ID, CUST_STORE_NO, CUST_NO, BTN_ARTICLE_ID, SUBSTITUTE_BTN_ARTICLE_ID, SUBSTITUTE_DESCR, SUBSTITUTE_TYPE, ALTERNATIVE_TYPE, DATE_FROM, DATE_TO, USAGE_COUNT, VERSION, CREATED_INITIATOR, CREATED_TS, CREATED_USER_INFO, LAST_MODIF_USER_TS, LAST_MODIF_INITIATOR, LAST_MODIFIED_TS, LAST_MODIF_USER_INFO)
VALUES
  ((SEQ_BTN_SUBSTITUTE.NEXTVAL), 5, NULL, NULL, (SELECT ID
                                                 FROM BTN_ARTICLE
                                                 WHERE DESCR = 'AAA'), (SELECT ID
                                                                        FROM BTN_ARTICLE
                                                                        WHERE DESCR = 'EEE'), 'DEFINED', 'V', NULL,
                                 NULL, NULL, NULL, 0, 'subst_dataset', NULL, NULL, NULL, NULL, NULL, NULL);

-- BBB > FFF
INSERT INTO BTN_SUBSTITUTE (ID, REGION_ID, CUST_STORE_NO, CUST_NO, BTN_ARTICLE_ID, SUBSTITUTE_BTN_ARTICLE_ID, SUBSTITUTE_DESCR, SUBSTITUTE_TYPE, ALTERNATIVE_TYPE, DATE_FROM, DATE_TO, USAGE_COUNT, VERSION, CREATED_INITIATOR, CREATED_TS, CREATED_USER_INFO, LAST_MODIF_USER_TS, LAST_MODIF_INITIATOR, LAST_MODIFIED_TS, LAST_MODIF_USER_INFO)
VALUES
  ((SEQ_BTN_SUBSTITUTE.NEXTVAL), 5, NULL, NULL, (SELECT ID
                                                 FROM BTN_ARTICLE
                                                 WHERE DESCR = 'BBB'), (SELECT ID
                                                                        FROM BTN_ARTICLE
                                                                        WHERE DESCR = 'FFF'), 'DEFINED', 'V', NULL,
                                 NULL, NULL, NULL, 0, 'subst_dataset', NULL, NULL, NULL, NULL, NULL, NULL);

-- CCC > GGG
INSERT INTO BTN_SUBSTITUTE (ID, REGION_ID, CUST_STORE_NO, CUST_NO, BTN_ARTICLE_ID, SUBSTITUTE_BTN_ARTICLE_ID, SUBSTITUTE_DESCR, SUBSTITUTE_TYPE, ALTERNATIVE_TYPE, DATE_FROM, DATE_TO, USAGE_COUNT, VERSION, CREATED_INITIATOR, CREATED_TS, CREATED_USER_INFO, LAST_MODIF_USER_TS, LAST_MODIF_INITIATOR, LAST_MODIFIED_TS, LAST_MODIF_USER_INFO)
VALUES
  ((SEQ_BTN_SUBSTITUTE.NEXTVAL), 5, NULL, NULL, (SELECT ID
                                                 FROM BTN_ARTICLE
                                                 WHERE DESCR = 'CCC'), (SELECT ID
                                                                        FROM BTN_ARTICLE
                                                                        WHERE DESCR = 'GGG'), 'DEFINED', 'V', NULL,
                                 NULL, NULL, NULL, 0, 'subst_dataset', NULL, NULL, NULL, NULL, NULL, NULL);

-- DDD > HHH
INSERT INTO BTN_SUBSTITUTE (ID, REGION_ID, CUST_STORE_NO, CUST_NO, BTN_ARTICLE_ID, SUBSTITUTE_BTN_ARTICLE_ID, SUBSTITUTE_DESCR, SUBSTITUTE_TYPE, ALTERNATIVE_TYPE, DATE_FROM, DATE_TO, USAGE_COUNT, VERSION, CREATED_INITIATOR, CREATED_TS, CREATED_USER_INFO, LAST_MODIF_USER_TS, LAST_MODIF_INITIATOR, LAST_MODIFIED_TS, LAST_MODIF_USER_INFO)
VALUES
  ((SEQ_BTN_SUBSTITUTE.NEXTVAL), 5, NULL, NULL, (SELECT ID
                                                 FROM BTN_ARTICLE
                                                 WHERE DESCR = 'DDD'), (SELECT ID
                                                                        FROM BTN_ARTICLE
                                                                        WHERE DESCR = 'HHH'), 'DEFINED', 'V', NULL,
                                 NULL, NULL, NULL, 0, 'subst_dataset', NULL, NULL, NULL, NULL, NULL, NULL);
