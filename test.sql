DECLARE
  l_locale_cz_id wapl_owner.wapl_locale.id%type;
  l_locale_sk_id wapl_owner.wapl_locale.id%type;
  l_locale_en_id wapl_owner.wapl_locale.id%type;
  l_application_id wapl_owner.wapl_application.id%type;
  l_localization_key_id wapl_owner.wapl_localization_key.id%type;

  PROCEDURE LOC_KEY(
    I_LOC_KEY IN VARCHAR2,
    L_APPLICATION_ID IN NUMBER)
  IS
    BEGIN
      BEGIN UPDATE wapl_owner.wapl_localization_key
      SET key = I_LOC_KEY
      WHERE KEY = I_LOC_KEY AND APPLICATION_ID = l_application_id;
        IF (SQL%ROWCOUNT = 0)
        THEN
          insert into wapl_owner.wapl_localization_key (id, application_id, key, created_initiator, created_ts)
          values (wapl_owner.seq_wapl_localization_key.nextval, L_APPLICATION_ID, I_LOC_KEY, 'system', current_timestamp);
        END IF;
      END;
    END;

  PROCEDURE LOC (
    I_LOC_KEY IN VARCHAR2,
    I_LOCALIZATION IN VARCHAR2,
    I_APPLICATION_ID IN NUMBER,
    I_LOCALE_ID IN NUMBER
  )
  IS
    L_LOC_KEY wapl_owner.wapl_localization_key.id%type;
    BEGIN
      select id into L_LOC_KEY from wapl_owner.wapl_localization_key where key = I_LOC_KEY and application_id = I_APPLICATION_ID;
      merge into wapl_owner.wapl_localization l
      using (select I_LOCALE_ID as locale_id, L_LOC_KEY as localization_key_id from dual) s on (l.locale_id = s.locale_id and l.localization_key_id = s.localization_key_id)
      when matched then
        update set text = I_LOCALIZATION
      when not matched then
        insert (id, locale_id, localization_key_id, text, created_initiator, created_ts) values (wapl_owner.seq_wapl_localization.nextval, I_LOCALE_ID, L_LOC_KEY, I_LOCALIZATION, 'system', current_timestamp);
    END;

BEGIN

  select id into l_locale_cz_id from wapl_owner.wapl_locale where name = 'cs_CZ';
  select id into l_locale_sk_id from wapl_owner.wapl_locale where name = 'sk_SK';
  select id into l_locale_en_id from wapl_owner.wapl_locale where name = 'en_US';
  select id into l_application_id from  wapl_owner.wapl_application where name = 'BTN';

  loc_key('notification.notificationIcon.hasMoreRecords', l_application_id);
  loc('notification.notificationIcon.hasMoreRecords', 'Seznam není úplný, celkový seznam můžete zobrazit ve správě hlášení', l_application_id, l_locale_cz_id);
  loc('notification.notificationIcon.hasMoreRecords', 'Zoznam nie je úplný, celý zoznam možete zobraziť v správe oznámení', l_application_id, l_locale_sk_id);
  loc('notification.notificationIcon.hasMoreRecords', 'List is not complete, you can view the whole list in notification administration', l_application_id, l_locale_en_id);

  loc_key('notification.notificationIcon.confirmAllQuestion', l_application_id);
  loc('notification.notificationIcon.confirmAllQuestion', 'Chcete potvrdit i nezobrazená hlášení?', l_application_id, l_locale_cz_id);
  loc('notification.notificationIcon.confirmAllQuestion', 'Chcete potvrdiť i skryté oznámenia?', l_application_id, l_locale_sk_id);
  loc('notification.notificationIcon.confirmAllQuestion', 'Do you want to confirm all notifications including the ones not displayed?', l_application_id, l_locale_en_id);

  loc_key('notification.notificationIcon.confirmAll', l_application_id);
  loc('notification.notificationIcon.confirmAll', 'Potvrdit vše', l_application_id, l_locale_cz_id);
  loc('notification.notificationIcon.confirmAll', 'Potvrdiť všetko', l_application_id, l_locale_sk_id);
  loc('notification.notificationIcon.confirmAll', 'Confirm all', l_application_id, l_locale_en_id);

  loc_key('notification.notificationIcon.close', l_application_id);
  loc('notification.notificationIcon.close', 'Zavřít', l_application_id, l_locale_cz_id);
  loc('notification.notificationIcon.close', 'Zavrieť', l_application_id, l_locale_sk_id);
  loc('notification.notificationIcon.close', 'Close', l_application_id, l_locale_en_id);
END;
/