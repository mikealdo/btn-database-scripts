delete from wapl_codelist where key = 'cfa_search';
delete from wapl_row where codelist_id = '1120';
delete from wapl_val where row_id in (select id from wapl_row where codelist_id = '1120');

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
  and cl.key = 'doc_type'
order by r.ord;

update WAPL_ROW set ADDINFO = '{"path": "/opt/edi"}' where CODELIST_ID = 442;