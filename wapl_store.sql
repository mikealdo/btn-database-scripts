select *
from BTN_STORE
order by STORE_NO;

select *
from WAPL_OWNER.WAPL_STORE
order by STORE_NO;

select *
from BTN_OWNER.BTN_STORE_V
order by STORE_NO;

select *
FROM
    wapl_owner.wapl_region reg
   ,wapl_owner.wapl_region_map reg_map
   ,wapl_owner.wapl_store store
--    ,btn_store
  WHERE
    reg.id = reg_map.region_id
    AND   reg_map.store_no = store.store_no
    AND   reg.lvl = 1
    AND   store.depot_ind = 0;
--     AND   store.store_no = btn_store.store_no (+)
    and store.STORE_NO = 30;
    AND   btn_store.store_type IS NULL;


select *
from WAPL_OWNER.WAPL_STORE s
       left join WAPL_OWNER.wapl_region_map rm on s.STORE_NO = rm.STORE_NO
       left join WAPL_OWNER.WAPL_REGION r on rm.REGION_ID = r.ID
where s.STORE_NO = 30;

select *
from wapl_region
where id = 663;
select *
from wapl_region reg left join wapl_region_map rm on reg.id = rm.region_id
where store_no = 2;

delete from WAPL_OWNER.wapl_region_map where REGION_ID =1 and STORE_NO = 30;
insert into WAPL_OWNER.wapl_region_map(ID, REGION_ID, STORE_NO) values (SEQ_WAPL_REGION_MAP.nextval, 1, 30);
insert into WAPL_OWNER.wapl_region_map(ID, REGION_ID, STORE_NO) values (SEQ_WAPL_REGION_MAP.nextval, 663, 30);

INSERT INTO WAPL_OWNER.WAPL_STORE (STORE_NO,
                                   STATUS,
                                   NAME,
                                   BUILDING,
                                   ADDRESS,
                                   TOWN,
                                   PROV_COUNTY_STATE,
                                   ADDR_PST_CD,
                                   POB_NO,
                                   POB_PST_CD,
                                   PHONE_NO,
                                   TELEX_NO,
                                   TELEFAX_NO,
                                   BANK_ACCOUNT_NO,
                                   BANK_NAME,
                                   BANK_ADDRESS,
                                   BANK_TOWN,
                                   BANK_COUNTY,
                                   BANK_POSTAL_CD,
                                   BANK_POB_NO,
                                   BANK_POB_PST_CD,
                                   BANK_ACCOUNT_NO_2,
                                   BANK_BUILDING,
                                   FISCAL_NO,
                                   FULL_STOCK_TK_IND,
                                   OPEN_DATE,
                                   TAX_OFFICE,
                                   STORE_REG_NO,
                                   STORE_REPRESENTATIVE,
                                   EIS_DATE,
                                   RELEASE,
                                   SALES_TAX,
                                   CPY_TYPE,
                                   FISCAL_LENGTH,
                                   EAN_CODE,
                                   NAME_GB,
                                   AREA_NO,
                                   STATE_NO,
                                   VAT_CERTIFICATE_NO,
                                   WAREHOUSE_IND,
                                   HAMPER_IND,
                                   LOG_ORDERS,
                                   BUYER_ORDERS,
                                   REGISTRATION_COURT,
                                   MAIN_ACTIVITY,
                                   STATISTIC_REG_NO,
                                   SAF_SWH,
                                   REGIONAL_HO_IND,
                                   GLOBAL_HO_IND,
                                   CURRENCY_HO,
                                   REGION_NO,
                                   CUSTOMS_WH_NO,
                                   COMPANY,
                                   LSP_CD,
                                   CUST_WH_IND,
                                   MMS_HIER_LFD,
                                   DATE_LOADED,
                                   COPY_FROM_ASSORTMENT,
                                   COPY_FROM_ART_EXCP,
                                   COPY_FROM_SUPPL_EXCP,
                                   MDW_DELIV_IND,
                                   MCRM_DELIV_IND,
                                   DEPOT_IND,
                                   DEPOT_STORE_NO,
                                   SATELLITE_IND,
                                   BANK_NAME_LONG,
                                   EXCLUDE_SAPARCH_IND,
                                   IBAN,
                                   SWIFT)
VALUES (30,
        1,
        'DC Kozomín',
        null,
        'Kaštanova ul. 50/506',
        'Kozomín',
        null,
        '620 00',
        '62',
        '620 00',
        '545592111',
        null,
        '545593355',
        '2048930118/2600',
        'Citibank Europe plc',
        'Bucharova 2641/14',
        'Stodůlky',
        'BRNO',
        '158 02',
        '158 02',
        '158 02',
        '2048930505/0300',
        null,
        'CZ26450691',
        1,
        TO_DATE('2000-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),
        null,
        '00288918',
        '1',
        TO_DATE('2017-04-03 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),
        80,
        null,
        null,
        null,
        '8590764000023',
        null,
        0,
        0,
        null,
        0,
        0,
        0,
        0,
        'ZAP. V OBCH. R. MĚSTSKÉHO SOUDU V PRAZE ODDÍL C,VLOŽKA 83051',
        null,
        null,
        null,
        0,
        0,
        'CZK',
        97,
        null,
        null,
        null,
        0,
        null,
        null,
        null,
        null,
        null,
        1,
        1,
        0,
        17,
        0,
        'Citibank Europe plc, organizační složka',
        0,
        'CZ21 2600 0000 0020 4893 0118',
        'CITICZPX');
