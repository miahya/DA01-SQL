-- create database and table
create table SALES_DATASET_RFM_PRJ
(
  ordernumber VARCHAR,
  quantityordered VARCHAR,
  priceeach        VARCHAR,
  orderlinenumber  VARCHAR,
  sales            VARCHAR,
  orderdate        VARCHAR,
  status           VARCHAR,
  productline      VARCHAR,
  msrp             VARCHAR,
  productcode      VARCHAR,
  customername     VARCHAR,
  phone            VARCHAR,
  addressline1     VARCHAR,
  addressline2     VARCHAR,
  city             VARCHAR,
  state            VARCHAR,
  postalcode       VARCHAR,
  country          VARCHAR,
  territory        VARCHAR,
  contactfullname  VARCHAR,
  dealsize         VARCHAR
) 

-- correcting the datatype

ALTER TABLE sales_dataset_rfm_prj ALTER COLUMN ordernumber TYPE numeric USING ordernumber::numeric;
ALTER TABLE sales_dataset_rfm_prj ALTER COLUMN quantityordered TYPE numeric USING quantityordered::numeric;
ALTER TABLE sales_dataset_rfm_prj ALTER COLUMN priceeach TYPE numeric USING priceeach::numeric;
ALTER TABLE sales_dataset_rfm_prj ALTER COLUMN orderdate TYPE date USING orderdate::date;
ALTER TABLE sales_dataset_rfm_prj ALTER COLUMN msrp TYPE numeric USING msrp::numeric;
ALTER TABLE sales_dataset_rfm_prj ALTER COLUMN orderlinenumber TYPE numeric USING orderlinenumber::numeric;
ALTER TABLE sales_dataset_rfm_prj ALTER COLUMN sales TYPE numeric USING sales::numeric;

select * from public.sales_dataset_rfm_prj;

-- check NULL/BLANK data

SELECT * FROM public.sales_dataset_rfm_prj
WHERE ordernumber IS NULL;

SELECT * FROM public.sales_dataset_rfm_prj
WHERE quantityordered IS NULL;

SELECT * FROM public.sales_dataset_rfm_prj
WHERE priceeach IS NULL;

SELECT * FROM public.sales_dataset_rfm_prj
WHERE orderlinenumber IS NULL;

SELECT * FROM public.sales_dataset_rfm_prj
WHERE sales IS NULL;

SELECT * FROM public.sales_dataset_rfm_prj
WHERE orderdate IS NULL;

-- add column CONTACTFIRSTNAME & CONTACTLASTNAME split from CONTACTFULLNAME

ALTER TABLE public.sales_dataset_rfm_prj
ADD COLUMN contactfirstname VARCHAR,
ADD COLUMN contactlastname	VARCHAR;

UPDATE public.sales_dataset_rfm_prj
SET contactfirstname = left(contactfullname, POSITION('-' IN contactfullname)-1),
	contactlastname = right(contactfullname, LENGTH(contactfullname) - POSITION('-' IN contactfullname));

UPDATE public.sales_dataset_rfm_prj
SET contactfirstname = upper(left(contactfirstname, 1))||lower(right(contactfirstname, length(contactfirstname)-1))
	contactlastname = upper(left(contactlastname, 1))||lower(right(contactlastname, length(contactlastname)-1));

--  add column QUARTER/MONTH/YEAR extract from ORDERDATE

ALTER TABLE public.sales_dataset_rfm_prj
ADD COLUMN QTR_ID NUMERIC,
ADD COLUMN MONTH_ID NUMERIC,
ADD COLUMN YEAR_ID NUMERIC;

UPDATE public.sales_dataset_rfm_prj
SET YEAR_ID = EXTRACT (YEAR from orderdate),
	MONTH_ID = EXTRACT(MONTH from orderdate),
	QTR_ID = (case 
		when MONTH_ID IN (1,2,3) then 1
		when MONTH_ID IN (4,5,6) then 2
		when MONTH_ID IN (7,8,9) then 3
		else 4
	end)

-- find OUTLIER of QUANTITYORDERED column

with cte_outlier as (
select 
	ROW_NUMBER() OVER(ORDER BY quantityordered) as stt, 
	quantityordered
from public.sales_dataset_rfm_prj)

select count(stt),
	round(0.25*count(stt)) as Q1,
	round(0.5*count(stt)) as Q2,
	round(0.75*count(stt)) as Q3
from cte_outlier

>>>>> Q1 = 706th  =   quantityordered 27
      Q2 = 1412th =   quantityordered 35
      Q3 = 2117th =   quantityordered 43
      total = 2823 values
      IQR = 43 - 27 = 16

>>>>> BOX PLOT
Min value = 27 - 1.5*16 = 3
Max value = 43 + 1.5*16 = 67
OUTLIER <> [3,67]


