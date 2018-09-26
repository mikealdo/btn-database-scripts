select d.* from btn_doc d where d.DOC_NO = '600093096';

update btn_doc set FLAG_USER_ID = '3', FLAG_STATUS = 'U' where DOC_NO = '600093094';

select * from WAPL_OWNER.WAPL_USER where login_ad like '%a%';