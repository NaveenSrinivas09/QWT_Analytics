### Copy these SQL statements into a Snowflake Worksheet, select all and execute them (i.e. pressing the play button).

#### create these raw tables and load the data from source s3/ stage

#### few copy statements are missing, manage the copy script accordingly

```
create warehouse COMPUTE_WH;
create database if not exists qwt_analytics;
create schema raw;

-- Set up the defaults
-- USE WAREHOUSE COMPUTE_WH;
-- USE DATABASE airbnb;
-- USE SCHEMA RAW;


create or replace TABLE CONTACTS_JSON (
	CONTACTS_DATA VARIANT
);

create or replace TABLE CUSTOMERS (
	CUSTOMERID NUMBER(38,0),
	COMPANYNAME VARCHAR(150),
	CONTACTNAME VARCHAR(150),
	CITY VARCHAR(150),
	COUNTRY VARCHAR(150),
	DIVISIONID NUMBER(38,0),
	ADDRESS VARCHAR(150),
	FAX VARCHAR(150),
	PHONE VARCHAR(150),
	POSTALCODE VARCHAR(150),
	STATEPROVINCE VARCHAR(150)
);

create or replace TABLE EMPLOYEES (
	EMPID NUMBER(38,0),
	LAST_NAME VARCHAR(100),
	FIRST_NAME VARCHAR(150),
	TITLE VARCHAR(150),
	HIRE_DATE DATE,
	OFFICE VARCHAR(150),
	EXTENSION VARCHAR(150),
	REPORTS_TO VARCHAR(150),
	YEAR_SALARY FLOAT
);

create or replace TABLE OFFICE (
	OFFICE NUMBER(38,0),
	OFFICEADDRESS VARCHAR(150),
	OFFICEPOSTALCODE VARCHAR(150),
	OFFICECITY VARCHAR(150),
	OFFICESTATEPROVINCE VARCHAR(150),
	OFFICEPHONE VARCHAR(150),
	OFFICEFAX VARCHAR(150),
	OFFICECOUNTRY VARCHAR(150)
);

create or replace TABLE ORDERS (
	ORDERID NUMBER(38,0),
	ORDERDATE TIMESTAMP_NTZ(9),
	CUSTOMERID NUMBER(38,0),
	EMPLOYEEID NUMBER(38,0),
	SHIPPERID NUMBER(38,0),
	FREIGHT NUMBER(38,13)
);

create or replace TABLE ORDER_DETAILS (
	ORDERID NUMBER(38,0),
	LINENO NUMBER(38,0),
	PRODUCTID NUMBER(38,0),
	QUANTITY NUMBER(38,0),
	UNITPRICE NUMBER(38,15),
	DISCOUNT NUMBER(38,2)
);

create or replace TABLE PRODUCTS (
	"ProductID" NUMBER(38,0),
	"ProductName" VARCHAR(100),
	"SupplierID" NUMBER(38,0),
	"CategoryID" NUMBER(38,0),
	"QuantityPerUnit" NUMBER(38,0),
	"UnitCost" NUMBER(38,0),
	"UnitPrice" NUMBER(38,0),
	"UnitsInStock" NUMBER(38,0),
	"UnitsOnOrder" NUMBER(38,0)
);

create or replace TABLE SHIPMENTS (
	ORDERID NUMBER(38,0),
	LINENO NUMBER(38,0),
	SHIPPERID NUMBER(38,0),
	CUSTOMERID NUMBER(38,0),
	PRODUCTID NUMBER(38,0),
	EMPLOYEEID NUMBER(38,0),
	SHIPMENTDATE TIMESTAMP_NTZ(9)
);

create or replace TABLE STUDENTS (
	ID NUMBER(38,0) autoincrement start 1 increment 1 noorder,
	NAME VARCHAR(50)
);

create or replace TABLE SUPPLIER_XML (
	SUPPLIER_DATA VARIANT
);

CREATE OR REPLACE FILE FORMAT CSV_FILEFORMAT
	SKIP_HEADER = 1
	FIELD_OPTIONALLY_ENCLOSED_BY = '\"'
;
CREATE OR REPLACE FILE FORMAT JSON_FILEFORMAT
	TYPE = json
	NULL_IF = ()
	STRIP_OUTER_ARRAY = TRUE
;
CREATE OR REPLACE FILE FORMAT UL_CS
	TYPE = csv
	FIELD_OPTIONALLY_ENCLOSED_BY = '\"'
	COMPRESSION = None
;

CREATE STAGE raw_stage
URL='s3://qwtdbtdata' 
CREDENTIALS=(AWS_KEY_ID='AKIAZ3ENE5SNQEZ4XANI' AWS_SECRET_KEY='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');

list @raw_stage;

-- select $1 from @raw_stage/Customers.csv; -->

copy into customers
from @raw_stage/Customers.csv
file_format = csv_fileformat
on_error = 'skip_file';

copy into Products
from @raw_stage/Products.csv
file_format = csv_fileformat
on_error = 'skip_file';

copy into Products
from @raw_stage/Products.csv
file_format = csv_fileformat

copy into employees
from @raw_stage/Employee.csv
file_format = csv_fileformat
on_error = 'continue';

COPY INTO "QWT_ANALYTICS"."RAW"."order_details" 
FROM @"QWT_ANALYTICS"."RAW"."RAW_STAGE"
FILES = ('OrderDetails.csv') 
FILE_FORMAT = csv_fileformat 
ON_ERROR=ABORT_STATEMENT;


```
