SELECT *
FROM
    (select * from btn_dl_apl_sys_log where operation_type = 'processManualPreOrdersJob' order by start_ts desc)
    WHERE rownum <= 1;

select * from btn_dl_apl_sys_log order by end_ts desc;
select * from btn_dl_apl_sys_log where operation_type = 'processManualPreOrdersJob' order by start_ts desc;

select * from BTN_DL_JOB_SCHEDULING_CONF_V;

delete from btn_dl_apl_sys_log where USER_INFO = 'SYSTEM_USER_BTN';
delete from btn_dl_apl_sys_log where OPERATION_TYPE = 'processManualPreOrdersJob';
delete from btn_dl_apl_sys_log;

select
  'O' task_type,
  'OBJ' task_type_2,
  'A' task_create_type,
  cust.store_no,
  cust.cust_no,
  cust.place_no,
  sysdate date_from,
  sysdate date_to,
  trunc(sysdate + (del_def.del_day - del_def.order_day)) del_date,
  del_def.order_type order_type,
  nvl(del_def.order_time_to, (select s.deadline_time from BTN_STORE_V s where s.store_no = cust.store_no)) order_time_to,
  trunc(sysdate) + (nvl(del_def.order_time_to, (select s.deadline_time from BTN_STORE_V s where s.store_no = cust.store_no))/24) deadline_time,
  del_def.order_time_from order_time_from,
  del_def.note note,
  trunc(sysdate) + (case when wapl_dl_utils_pkg.get_json_val(wapl_codelist_pkg.get_addinfo('order_income_type', del_def.order_type, 'BTN'), 'contact_time') = 'order_time_to' then
  del_def.order_time_to else del_def.order_time_from end/24) next_contact_time
from btn_cust cust,
  btn_cust_del_def del_def
where cust.id = del_def.cust_id
  and cust.place_status not in (5, 9)
  and ((cust.winter_mode = del_def.winter_mode) or (cust.winter_mode is null and del_def.winter_mode is null))
  and del_def.order_day = to_char(sysdate, 'D')
  and not exists (select 1
    from btn_doc doc where doc.doc_type = 'OBJ' and doc.doc_status = 'W'
      and doc.store_no = cust.store_no and doc.cust_no = cust.cust_no and doc.place_no = cust.place_no
      and trunc(sysdate + (del_def.del_day - del_def.order_day)) = trunc(doc.doc_date_del))
  and not exists (select 1
    from btn_cc_task task
    where task.store_no = cust.store_no and task.cust_no = cust.cust_no and task.place_no = cust.place_no
      and task.task_type = 'O' and trunc(sysdate + (del_def.del_day - del_def.order_day)) = task.del_date);

select s.STORE_NO, s.* from btn_store s order by s.STORE_NO;

select * from WAPL_OWNER.WAPL_STORE order by WAPL_STORE.STORE_NO asc;
select * from BTN_STORE_V v order by v.STORE_NO asc;