SELECT *
FROM btn_substitute
ORDER BY id;

(SELECT * FROM BTN_ARTICLE WHERE DESCR = 'KKK');

SELECT * from BTN_DOC_LINE where order by doc_date desc;
select * from BTN_DOC_LINE_SUBSTITUTE;

delete from btn_doc_line where id in (
91303326,
91303324,
91303327,
91303342,
91303345,
91303344,
91303322,
91303346,
91303347,
91303343,
91303302,
91303297,
91303298,
91303296,
91303295,
91303294,
91303286,
91303287,
91303288,
91303289,
91303290,
91303291,
91303292,
91303293
);

select a.id, a.ART_NO, a.LEADING_NO, a.DESCR, a.CFA_TYPE, a.CFA_PARENT_ID from BTN_ARTICLE a where a.LEADING_NO = 'CFA123456';


delete from BTN_SUBSTITUTE where id = 788;

SELECT
  a.art_no,
  a.ACTIVE,
  a.DESCR,
  a.cont_sell_unit,
  a.GRP_TYPE,
  a.GRP_DESCR,
  a.GRP_NO,
  ast.id,
  ast.art_qty,
  ast.depot_art_qty,
  a.mutation_stock_koef,
  ast.mut_art_qty,
  ast.depot_mut_art_qty
FROM btn_article a LEFT JOIN btn_article_store ast ON a.id = ast.btn_article_id
  where ast.SELL_PRICE  is not null and ast.ART_QTY is not null
order by ast.ART_QTY desc;

select aa.art_no from article_all aa left join BTN_ARTICLE a on aa.art_no = a.ART_NO;
select * from BTN_GRP_TYPE;
select distinct grp_no, GRP_DESCR from BTN_ARTICLE order by grp_no;

update btn_article_store set ART_QTY = floor(dbms_random.value(0, 10));
update btn_article_store set ART_QTY = floor(dbms_random.value(0, 10)) where BTN_ARTICLE_ID in (select a.id from BTN_ARTICLE a where a.grp_no in (
627,
582,
402,
410,
102,
424
));
update btn_article_store set ART_QTY = 6 where id = 448556877;

select a.id from BTN_ARTICLE a where a.grp_no in (
627,
582,
402,
410,
102,
424
);

select grp_no, GRP_DESCR, count(*) as grouped_count from BTN_ARTICLE a having count(*) > 10 group by grp_no, GRP_DESCR order by count(*) desc;

SELECT count(*) FROM btn_article_store where ACTIVE = 'N';
SELECT count(*) FROM btn_article_store where ACTIVE = 'A';
SELECT * FROM btn_article_store where SELL_PRICE is not null;

update BTN_ARTICLE_STORE set ACTIVE = 'A';

select a.active, a.DESCR from BTN_ARTICLE a where DESCR like '%JACOBS%';

SELECT *
FROM btn_store_v;

select * from BTN_DEL_TYPE;

update BTN_DEL_TYPE set COD_STORE = null;

SELECT a.id
FROM btn_article a;


SELECT a.id
FROM btn_article a
WHERE a.cont_sell_unit IS NOT NULL;

UPDATE btn_article_store
SET art_qty = 36
WHERE id = 448545360;

SELECT *
FROM btn_cust
where store_no = 6;
SELECT *
FROM btn_cust
where cust_no = '150775';
SELECT *
from BTN_GRP_TYPE;
SELECT *
from BTN_DOC_LINE order by doc_date desc;
SELECT *
from BTN_DOC;


SELECT *
FROM article_all;
SELECT
  store_no,
  art_no,
  descr,
  stock,
  stock_rec,
  reserved_stock
FROM lts_owner.article_all
WHERE store_no = 6 AND stock > 0;

SELECT DISTINCT aro_article_new
FROM btn_owner.btn_article;
SELECT DISTINCT *
FROM own_brand_tmp;

SELECT *
FROM wapl_region;

SELECT doc_no
FROM btn_doc
WHERE id = 5140948;
SELECT *
FROM btn_doc_line
ORDER BY created_ts DESC;

SELECT count(1)
FROM btn_article btn_art
  , btn_article_store btn_art_st
WHERE btn_art.id = btn_art_st.btn_article_id
      AND btn_art_st.store_no = 6
      AND btn_art.art_no IN (310835, 310870, 310874, 311080)
      AND (nvl(btn_art_st.art_qty, 0) + nvl(btn_art_st.depot_art_qty, 0) +
           (nvl(btn_art.mutation_stock_koef, 1) * nvl(btn_art_st.mut_art_qty, 0)) +
           (nvl(btn_art.mutation_stock_koef, 1) * nvl(btn_art_st.depot_mut_art_qty, 0))) > 0
      AND btn_art.active = 'A';

