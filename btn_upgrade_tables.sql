SELECT * from UPGRADE_BTN_OWNER order by VERSION desc, UPGRADE_NO asc;
select * from lts_tech.upgrade_main;

delete from UPGRADE_BTN_OWNER where VERSION = '3.1.4';

delete from UPGRADE_BTN_OWNER;
delete from lts_tech.upgrade_main;

select ord from (
select nvl(max(ord), 0) ord from BTN_OWNER.UPGRADE_BTN_OWNER where upgrade_no = 1011 order by nvl(ord, 0) desc
)
where ROWNUM = 1;

select nvl(ord, '0') ord from BTN_OWNER.UPGRADE_BTN_OWNER order by nvl(ord, 0) desc;

insert into UPGRADE_BTN_OWNER (UPGRADE_NO, DESCR, SCRIPT_DATE, PROJECT, VERSION, CREATE_DATE, CREATE_USER) VALUES
  (0, 'Initial upgrade doing nothing', sysdate, 'BTN', '0', sysdate, 'SYSTEM');

begin
  btn_owner.add_upgrade_btn_owner(p_upgrade_no  => 1002,
                                  p_descr       => 'install_BTN_ver_3_1_1.sql - 01_doc_updates.sql, J.Sedlak - WASTE sloupce do btn_article, btn_doc, merge do btn_parameter',
                                  p_script_date => to_date('21.2.2018', 'dd.mm.yyyy'),
                                  p_project     => 'BTN',
                                  p_version     => '3.1.1');
  end;

  alter user sys identified by 1234;