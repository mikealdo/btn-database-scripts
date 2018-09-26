delete from wapl_codelist where key = 'underlimit_active';
delete from wapl_row where codelist_id = '1421';
delete from wapl_val where row_id in (select id from wapl_row where codelist_id = '1120');

select * from wapl_row where addinfo is not null;
select * from wapl_codelist where key = 'underlimit_active';
select * from BTN_ICON;

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
  and cl.key = 'doc_ddc'
order by r.ord;

SELECT C.ID
        FROM WAPL_CODELIST C

        WHERE C.KEY = 'underlimit_active';

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
  and cl.key = 'extra_type'
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
  and cl.name = 'card_type'
order by r.ord;



BEGIN UPDATE WAPL_OWNER.WAPL_CODELIST
SET NAME = 'Status účtování podlimitního poplatku'
WHERE KEY = 'underlimit_active' AND APPLICATION_ID IS NULL;
  IF (SQL%ROWCOUNT = 0)
  THEN INSERT INTO WAPL_CODELIST (ID, KEY, NAME, APPLICATION_ID)
  VALUES (wapl_owner.SEQ_WAPL_CODELIST.NEXTVAL, 'underlimit_active', 'Status účtování podlimitního poplatku', NULL); END IF;
END;