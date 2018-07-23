update btn_xy set date_to = to_date('5.5.2018', 'DD.MM.YYYY');
update btn_xy set date_to = to_date('5.1.2018', 'DD.MM.YYYY') where id = 1;

select * from btn_article where id = '280418'; -- art no 338099
select * from btn_article where id = '280412'; -- art no 337742
select * from btn_article where id = '280329'; -- art no 356224

select * from btn_article where descr is not null and extra_type = 'Y';
select * from btn_article where descr is not null;

update btn_article set extra_type= 'Y', xy = 'A' where id = 280418;

select * from btn_xy;
SELECT * FROM BTN_XY_STORE;
SELECT * FROM BTN_DEL_TYPE;
SELECT * FROM BTN_XY_LINKAGE;

select sysdate + interval '30' day from dual;

SELECT TRUNC(to_timestamp('28.03.2018 09:39:00','DD.MM.YYYY HH:MI:SS'), 'MI') "New Year" FROM DUAL;

select TRUNC(sysdate, 'MI') from dual;

update btn_xy set BTN_ARTICLE_ID_LEAD = '292308', BTN_ARTICLE_ID_1 = '292309', BTN_ARTICLE_ID_2 = '292310' where id = 41;

update btn_xy set LAST_USED_TS = to_timestamp('28.03.2018 09:39:00,000000000','DD.MM.YYYY HH:MI:SS,FF') where id = 21;

select * from BTN_ARTICLE where ART_NO_DEPOSIT is NOT NULL;
select a.* from BTN_ARTICLE a  where a.ART_NO_DEPOSIT is NOT NULL and exists (select b.id from btn_article b where b.art_no = a.ART_NO_DEPOSIT);

select * from BTN_DOC_LINE where DEPOSIT_LINKAGE is not null;

select s.STOCK_ORDERED, s.ORDERABLE, s.* from BTN_ARTICLE_STORE s where s.BTN_ARTICLE_ID = 278918;

update BTN_ARTICLE_STORE set ART_QTY = 50, STOCK_ACT = 10, STOCK_MIN = 1, STOCK_ORDERED = 10, ACTIVE = 'A', ORDERABLE = 'A' where BTN_ARTICLE_ID = 278918;

select a.ART_NO_DEPOSIT, a.* from BTN_ARTICLE a where a.ID = 278918; -- 366846
select * from BTN_ARTICLE where ID = 279236;

select btn_xy_id, cod_store, name, picking_note, date_from,
  date_to, btn_article_id_lead, art_descr_lead, btn_article_id_1, art_descr_1, quantity_1, sell_price_1,
  btn_article_id_2, art_descr_2, quantity_2, sell_price_2, max_quantity
from btn_xy xy,
  btn_xy_store xy_store
where xy.id = xy_store.btn_xy_id
  and xy.active = 'A'
  and xy.btn_article_id_lead = 293832
  and xy_store.cod_store = 6
  --and trunc(sysdate) between xy.date_from and xy.date_to
;

  select art.id
  from btn_article art,
  (
    select xy.btn_article_id_lead
    from btn_xy xy,
      btn_xy_store xy_store
    where xy.id = xy_store.btn_xy_id
      and xy.active = 'A'
      and ((trunc(sysdate) between xy.date_from - 1 and xy.date_to)
        or (trunc(sysdate) + 1 between xy.date_from - 1 and xy.date_to)
        or (trunc(sysdate) + 2 between xy.date_from - 1 and xy.date_to))
  ) xy_line
  where art.id = xy_line.btn_article_id_lead (+)
   and ((art.xy is not null and xy_line.btn_article_id_lead is null) or (art.xy is null and xy_line.btn_article_id_lead is not null));