SELECT *
FROM btn_article
WHERE id = 290327;
SELECT count(*)
FROM btn_article;
SELECT count(*)
FROM btn_article a LEFT JOIN btn_article_store ast ON a.id = ast.btn_article_id
WHERE a.active = 'A' AND ast.store_no = 6;
SELECT *
FROM btn_article
WHERE manual_block IS NULL;
SELECT *
FROM btn_article_store
WHERE manual_block = 'A';
SELECT
  btn_article_id,
  active
FROM btn_article_store
WHERE block_ind = 0 AND store_no = 6;


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

SELECT
  a.id,
  a.art_no,
  a.active,
  a.manual_block,
  ast.active,
  ast.manual_block,
  ast.block_ind
FROM btn_article a LEFT JOIN btn_article_store ast ON a.id = ast.btn_article_id
WHERE ast.store_no = 6
      AND (ast.manual_block IS NULL OR ast.manual_block <> 'A')
      AND (ast.block_ind IS NULL OR ast.block_ind <> 1)
      AND (a.manual_block IS NULL OR a.manual_block <> 'A')
      AND ast.active = 'A' AND a.active = 'A'
      AND art_no IN (
  310939,
  310942,
  311972,
  311978,
  352059,
  322605);

SELECT *
FROM btn_del_type;
SELECT *
FROM btn_substitute
START WITH btn_article_id = 290285
CONNECT BY PRIOR substitute_btn_article_id = btn_article_id
ORDER SIBLINGS BY substitute_btn_article_id;

SELECT
  this_.id                        AS id1_95_3_,
  this_.btn_article_id            AS btn_article_id18_95_3_,
  this_.substitute_btn_article_id AS substitute_btn_ar20_95_3_,
  this_.substitute_descr          AS substitute_descr15_95_3_,
  this_.substitute_type           AS substitute_type16_95_3_
FROM btn_substitute this_
  LEFT OUTER JOIN wapl_region region5_ ON this_.region_id = region5_.id
  INNER JOIN btn_article subart1_ ON this_.substitute_btn_article_id = subart1_.id
WHERE subart1_.active = 'A' AND
      this_.substitute_type = 'C' AND this_.cust_store_no = 6 AND this_.cust_no = 224559
START WITH btn_article_id = 290285
CONNECT BY PRIOR substitute_btn_article_id = btn_article_id
ORDER SIBLINGS BY substitute_btn_article_id;

select *
from btn_article_store;
SELECT R.ID
FROM WAPL_REGION_MAP RM LEFT JOIN WAPL_REGION R ON RM.STORE_NO = R.ID
WHERE RM.STORE_NO = 6;

-- cust_store_no, cust_no, regions, date_to, date_from
SELECT
  substitute.id                                                                AS id,
  substitute.btn_article_id                                                    AS art_id,
  substitute.substitute_btn_article_id                                         AS substitute_art_id,
  originalarticle.art_no                                                       AS art_no,
  substarticle.art_no                                                          AS substitute_art_no,
  substitute.cust_no                                                           AS cust_no11_95_3_,
  substitute.cust_store_no                                                     AS cust_store_no12_95_3_,
  substitute.substitute_descr                                                  AS substitute_descr15_95_3_,
  substitute.substitute_type                                                   AS substitute_type16_95_3_,
  region.name                                                                  AS region_name,
  ast.ID                                                                       as ast_id,
  (nvl(ast.art_qty, 0) + nvl(ast.depot_art_qty, 0) +
   (nvl(substarticle.mutation_stock_koef, 1) * nvl(ast.mut_art_qty, 0)) +
   (nvl(substarticle.mutation_stock_koef, 1) * nvl(ast.depot_mut_art_qty, 0))) as quantity
FROM btn_substitute substitute
  INNER JOIN btn_article originalarticle ON substitute.btn_article_id = originalarticle.id
  INNER JOIN btn_article substarticle ON substitute.substitute_btn_article_id = substarticle.id
  LEFT JOIN btn_article_store ast ON SUBSTARTICLE.ID = ast.btn_article_id
  LEFT JOIN wapl_owner.wapl_region region ON substitute.region_id = region.id
