SELECT * from BTN_PARAMETER where PAR_NAME = 'cod_bulk_get';

update BTN_PARAMETER set PAR_DEFAULT = 'http://localhost:8111' where PAR_NAME = 'cod_ws_url';
update BTN_PARAMETER set PAR_DEFAULT = 'V09' where PAR_NAME = 'create_order_version';

MERGE INTO BTN_OWNER.BTN_PARAMETER p USING (
  SELECT
    (SELECT id FROM wapl_owner.wapl_application WHERE name = 'BTN') application_id,
    (SELECT id FROM wapl_owner.wapl_region WHERE lvl = 5)      region_id,
    s.*
  FROM (
          SELECT
            'SET'                                   par_group,
            'obj_line_max_qty'                      par_name,
            '9000'                                  par_text_1,
            '9000'                                  par_default,
            'NUMBER(15,3)'                          par_format,
            'Maximální množství na řádku v OPB/OBJ' par_note
          FROM dual
          UNION
          SELECT
            'SET'                                                        par_group,
            'cod_line_max_qty'                                           par_name,
            '900'                                                        par_text_1,
            '900'                                                        par_default,
            'NUMBER(15,3)'                                               par_format,
            'Maximální množství na řádku v COD, rozpadá se po násobcích' par_note
          FROM dual
          UNION
          SELECT
            'SET'                                                        par_group,
            'cfc_line_max_qty'                                           par_name,
            '900'                                                        par_text_1,
            '900'                                                        par_default,
            'NUMBER(15,3)'                                               par_format,
            'Maximální množství na řádku v CFC, rozpadá se po násobcích' par_note
          FROM dual
          UNION
          SELECT
            'SET'                                                        par_group,
            'c30_line_max_qty'                                           par_name,
            '900'                                                        par_text_1,
            '900'                                                        par_default,
            'NUMBER(15,3)'                                               par_format,
            'Maximální množství na řádku v C30, rozpadá se po násobcích' par_note
          FROM dual
          UNION
          SELECT
            'SET'                                                        par_group,
            'pic_line_max_qty'                                           par_name,
            '900'                                                        par_text_1,
            '900'                                                        par_default,
            'NUMBER(15,3)'                                               par_format,
            'Maximální množství na řádku v PIC, rozpadá se po násobcích' par_note
          FROM dual
          UNION
          SELECT
            'SET'                                par_group,
            'mpos_line_max_qty'                  par_name,
            '999.999'                            par_text_1,
            '999.999'                            par_default,
            'NUMBER(15,3)'                       par_format,
            'Maximální množství na řádku v MPOS' par_note
          FROM dual
          UNION
          SELECT
            'SET'                               par_group,
            'mpos_line_max_ammount'             par_name,
            '999999'                            par_text_1,
            '999999'                            par_default,
            'NUMBER(15,3)'                      par_format,
            'Maximální hodnota na řádku v MPOS' par_note
          FROM dual
          UNION
          SELECT
            'SET'                              par_group,
            'mpos_max_ammount'                 par_name,
            '9999999'                          par_text_1,
            '9999999'                          par_default,
            'NUMBER(15,3)'                     par_format,
            'Maximální hodnota dokladu v MPOS' par_note
          FROM dual) s
  ) ss
ON (p.par_group = ss.par_group AND p.par_name = ss.par_name)
WHEN MATCHED THEN UPDATE
  SET par_text_1 = ss.par_text_1, par_default = ss.par_default, par_note = ss.par_note, par_format = ss.par_format
WHEN NOT MATCHED THEN
  INSERT (id, application_id, region_id, par_group, par_name, par_text_1, par_default, par_note)
  VALUES (seq_btn_parameter.nextval, ss.application_id, ss.region_id, ss.par_group, ss.par_name, ss.par_text_1,
          ss.par_default, ss.par_note)
/
