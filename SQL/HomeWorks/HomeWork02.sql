-- Part 1

-- show all customers in Australia
select  *
  from  classicmodels.customers cust
  where cust.country = 'Australia';

-- show First and Last name of customers in Melbourne
select  cust.contactFirstName, cust.contactLastName
  from  classicmodels.customers cust
  where cust.city = 'Melbourne';

-- show all customers with Credit Limit over $200,000
select  *
  from  classicmodels.customers cust
  where cust.creditLimit > 200000;

-- who is the president of the company?
select  firstName, lastName
  from  classicmodels.employees emp
  where jobTitle = 'President';

-- how many Sales Reps are in the company?
select  firstName, lastName
  from  classicmodels.employees emp
  where jobTitle = 'Sales Rep'
order by lastName, firstName;

-- show payments in descending order
select  *
  from  classicmodels.payments
order by paymentDate desc;

-- what was the check# for the payment done on December 17th 2004
select  pay.checkNumber, pay.*
  from  classicmodels.payments pay
  where paymentDate = '2004-12-17';

-- show product line with the word 'realistic' in the description
select  *
  from  classicmodels.productlines prl
  where prl.textDescription like '%realistic%';

-- show product name for vendor 'Unimax Art Galleries'
select  pr.productName
  from  classicmodels.products pr
  where pr.productVendor = 'Unimax Art Galleries';

-- what is the customer number for the highest amount of payment
select  pay.customerNumber
  from  classicmodels.payments pay
  where pay.amount = (select max(amount)
                        from classicmodels.payments);

-- H2 Part2
-- Run UniversityDB script
-- Show EER diagram
-- Show counts of every table in different ways
-- variant 1
select  TABLE_SCHEMA, TABLE_NAME, TABLE_ROWS, ENGINE
  from  information_schema.TABLES
  where TABLE_SCHEMA = 'UniversityDB'
order by TABLE_NAME;

-- variant 2
select 'UniversityDB.Classes', count(*) from UniversityDB.Classes;
select 'UniversityDB.Courses', count(*) from UniversityDB.Courses;
select 'UniversityDB.Departments', count(*) from UniversityDB.Departments;
select 'UniversityDB.Enrollment', count(*) from UniversityDB.Enrollment;
select 'UniversityDB.Grades', count(*) from UniversityDB.Grades;
select 'UniversityDB.Instructors', count(*) from UniversityDB.Instructors;
select 'UniversityDB.Semesters', count(*) from UniversityDB.Semesters;
select 'UniversityDB.Students', count(*) from UniversityDB.Students;

-- variant 3
select  TABLE_SCHEMA, TABLE_NAME, TABLE_ROWS, ENGINE
  from  information_schema.TABLES
  where TABLE_SCHEMA = 'UniversityDB'
order by TABLE_NAME;

select 'UniversityDB.Classes' as TableName, count(*) from UniversityDB.Classes
union all
select 'UniversityDB.Courses', count(*) from UniversityDB.Courses
union all
select 'UniversityDB.Departments', count(*) from UniversityDB.Departments
union all
select 'UniversityDB.Enrollment', count(*) from UniversityDB.Enrollment
union all
select 'UniversityDB.Grades', count(*) from UniversityDB.Grades
union all
select 'UniversityDB.Instructors', count(*) from UniversityDB.Instructors
union all
select 'UniversityDB.Semesters', count(*) from UniversityDB.Semesters
union all
select 'UniversityDB.Students', count(*) from UniversityDB.Students;
