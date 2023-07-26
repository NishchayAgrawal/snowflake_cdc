CREATE or replace TABLE regions
  (
    region_id NUMBER PRIMARY KEY,
    region_name VARCHAR2( 50 ) NOT NULL
  );
  
 CREATE  or replace TABLE countries
  (
    country_id   CHAR( 2 ) PRIMARY KEY  ,
    country_name VARCHAR2( 40 ) NOT NULL,
    region_id    NUMBER
  );
 
