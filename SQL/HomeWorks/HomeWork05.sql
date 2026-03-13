-- ---------------------------------------------------
-- Homework #5
-- Part 1
-- Group By  Example by Animation: https://dataschool.com/how-to-teach-people-sql/how-sql-aggregations-work/
-- Classicmodels Database
--  1.use union: show products with buyPrice > 100 and <200
select  productName, buyPrice
  from  classicmodels.products
  where buyPrice > 100
   and  buyPrice < 200;

--  2.use subquery: show all customer names with employees in San Francisco office
select  cust.customerName
  from  classicmodels.customers cust
        join classicmodels.employees emp on cust.salesRepEmployeeNumber = emp.employeeNumber
        join classicmodels.offices o on emp.officeCode = o.officeCode
  where o.city = 'San Francisco';

--  3.use subquery: based on previous query add count(*) to show total of employees in San Francisco office
select  count(*) as empCount
  from  classicmodels.employees emp
        join classicmodels.offices o on emp.officeCode = o.officeCode
                                    and o.city = 'San Francisco';

-- Part 2
-- Classicmodels Database - Keep working on these queries
-- write sql for classicmodels #10-15
-- 10.how many vendors, product lines, and products exist in the database?
select count(distinct prod.productVendor) as vendorsCount
     , (select count(*)
          from classicmodels.productlines) as productLinesCount
     , count(*) as productsCount
  from classicmodels.products prod;

-- 11.what is the average price (buy price, MSRP) per vendor?
select  prod.productVendor
      , avg(prod.buyPrice) as buyPriceAvg
      , avg(prod.MSRP) as msrpAvg
  from  classicmodels.products prod
group by prod.productVendor;

-- 12.what is the average price (buy price, MSRP) per customer?
select  cust.customerName
      , avg(prod.buyPrice) as buyPriceAvg
      , avg(prod.MSRP) as msrpAvg
  from  classicmodels.products prod
        inner join classicmodels.orderdetails od on prod.productCode = od.productCode
        inner join classicmodels.orders ord on od.orderNumber = ord.orderNumber
        inner join classicmodels.customers cust on ord.customerNumber = cust.customerNumber
group by cust.customerName;

-- 13.what product was sold the most?
select  prod.productName, sum(ord.quantityOrdered) as soldQuantity
  from  classicmodels.products prod
        inner join classicmodels.orderdetails ord on prod.productCode = ord.productCode
group by prod.productName
order by soldQuantity desc
limit 1;

-- 14.how much money was made between buyPrice and MSRP?
select  sum((MSRP - buyPrice) * od.quantityOrdered)
  from  classicmodels.products prod
        inner join classicmodels.orderdetails od
            on prod.productCode = od.productCode
        inner join classicmodels.orders ord
            on od.orderNumber = ord.orderNumber
  where ord.status not in ('Cancelled', 'Disputed');

-- 15.which vendor sells more products?
select  prod.productVendor, sum(od.quantityOrdered) quantitySold
  from  classicmodels.products prod
        inner join classicmodels.orderdetails od
            on prod.productCode = od.productCode
        inner join classicmodels.orders ord
            on od.orderNumber = ord.orderNumber
  where ord.status not in ('Cancelled', 'Disputed')
group by prod.productVendor
order by quantitySold desc
limit 1;

-- Part 3
-- Run RealEstateDB.sql, check out EER Diagram, run these queries
-- Show all listings with property address, price, agent full name, and status
select  p.address as property_address
     ,  p.city as property_city
     ,  p.state as property_state
     ,  p.zip_code as property_zip_code
     ,  lst.listing_price
     ,  concat(a.first_name, ' ', a.last_name) as agent_full_name
     ,  lst.status
  from  RealEstateDB.Listings lst
        join RealEstateDB.Agents a on lst.agent_id = a.agent_id
        join RealEstateDB.Properties p on lst.property_id = p.property_id;

-- Show all showings with client full name and listing details (address, date, notes)
select  concat(cl.first_name, ' ', cl.last_name) as client_full_name
     ,  prop.address as property_address
     ,  prop.city as property_city
     ,  prop.state as property_state
     ,  prop.zip_code as property_zip_code
     ,  sh.showing_date
     ,  sh.notes
  from  RealEstateDB.Showings sh
        join RealEstateDB.Clients cl on sh.client_id = cl.client_id
        join RealEstateDB.Listings lst on sh.listing_id = lst.listing_id
        join RealEstateDB.Properties prop on lst.property_id = prop.property_id;

-- Show offers with listing info (address and price), client full name, and offer status
select  prop.address as property_address
     ,  prop.city as property_city
     ,  prop.state as property_state
     ,  prop.zip_code as property_zip_code
     ,  concat(cl.first_name, ' ', cl.last_name) as client_full_name
     ,  lst.listing_price
     ,  ofr.offer_price
     ,  ofr.offer_date
     ,  ofr.offer_status
  from  RealEstateDB.Offers ofr
        join RealEstateDB.Listings lst on ofr.listing_id = lst.listing_id
        join RealEstateDB.Properties prop on lst.property_id = prop.property_id
        join RealEstateDB.Clients cl on ofr.client_id = cl.client_id;

-- Show completed transactions (transaction, closing date, sale price, address, buyer full name)
select  tr.closing_date
     ,  tr.final_sale_price as sale_price
     ,  prop.address as property_address
     ,  prop.city as property_city
     ,  prop.state as property_state
     ,  prop.zip_code as property_zip_code
     ,  concat(cl.first_name, ' ', cl.last_name) as buyer_full_name
  from  RealEstateDB.Transactions tr
        join RealEstateDB.Listings lst on tr.listing_id = lst.listing_id
        join RealEstateDB.Properties prop on lst.property_id = prop.property_id
        join RealEstateDB.Offers ofr on tr.offer_id = ofr.offer_id
        join RealEstateDB.Clients cl on ofr.client_id = cl.client_id;