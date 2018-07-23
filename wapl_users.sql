select * from wapl_user where LOGIN_DB = 'ppt_qa';
select * from wapl_user where login_db is NOT NULL ;

select * from wapl_owner.wapl_dl_job_scheduling_conf;
UPDATE wapl_owner.wapl_dl_job_scheduling_conf set cron_ex = '0 0/10 * * * ?' where app = 'BTN' and name = 'processPendingPreOrdersJob';