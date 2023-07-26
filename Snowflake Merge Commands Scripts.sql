merge into REGIONS tgt
using
(
    select $1:row:values:REGION_ID::integer as REGION_ID,$1:row:values:REGION_NAME::varchar as REGION_NAME, $1:type::varchar as cdc_type 
    from @mysql_cdc_logs_stage/mysql-cdc-data/TableName=REGIONS/ where $1:type::varchar <> 'UpdateRowsEvent'
union
select $1:row:after_values:REGION_ID::integer as REGION_ID,$1:row:after_values:REGION_NAME::varchar as REGION_NAME, $1:type::varchar as cdc_type 
    from @mysql_cdc_logs_stage/mysql-cdc-data/TableName=REGIONS/ where $1:type::varchar = 'UpdateRowsEvent'
) src 
on tgt.REGION_ID = src.REGION_ID 
when not matched and cdc_type = 'WriteRowsEvent' then
 insert values(src.REGION_ID,src.REGION_NAME,CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
when matched and cdc_type = 'UpdateRowsEvent'  then
 update SET tgt.REGION_NAME = src.REGION_NAME,
            tgt.updated_date = CURRENT_TIMESTAMP
when matched and cdc_type = 'DeleteRowsEvent'  then
    Delete
;

merge into COUNTRIES tgt
using
(
    select $1:row:values:COUNTRY_ID::varchar as COUNTRY_ID,$1:row:values:COUNTRY_NAME::varchar as COUNTRY_NAME, $1:row:values:REGION_ID::integer as REGION_ID, $1:type::varchar as cdc_type 
    from stg_countries where $1:type::varchar <> 'UpdateRowsEvent'
union
    select $1:row:after_values:COUNTRY_ID::varchar as COUNTRY_ID,$1:row:after_values:COUNTRY_NAME::varchar as COUNTRY_NAME, $1:row:after_values:REGION_ID::integer as REGION_ID, $1:type::varchar as cdc_type 
    from stg_countries where $1:type::varchar = 'UpdateRowsEvent'
) src 
on tgt.COUNTRY_ID = src.COUNTRY_ID 
when not matched and cdc_type = 'WriteRowsEvent' then
 insert values(src.COUNTRY_ID,src.COUNTRY_NAME,REGION_ID,CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
when matched and cdc_type = 'UpdateRowsEvent'  then
 update SET tgt.COUNTRY_NAME = src.COUNTRY_NAME,
            tgt.REGION_ID = src.REGION_ID,
            tgt.updated_date = CURRENT_TIMESTAMP
when matched and cdc_type = 'DeleteRowsEvent'  then
    Delete
;