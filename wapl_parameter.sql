SELECT * from BTN_PARAMETER where PAR_NAME = 'enviroment';

update BTN_PARAMETER set PAR_DEFAULT = 'http://localhost:8111' where PAR_NAME = 'cod_ws_url';

-- http://mcrm02-idm-pp.metrosystems.net:2300/mcrm/all/mcc/enu/webservices/start.swe?SWEExtSource=WebService&SWEExtCmd=Execute&WSSOAP=1