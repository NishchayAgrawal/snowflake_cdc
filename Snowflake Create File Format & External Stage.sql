------ File Format Scripts ------

CREATE OR REPLACE FILE FORMAT JSON_FORMAT
  TYPE = 'json';


------ External Stage Scripts ------
  
CREATE or replace STAGE mysql_cdc_logs_stage
STORAGE_INTEGRATION = mysql_cdc_logs 
URL = 's3://mysql-cdc-logs-bucket-8504/' -- Change the bucket name if you have created with different name in step 1
FILE_FORMAT = json_format;