SELECT * from BTN_CUST;
SELECT * from BTN_CUST where cust_no = 104200;

select * from btn_cust where (cust_cc, cust_cc_store_no) not in (select cust_no, store_no from lts_owner.cust_all);

select * from btn_cust where (cust_cc, cust_cc_store_no) not in (select cust_no, store_no from BTN_CUST_CUST_ALL_V);

select distinct count(*) from btn_cust where (cust_cc, cust_cc_store_no) not in (select cust_no, store_no from cust_all);
select distinct count(*) from btn_cust where (cust_cc, cust_cc_store_no) in (select cust_no, store_no from btn_cc_cust);
select * from btn_cust where (cust_cc, cust_cc_store_no) in (select cust_no, store_no from btn_cc_cust);
select * from btn_cust where (cust_cc, cust_cc_store_no) in (select cust_no, store_no from lts_owner.cust_all);
select * from btn_cust where cust_cc = 700549;
select * from btn_cust where cust_no = 700549 and store_no = 2;
select * from btn_cust_cust_all_v where cust_no = 700684;
select * from cust_all where cust_no = 700104;

select * from BTN_CUST_CUST_ALL_V;
select * from cust_all;

select cust_no, store_no from cust_all where cust_no = 700671;
select count(*) from cust_all;
select count(*) from btn_cust;
select count(*) from btn_cust where cust_cc_store_no is not null;
select * from btn_cust where inherit_cip is not null;

select store_no, cust_no, name cust_full_name, cust_reg_no
from cust_all
union all
select store_no, cust_no, cust_full_name, cust_reg_no
from btn_cust
where place_no is null and (store_no, cust_no) in
(select store_no, cust_no
 from btn_cust
 minus
 select store_no, cust_no
 from cust_all);

select * from btn_cust_cust_all_v where cust_no = 179746;
select * from btn_cust_search cs;

select c.* from btn_cust_search cs
 left join btn_cust c on c.id = cs.btn_cust_id
 left join btn_cust_cust_all_v cv on c.cust_no = cv.cust_no and c.store_no = cv.store_no
 where SEARCH_TEXT_1 like '%MEDPRIM S.R.O.%';

select * from WAPL_ROLE;
select * from WAPL_ROLE where name = 'EDIT_CUST_CM';

select custv0_.CUST_NO as CUST_NO1_44_0_, custv0_.STORE_NO as STORE_NO4_44_0_, custv0_.CUST_FULL_NAME as CUST_FULL_NAME2_44_0_, custv0_.CUST_REG_NO as CUST_REG_NO3_44_0_ from BTN_CUST_V custv0_ where custv0_.CUST_NO=700671; and custv0_.STORE_NO=12

select 1 from INVOICE_DW where rownum = 1;
select 1 from CUST_ALL where rownum = 1;
select 1 from BTN_CUST_CUST_ALL_V where rownum = 1;



