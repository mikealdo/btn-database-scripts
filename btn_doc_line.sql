SELECT *
FROM BTN_DOC_LINE dl
WHERE dl.LINE_STATUS = 'X' AND dl.DOC_TYPE = 'OBP' AND exists(SELECT d.id
                                                              FROM btn_doc d
                                                              WHERE d.id = dl.BTN_DOC_ID);
SELECT * FROM BTN_DOC where COUNT_LINE > 7;
select SELL_PRICE_TYPE
from BTN_DOC_LINE where SELL_PRICE_TYPE like '%AKCE XY%';

select SELL_PRICE from BTN_ARTICLE_STORE where SELL_PRICE is not null;

SELECT
  d.id,
  count(dl.id) as cnt
FROM btn_doc d left join btn_doc_line dl on d.ID = dl.BTN_DOC_ID
GROUP BY d.ID
HAVING count(dl.ID) > 10
ORDER BY cnt desc;

UPDATE BTN_DOC_LINE
SET LINE_STATUS = 'X'
WHERE BTN_DOC_ID = 800022852;

SELECT *
FROM btn_doc
WHERE DOC_NO = '800022852';

SELECT *
FROM btn_doc
WHERE id = '2238130';

select max(id) from BTN_DOC;

select * from btn_doc where FLAG_STATUS = 'U';
update btn_doc set FLAG_STATUS = null where FLAG_STATUS = 'U';

select id, doc_status, DOC_TYPE, PREORD_TYPE, preord_Dt_From, preord_ord2cust, trunc(preord_Dt_From - preord_ord2cust) from btn_doc where PREORD_TYPE = 'J' ORDER BY DOC_DATE desc;

update BTN_DOC set preord_Dt_From = TO_TIMESTAMP('2018-04-03 00:01:00', 'YYYY-MM-DD HH24:MI:SS'), preord_ord2cust = 0, DOC_DATE = TO_TIMESTAMP('2018-04-02 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), DOC_STATUS = 'O' where id = 4927368;
