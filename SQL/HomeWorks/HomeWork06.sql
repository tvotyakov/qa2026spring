-- ---------------------------------------------------
-- Homework #6

-- ---------------------------------------------------
-- Homework - Part #2
-- Find any dataset you want to analyze (csv, xls, etc.) and import the data
-- https://www.dataquest.io/blog/free-datasets-for-projects/
-- https://www.kaggle.com/datasets
-- https://catalog.data.gov/dataset
-- https://data.world
-- https://datasf.org/opendata/
DROP DATABASE IF EXISTS data_gov;
CREATE DATABASE IF NOT EXISTS data_gov;

CREATE TABLE IF NOT EXISTS data_gov.air_quality
(
    `Unique ID` bigint not null
  , `Indicator ID` bigint not null
  , `Name` text
  , `Measure` text
  , `Measure Info` text
  , `Geo Type Name` text
  , `Geo Join ID` bigint
  , `Geo Place Name` text
  , `Time Period` text
  , Start_Date text
  , Data_Value text
  , Message text
);

LOAD DATA LOCAL INFILE 'd:/learn/qa2026spring/SQL/Air_Quality.csv '
  INTO TABLE data_gov.air_quality
  FIELDS TERMINATED BY ','
  ENCLOSED BY '"'
  LINES TERMINATED BY '\n'
  IGNORE 1 ROWS
  ( `Unique ID`
  , `Indicator ID`
  , `Name`
  , `Measure`
  , `Measure Info`
  , `Geo Type Name`
  , `Geo Join ID`
  , `Geo Place Name`
  , `Time Period`
  , Start_Date
  , Data_Value
  , Message);

select count(*) from data_gov.air_quality;
select * from data_gov.air_quality limit 100;

-- Count measures by Name
select Name, count(*)
  from data_gov.air_quality
group by Name;

-- Count measures by type
select Measure, count(*)
  from data_gov.air_quality
group by Measure;

select *
  from data_gov.air_quality
  where Measure = 'Million miles';

alter table data_gov.air_quality
    rename column Start_Date to Start_Date_Str;

alter table data_gov.air_quality
    add column Start_Date date;

select distinct Start_Date_Str
  from data_gov.air_quality;

update data_gov.air_quality
  set  Start_Date = str_to_date(Start_Date_Str, '%m/%d/%Y');

select distinct Start_Date_Str, Start_Date
  from data_gov.air_quality;

-- select measures started in the last decade
select  *
  from  data_gov.air_quality
  where YEAR(Start_Date) >= YEAR(NOW()) - 10;

-- select count of measures by Name and Measure
select  Name, Measure, count(*)
  from  data_gov.air_quality
group by Name, Measure;

-- select count of Fine Particles measures
-- and avg data_value by Name and Time Period
select  Name, Measure, `Time Period`, count(*), avg(Data_Value)
  from data_gov.air_quality
  where Name = 'FIne particles (PM 2.5)'
group by Name, Measure, `Time Period`;

-- select measures with messages
select  *
  from  data_gov.air_quality
  where IFNULL(Message, '') != '';

-- ---------------------------------------------------
-- Homework - Part #3
-- Import file using Table Data Import Wizard
-- Film Locations in San Francisco
-- import csv file Film_Locations_in_San_Francisco.csv from course meterials or from source
-- https://data.sfgov.org/Culture-and-Recreation/Film-Locations-in-San-Francisco/yitu-d5am
-- in MySQL Workbanch:
-- Drop database Film;
-- Create database Film;
-- right click on Film database - Table Data Import Wizard - Next ...
-- select * from film.film_locations_in_san_francisco;
DROP DATABASE IF EXISTS film;
CREATE DATABASE IF NOT EXISTS film;

/* loaded 171 records instead of 1,976
why?
The MySQL Workbench 8.0 import wizard seems to fail apostrophes in column names. 
This is reported as a bug here: https://bugs.mysql.com/bug.php?id=95700, but the bug is not yet fixed. 
They suggest a workaround of using JSON input files instead of CSV, 
but that doesn't help you if you must import CSV files.*/

-- Queries:
-- Count distinct movies
select count(distinct title, `Release Year`) as CountDistictMovies
  from film.film_locations_in_san_francisco_2;

-- Count of all films by release year
select `Release Year`, count(distinct Title)
  from film.film_locations_in_san_francisco
group by `Release Year`;

-- Count of all films by 'production company'
select `Production Company`, count(distinct Title)
  from film.film_locations_in_san_francisco
