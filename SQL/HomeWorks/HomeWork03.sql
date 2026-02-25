-- ---------------------------------------------
-- Prepare to home work
-- ---------------------------------------------
CREATE DATABASE IF NOT EXISTS my_work;

CREATE TABLE IF NOT EXISTS my_work.emp (
    empno INT (10) NOT NULL,
    ename VARCHAR(10) DEFAULT NULL,
    job VARCHAR(9) DEFAULT NULL,
    mgr INT(10) DEFAULT NULL,
    hiredate DATE,
    sal NUMERIC(7,2),
    comm NUMERIC(7,2) NULL,
    dept INT (10),

    PRIMARY KEY (empno)
);

insert into my_work.emp (empno,ename,job,mgr,hiredate,sal,comm,dept)
values
    (1,'JOHNSON','ADMIN',6,'1990-12-17',18000,NULL,4),
    (2,'HARDING','MANAGER',9,'1990-12-17',52000,300,3),
	(3,'TAFT','SALES I',2,'1995-12-17',25000,500,3),
    (4,'HOOVER','SALES I',2,'1990-04-02',27000,NULL,3),
    (5,'LINCOLN','TECH',6,'1994-06-23',22500,1400,4),
    (6,'GARFIELD','MANAGER',9,'1993-05-01',54000,NULL,4),
    (7,'POLK','TECH',6,'1997-09-22',25000,NULL,4),
    (8,'GRANT','ENGINEER',10,'1997-03-30',32000,NULL,2),
    (9,'JACKSON','CEO',NULL,'1990-01-01',75000,NULL,4),
    (10,'FILLMORE','MANAGER',9,'1994-08-09',56000,NULL,2),
    (11,'ADAMS','ENGINEER',10,'1996-03-15',34000,NULL,2),
    (12,'WASHINGTON','ADMIN',6,'1998-04-16',18000,NULL,4),
    (13,'MONROE','ENGINEER',10,'2000-12-03',30000,NULL,2),
    (14,'ROOSEVELT','CPA',9,'1995-10-12',35000,NULL,1);

ALTER TABLE my_work.emp RENAME COLUMN job TO job_title;

UPDATE  my_work.emp
  SET   ename = 'SMITH'
  WHERE ename = 'POLK';

DELETE FROM my_work.emp
  WHERE ename = 'ROOSEVELT';

CREATE TABLE IF NOT EXISTS my_work.dept (
    deptno INT NOT NULL,
    dname VARCHAR(14),
    loc VARCHAR(13),

    PRIMARY KEY (deptno)
);

insert into my_work.dept
values
    (1,'ACCOUNTING','ST LOUIS'),
    (2,'RESEARCH','NEW YORK'),
    (3,'SALES','ATLANTA'),
    (4,'OPERATIONS','SEATTLE');

ALTER TABLE my_work.emp
  ADD FOREIGN KEY fk_dept(dept) REFERENCES dept(deptno)
        ON DELETE NO ACTION
        ON UPDATE CASCADE;

-- ---------------------------------------------
-- Home work
-- ---------------------------------------------
-- Part 1 - my_work database
ALTER TABLE my_work.dept
  ADD COLUMN country varchar(50);

ALTER TABLE my_work.dept
  RENAME COLUMN loc TO city;

INSERT INTO my_work.dept(deptno, dname, city, country)
VALUES
    (5, 'HR', 'ST LOUIS', 'USA'),
    (6, 'Engineering', 'NEW YORK', 'USA'),
    (7, 'Marketing', 'ATLANTA', 'USA');

-- DELETE FROM my_work.dept WHERE deptno IN (5, 6, 7);
-- UPDATE my_work.dept SET country = 'USA' WHERE country IS NULL;

SELECT  *
  FROM  my_work.dept
  WHERE city = 'Atlanta';

-- Part 2 - UniversityDB database
-- show schedule day for classes in room 306
select  schedule_day
  from  UniversityDB.Classes
  where room like '%306';

-- how many credits is Linear Algebra course?
select  credits
  from  UniversityDB.Courses
  where course_name = 'Linear Algebra';

-- in which building is English department?
select  building
  from  UniversityDB.Departments
  where department_name = 'English';

-- show all records for enrollment date '2024-08-22'?
select  *
  from  UniversityDB.Enrollment
  where enrollment_date = '2024-08-22';

-- show distinct letter grades given to students?
select distinct letter_grade
  from UniversityDB.Grades;

-- show email address for instructor Alice Johnson
select  email
  from  UniversityDB.Instructors
  where first_name = 'Alice'
    and last_name = 'Johnson';

-- show the start and end date of the last semester
select  start_date, end_date
  from  UniversityDB.Semesters
order by start_date desc
limit 1;

-- show contact info for student Michael Jordan
select  email, phone
  from  UniversityDB.Students
  where first_name = 'Michael'
    and last_name = 'Jordan';

-- Part 3 - classicmodels database (new numbers based on complexity)
-- start querying if you have time, first 5 questions use one table

-- 1. which vendor sells 1966 Shelby Cobra?
select  productVendor
  from  classicmodels.products
  where productName like '%1966 Shelby Cobra%';

-- 2. which product is the most and least expensive?
(select  'most expensive' as expensiveness, productName, buyPrice
  from  classicmodels.products
order by buyPrice desc
limit 1)
union all
(select  'least expensive', productName, buyPrice
  from  classicmodels.products
order by buyPrice
limit 1);

-- 3. which product has the most quantityInStock?
select productName
  from classicmodels.products
order by quantityInStock desc
limit 1;

-- 4. list all products that have quantity in stock less than 20
select  productName, quantityInStock
  from  classicmodels.products
  where quantityInStock < 20;

-- 5. which customer has the highest and lowest credit limit?
select  customerName, creditLimit
  from  classicmodels.customers
  where creditLimit = (select min(creditLimit) from classicmodels.customers)
    or  creditLimit = (select max(creditLimit) from classicmodels.customers)
order by creditLimit;
