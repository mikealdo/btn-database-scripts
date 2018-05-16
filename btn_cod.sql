select LINE_STATUS FROM BTN_DOC_LINE where LINE_STATUS is null;
select * FROM BTN_DOC_LINKAGE;
select * FROM BTN_DOC_LINKAGE where BTN_DOC_ID_1 = 4910395 and not exists(select BTN_DOC_ID_2 from BTN_DOC_LINKAGE where BTN_DOC_ID_2 = 4910395);
select * FROM BTN_DOC_LINKAGE where BTN_DOC_ID_1 = 4910395 or BTN_DOC_ID_2 = 4910395;

update BTN_DOC set doc_status = 'F' where DOC_NO = 600093672;

select id, doc_no, EXTERNAL_DOC_NO FROM BTN_DOC where ID = 4910395 or ID = 4910502; -- DOC_NO 300034878, 300035068
select * FROM BTN_DOC where ID = 600091861 or DOC_NO = 600086636;
select * FROM BTN_DOC where ID = 4606193;
select * from BTN_DOC_LINE where BTN_DOC_ID = 4606193;
select * from BTN_ARTICLE where id = 290169;

SELECT d.DOC_NO, d.DOC_TYPE, d.FLAG_STATUS, d.DOC_STATUS, d.* from BTN_DOC d where d.DOC_NO = 200096313;

select * FROM BTN_DOC where DOC_TYPE = 'COD' and DOC_STATUS = 'F' and ORDER_SOURCE = 'BTN';
select * FROM BTN_DOC where DOC_TYPE = 'OBJ' and DOC_STATUS = 'W' and STORE_NO = 6 order by DOC_DATE_DEL desc;

update BTN_PARAMETER set PAR_DEFAULT = 'http://localhost:8111' where PAR_NAME = 'cod_ws_url';
update BTN_PARAMETER set PAR_DEFAULT = 'V09' where PAR_NAME = 'create_order_version';

update btn_doc set DOC_DATE_DEL = to_date('19.04.2018', 'dd.mm.yyyy'), DOC_DATE = to_date('19.04.2018', 'dd.mm.yyyy'), DOC_STATUS = 'V' where doc_no = '600086636';

select d.id, d.STORE_NO, d.doc_type, d.DOC_STATUS from btn_doc d left join BTN_DOC_LINE  dl on d.ID = dl.BTN_DOC_ID
where exists(select a.id from BTN_ARTICLE a where a.id = dl.BTN_ARTICLE_ID)
    and d.DOC_TYPE = 'OBJ' and DOC_STATUS = 'W' and d.STORE_NO = 6;

select * FROM BTN_DOC d
    left join btn_doc_linkage dl on (dl.BTN_DOC_ID_1 = d.id or dl.BTN_DOC_ID_2 = d.ID)
    left join btn_doc dl1 on (dl.BTN_DOC_ID_1 = dl1.ID)
where d.DOC_TYPE = 'OBJ' and d.EXTERNAL_DOC_NO is not null and d.VALIDATION_RESULT like 'Úspěšně dokončený přenos%' and d.PREORD_TYPE is null
    and dl1.DOC_TYPE != 'OBP'
order by d.DOC_DATE_DEL desc;

select d.id, (select count(*) from btn_doc_linkage dl where dl.BTN_DOC_ID_1 = d.id or dl.BTN_DOC_ID_2 = d.ID) FROM BTN_DOC d
where d.DOC_TYPE = 'OBJ' and d.EXTERNAL_DOC_NO is not null and d.VALIDATION_RESULT like 'Úspěšně dokončený přenos%' and d.PREORD_TYPE is null
order by d.DOC_DATE_DEL desc;

select count(d.id) FROM BTN_DOC d
where d.DOC_TYPE = 'OBJ' and d.EXTERNAL_DOC_NO is not null and d.VALIDATION_RESULT like 'Úspěšně dokončený přenos%' and d.PREORD_TYPE is null
order by d.DOC_DATE_DEL desc;

select d.id, d.doc_no, d.EXTERNAL_DOC_NO, l.REQUEST, l.RESPONSE FROM BTN_DOC d
    left join BTN_WS_LOG l on (l.PROCESS_ID = TO_CHAR(d.ID) or l.PROCESS_ID = d.EXTERNAL_DOC_NO)
where l.request is not null
order by d.DOC_DATE_DEL desc;


select distinct d.id FROM BTN_DOC d left join BTN_WS_LOG l on (l.PROCESS_ID = TO_CHAR(d.ID) or l.PROCESS_ID = d.EXTERNAL_DOC_NO) where l.request is not null;

SELECT * from BTN_WS_LOG;
SELECT * from BTN_WS_LOG where MESSAGE is not null;
SELECT * from BTN_WS_LOG where PROCESS_ID = '600091861';
SELECT * from BTN_WS_LOG order by CREATED_TS desc;

select * from BTN_EDI_MESSAGE_TYPE;

update BTN_EDI_MESSAGE_TYPE set DIRECTORY = '/orders_in' where id = 4;

select * from BTN_NOTIFICATION order by CREATED_TS desc;
select * from BTN_DOC where EXTERNAL_DOC_NO = '4-550193589858';
select * from BTN_NOTIFICATION WHERE CREATED_TS > to_date('04.04.2018', 'dd.mm.yyyy') order by CREATED_TS desc;