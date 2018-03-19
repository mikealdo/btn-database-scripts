SELECT
              count(*) 
             FROM WAPL_LOCALIZATION_KEY K 
              LEFT JOIN (SELECT TEXT, LOCALIZATION_KEY_ID
                               FROM WAPL_LOCALIZATION L
                               LEFT JOIN WAPL_LOCALE LOCALE ON L.LOCALE_ID = LOCALE.ID
                               WHERE LOCALE.NAME = :locale) LL ON LL.LOCALIZATION_KEY_ID = K.ID
              LEFT JOIN WAPL_APPLICATION A ON K.APPLICATION_ID = A.ID
              LEFT JOIN WAPL_LOCALE LOCALE ON L.LOCALE_ID = LOCALE.ID
              WHERE (A.NAME = 'WAPL' OR A.NAME = 'BTN') AND LOCALE.NAME = 'cs_CZ'
              ORDER BY KEY ASC;

SELECT
              K.KEY AS KEY,
              nvl(LL.TEXT, K.KEY) AS VALUE 
             FROM WAPL_LOCALIZATION_KEY K 
              LEFT JOIN (SELECT TEXT, LOCALIZATION_KEY_ID
                               FROM WAPL_LOCALIZATION L
                               LEFT JOIN WAPL_LOCALE LOCALE ON L.LOCALE_ID = LOCALE.ID
                               WHERE LOCALE.NAME = :locale) LL ON LL.LOCALIZATION_KEY_ID = K.ID
              LEFT JOIN WAPL_APPLICATION A ON K.APPLICATION_ID = A.ID
              LEFT JOIN WAPL_LOCALE LOCALE ON L.LOCALE_ID = LOCALE.ID
              WHERE (A.NAME = 'WAPL' OR A.NAME = 'BTN') AND LOCALE.NAME = 'cs_CZ'
              ORDER BY KEY ASC;

select count(*)
from wapl_localization_key localizati0_
cross join wapl_localization values1_
left outer join wapl_locale localemode3_ on values1_.locale_id=localemode3_.id
left outer join wapl_application applicatio2_ on localizati0_.application_id=applicatio2_.id
where (applicatio2_.name='WAPL' or applicatio2_.name='BTN') and localemode3_.name='aa' order by localizati0_.key asc;

select count(*)
from wapl_localization_key localizati0_
right join wapl_localization values1_ on values1_.localization_key_id  = localizati0_.id;

select k.* from wapl_localization_key k;
select l.* from wapl_localization l where localization_key_id = 13629;
delete from wapl_localization where id = 19899;

SELECT * from WAPL_LOCALE; -- cs_CZ

select k.* from wapl_localization_key k where not exists (select localization_key_id from wapl_localization l where k.id = l.localization_key_id and locale_id = 2);

SELECT
              K.KEY AS KEY,
              nvl(LL.TEXT, K.KEY) AS VALUE
             FROM WAPL_LOCALIZATION_KEY K
              LEFT OUTER JOIN (SELECT TEXT, LOCALIZATION_KEY_ID
                               FROM WAPL_LOCALIZATION L
                               LEFT JOIN WAPL_LOCALE LOCALE ON L.LOCALE_ID = LOCALE.ID
                               WHERE LOCALE.NAME = 'en_US') LL ON LL.LOCALIZATION_KEY_ID = K.ID
              LEFT JOIN WAPL_APPLICATION A ON K.APPLICATION_ID = A.ID
              WHERE (A.NAME = 'WAPL' OR A.NAME = 'BTN') AND K.KEY = 'doc.noteFragment.delTime.undefined'
              ORDER BY KEY ASC;