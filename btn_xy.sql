update btn_xy set date_to = to_date('5.5.2018', 'DD.MM.YYYY') where id = 41;

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

update btn_xy set BTN_ARTICLE_ID_LEAD = '292308', BTN_ARTICLE_ID_1 = '292309', BTN_ARTICLE_ID_2 = '292310' where id = 41;


truncate table btn_icon;
select * from btn_icon;