select * from wapl_user where login_db is not null;

select
       substr(a.spid,1,9) pid,
       substr(b.sid,1,5) sid,
       substr(b.serial#,1,5) ser#,
       substr(b.machine,1,6) box,
       substr(b.username,1,10) username,
       b.server,
       substr(b.osuser,1,8) os_user,
       substr(b.program,1,30) program
from v$session b, v$process a
where
b.paddr = a.addr
and type='USER'
order by spid;

select SEQ_WAPL_ROW.nextval from DUAL;

select * from all_synonyms where synonym_name = 'SEQ_WAPL_ROW';
select * from all_objects where object_name = 'SEQ_WAPL_ROW';

create public synonym cust_all for lts_owner.cust_all;
drop public synonym cust_all;

select * from CUST_ALL;

select wapl_user_info_pkg.get_context_val('user_info') from dual;
select wapl_user_info_pkg.get_version() from dual;

select * from all_constraints
where owner = 'BTN_OWNER'
and constraint_name = 'SYS_C008633';

update btn_cust set version = 4 where id = 71;

begin
wapl_user_info_pkg.SET_USER_INFO('WAPL_LOCK','ja','cs_CZ','sessionId');
end;
/

select username from v$session where username is not null;

select TEXT
   from DBA_VIEWS
   where OWNER = 'BTN_OWNER'
   and VIEW_NAME  = 'BTN_CUST_CUST_ALL_V';

select owner
     , object_name
     , object_type
  from ALL_OBJECTS
 where object_name = 'MMAIL_TMP';

ALTER TABLE ORDER_LINE_HO ENABLE ROW MOVEMENT;
ALTER TABLE ORDER_LINE_HO SHRINK SPACE;
ALTER TABLE ORDER_LINE_HO DISABLE ROW MOVEMENT;

GRANT SELECT ON CUST_ALL TO BTN_OWNER;

select INDEX_NAME, TABLE_OWNER, TABLE_NAME, UNIQUENESS from ALL_INDEXES where table_name='BTN_ARTICLE';

select par.partition_name
      from all_tab_partitions par
      where par.table_owner = 'BTN_OWNER'
        and par.table_name = 'BTN_ARTICLE';

BEGIN
  FOR t IN (SELECT * FROM dba_tables where owner = 'WAPL_OWNER')
  LOOP
    EXECUTE IMMEDIATE 'GRANT SELECT, INSERT, UPDATE, DELETE ON WAPL_OWNER.' || t.table_name || ' TO BTN_OWNER';
    EXECUTE IMMEDIATE 'GRANT REFERENCES ON WAPL_OWNER.' || t.table_name || ' TO BTN_OWNER';
    EXECUTE IMMEDIATE 'CREATE PUBLIC SYNONYM ' || t.TABLE_NAME || ' FOR WAPL_OWNER.' || t.TABLE_NAME;
    EXECUTE IMMEDIATE 'GRANT REFERENCES ON WAPL_OWNER.' || t.table_name || ' TO BTN_OWNER';
  END LOOP;
END;
/

EXECUTE IMMEDIATE 'CREATE PUBLIC SYNONYM WAPL_CONTEXT_TEMP FOR WAPL_OWNER.WAPL_CONTEXT_TEM';

select * from NLS_DATABASE_PARAMETERS;

SELECT TO_CHAR
    (SYSDATE, 'MM-DD-YYYY HH24:MI:SS') "NOW"
     FROM DUAL;