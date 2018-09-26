select * from BTN_OWNER.BTN_CUST_PARAM;
select * from BTN_OWNER.BTN_CUST_PARAM where CUST_PAR_NAME = 'cust_payment';
select MARKUP from BTN_ARTICLE;
select distinct CUST_CIP_TYPE from BTN_CUST;
select distinct CIP_TYPE from btn_cip_v;
select distinct SELL_PRICE_TYPE from BTN_DOC_LINE;

select * from BTN_DOC_LINE order by id desc;
select * from WAPL_OWNER.WAPL_REGION;

select EXTRA_MARKUP from BTN_DOC_LINE;
select * from BTN_DOC order by id desc;
update btn_doc set TABACCO_SALE = null where id = 5329151;

update BTN_CUST set TABACCO_SALE = 'A' where cust_no = 903;


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
  ast.SELL_PRICE,
  a.mutation_stock_koef,
  ast.mut_art_qty,
  ast.depot_mut_art_qty
FROM btn_article a LEFT JOIN btn_article_store ast ON a.id = ast.btn_article_id
  where
    ast.SELL_PRICE  is not null
    and ast.ART_QTY is not null
    and ast.SELL_PRICE like '%|C|%'
order by ast.ART_QTY desc;

select /*+RESULT_CACHE */ r.key, nvl(val.text, r.key) label, master_r.key master_key
from wapl_codelist cl
 ,wapl_row r
 ,wapl_row master_r
 ,(
  select val.row_id, val.text
  from wapl_val val,
    wapl_locale loc
  where val.locale_id = loc.id
    and (loc.name = 'cs_CZ' or upper(loc.name) like upper('cs_CZ%'))
  ) val
where cl.id = r.codelist_id
  and r.master_row_id = master_r.id (+)
  and r.id = val.row_id (+)
  and cl.key = 'extra_markup'
order by r.ord;