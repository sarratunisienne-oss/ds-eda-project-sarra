CREATE SCHEMA eda;

SET search_path TO eda;

--create the full table containing all of the data the csv file has
CREATE TABLE king_county_house_prices_full(
id varchar(50),
"date" date,
price float(8),
bedrooms float(4),
bathrooms float(4),
sqft_living float(8),
sqft_lot float(8),
floors float(4),
waterfront float(4),
"view" float(4),
"condition" integer,
grade integer,
sqft_above float(8),
sqft_basement float(8),
yr_built integer,
yr_renovated integer,
zipcode integer,
lat float(4),
long float(4),
sqft_living15 float(8),
sqft_lot15 float(8)
);

--testing
--SELECT * FROM king_county_house_prices_full;
--DROP TABLE king_county_house_prices_full;

--used the gui to upload the csv file to the table


--create table with house sales
CREATE TABLE king_county_house_sales (
"date" date,
price float(8),
house_id varchar(50)
);

INSERT INTO king_county_house_sales 
(
SELECT "date",price,id AS house_id FROM king_county_house_prices_full
);

ALTER TABLE king_county_house_sales
ADD COLUMN id serial PRIMARY KEY;

--testing
--SELECT * FROM king_county_house_sales;
--DROP TABLE king_county_house_sales;


--create table with house details data
CREATE TABLE king_county_house_details (
id varchar(50),
bedrooms float(4),
bathrooms float(4),
sqft_living float(8),
sqft_lot float(8),
floors float(4),
waterfront float(4),
"view" float(4),
"condition" integer,
grade integer,
sqft_above float(8),
sqft_basement float(8),
yr_built integer,
yr_renovated integer,
zipcode integer,
lat float(4),
long float(4),
sqft_living15 float(8),
sqft_lot15 float(8)
);

--insert only unique rows into house details table
INSERT INTO king_county_house_details (
SELECT id,bedrooms,bathrooms,
sqft_living,sqft_lot,floors,
waterfront,"view","condition",grade,
sqft_above,sqft_basement,yr_built,
yr_renovated,zipcode,lat,long,
sqft_living15,sqft_lot15
FROM
(SELECT 
		*, ROW_NUMBER() OVER( PARTITION BY(id)) as row_num
        FROM king_county_house_prices_full 
) as t        
where t.row_num = 1
);

--testing
--SELECT * 
--FROM king_county_house_details kchd ;

--DROP TABLE king_county_house_details ;












