select * from BTN_ICON order by source, key;

delete from BTN_ICON where key = 'ART_DUPLICATE';
delete from BTN_ICON where key = 'ART_SUBSTITUTE';
delete from BTN_ICON where key = 'ARTICLE_VALIDATION';


select * from all_directories;

update BTN_ICON set icon = (select icon from btn_icon where id = 7), icon_2 = (select icon_2 from btn_icon where id = 7) where id = 378;
update BTN_ICON set icon = (select icon from btn_icon where id = 53), icon_2 = (select icon_2 from btn_icon where id = 53) where id = 379;

insert into BTN_OWNER.BTN_ICON (id, source, key, descr, short_descr, CREATED_INITIATOR)
    values (BTN_OWNER.SEQ_BTN_ICON.nextval, 'ARTICLE_VALIDATION', 'ART_DUPLICATE', 'Duplicitní artikl', 'Duplicitní artikl', 'system')
/

insert into BTN_OWNER.BTN_ICON (id, source, key, descr, short_descr, CREATED_INITIATOR)
    values (BTN_OWNER.SEQ_BTN_ICON.nextval, 'ARTICLE_VALIDATION', 'ART_SUBSTITUTE', 'Artikl již v objednávce je a byl nahrazen.', 'Nahrazený artikl', 'system')
/