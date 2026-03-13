-- ---------------------------------------------------
-- Homework for Lesson #4

-- Part #1 classicmodels database

-- 1-9 easy questions
-- 1.which vendor sells 1966 Shelby Cobra?
select  productVendor
  from  classicmodels.products
  where productName like '%1966 Shelby Cobra%';

-- 2.which product is the most and least expensive?
(
  select 'most expensive' as expensiveness, productName, MSRP
    from  classicmodels.products
  order by msrp desc
  limit 1
)
union all
(
  select 'least expensive', productName, MSRP
    from  classicmodels.products
  order by msrp
  limit 1
);

-- 3.which product has the most quantityInStock?
select productName, quantityInStock
  from classicmodels.products
order by quantityInStock desc
limit 1;

-- 4.list all products that have quantity in stock less than 20
select  productName, quantityInStock
  from  classicmodels.products
  where quantityInStock < 20;

-- 5.which customer has the highest and lowest credit limit?
select  customerName, creditLimit
  from  classicmodels.customers
  where creditLimit =(select min(creditLimit) from classicmodels.customers)
    or  creditLimit = (select max(creditLimit) from classicmodels.customers)
order by creditLimit;

-- 6.customers in what city are the most profitable to the company? -- based on highest single payment
select  cust.city, paym.amount
  from  classicmodels.customers cust
        left join classicmodels.payments paym
            on cust.customerNumber = paym.customerNumber
order by paym.amount desc
limit 1;

-- 7.who is the best customer? --based on single payment
select  cust.customerName, paym.amount as paidAmount
  from  classicmodels.customers cust
        left join classicmodels.payments paym
            on cust.customerNumber = paym.customerNumber
order by paym.amount desc
limit 1;

-- 8.customers without payment
-- variant 1
select  cust.customerName
  from  classicmodels.customers cust
  where not exists(select  *
                     from  classicmodels.payments paym
                     where paym.customerNumber = cust.customerNumber);

-- variant 2
select  cust.customerName
  from  classicmodels.customers cust
        left join classicmodels.payments paym
            on cust.customerNumber = paym.customerNumber
  where paym.customerNumber is null;

-- 9.list all employees by their (full name: first + last) in alpabetical order
select concat(empl.firstName, ' ', empl.lastName) as fullName
  from classicmodels.employees empl
order by fullName;

-- these questions require table joins and group by
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

-- 16. rank customers by credit limit
select  cust.customerName
      , cust.creditLimit
      , (dense_rank()
            over (order by creditLimit desc)) as customerRank
  from  classicmodels.customers cust
order by customerRank;

-- 17. list the most sold product by city
with soldProducts as
    (select  offices.city
          ,  prod.productName
          ,  sum(od.quantityOrdered) as soldQuantity
       from  classicmodels.offices
             inner join classicmodels.employees empl on offices.officeCode = empl.officeCode
             inner join classicmodels.customers cust on empl.employeeNumber = cust.salesRepEmployeeNumber
             inner join classicmodels.orders ord on cust.customerNumber = ord.customerNumber
             inner join classicmodels.orderdetails od on ord.orderNumber = od.orderNumber
             inner join classicmodels.products prod on od.productCode = prod.productCode
       where ord.status != 'Cancelled'
     group by offices.city, prod.productName)
select  *
  from  soldProducts sp
  where soldQuantity = (select max(sp2.soldQuantity)
                          from soldProducts sp2
                          where sp2.city = sp.city
                        group by sp2.city);

-- 18.what is the average number of orders per customer?
select  count(*) / count(distinct customerNumber) as avgOrdersPerCustomer
  from  classicmodels.orders;

-- 19.what is the average number of days between the order date and ship date?
select  avg(datediff(ord.shippedDate, ord.orderDate)) as avgDateDiff
  from  classicmodels.orders ord
  where ord.shippedDate is not null;

-- 20.sales by year
select  year(orderDate) as orderYear
      , count(*) as ordersCount
  from  classicmodels.orders
  where shippedDate is not null
group by orderYear
order by orderYear;

-- 21.how many orders are not shipped?
select  count(*)
  from  classicmodels.orders
  where shippedDate is null;

