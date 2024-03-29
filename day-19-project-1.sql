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

