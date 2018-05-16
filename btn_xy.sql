update btn_xy set date_to = to_date('5.5.2018', 'DD.MM.YYYY');
update btn_xy set date_to = to_date('5.1.2018', 'DD.MM.YYYY') where id = 1;

SELECT * FROM WAPL_ROW WHERE CODELIST_ID IN (SELECT ID FROM WAPL_CODELIST WHERE KEY = 'xx_type');

select * from btn_article where id = '280418'; -- art no 338099
select * from btn_article where id = '280412'; -- art no 337742
select * from btn_article where id = '280329'; -- art no 356224

select * from btn_article where descr is not null and extra_type = 'Y';
select * from btn_article where descr is not null;

update btn_article set extra_type= 'Y', xy = 'A' where id = 280418;

select * from btn_xy;
SELECT * FROM BTN_XY_STORE;
SELECT * FROM BTN_DEL_TYPE;

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

-- 367820, 366640, 363292