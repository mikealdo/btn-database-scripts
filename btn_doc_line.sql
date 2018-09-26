SELECT ART_MU, ART_MU_QUANTITY
FROM BTN_DOC_LINE dl where ART_MU_QUANTITY != '1.000' order by DOC_DATE desc;

select * from ARTICLE_ALL;

select distinct d.STORE_TYPE from btn_doc d;

select d.EXTERNAL_DOC_NO, d.* from btn_doc d where EXTERNAL_DOC_NO is not null and DOC_TYPE = 'OBJ' order by DOC_DATE desc ;

select * from BTN_DOC_LINE order by id desc;
select dl.* from BTN_DOC_LINE dl left join BTN_ARTICLE a on dl.BTN_ARTICLE_ID = a.ID where a.CREATED_INITIATOR = 'subst_dataset' order by dl.id desc;
select dl.* from BTN_DOC_LINE dl left join BTN_ARTICLE a on dl.BTN_ARTICLE_ID = a.ID where a.desc = 'AAA' order by dl.id desc;

delete from BTN_DOC_LINE dl where BTN_ARTICLE_ID in (select ID from BTN_ARTICLE a where dl.BTN_ARTICLE_ID = a.ID and a.CREATED_INITIATOR = 'subst_dataset');

SELECT * from BTN_XX_LINE;
SELECT * from BTN_XY;
delete from  BTN_XX_LINE;
DELETE FROM BTN_XY;
DELETE FROM BTN_XY_STORE;

delete from BTN_ARTICLE where id in (
    (SELECT ID
                               FROM BTN_ARTICLE
                               WHERE DESCR = 'AAA')
);

select OWNER, CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME, SEARCH_CONDITION, * from ALL_CONSTRAINTS where CONSTRAINT_NAME = 'BTN_ARTICLE_STO_BTN_ARTICLE_FK';

delete from BTN_DOC_LINE where id in (
91303379,
91303378,
91303377,
91303376,
91303375,
91303374,
91303370,
91303369,
91303368,
91303367,
91303366,
91303365,
91303364,
91303363,
91303362,
91303354,
91303353,
91303352,
91303351,
91303350,
91303349,
91303348

);

SELECT *
FROM BTN_DOC_LINE dl
WHERE dl.LINE_STATUS = 'X' AND dl.DOC_TYPE = 'OBP' AND exists(SELECT d.id
                                                              FROM btn_doc d
                                                              WHERE d.id = dl.BTN_DOC_ID);
SELECT * FROM BTN_DOC where COUNT_LINE > 7;
select SELL_PRICE_TYPE
from BTN_DOC_LINE where SELL_PRICE_TYPE like '%AKCE XY%';

select SELL_PRICE from BTN_ARTICLE_STORE where SELL_PRICE is not null;

SELECT
  d.id,
  count(dl.id) as cnt
FROM btn_doc d left join btn_doc_line dl on d.ID = dl.BTN_DOC_ID
GROUP BY d.ID
HAVING count(dl.ID) > 10
ORDER BY cnt desc;

UPDATE BTN_DOC_LINE
SET LINE_STATUS = 'X'
WHERE BTN_DOC_ID = 800022852;

SELECT *
FROM btn_doc
WHERE DOC_TYPE = 'FAK' and store_no = 6 and cust_no = 224559;

update btn_doc set DOC_DATE = TO_TIMESTAMP('2018-04-03 00:01:00', 'YYYY-MM-DD HH24:MI:SS')
WHERE DOC_TYPE = 'FAK' and store_no = 6 and cust_no = 224559;

update btn_doc_line set DOC_DATE = TO_TIMESTAMP('2018-04-03 00:01:00', 'YYYY-MM-DD HH24:MI:SS') where BTN_DOC_ID = 4860726;

SELECT *
FROM btn_doc
WHERE id = '2238130';

select max(id) from BTN_DOC;

select * from btn_doc where FLAG_STATUS = 'U';
update btn_doc set FLAG_STATUS = null where FLAG_STATUS = 'U';

select id, doc_status, DOC_TYPE, PREORD_TYPE, preord_Dt_From, preord_ord2cust, trunc(preord_Dt_From - preord_ord2cust) from btn_doc where PREORD_TYPE = 'J' ORDER BY DOC_DATE desc;

update BTN_DOC set preord_Dt_From = TO_TIMESTAMP('2018-04-03 00:01:00', 'YYYY-MM-DD HH24:MI:SS'), preord_ord2cust = 0, DOC_DATE = TO_TIMESTAMP('2018-04-02 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), DOC_STATUS = 'O' where id = 4927368;


select line.*,
   art_st.art_note art_note,
   art_st.art_status art_status,
   art_st.art_status_depot art_status_depot,
   art.art_no art_no,
   doc.cust_no doc_cust_no,
   doc.cust_store_no doc_cust_store_no,
   btn_grp_type.invoice_warning,
   btn_grp_type.ddc_no,
   art_st.block_ind
  from btn_doc doc,
    btn_doc_line line,
    btn_article art,
    btn_article_store art_st,
    btn_grp_type btn_grp_type
  where doc.id = line.btn_doc_id
    and doc.doc_date = line.doc_date
    and line.btn_article_id = art.id (+)
    and art.id = art_st.btn_article_id (+)
    and art.grp_type = btn_grp_type.grp_type (+)
    and (art_st.store_no is null or doc.store_no = art_st.store_no)
    and doc.id = 4860726;

select line.*, asrt.*
from (
  select line.*,
   art_st.art_note art_note,
   art_st.art_status art_status,
   art_st.art_status_depot art_status_depot,
   art.art_no art_no,
   doc.cust_no doc_cust_no,
   doc.cust_store_no doc_cust_store_no,
   btn_grp_type.invoice_warning,
   btn_grp_type.ddc_no,
   art_st.block_ind
  from btn_doc doc,
    btn_doc_line line,
    btn_article art,
    btn_article_store art_st,
    btn_grp_type btn_grp_type
  where doc.id = line.btn_doc_id
    and doc.doc_date = line.doc_date
    and line.btn_article_id = art.id (+)
    and art.id = art_st.btn_article_id (+)
    and art.grp_type = btn_grp_type.grp_type (+)
    and (art_st.store_no is null or doc.store_no = art_st.store_no)
    and doc.id = 4860726
) line,
(
  select cust_no, customer_store_no, btn_article_id asrt_btn_article_id, assortment_type, assortment_descr
  from btn_assortment
  where sysdate between date_from and date_to
) asrt
where line.doc_cust_no = asrt.cust_no (+)
  and line.doc_cust_store_no = asrt.customer_store_no (+)
  and line.btn_article_id = asrt.asrt_btn_article_id (+)
order by line.line_no asc, line.line_sub_no asc nulls first;
