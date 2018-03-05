update btn_icon set icon = null, icon_2 = null;

update wapl_user set login_db = 'ppt_qa' WHERE id = 37;

-- 119518

-- 119267

select * from btn_catalog where catalog_name = 'dd' order by id desc;
select * from btn_catalog where catalog_name = 'ee' order by id desc;
select max(id) from btn_catalog;

SELECT SEQ_BTN_CATALOG.NEXTVAL FROM dual;

select * from btn_doc where id = 4856188;
select * from btn_cust where cust_no = 701518;

select id, store_no, cust_no, inherit_cip, inherit_cip_store_no from btn_cust where cust_no = 701733;
select id, store_no, cust_no, inherit_cip, inherit_cip_store_no, cust_full_name from btn_cust where inherit_cip is not null and id = 126538;

select * from btn_cip_v where cust_id = 80337 or (cust_no, cust_store_no) in (select inherit_cip, inherit_cip_store_no from btn_cust where id = 80337); --inherit_cip_store_no

select * from btn_cip_v where cust_id in (select id from btn_cust where inherit_cip is not null);

select * from btn_cust where inherit_cip = 701731;

select * from btn_cip_v order by date_to desc;
select * from btn_cip order by date_to desc;
select * from btn_cip_v where cust_no = 701733; -- 710381
select * from btn_cip_v where cust_no = 701733; -- 710381

select * from WAPL_DL_JOB_SCHEDULING_CONF;


-- cust_no 701731 a store 6
update btn_cust set inherit_cip_store_no  = 6 where id = 80337;

update btn_cip set date_to = TO_TIMESTAMP('2018-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS') where date_to < TO_TIMESTAMP('2019-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS');

UPDATE BTN_CIP SET date_to=add_months( DATE_TO, 12 )-1 where date_to > TO_TIMESTAMP('2017-11-15 00:00:00', 'YYYY-MM-DD HH24:MI:SS');

update btn_cip set date_to = TO_TIMESTAMP('2018-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS');
delete from btn_cip_line;
delete from btn_cip;

select * from btn_cip where cust_no=702970 order by date_to desc;
select * from btn_cip order by date_to desc;
select * from btn_cip_line;

  SELECT
    cust.id,
    cust.cust_no,
    cust.cust_full_name,
    cip.date_from,
    cip.DATE_TO,
    cip.id
  FROM
    btn_cip_line line
    LEFT JOIN btn_cip cip ON cip.id = line.btn_cip_id
    LEFT JOIN btn_article art ON line.btn_article_id = art.id
    LEFT JOIN btn_cust cust ON cip.cust_no = cust.cust_no
                               AND cip.cust_store_no = cust.store_no
  WHERE
    cust.cust_record_type = 'Z'
    AND cip.cip_status IN ('A','P')
    AND line.cip_status_line IN ('S','O')
    AND cust.cust_no=701731
  order by cip.date_to asc;

  SELECT
    cust.id,
    cust.cust_no,
    cust.cust_full_name,
    count(cip_no) cnt
  FROM
    btn_cip_line line
    LEFT JOIN btn_cip cip ON cip.id = line.btn_cip_id
    LEFT JOIN btn_article art ON line.btn_article_id = art.id
    LEFT JOIN btn_cust cust ON cip.cust_no = cust.cust_no
                               AND cip.cust_store_no = cust.store_no
  WHERE
    cust.cust_record_type = 'Z'
    AND cip.cip_status IN ('A','P')
    AND line.cip_status_line IN ('S','O')
    AND date_to > TO_TIMESTAMP('2018-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
  group by cust.id, cust.cust_no, cust.cust_full_name
  having count(cip_no) > 15;

select cipv0_.id as id1_5_, cipv0_.art_descr as art_desc2_5_, cipv0_.art_no as art_no3_5_, cipv0_.btn_article_id as btn_arti4_5_, cipv0_.cip_no as cip_no5_5_, cipv0_.cip_price as cip_pric6_5_, cipv0_.cip_type as cip_type7_5_, cipv0_.cust_full_name as cust_ful8_5_, cipv0_.cust_no as cust_no9_5_, cipv0_.cust_store_no as cust_st10_5_, cipv0_.cust_id as cust_id11_5_, cipv0_.date_from as date_fr12_5_, cipv0_.date_to as date_to13_5_ 
from btn_cip_v cipv0_ where cipv0_.cust_id=80337 or 
(cipv0_.cust_no , cipv0_.cust_store_no) in (select customermo1_.inherit_cip, customermo1_.inherit_cip_store_no from btn_cust customermo1_, btn_store_v btnstorev2_ where customermo1_.inherit_cip_store_no=btnstorev2_.store_no and customermo1_.id=80337);