group by `Production Company`;

-- Count of all films directed by Woody Allen
select  count(distinct Title) as `Films by Woody Allen`
  from  film.film_locations_in_san_francisco
  where Director = 'Woody Allen';

-- How many movies have/don't have fun facts?
select count(`Fun Facts`) as `With Fun Facts`
     , count(if(`Fun Facts` is null, 1, null)) as `Without Fun Facts`
     , count(*) as `Total Count`
  from (select distinct Title, `Fun Facts`
          from film.film_locations_in_san_francisco) films;

-- In how many movies were Keanu Reeves and Robin Williams?
select  count(distinct Title) as MoviesCount
  from  film.film_locations_in_san_francisco
  where (`Actor 1` = 'Keanu Reeves' or `Actor 2` = 'Keanu Reeves' or `Actor 3` = 'Keanu Reeves')
    or  (`Actor 1` = 'Robin Williams' or `Actor 2` = 'Robin Williams' or `Actor 3` = 'Robin Williams');

-- ---------------------------------------------------
-- Homework - Part #4
-- ------------------- ETL (EXTRACT TRANSFORM LOAD) -------------------
-- ------------------- Loading the same .csv file via the Command-Line --------------
-- 1. Create database and table structure (with column names and datatypes) for CSV data load
-- look up the data type of existing columns if imported table exists
SELECT  column_name, column_type 
FROM INFORMATION_SCHEMA.columns
WHERE TABLE_SCHEMA = 'film';

-- create new database and empty table
CREATE TABLE film.film_locations_in_san_francisco_2 (
    `Title`	text,
    `Release Year`	int(11),
    `Locations`	text,
    `Fun Facts`	text,
    `Production Company`	text,
    `Distributor`	text,
    `Director`	text,
    `Writer`	text,
    `Actor 1`	text,
    `Actor 2`	text,
    `Actor 3`	text
);
-- select * from film.film_locations_in_san_francisco_2;

-- 2. Set Client and Server ON - to Enable local data load on MySQL Client and Server
-- Instructions for Windows in file: 'ETL - Enabling local data load on MySQL Client and Server.docx'

-- 3. Import the CSV file
-- Windows - Search MySQL - In command prompt paste:
LOAD DATA LOCAL INFILE 'd:/learn/qa2026spring/SQL/Film_Locations_in_San_Francisco.csv '
 INTO TABLE film.film_locations_in_san_francisco_2
 FIELDS TERMINATED BY ',' 
 ENCLOSED BY '"' 
 LINES TERMINATED BY '\n' 
 IGNORE 1 ROWS
 (`Title`,`Release Year`,`Locations`,`Fun Facts`,`Production Company`,`Distributor`,
 `Director`,`Writer`,`Actor 1`,`Actor 2`,`Actor 3`);

-- see 1976 records loaded
select count(*) from film.film_locations_in_san_francisco_2;
select * from film.film_locations_in_san_francisco_2;

-- Queries:
-- Count distinct movies
select count(distinct title, `Release Year`) as CountDistictMovies
  from film.film_locations_in_san_francisco_2;

-- Count of all films by release year
select `Release Year`, count(distinct Title)
  from film.film_locations_in_san_francisco_2
group by `Release Year`;

-- Count of all films by 'production company'
select `Production Company`, count(distinct Title)
  from film.film_locations_in_san_francisco_2
group by `Production Company`;

-- Count of all films directed by Woody Allen
select  count(distinct Title) as `Films by Woody Allen`
  from  film.film_locations_in_san_francisco_2
  where Director = 'Woody Allen';

-- How many movies have/don't have fun facts?
select count(if(ifnull(`Fun Facts`, '') = '', null, 1)) as `With Fun Facts`
     , count(if(ifnull(`Fun Facts`, '') = '', 1, null)) as `With Fun Facts`
     , count(*) as `Total Count`
  from (select distinct Title, `Fun Facts`
          from film.film_locations_in_san_francisco_2) films;

-- In how many movies were Keanu Reeves and Robin Williams?
select  count(distinct Title) as MoviesCount
  from  film.film_locations_in_san_francisco_2
  where `Actor 1` = 'Keanu Reeves'
     or `Actor 2` = 'Keanu Reeves'
     or `Actor 3` = 'Keanu Reeves'
     or `Actor 1` = 'Robin Williams'
     or `Actor 2` = 'Robin Williams'
     or `Actor 3` = 'Robin Williams';