WHERE ((substitute.cust_store_no = 6 AND substitute.cust_no = 150775) OR region.id IN (5) OR
       substitute.substitute_type = 'P')
      AND ((substitute.date_to IS NULL AND substitute.date_from IS NULL) OR
           (substitute.date_from <= to_timestamp('19-DEC-17 02.48.14.066000000 PM', 'DD-MON-RR HH.MI.SSXFF AM') AND
            substitute.date_to IS NULL) OR
           (substitute.date_from <= to_timestamp('19-DEC-17 02.48.14.066000000 PM', 'DD-MON-RR HH.MI.SSXFF AM') AND
            substitute.date_to >= to_timestamp('19-DEC-17 02.48.14.066000000 PM', 'DD-MON-RR HH.MI.SSXFF AM')))
      AND ast.store_no = 6
      AND (ast.manual_block IS NULL OR ast.manual_block <> 'A')
      AND (ast.block_ind IS NULL OR ast.block_ind <> 1)
      AND (substarticle.manual_block IS NULL OR substarticle.manual_block <> 'A')
      AND ast.active = 'A'
      AND substarticle.active = 'A'
      AND (NVL(substarticle.cfa_type, '-') <> 'P')
      AND (nvl(ast.art_qty, 0) + nvl(ast.depot_art_qty, 0) +
           (nvl(substarticle.mutation_stock_koef, 1) * nvl(ast.mut_art_qty, 0)) +
           (nvl(substarticle.mutation_stock_koef, 1) * nvl(ast.depot_mut_art_qty, 0))) > 0;

select
  SUBSTITUTE.ID                        as ID,
  SUBSTITUTE.BTN_ARTICLE_ID            as ART_ID,
  SUBSTITUTE.SUBSTITUTE_BTN_ARTICLE_ID as SUBSTITUTE_ART_ID,
  ORIGINALARTICLE.ART_NO               as ART_NO,
  ORIGINALARTICLE.DESCR                as ART_DESCR,
  SUBSTARTICLE.ART_NO                  as SUBSTITUTE_ART_NO,
  SUBSTARTICLE.DESCR                   as SUBSTITUTE_ART_DESCR,
  SUBSTITUTE.SUBSTITUTE_DESCR          as SUBSTITUTE_DESCR1PTION,
  SUBSTITUTE.SUBSTITUTE_TYPE           as SUBSTITUTE_TYPE
from BTN_SUBSTITUTE SUBSTITUTE inner join BTN_ARTICLE ORIGINALARTICLE on SUBSTITUTE.BTN_ARTICLE_ID = ORIGINALARTICLE.ID
  inner join BTN_ARTICLE SUBSTARTICLE on SUBSTITUTE.SUBSTITUTE_BTN_ARTICLE_ID = SUBSTARTICLE.ID
  left join BTN_ARTICLE_STORE AST on SUBSTARTICLE.ID = AST.BTN_ARTICLE_ID
  left join WAPL_OWNER.WAPL_REGION REGION on SUBSTITUTE.REGION_ID = REGION.ID
where ((SUBSTITUTE.CUST_STORE_NO = 6 and SUBSTITUTE.CUST_NO = 6) or SUBSTITUTE.SUBSTITUTE_TYPE = 'P') and
      ((SUBSTITUTE.DATE_TO is null and SUBSTITUTE.DATE_FROM is null) or (SUBSTITUTE.DATE_FROM <= to_timestamp('19-DEC-17 02.48.14.066000000 PM', 'DD-MON-RR HH.MI.SSXFF AM') and SUBSTITUTE.DATE_TO is null) or
       (SUBSTITUTE.DATE_FROM <= to_timestamp('19-DEC-17 02.48.14.066000000 PM', 'DD-MON-RR HH.MI.SSXFF AM') and SUBSTITUTE.DATE_TO >= to_timestamp('19-DEC-18 02.48.14.066000000 PM', 'DD-MON-RR HH.MI.SSXFF AM'))) and AST.STORE_NO = 6 and (AST.MANUAL_BLOCK is NULL or AST.MANUAL_BLOCK <> 'A') and
      (AST.BLOCK_IND is NULL or AST.BLOCK_IND <> 1) and (SUBSTARTICLE.MANUAL_BLOCK is NULL or SUBSTARTICLE.MANUAL_BLOCK <> 'A') and AST.ACTIVE = 'A' and SUBSTARTICLE.ACTIVE = 'A' and
      (nvl(AST.ART_QTY, 0) + nvl(AST.DEPOT_ART_QTY, 0) + (nvl(SUBSTARTICLE.MUTATION_STOCK_KOEF, 1) * nvl(AST.MUT_ART_QTY, 0)) + (nvl(SUBSTARTICLE.MUTATION_STOCK_KOEF, 1) * nvl(AST.DEPOT_MUT_ART_QTY, 0))) > 0;