-- 22.list of employees  by how much they sold in 2003?
select  concat(empl.firstName, ' ', empl.lastName) as employeeFullName
      , sum(o2.quantityOrdered) as soldQuantity
  from  classicmodels.employees empl
        inner join classicmodels.customers c on empl.employeeNumber = c.salesRepEmployeeNumber
        inner join classicmodels.orders o on c.customerNumber = o.customerNumber
        inner join classicmodels.orderdetails o2 on o.orderNumber = o2.orderNumber
  where year(o.orderDate) = 2003
    and o.status != 'Cancelled'
group by employeeFullName
order by employeeFullName;

select  quantityOrdered
  from  classicmodels.employees empl
        inner join classicmodels.customers c on empl.employeeNumber = c.salesRepEmployeeNumber
        inner join classicmodels.orders o on c.customerNumber = o.customerNumber
        inner join classicmodels.orderdetails o2 on o.orderNumber = o2.orderNumber
  where empl.firstName = 'Julie' and empl.lastName = 'Firrelli'
    and year(o.orderDate) = 2003
    and o.status != 'Cancelled';

-- 23.which city has the most number of employees?
select  city, count(*) as employeesCount
  from  classicmodels.offices
        inner join classicmodels.employees e
            on offices.officeCode = e.officeCode
group by city
order by employeesCount desc
limit 1;

-- 24.which office has the biggest sales?
select  offices.city
     ,  sum(od.quantityOrdered * od.priceEach) as salesAmount
  from  classicmodels.offices
        inner join classicmodels.employees empl on offices.officeCode = empl.officeCode
        inner join classicmodels.customers cust on empl.employeeNumber = cust.salesRepEmployeeNumber
        inner join classicmodels.orders ord on cust.customerNumber = ord.customerNumber
        inner join classicmodels.orderdetails od on ord.orderNumber = od.orderNumber
        inner join classicmodels.products prod on od.productCode = prod.productCode
  where ord.status != 'Cancelled'
group by offices.city
order by salesAmount desc
limit 1;

-- Part 2 UniversityDB
-- 1. List all Students and their major Departments
select  concat(st.first_name, ' ', st.last_name) as studentName
     ,  dept.department_name
  from  UniversityDB.Students st
        inner join UniversityDB.Departments dept on st.major_department_id = dept.department_id
order by studentName;

-- 2. Show all Classes with Course, Instructor, and Semester info
select  c.course_name
      , concat(instr.first_name, ' ', instr.last_name) as instructor_name
      , sem.semester_name
      , sem.start_date
      , sem.end_date
      , cls.room
  from  UniversityDB.Classes as cls
        inner join UniversityDB.Courses as c on cls.course_id = c.course_id
        inner join UniversityDB.Instructors as instr on cls.instructor_id = instr.instructor_id
        inner join UniversityDB.Semesters as sem on cls.semester_id = sem.semester_id
order by c.course_name, sem.start_date, instructor_name;

-- 3. Display all enrollments with Student and Class details
select  concat(s.first_name, ' ', s.last_name) as student_name
    ,   c2.course_name
    ,   c.room as class_room
    ,   c.schedule_day as class_schedule_day
    ,   enr.enrollment_date
  from  UniversityDB.Enrollment enr
        inner join UniversityDB.Students s on enr.student_id = s.student_id
        inner join UniversityDB.Classes c on enr.class_id = c.class_id
        inner join UniversityDB.Courses c2 on c.course_id = c2.course_id
order by student_name;

-- 4. Display Grades for each student and course
select  concat(stud.first_name, ' ', stud.last_name) as studentName
      , c.course_name
      , ifnull(gr.letter_grade, '???')
  from  UniversityDB.Students stud
        inner join UniversityDB.Enrollment enr on enr.student_id = stud.student_id
        inner join UniversityDB.Classes cls on enr.class_id = cls.class_id
        inner join UniversityDB.Courses c on cls.course_id = c.course_id
        left join UniversityDB.Grades gr on enr.enrollment_id = gr.enrollment_id
order by studentName, c.course_name, enr.enrollment_date;