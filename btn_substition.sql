select *
from BTN_SUBSTITUTE
order by id;


SELECT
  a.art_no,
  a.CONT_SELL_UNIT,
  ast.ID,
  ast.ART_QTY,
  ast.depot_art_qty,
  a.mutation_stock_koef,
  ast.mut_art_qty,
  ast.depot_mut_art_qty
from BTN_ARTICLE a left join BTN_ARTICLE_STORE ast on a.ID = ast.BTN_ARTICLE_ID
where a.id = 290402 and ast.STORE_NO = 6;


select a.id
from BTN_ARTICLE a
where a.CONT_SELL_UNIT is null;

update BTN_ARTICLE_STORE
set ART_QTY = 36
where id = 448545360;

select SUBST_PREFER
from btn_cust;

select *
from article_all;
select
  store_no,
  art_no,
  descr,
  stock,
  STOCK_REC,
  RESERVED_STOCK
from lts_owner.article_all
where store_no = 6 and stock > 0;

select distinct aro_article_new
from BTN_OWNER.BTN_ARTICLE;
select distinct *
from OWN_BRAND_TMP;

select *
from WAPL_REGION;

select doc_no
from btn_doc
where id = 5140948;
select *
from btn_doc_line
order by CREATED_TS desc;

select count(1)
from btn_article btn_art
  , btn_article_store btn_art_st
where btn_art.id = btn_art_st.btn_article_id
      and btn_art_st.store_no = 6
      and btn_art.art_no in (310835, 310870, 310874, 311080)
      and (nvl(btn_art_st.art_qty, 0) + nvl(btn_art_st.depot_art_qty, 0) +
           (nvl(btn_art.mutation_stock_koef, 1) * nvl(btn_art_st.mut_art_qty, 0)) +
           (nvl(btn_art.mutation_stock_koef, 1) * nvl(btn_art_st.depot_mut_art_qty, 0))) > 0
      and btn_art.active = 'A';

select *
from btn_article
where id = 290327;
select count(*)
from btn_article a left join btn_article_store ast on a.ID = ast.BTN_ARTICLE_ID
where a.ACTIVE = 'A' and ast.STORE_NO = 6;
select *
from btn_article
where MANUAL_BLOCK is null;
select *
from btn_article_store
where MANUAL_BLOCK = 'A';
select
  BTN_ARTICLE_ID,
  ACTIVE
from btn_article_store
where BLOCK_IND = 0 and STORE_NO = 6;


update BTN_ARTICLE
set MANUAL_BLOCK = 'A'
where ART_NO = '311972';
update BTN_ARTICLE
set ACTIVE = 'A'
where ART_NO = '310939';
update BTN_ARTICLE_STORE
set MANUAL_BLOCK = 'A'
where BTN_ARTICLE_ID = '291334';
update BTN_ARTICLE_STORE
set BLOCK_IND = '0', MANUAL_BLOCK = 'A'
where BTN_ARTICLE_ID = '291335';
update BTN_ARTICLE_STORE
set BLOCK_IND = null, MANUAL_BLOCK = null
where BTN_ARTICLE_ID = '290319';
update BTN_ARTICLE_STORE
set ACTIVE = 'N'
where BTN_ARTICLE_ID = '292836';

select
  a.id,
  a.ART_NO,
  a.ACTIVE,
  a.MANUAL_BLOCK,
  ast.ACTIVE,
  ast.MANUAL_BLOCK,
  ast.BLOCK_IND
from btn_article a left join btn_article_store ast on a.ID = ast.BTN_ARTICLE_ID
where ast.STORE_NO = 6
      and (ast.manual_block is NULL or ast.manual_block <> 'A')
      and (ast.block_ind is NULL or ast.block_ind <> 1)
      and (a.manual_block is NULL or a.manual_block <> 'A')
      and ast.ACTIVE = 'A' and a.ACTIVE = 'A'
      and art_no in (
  310939,
  310942,
  311972,
  311978,
  352059,
  322605);

select *
from BTN_DEL_TYPE;
select *
from BTN_SUBSTITUTE
start with BTN_ARTICLE_ID = 290285
connect by prior SUBSTITUTE_BTN_ARTICLE_ID = BTN_ARTICLE_ID
order siblings by SUBSTITUTE_BTN_ARTICLE_ID;

