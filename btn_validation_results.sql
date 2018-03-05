select VALIDATION_RESULT_TMP, VALIDATION_RESULT from BTN_DOC;
select count(*) from BTN_CUST_PARAM;
select count(*) from ORDERS_HO;
select count(*) from BTN_DOC_LINE;
select * from BTN_DOC_LINE where btn_doc_id = '1054462';
select * from btn_article where id = '249802';
select * from BTN_DOC where doc_type = 'OBJ';

delete from BTN_DOC;
describe BTN_DOC;

alter table BTN_DOC drop column VALIDATION_RESULT;
alter table BTN_DOC add (VALIDATION_RESULT CLOB);
alter table BTN_DOC add (VALIDATION_RESULT_TMP VARCHAR2(4000));
alter table BTN_DOC add (VALIDATION_RESULT VARCHAR2(4000 CHAR));

alter table BTN_DOC rename column VALIDATION_RESULT to VALIDATION_RESULT_TMP;
alter table BTN_DOC drop column VALIDATION_RESULT_TMP;


update BTN_DOC set VALIDATION_RESULT_TMP = DBMS_LOB.SUBSTR(VALIDATION_RESULT, 3500, 1);

select * from nls_instance_parameters where parameter = 'NLS_LENGTH_SEMANTICS';

alter system set NLS_LENGTH_SEMANTICS = CHAR;

select length('ž') "L" from dual;
select lengthb('ž') "L" from dual;
select asciistr('ž') from dual;

ANALYZE TABLE BTN_DOC VALIDATE STRUCTURE;
ANALYZE TABLE BTN_DOC VALIDATE STRUCTURE CASCADE ONLINE;