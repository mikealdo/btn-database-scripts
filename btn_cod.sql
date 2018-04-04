select * FROM BTN_DOC_LINKAGE where BTN_DOC_ID_1 = 2465031 or BTN_DOC_ID_2 = 2465031;

select * FROM BTN_DOC where ID = 2465030 or ID = 2465031; -- DOC_NO 300034878, 300035068
select * FROM BTN_DOC where ID = 2465031;

SELECT d.DOC_NO, d.DOC_TYPE, d.FLAG_STATUS, d.DOC_STATUS, d.* from BTN_DOC d where d.DOC_NO = 200096313;

select * FROM BTN_DOC where DOC_TYPE = 'COD' and DOC_STATUS = 'F' and ORDER_SOURCE = 'BTN';

SELECT * from BTN_WS_LOG where MESSAGE is not null;

select * from BTN_EDI_MESSAGE_TYPE;

update BTN_EDI_MESSAGE_TYPE set DIRECTORY = '/orders_in' where id = 4;

select EXTERNAL_DOC_NO from BTN_DOC where EXTERNAL_DOC_NO is NOT NULL ;

select * from wapl_row;