select
  this_.id                        as id1_95_3_,
  this_.BTN_ARTICLE_ID            as BTN_ARTICLE_ID18_95_3_,
  this_.SUBSTITUTE_BTN_ARTICLE_ID as SUBSTITUTE_BTN_AR20_95_3_,
  this_.SUBSTITUTE_DESCR          as SUBSTITUTE_DESCR15_95_3_,
  this_.SUBSTITUTE_TYPE           as SUBSTITUTE_TYPE16_95_3_
from BTN_SUBSTITUTE this_
  left outer join WAPL_REGION region5_ on this_.REGION_ID = region5_.id
  inner join BTN_ARTICLE subart1_ on this_.SUBSTITUTE_BTN_ARTICLE_ID = subart1_.id
where subart1_.ACTIVE = 'A' and
      this_.SUBSTITUTE_TYPE = 'C' and this_.CUST_STORE_NO = 6 and this_.CUST_NO = 224559
start with BTN_ARTICLE_ID = 290285
connect by prior SUBSTITUTE_BTN_ARTICLE_ID = BTN_ARTICLE_ID
order siblings by SUBSTITUTE_BTN_ARTICLE_ID;

-- cust_store_no, cust_no, regions, date_to, date_from
select
  substitute.id                                                                                            as ID,
  substitute.BTN_ARTICLE_ID                                                                                as ART_ID,
  substitute.SUBSTITUTE_BTN_ARTICLE_ID                                                                     as SUBSTITUTE_ART_ID,
  originalArticle.ART_NO                                                                                   as art_no,
  substArticle.ART_NO                                                                                      as substitute_art_no,
  substitute.CUST_NO                                                                                       as CUST_NO11_95_3_,
  substitute.CUST_STORE_NO                                                                                 as CUST_STORE_NO12_95_3_,
  substitute.SUBSTITUTE_DESCR                                                                              as SUBSTITUTE_DESCR15_95_3_,
  substitute.SUBSTITUTE_TYPE                                                                               as SUBSTITUTE_TYPE16_95_3_,
  region.NAME                                                                                              as REGION_NAME
from BTN_SUBSTITUTE substitute
  inner join BTN_ARTICLE originalArticle on substitute.BTN_ARTICLE_ID = originalArticle.id
  inner join BTN_ARTICLE substArticle on substitute.SUBSTITUTE_BTN_ARTICLE_ID = substArticle.id
  left join btn_article_store ast on substArticle.ID = ast.BTN_ARTICLE_ID
  left join WAPL_OWNER.WAPL_REGION region on substitute.REGION_ID = region.id
where ((substitute.CUST_STORE_NO = 6 and substitute.CUST_NO = 224559) or region.id in (5) or substitute.SUBSTITUTE_TYPE = 'P')
      and ((substitute.date_to is null and substitute.date_from is null) or (substitute.date_from <= to_timestamp('19-DEC-17 02.48.14.066000000 PM','DD-MON-RR HH.MI.SSXFF AM') and substitute.date_to is null) or (substitute.date_from<= to_timestamp('19-DEC-17 02.48.14.066000000 PM','DD-MON-RR HH.MI.SSXFF AM') and substitute.date_to>=to_timestamp('19-DEC-17 02.48.14.066000000 PM','DD-MON-RR HH.MI.SSXFF AM')))
      and ast.STORE_NO = 6
      and (ast.manual_block is NULL or ast.manual_block <> 'A')
      and (ast.block_ind is NULL or ast.block_ind <> 1)
      and (substArticle.manual_block is NULL or substArticle.manual_block <> 'A')
      and ast.ACTIVE = 'A'
      and substArticle.ACTIVE = 'A'
      and (NVL(substArticle.cfa_type, '-') <> 'P')
      and (nvl(ast.art_qty,0) + nvl(ast.depot_art_qty,0) + (nvl(substArticle.mutation_stock_koef, 1) * nvl(ast.mut_art_qty,0)) + (nvl(substArticle.mutation_stock_koef, 1) * nvl(ast.depot_mut_art_qty,0))) > 0;


