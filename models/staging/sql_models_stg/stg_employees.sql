{{ config(materialized='table', sql_header="alter session set timezone = 'Asia/Kolkata';") }}
--test ci job
select * from
{{ source("raw",'employees')}}