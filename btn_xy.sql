update btn_xy set date_to = to_date('5.5.2018', 'DD.MM.YYYY') where id = 41;

SELECT * FROM WAPL_ROW WHERE CODELIST_ID IN (SELECT ID FROM WAPL_CODELIST WHERE KEY = 'xx_type');

select * from btn_article where id = '292308'; -- art no 338099
select * from btn_article where id = '292309'; -- art no 337742
select * from btn_article where id = '293128'; -- art no 356224

select * from btn_article where descr is not null;

update btn_article set extra_type= 'Y', xy = 'A' where id = 292308;

select * from btn_xy;

update btn_xy set BTN_ARTICLE_ID_LEAD = '292308', BTN_ARTICLE_ID_1 = '292309', BTN_ARTICLE_ID_2 = '292310' where id = 41;


truncate table btn_icon;
select * from btn_icon;