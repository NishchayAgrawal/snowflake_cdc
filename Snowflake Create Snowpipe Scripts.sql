create or replace pipe MYSQL_CDC_LOGS_TBL_REGIONS
auto_ingest=true 
as 
copy into STG_REGIONS from 
@mysql_cdc_logs_stage/mysql-cdc-data/TableName=REGIONS/;



create or replace pipe MYSQL_CDC_LOGS_TBL_COUNTRIES
auto_ingest=true 
as 
copy into STG_COUNTRIES from 
@mysql_cdc_logs_stage/mysql-cdc-data/TableName=COUNTRIES/;