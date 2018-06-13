delete from wapl_codelist where key = 'subst_prefer';
delete from wapl_row where codelist_id = '1120';
delete from wapl_val where row_id in (select id from wapl_row where codelist_id = '1120');

select * from wapl_row where addinfo is not null;
select * from wapl_codelist where key = 'subst_prefer' or key = 'history_view';

select cl.*, r.*, nvl(val.text, r.key) label, master_r.key master_key, val.*
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
  and cl.key = 'subst_prefer'
order by r.ord;

update WAPL_ROW set ADDINFO = '{"path": "/opt/edi"}' where CODELIST_ID = 442;

UPDATE WAPL_OWNER.WAPL_CODELIST
SET APPLICATION_ID = 2
WHERE KEY = 'underlimit_active' or KEY = 'underlimit_fee';

select key from wapl_row where codelist_id = (select id from wapl_codelist where key = 'cod_btn_price_type');

select * from wapl_val;

delete from wapl_val where row_id = (select id from wapl_row where key = 'AKCE XX');
delete from wapl_val where row_id = (select id from wapl_row where key = 'AKCE XY');
delete from WAPL_ROW where key = 'AKCE XX';
delete from WAPL_ROW where key = 'AKCE XY';

select /*+RESULT_CACHE */ r.*, nvl(val.text, r.key) label, master_r.key master_key
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
  and cl.key = 'doc_status_cod'
  and r.addinfo like '%replication%'
order by r.ord;


select cl.application_id, r.*, nvl(val.text, r.key) label, master_r.key master_key
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
  and cl.name = 'underlimit_active'
order by r.ord;