select * from WAPL_OWNER.WAPL_REGION;

REM INSERTING into BTN_SUBSTITUTE
SET DEFINE OFF;
Insert into BTN_SUBSTITUTE (ID,REGION_ID,CUST_STORE_NO,CUST_NO,BTN_ARTICLE_ID,SUBSTITUTE_BTN_ARTICLE_ID,SUBSTITUTE_DESCR,SUBSTITUTE_TYPE,ALTERNATIVE_TYPE,DATE_FROM,DATE_TO,USAGE_COUNT,VERSION,CREATED_INITIATOR,CREATED_TS,CREATED_USER_INFO,LAST_MODIF_USER_TS,LAST_MODIF_INITIATOR,LAST_MODIFIED_TS,LAST_MODIF_USER_INFO) values
(SEQ_BTN_SUBSTITUTE.nextval,34,null,null,292391,292388,null,'A',null,null,null,null,1,'WAPL_LOCK/BTN_APL',to_timestamp('19-DEC-17 02.48.14.066000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'6382',null,null,null,null);
Insert into BTN_SUBSTITUTE (ID,REGION_ID,CUST_STORE_NO,CUST_NO,BTN_ARTICLE_ID,SUBSTITUTE_BTN_ARTICLE_ID,SUBSTITUTE_DESCR,SUBSTITUTE_TYPE,ALTERNATIVE_TYPE,DATE_FROM,DATE_TO,USAGE_COUNT,VERSION,CREATED_INITIATOR,CREATED_TS,CREATED_USER_INFO,LAST_MODIF_USER_TS,LAST_MODIF_INITIATOR,LAST_MODIFIED_TS,LAST_MODIF_USER_INFO) values
((SEQ_BTN_SUBSTITUTE.nextval),null,6,224559,290286,290402,null,'C','P',null,null,null,0,null,null,null,null,null,null,null);
Insert into BTN_SUBSTITUTE (ID,REGION_ID,CUST_STORE_NO,CUST_NO,BTN_ARTICLE_ID,SUBSTITUTE_BTN_ARTICLE_ID,SUBSTITUTE_DESCR,SUBSTITUTE_TYPE,ALTERNATIVE_TYPE,DATE_FROM,DATE_TO,USAGE_COUNT,VERSION,CREATED_INITIATOR,CREATED_TS,CREATED_USER_INFO,LAST_MODIF_USER_TS,LAST_MODIF_INITIATOR,LAST_MODIFIED_TS,LAST_MODIF_USER_INFO) values
((SEQ_BTN_SUBSTITUTE.nextval),null,6,224559,290402,290234,null,'C','P',null,null,null,0,null,null,null,null,null,null,null);
Insert into BTN_SUBSTITUTE (ID,REGION_ID,CUST_STORE_NO,CUST_NO,BTN_ARTICLE_ID,SUBSTITUTE_BTN_ARTICLE_ID,SUBSTITUTE_DESCR,SUBSTITUTE_TYPE,ALTERNATIVE_TYPE,DATE_FROM,DATE_TO,USAGE_COUNT,VERSION,CREATED_INITIATOR,CREATED_TS,CREATED_USER_INFO,LAST_MODIF_USER_TS,LAST_MODIF_INITIATOR,LAST_MODIFIED_TS,LAST_MODIF_USER_INFO) values
((SEQ_BTN_SUBSTITUTE.nextval),null,6,224559,291837,290285,null,'C','P',null,null,null,0,null,null,null,null,null,null,null);
Insert into BTN_SUBSTITUTE (ID,REGION_ID,CUST_STORE_NO,CUST_NO,BTN_ARTICLE_ID,SUBSTITUTE_BTN_ARTICLE_ID,SUBSTITUTE_DESCR,SUBSTITUTE_TYPE,ALTERNATIVE_TYPE,DATE_FROM,DATE_TO,USAGE_COUNT,VERSION,CREATED_INITIATOR,CREATED_TS,CREATED_USER_INFO,LAST_MODIF_USER_TS,LAST_MODIF_INITIATOR,LAST_MODIFIED_TS,LAST_MODIF_USER_INFO) values
((SEQ_BTN_SUBSTITUTE.nextval),null,6,224559,291838,290220,null,'C','P',null,null,null,0,null,null,null,null,null,null,null);
Insert into BTN_SUBSTITUTE (ID,REGION_ID,CUST_STORE_NO,CUST_NO,BTN_ARTICLE_ID,SUBSTITUTE_BTN_ARTICLE_ID,SUBSTITUTE_DESCR,SUBSTITUTE_TYPE,ALTERNATIVE_TYPE,DATE_FROM,DATE_TO,USAGE_COUNT,VERSION,CREATED_INITIATOR,CREATED_TS,CREATED_USER_INFO,LAST_MODIF_USER_TS,LAST_MODIF_INITIATOR,LAST_MODIFIED_TS,LAST_MODIF_USER_INFO) values
((SEQ_BTN_SUBSTITUTE.nextval),null,6,224559,291839,290402,null,'C','P',null,null,null,0,null,null,null,null,null,null,null);
Insert into BTN_SUBSTITUTE (ID,REGION_ID,CUST_STORE_NO,CUST_NO,BTN_ARTICLE_ID,SUBSTITUTE_BTN_ARTICLE_ID,SUBSTITUTE_DESCR,SUBSTITUTE_TYPE,ALTERNATIVE_TYPE,DATE_FROM,DATE_TO,USAGE_COUNT,VERSION,CREATED_INITIATOR,CREATED_TS,CREATED_USER_INFO,LAST_MODIF_USER_TS,LAST_MODIF_INITIATOR,LAST_MODIFIED_TS,LAST_MODIF_USER_INFO) values
((SEQ_BTN_SUBSTITUTE.nextval),null,6,224559,291837,290232,null,'C','P',null,null,null,0,null,null,null,null,null,null,null);
Insert into BTN_SUBSTITUTE (ID,REGION_ID,CUST_STORE_NO,CUST_NO,BTN_ARTICLE_ID,SUBSTITUTE_BTN_ARTICLE_ID,SUBSTITUTE_DESCR,SUBSTITUTE_TYPE,ALTERNATIVE_TYPE,DATE_FROM,DATE_TO,USAGE_COUNT,VERSION,CREATED_INITIATOR,CREATED_TS,CREATED_USER_INFO,LAST_MODIF_USER_TS,LAST_MODIF_INITIATOR,LAST_MODIFIED_TS,LAST_MODIF_USER_INFO) values
((SEQ_BTN_SUBSTITUTE.nextval),null,2,302161,291072,290834,null,'C','P',null,null,null,1,null,null,null,null,null,null,null);
Insert into BTN_SUBSTITUTE (ID,REGION_ID,CUST_STORE_NO,CUST_NO,BTN_ARTICLE_ID,SUBSTITUTE_BTN_ARTICLE_ID,SUBSTITUTE_DESCR,SUBSTITUTE_TYPE,ALTERNATIVE_TYPE,DATE_FROM,DATE_TO,USAGE_COUNT,VERSION,CREATED_INITIATOR,CREATED_TS,CREATED_USER_INFO,LAST_MODIF_USER_TS,LAST_MODIF_INITIATOR,LAST_MODIFIED_TS,LAST_MODIF_USER_INFO) values
((SEQ_BTN_SUBSTITUTE.nextval),null,2,299417,291837,290220,null,'C','B',null,null,null,0,null,null,null,null,null,null,null);
Insert into BTN_SUBSTITUTE (ID,REGION_ID,CUST_STORE_NO,CUST_NO,BTN_ARTICLE_ID,SUBSTITUTE_BTN_ARTICLE_ID,SUBSTITUTE_DESCR,SUBSTITUTE_TYPE,ALTERNATIVE_TYPE,DATE_FROM,DATE_TO,USAGE_COUNT,VERSION,CREATED_INITIATOR,CREATED_TS,CREATED_USER_INFO,LAST_MODIF_USER_TS,LAST_MODIF_INITIATOR,LAST_MODIFIED_TS,LAST_MODIF_USER_INFO) values
((SEQ_BTN_SUBSTITUTE.nextval),null,6,224559,291410,291489,null,'C','P',null,null,null,0,null,null,null,null,null,null,null);