select
  SUBSTITUTE.ID                                                                                            as ID,
  SUBSTITUTE.BTN_ARTICLE_ID                                                                                as ART_ID,
  SUBSTITUTE.SUBSTITUTE_BTN_ARTICLE_ID                                                                     as SUBSTITUTE_ART_ID,
  ORIGINALARTICLE.ART_NO                                                                                   as ART_NO,
  ORIGINALARTICLE.DESCR                                                                                    as ART_DESCR,
  SUBSTARTICLE.ART_NO                                                                                      as SUBSTITUTE_ART_NO,
  SUBSTARTICLE.DESCR                                                                                       as SUBSTITUTE_ART_DESCR,
  SUBSTITUTE.SUBSTITUTE_DESCR                                                                              as SUBSTITUTE_DESCR1PTION,
  SUBSTITUTE.SUBSTITUTE_TYPE                                                                               as SUBSTITUTE_TYPE,
  SUBSTITUTE.USAGE_COUNT                                                                                   as SUBSTITUTE_USAGE_COUNT
 from BTN_SUBSTITUTE SUBSTITUTE
  inner join BTN_ARTICLE ORIGINALARTICLE on SUBSTITUTE.BTN_ARTICLE_ID = ORIGINALARTICLE.ID
  inner join BTN_ARTICLE SUBSTARTICLE on SUBSTITUTE.SUBSTITUTE_BTN_ARTICLE_ID = SUBSTARTICLE.ID
  left join BTN_ARTICLE_STORE AST on SUBSTARTICLE.ID = AST.BTN_ARTICLE_ID
  left  join WAPL_OWNER.WAPL_REGION REGION on SUBSTITUTE.REGION_ID = REGION.ID
 where (
           (SUBSTITUTE.CUST_STORE_NO = 6 and SUBSTITUTE.CUST_NO = 150775)
               or REGION.ID in (5
,34
,35
,140
,360
,420
,442
,463
,503
,563
,160
,400
,100
,340
,380
,440
,583
,623
,320
,322
,443
,483
,544)
               or SUBSTITUTE.SUBSTITUTE_TYPE = 'P'
       )
      and (
               (SUBSTITUTE.DATE_TO is null and SUBSTITUTE.DATE_FROM is null)
                   or (SUBSTITUTE.DATE_FROM <= to_timestamp('06-JUN-18 00.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM') and SUBSTITUTE.DATE_TO is null)
                   or (SUBSTITUTE.DATE_FROM<= to_timestamp('06-JUN-18 00.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM') and SUBSTITUTE.DATE_TO>=to_timestamp('06-JUN-18 00.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'))
           )
      and AST.STORE_NO = 6
      and (AST.MANUAL_BLOCK is NULL or AST.MANUAL_BLOCK <> 'A')
      and (AST.BLOCK_IND is NULL or AST.BLOCK_IND <> 1)
      and (SUBSTARTICLE.MANUAL_BLOCK is NULL or SUBSTARTICLE.MANUAL_BLOCK <> 'A')
      and AST.ACTIVE = 'A'
      and SUBSTARTICLE.ACTIVE = 'A'
      and (nvl(AST.ART_QTY,0) + nvl(AST.DEPOT_ART_QTY,0) + (nvl(SUBSTARTICLE.MUTATION_STOCK_KOEF, 1) * nvl(AST.MUT_ART_QTY,0)) + (nvl(SUBSTARTICLE.MUTATION_STOCK_KOEF, 1) * nvl(AST.DEPOT_MUT_ART_QTY,0))) > 0;



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
   AND CFA_ARTICLE.LEADING_NO IN (select LEADING_NO from BTN_ARTICLE where BTN_ARTICLE.ART_NO IN ('-99991'));

--    (
--        CFA_ARTICLE.CFA_PARENT_ID IN (select CFA_PARENT_ID from BTN_ARTICLE where BTN_ARTICLE.ART_NO IN ('-99991'))
--            or
--        CFA_ARTICLE.ID in (select CFA_PARENT_ID from BTN_ARTICLE where BTN_ARTICLE.ART_NO IN ('-99991')));


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
       CFA_ARTICLE.CFA_PARENT_ID IN (select ID from BTN_ARTICLE where BTN_ARTICLE.ART_NO IN ('-999911'))
           or
       CFA_ARTICLE.ID in (select ID from BTN_ARTICLE where BTN_ARTICLE.ART_NO IN ('-999911')));