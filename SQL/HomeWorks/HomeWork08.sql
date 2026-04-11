-- -------------------------------------------------------
-- Homework #8
-- Part1 world.sql

-- download 'world database' https://dev.mysql.com/doc/index-other.html
-- unzip, open and run sql script world.sql
-- create EER diagram and write queries
use `world`;

-- 1. show distinct continent, region, country
select distinct Continent
  from world.country;

select distinct Region
  from world.country;

select distinct country.Name
  from world.country;

-- 2. what languages are spoken in Sydney?
select  cl.Language
  from  world.countrylanguage cl
        join world.city c on cl.CountryCode = c.CountryCode
  where c.Name = 'Sydney';

-- 3. show governmentForm and number of countries (desc order)
select GovernmentForm, count(*)
  from world.country
group by GovernmentForm
order by count(*) desc;

-- 4. rank country by population (desc order)
select Name
     , Population
     , rank() over (order by Population desc) as RankByPopulation
  from world.country;

-- 5. which country has the bigest number of languages?
with LanguageCounts as
  (select CountryCode
        , count(*) as LanguageCount
     from world.countrylanguage
   group by CountryCode)
select  c.Name
      , lc.LanguageCount
      , max(lc.LanguageCount) over(order by c.Name)
  from  world.country c
        join LanguageCounts lc on c.Code = lc.CountryCode
  where lc.LanguageCount = (select max(LanguageCount)
                              from LanguageCounts)
order by c.Name;

-- 6. which country has the lowest LifeExpectancy
select  Name, LifeExpectancy
  from  world.country
  where LifeExpectancy = (select min(LifeExpectancy)
                            from world.country);

-- 7. if a country has English as one of the languages, it is an 'English Speaking' country, if not 'Non English Speaking'
select c.Name as "Country Name"
     , if(cl.Language is null,
          'Non English Speaking',
          'English Speaking') as "English Speaking or Not"
  from world.country c
       left join world.countrylanguage cl on c.Code = cl.CountryCode
                                         and cl.Language = 'English';

-- 8. what is the average life expectancy for countries with population < 1 million and > 1 million?
select  '< 1 mill' as `Country Group`
      , avg(country.LifeExpectancy) as "Avg Life Expectancy"
  from  world.country
  where Population < 1000000
union all
select  '>= 1 mill' as `Country Group`
      , avg(country.LifeExpectancy) as "Avg Life Expectancy"
  from  world.country
  where Population >= 1000000;

 -- Part2 jeopardy database
/*create database jeopardy;
 right click of database jeopardy and download jason or csv file (both have issues) from
 https://www.reddit.com/r/datasets/comments/1uyd0t/200000_jeopardy_questions_in_a_json_file/ */
CREATE DATABASE IF NOT EXISTS jeopardy DEFAULT CHARACTER SET utf8mb4;

-- Queries
-- 1.find top 5 categories
select  Category
  from  jeopardy.JEOPARDY_CSV
group by Category
order by count(*) desc
limit 5;

-- 2.find a question about Shakespere
select  *
  from  jeopardy.JEOPARDY_CSV
  where Category = 'Shakespeare';

-- 3.how many distinct show numbers?
select count(distinct `Show Number`) as `Show Numbers Count`
  from jeopardy.JEOPARDY_CSV;

-- 4.what are the 3 most common answers?
select  Answer, count(*)
  from  jeopardy.JEOPARDY_CSV
group by Answer
order by count(*) desc
limit 3;

-- 5.how many questions per each value?
select Value, count(distinct Question)
  from jeopardy.JEOPARDY_CSV
group by Value
order by count(distinct Question) desc;

-- 6.which category has the most questions?
select Category, count(distinct Question) as `Questions Count`
  from jeopardy.JEOPARDY_CSV
group by Category
order by `Questions Count` desc;

-- 7.how many questions each year?
select  YEAR(`Air Date`) as `Year`
      , count(Question) as `Questions Count`
  from  jeopardy.JEOPARDY_CSV
group by YEAR(`Air Date`)
order by `Year`;

-- 8.show number of questions for each value in each round
select Round
     , Value
    , count(distinct Question) as `Number of Questions`
  from jeopardy.JEOPARDY_CSV
group by Round, Value;

-- 9.how many questions are missing?
select  count(*) as `Count of Missing Question`
  from  jeopardy.JEOPARDY_CSV
  where Question is null or Question = '';

-- 10.how many questions have no answers?
select  count(distinct Question) as `Count of Questions without Answers`
  from  jeopardy.JEOPARDY_CSV
  where Answer is null || Answer = '';

-- 11.how many distinct rounds in each show?
select `Show Number`
     , count(distinct Round) as `Rounds in Show`
  from jeopardy.JEOPARDY_CSV
group by `Show Number`
order by `Show Number`;


-- Part 3
-- Run Hotel Management DB (HotelDB.sql) and these queries
-- 1. Show all hotels and their ratings
select hotel_name, city, country, rating
from HotelDB.Hotels;

-- 2. Show rooms info in each hotel
select H.hotel_name
     , R.room_number
     , R.room_type
     , R.price_per_night
     , R.capacity
     , R.status
  from HotelDB.Rooms R
       join HotelDB.Hotels H on R.hotel_id = H.hotel_id
order by H.hotel_name, R.room_number;

-- 3. Show all reservations with guest and room info
select concat(guest.first_name, ' ', guest.last_name) as `Guest's Full Name`
     , hotel.hotel_name
     , room.room_number
     , room.room_type
     , reserv.check_in_date
     , reserv.check_out_date
     , reserv.total_amount
     , reserv.reservation_status
  from HotelDB.Reservations reserv
       join HotelDB.Rooms room on room.room_id = reserv.room_id
       join HotelDB.Guests guest on guest.guest_id = reserv.guest_id
       join HotelDB.Hotels hotel on hotel.hotel_id = room.hotel_id;

-- 4. Display service transactions with guest info
select s.service_name
     , room.room_number
     , st.quantity as `Service Quantity`
     , st.total_price as `Service Price`
     , concat(g.first_name, ' ', g.last_name) as `Guest's Full Name`
     , g.email as `Guest's Email`
     , g.phone as `Guest's Phone`
  from HotelDB.ServiceTransactions st
       join HotelDB.Services s on s.service_id = st.service_id
       join HotelDB.Reservations r on r.reservation_id = st.reservation_id
       join HotelDB.Guests g on r.guest_id = g.guest_id
       join HotelDB.Rooms room on room.room_id = r.room_id;

-- 5 Show Housekeeping log (cleaning date/room/staff/remarks)
select hk.cleaning_date
     , r.room_number
     , concat(s.first_name, ' ', s.last_name) as `staff`
     , hk.remarks
  from HotelDB.Housekeeping hk
       join HotelDB.Rooms r on r.room_id = hk.room_id
       join HotelDB.Staff s on s.staff_id = hk.staff_id
order by hk.cleaning_date;