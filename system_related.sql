SELECT * FROM V$VERSION;

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

ALTER TABLESPACE TEMP RESIZE 200M;

select * from V$SORT_SEGMENT;

select *
from dba_tablespaces
order by tablespace_name
         ;

alter user sys identified by Btn12345;

select * from v$option where parameter='Partitioning';
update v$option set VALUE = TRUE where parameter='Partitioning';

select * from dba_temp_files;

DROP TABLESPACE TEMP including contents and datafiles;

SELECT DISTINCT sgm.TABLESPACE_NAME , dtf.FILE_NAME
FROM DBA_SEGMENTS sgm
JOIN DBA_DATA_FILES dtf ON (sgm.TABLESPACE_NAME = dtf.TABLESPACE_NAME);

SELECT * FROM dba_users;

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

GRANT CREATE PUBLIC SYNONYM TO BTN_OWNER;
GRANT CREATE VIEW TO BTN_OWNER;
GRANT CREATE SYNONYM TO BTN_OWNER;
GRANT CREATE SYNONYM TO BTN_APL;
GRANT CREATE SYNONYM TO BTN_QUARTZ;

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

SELECT resource_name, limit
FROM dba_profiles
WHERE profile = 'DEFAULT'
AND resource_type = 'PASSWORD';

ALTER PROFILE DEFAULT LIMIT PASSWORD_LIFE_TIME UNLIMITED;

ALTER USER BTN_APL ACCOUNT UNLOCK;

select * from UPGRADE_BTN_OWNER;

CREATE OR REPLACE PROCEDURE BTN_OWNER.add_upgrade_btn_owner( p_upgrade_no                 VARCHAR2,
                                                             p_descr                      VARCHAR2,
                                                             p_script_date                DATE,
                                                             p_project                    VARCHAR2,
                                                             p_version                    VARCHAR2,
                                                             p_check_unique_upgrade_no    BOOLEAN DEFAULT FALSE ) IS
BEGIN
    lts_tech.add_upgrade( 'btn_owner.upgrade_btn_owner',
                          p_upgrade_no,
                          p_descr,
                          p_script_date,
                          p_project,
                          p_version,
                          p_check_unique_upgrade_no );
END;
/

select ord from (
select nvl(max(ord), 0) ord from BTN_OWNER.UPGRADE_BTN_OWNER where upgrade_no = '' order by nvl(ord, 0) desc
)
where rownum = 1;

select ord from (
select nvl(max(ord), 0) ord from BTN_OWNER.UPGRADE_BTN_OWNER where upgrade_no = 1011 order by nvl(ord, 0) desc
)
where ROWNUM = 1;

select CONNECTION_POOL, STATUS,MINSIZE,MAXSIZE from DBA_CPOOL_INFO;

begin
  DBMS_CONNECTION_POOL.START_POOL('SYS_DEFAULT_CONNECTION_POOL');
end;

desc DBMS_CONNECTION_POOL.CONFIGURE_POOL;

select ord from (
 select nvl(max(ord), 0) ord from BTN_OWNER.UPGRADE_BTN_OWNER where upgrade_no = 1042 order by nvl(ord, 0) desc
       )
      where ROWNUM = 1;

select * from lts_tech.upgrade_main;

col "Tablespace" for a22
col "Used MB" for 99,999,999
col "Free MB" for 99,999,999
col "Total MB" for 99,999,999

select df.tablespace_name "Tablespace",
totalusedspace "Used MB",
(df.totalspace - tu.totalusedspace) "Free MB",
df.totalspace "Total MB",
round(100 * ( (df.totalspace - tu.totalusedspace)/ df.totalspace))
"Pct. Free"
from
(select tablespace_name,
round(sum(bytes) / 1048576) TotalSpace
from dba_data_files
group by tablespace_name) df,
(select round(sum(bytes)/(1024*1024)) totalusedspace, tablespace_name
from dba_segments
group by tablespace_name) tu
where df.tablespace_name = tu.tablespace_name ;