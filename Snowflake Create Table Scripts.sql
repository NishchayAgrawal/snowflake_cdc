
------- Stage tables scripts -------

CREATE or replace TABLE STG_REGIONS
(
    REGIONS_DATA variant
);
  
CREATE or replace TABLE STG_COUNTRIES
(
    COUNTRIES_DATA variant
);

------- Target tables scripts -------

CREATE or replace TABLE REGIONS
  (
    REGION_ID integer PRIMARY KEY,
    REGION_NAME VARCHAR(50),
    created_date TIMESTAMP_LTZ,
    updated_date TIMESTAMP_LTZ
  );

  
 CREATE or replace TABLE COUNTRIES
  (
    COUNTRY_ID VARCHAR(50) PRIMARY KEY,
    COUNTRY_NAME VARCHAR(50),
    REGION_ID INT,
    created_date TIMESTAMP_LTZ,
    updated_date TIMESTAMP_LTZ
  );