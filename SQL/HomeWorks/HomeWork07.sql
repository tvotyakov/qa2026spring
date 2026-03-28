-- ---------------------------------------------------
-- Homework #7
-- Part 1
-- Data Cleaning Project: "English Dictionary"
-- Import two files english_dictionary_master.csv and english_dictionary_most_common_words.csv
-- (Source: http://www.rupert.id.au/resources/1000-words.php)
-- 1.Edit - Preferences - SQL Editor - change RDBMS timeout connection to 600
-- 2.Create database Dictionary;
-- 3.Right click on database dictionary - Table Data Import Wizard - dictionary.english_dictionary_master - Next
-- Right click on database dictionary - Table Data Import Wizard - dictionary.english_dictionary_most_common_words - Next
-- Get to know the data: n - noun, a - adjective, v - verb, adverb, preposition
create database if not exists dictionary;

-- 4.Show counts of both tables
select 'english_dictionary_main' as TableName
      , count(*) as RowCount
  from dictionary.english_dictionary_main
union all
select 'english_dictionary_most_common_words'
      , count(*)
  from dictionary.english_dictionary_most_common_words;

-- 5.Create copies of both tables just in case you accidentally delete the originals
create table dictionary.english_dictionary_main_copy
(
    Word       text null,
    Type       text null,
    Length     int  null,
    Definition text null
);
insert into dictionary.english_dictionary_main_copy
select Word, Type, Length, Definition
  from dictionary.english_dictionary_main;

create table dictionary.english_dictionary_most_common_words_copy
(
    common_words text null
);
insert into dictionary.english_dictionary_most_common_words_copy
select common_words
  from dictionary.english_dictionary_most_common_words;

select 'english_dictionary_main_copy' as TableName
     , count(*)                       as RowCount
from dictionary.english_dictionary_main_copy
union all
select 'english_dictionary_most_common_words_copy'
     , count(*)
from dictionary.english_dictionary_most_common_words_copy;

-- 6.Rename column type to word_type and definition to word_def
alter table dictionary.english_dictionary_main
  rename column `Type` to `word_type`;

alter table dictionary.english_dictionary_main
  rename column Definition to word_def;

-- 7.Update column word_type and word_def to remove " and .
delete
  from  dictionary.english_dictionary_most_common_words
  where common_words = 'common_words';

update  dictionary.english_dictionary_main
  set   word_type = trim(regexp_replace(word_type, '[".]', ''))
      , word_def = trim(replace(word_def, '"', ''))
      , Length = length(trim(replace(word_def, '"', '')));

select word, word_type, length, word_def
  from dictionary.english_dictionary_main;

-- 8.Add column is_common to master table and update this column with 'yes' for common words
alter table dictionary.english_dictionary_main
  add column is_common boolean;

alter table dictionary.english_dictionary_most_common_words
  modify column common_words nvarchar(100) not null;

alter table dictionary.english_dictionary_most_common_words
  add constraint PK_common_words primary key (common_words);

update  dictionary.english_dictionary_main
  set   is_common = true
  where Word in (select common_words
                   from dictionary.english_dictionary_most_common_words);

update  dictionary.english_dictionary_main
  set   is_common = false
  where is_common is null;

-- 9.Using trim function get rid off extra spaces in all columns in dictionary.english_dictionary_master
update dictionary.english_dictionary_main
  set  Word = trim(Word);

-- 10.
-- Query1: how many distinct common/uncommon words are in the table?
select  'Total count of words' as Title
      , count(distinct Word) as cnt
  from  dictionary.english_dictionary_main
union all
select  'Count of common words' as Title
      , count(distinct Word) as cnt
  from  dictionary.english_dictionary_main
  where is_common
union all
select  'Count of uncommon words' as Title
      , count(distinct Word) as cnt
  from  dictionary.english_dictionary_main
  where not is_common;

select if(is_common, 'true', 'false')
     , count(distinct Word)
  from dictionary.english_dictionary_main
group by is_common;

-- Query2: how many distinct word_types are in the table?
select  count(distinct word_type)
  from dictionary.english_dictionary_main;

-- Query3: find all english words for different colors (e.g. bronze, ruby, white, pink, red, azure, blue, etc.)
select  *
  from  dictionary.english_dictionary_main
  where word_def like '%color%'
    and word_type = 'a';

-- Query4: randomly select 4 nouns and adjectives (order by rand())
select  *
  from  dictionary.english_dictionary_main
  where word_type in ('a', 'n')
order by rand()
limit 4;

-- Query5: create separate columns for each letter in the word -- use substr function
select max(length(Word))
  from dictionary.english_dictionary_main;

select  distinct Word, length(Word)
  from  dictionary.english_dictionary_main
order by length(Word) desc;

select  distinct Word
      , substr(Word, 1, 1) as letter_1
      , substr(Word, 2, 1) as letter_2
      , substr(Word, 3, 1) as letter_3
      , substr(Word, 4, 1) as letter_4
      , substr(Word, 5, 1) as letter_5
  from  dictionary.english_dictionary_main
  where length(Word) = 5;

-- Part2
-- Run TeslaDB.sql and these Queries
-- 1. Show all factories
select *
  from TeslaDB.Factories;

-- 2. Show employees with their factory info
desc TeslaDB.Employees;
select  concat(emp.first_name, '', emp.last_name)
      , emp.position
      , emp.email
      , f.factory_name
      , f.location
  from  TeslaDB.Employees emp
        left join TeslaDB.Factories f on f.factory_id = emp.factory_id;

-- 3. Show available vehicle models
select *
  from TeslaDB.VehicleModels;

-- 4. Display all vehicles with model names
select  VM.model_name
     ,  V.vin
     ,  V.production_date
     ,  V.color
     ,  V.status
  from  TeslaDB.Vehicles V
        join TeslaDB.VehicleModels VM on VM.model_id = V.model_id;

-- 5. Check orders with customer and model details
select  concat(C.first_name, ' ', C.last_name)
     ,  VM.model_name
     ,  VM.battery_capacity_kWh
     ,  O.order_date
     ,  O.total_price
     ,  O.status
  from  TeslaDB.Orders O
        join TeslaDB.Customers C on C.customer_id = O.customer_id
        join TeslaDB.VehicleModels VM on VM.model_id = O.model_id;

-- 6. Display shipments
select  Sh.shipping_date
     ,  Sh.arrival_date
     ,  Sh.shipping_status
     ,  F.factory_name
     ,  O.order_date
  from  TeslaDB.Shipments Sh
        join TeslaDB.Factories F on Sh.factory_id = F.factory_id
        join TeslaDB.Orders O on Sh.order_id = O.order_id;

-- 7. Show service appointments with vehicle VIN and center info
select  SC.center_name
     ,  SC.center_name
     ,  SA.appointment_date
     ,  SA.service_needed
     ,  SA.appointment_status
     ,  V.vin
     ,  V.status
  from  TeslaDB.ServiceAppointments SA
        join TeslaDB.Vehicles V on SA.vehicle_id = V.vehicle_id
        join TeslaDB.ServiceCenters SC on SA.center_id = SC.center_id;