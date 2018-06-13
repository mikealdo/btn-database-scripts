select a.id, a.ART_WEIGHT_MEAN, a.ART_UNIT, a.* from BTN_ARTICLE a where a.ART_WEIGHT_MEAN is not null;

select
  a.ARO_ARTICLE_NEW,
  a.*
from btn_article a
where ARO_ARTICLE_NEW is not null and ARO_ARTICLE_NEW > 0;

describe BTN_ARTICLE;

select
  a.LEADING_NO,
  a.*
from btn_article a
where a.LEADING_NO is not null;
select *
from btn_article
where descr like '%KEDLUBNA%';
select *
from btn_article
where id = '5085';
select
  a.cfa_parent_id,
  a.CFA_TYPE,
  a.*
from btn_article a
where a.cfa_parent_id is not null;
select
  a.cfa_parent_id,
  a.CFA_TYPE,
  a.*
from btn_article a
where id = '291489';

select
  original.art_no,
  original.MARKETING_NAME_CZ,
  original.CFA_TYPE,
  original.CFA_PARENT_ID
from btn_article original START WITH original.ART_NO = 10
CONNECT BY PRIOR CFA_PARENT_ID = ID;

select
  CFA_ARTICLE.ID as SUBSTITUTE_ART_ID,
  CFA_ARTICLE.ART_NO as SUBSTITUTE_ART_NO,
  CFA_ARTICLE.DESCR as SUBSTITUTE_ART_DESCR,
  CFA_ARTICLE.CFA_TYPE as SUBSTITUTE_CFA_TYPE,
  PARENT_ARTICLE.ID as PARENT_ID,
  PARENT_ARTICLE.ART_NO as PARENT_ART_NO
 from BTN_ARTICLE CFA_ARTICLE
   left join BTN_ARTICLE PARENT_ARTICLE on CFA_ARTICLE.CFA_PARENT_ID = PARENT_ARTICLE.ID
 where
   CFA_ARTICLE.CFA_TYPE IS NOT NULL
   AND (
       CFA_ARTICLE.CFA_PARENT_ID IN (select ID from BTN_ARTICLE where BTN_ARTICLE.ART_NO IN (11))
           or
       CFA_ARTICLE.ID in (select ID from BTN_ARTICLE where BTN_ARTICLE.ART_NO IN (11)));

select
  CFA_ARTICLE.ID as SUBSTITUTE_ART_ID,
  CFA_ARTICLE.ART_NO as SUBSTITUTE_ART_NO,
  CFA_ARTICLE.DESCR as SUBSTITUTE_ART_DESCR,
  CFA_ARTICLE.CFA_TYPE as SUBSTITUTE_CFA_TYPE,
  CFA_ARTICLE.CFA_PARENT_ID as SUBSTITUTE_PARENT_ID
 from BTN_ARTICLE CFA_ARTICLE
 where
   CFA_TYPE IS NOT NULL
   AND (
       CFA_ARTICLE.CFA_PARENT_ID IN (select CFA_PARENT_ID from BTN_ARTICLE where BTN_ARTICLE.ART_NO IN (10))
           or
       CFA_ARTICLE.ID in (select CFA_PARENT_ID from BTN_ARTICLE where BTN_ARTICLE.ART_NO IN (10)));

select CFA_PARENT_ID from BTN_ARTICLE where BTN_ARTICLE.ART_NO = 10;

update btn_article
set cfa_type = 'P'
where id = '291489';
update btn_article
set cfa_parent_id = '291489'
where id = '291409';


select
  c.CFA_ORDER,
  c.del_type,
  c.*
from btn_cust c
where c.del_type = 'SHC' and store_no = 2;
select del_type
from btn_doc;


Insert into BTN_SALE_CUST_ARTICLE (ID, CUST_STORE_NO, CUST_NO, BTN_ARTICLE_ID, SALE_DATE, QUANTITY, SALE_AMOUNT, STORE_NO, TILL_NO, INVOICE_NO, IND_INVOICE, BTN_DOC_ID, VERSION, CREATED_INITIATOR, CREATED_TS, CREATED_USER_INFO, LAST_MODIF_USER_TS, LAST_MODIF_INITIATOR, LAST_MODIFIED_TS, LAST_MODIF_USER_INFO)
values ('4016044894', '15', '700869', '5085', to_timestamp('28.03.2018 09:39:00,000000000', 'DD.MM.YYYY HH:MI:SS,FF'), '1', '160', '15', '79', '1579000882', '0', '5115304', '0', 'system',
        to_timestamp('10.04.2018 02:54:51,333000000', 'DD.MM.YYYY HH:MI:SS,FF'), null, null, null, null, null);

select *
from article_price_tmp;
select *
from DBA_USERS;
select count(*)
from BTN_PICKING_LINE;
select *
from CUST_ALL;