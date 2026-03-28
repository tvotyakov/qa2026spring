/* Below is a Tesla-inspired SQL relational database schema. 
This schema models a simplified view of how Tesla might manage information about factories, 
employees, vehicle models, vehicles, customers, orders, shipments, service centers, and service appointments. 
Of course, in reality, Tesla’s databases are far more complex. But this example gives you a foundational 
structure that “most likely exists” in some form within Tesla’s environment.
Feel free to modify table names, columns, data types, and sample records as needed for your training
or demonstration purposes.

In reality, Tesla’s databases would include far more detail (e.g., battery pack IDs, supply chain data, 
autopilot hardware versions, software updates, supercharger usage, etc.).
This example schema can be expanded or adapted to cover additional 
Tesla-specific scenarios such as charging stations, supply chain management, warranty claims, 
over-the-air software updates, and more.
 */

/*
SELECT table_name, table_rows  
FROM INFORMATION_SCHEMA.tables
WHERE TABLE_SCHEMA = 'TeslaDB'; 

select * from TeslaDB.customers;	-- 4
select * from TeslaDB.employees;	-- 5
select * from TeslaDB.factories;	-- 4
select * from TeslaDB.orders;	-- 4
select * from TeslaDB.serviceappointments;	-- 2
select * from TeslaDB.servicecenters;	-- 3
select * from TeslaDB.shipments;	-- 2
select * from TeslaDB.vehiclemodels;	-- 4
select * from TeslaDB.vehicles;	-- 4
*/

/* 1. Create the Database */
-- You can skip this step if you already have a database created.
DROP DATABASE IF EXISTS TeslaDB;
CREATE DATABASE TeslaDB;
USE TeslaDB;
/* 2. Create Tables
We will create 9 tables in a logical order to satisfy the foreign key constraints.

 2.1 Factories
Represents the Tesla manufacturing factories/assembly plants (e.g., Fremont, Giga Berlin, Giga Shanghai, etc.).*/
CREATE TABLE IF NOT EXISTS Factories (
    factory_id   INT AUTO_INCREMENT PRIMARY KEY,
    factory_name VARCHAR(100) NOT NULL,
    location     VARCHAR(100),
    phone        VARCHAR(20)
);
/* 2.2 Employees
Stores information about employees, including which factory they work at.*/
CREATE TABLE IF NOT EXISTS Employees (
    employee_id  INT AUTO_INCREMENT PRIMARY KEY,
    factory_id   INT NOT NULL,
    first_name   VARCHAR(50) NOT NULL,
    last_name    VARCHAR(50) NOT NULL,
    position     VARCHAR(50),        -- e.g. 'Production Associate', 'Engineer', 'Manager'
    email        VARCHAR(100),
    CONSTRAINT fk_employees_factory
        FOREIGN KEY (factory_id) REFERENCES Factories(factory_id)
);
/* 2.3 VehicleModels
General information about Tesla vehicle models (e.g., Model S, Model 3, Model X, Model Y, Cybertruck, etc.).*/
CREATE TABLE IF NOT EXISTS VehicleModels (
    model_id                INT AUTO_INCREMENT PRIMARY KEY,
    model_name              VARCHAR(50) NOT NULL,  -- e.g., 'Model 3'
    base_price              DECIMAL(12,2),
    battery_capacity_kWh    INT,                   -- e.g., 75 kWh
    production_start_year   INT,
    production_end_year     INT  -- NULL if still in production
);
/* 2.4 Vehicles
Individual vehicles that have been produced. Each vehicle references a model.
VIN (Vehicle Identification Number) is typically unique, so we’ll store it here.*/

CREATE TABLE IF NOT EXISTS Vehicles (
    vehicle_id     INT AUTO_INCREMENT PRIMARY KEY,
    model_id       INT NOT NULL,
    vin            VARCHAR(50) NOT NULL UNIQUE,
    production_date DATE,
    color          VARCHAR(50),
    status         VARCHAR(50),    -- e.g., 'In Production', 'Completed', 'Delivered'
    CONSTRAINT fk_vehicles_model
        FOREIGN KEY (model_id) REFERENCES VehicleModels(model_id)
);
/* 2.5 Customers
Information about customers who purchase Tesla vehicles.*/

CREATE TABLE IF NOT EXISTS Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name  VARCHAR(50) NOT NULL,
    last_name   VARCHAR(50) NOT NULL,
    email       VARCHAR(100),
    phone       VARCHAR(20),
    address     VARCHAR(200)
);
/* 2.6 Orders
When a customer orders a particular Tesla model, it’s stored here (along with total price and status).
In many real-world systems, once a VIN is assigned (when production is complete or allocated), it might reference the Vehicles table. For simplicity here, we’ll just track model-level orders.
*/
CREATE TABLE IF NOT EXISTS Orders (
    order_id    INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    model_id    INT NOT NULL,
    order_date  DATE NOT NULL,
    total_price DECIMAL(12,2),
    status      VARCHAR(50),   -- e.g., 'Confirmed', 'In Production', 'Shipped', 'Delivered', 'Cancelled'
    CONSTRAINT fk_orders_customer
        FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    CONSTRAINT fk_orders_model
        FOREIGN KEY (model_id) REFERENCES VehicleModels(model_id)
);
/* .7 Shipments
Shipment records for completed vehicles (or batches) from a factory to the final delivery location/customer.
In a real system, Tesla would likely have more elaborate logistics and distribution centers. Here, we simplify it to store shipping info tied to an order.
*/
CREATE TABLE IF NOT EXISTS Shipments (
    shipment_id     INT AUTO_INCREMENT PRIMARY KEY,
    order_id        INT NOT NULL,
    factory_id      INT NOT NULL,
    shipping_date   DATE,
    arrival_date    DATE,
    shipping_status VARCHAR(50),  -- e.g. 'In Transit', 'Delivered', 'Delayed'
    CONSTRAINT fk_shipments_order
        FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    CONSTRAINT fk_shipments_factory
        FOREIGN KEY (factory_id) REFERENCES Factories(factory_id)
);
/* 2.8 ServiceCenters
Tesla service centers where customers can bring their vehicles for maintenance or repairs.
*/
CREATE TABLE IF NOT EXISTS ServiceCenters (
    center_id   INT AUTO_INCREMENT PRIMARY KEY,
    center_name VARCHAR(100) NOT NULL,
    location    VARCHAR(100),
    phone       VARCHAR(20)
);
/* 2.9 ServiceAppointments
When a Tesla vehicle needs service, it’s scheduled at a service center.
References the Vehicles table (by vehicle_id) and the ServiceCenters table (by center_id).
*/
CREATE TABLE IF NOT EXISTS ServiceAppointments (
    appointment_id   INT AUTO_INCREMENT PRIMARY KEY,
    vehicle_id       INT NOT NULL,
    center_id        INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    service_needed   VARCHAR(200),  -- e.g., 'Annual Maintenance', 'Battery Check', 'Software Update'
    appointment_status VARCHAR(50), -- e.g. 'Scheduled', 'Completed', 'Cancelled'
    CONSTRAINT fk_appointments_vehicle
        FOREIGN KEY (vehicle_id) REFERENCES Vehicles(vehicle_id),
    CONSTRAINT fk_appointments_center
        FOREIGN KEY (center_id) REFERENCES ServiceCenters(center_id)
);
/* 3. Insert Sample Data
Below are some sample records to populate the tables and demonstrate the relationships.*/

-- 3.1 Factories
INSERT INTO Factories (factory_name, location, phone)
VALUES
    ('Fremont Factory',    'Fremont, CA, USA',    '+1-202-555-1111'),
    ('Giga Shanghai',      'Shanghai, China',     '+86-21-5555-1111'),
    ('Giga Berlin',        'Berlin, Germany',     '+49-30-5555-1111'),
    ('Giga Texas',         'Austin, TX, USA',     '+1-512-555-2222');

-- 3.2 Employees
INSERT INTO Employees (factory_id, first_name, last_name, position, email)
VALUES
    (1, 'Alice',  'Johnson', 'Production Associate', 'alice.johnson@tesla.com'),
    (1, 'Bob',    'Smith',   'Engineer',             'bob.smith@tesla.com'),
    (2, 'Cindy',  'Wong',    'Manager',              'cindy.wong@tesla.com'),
    (3, 'David',  'Taylor',  'Engineer',             'david.taylor@tesla.com'),
    (4, 'Eve',    'Miller',  'Production Associate', 'eve.miller@tesla.com');

-- 3.3 VehicleModels
INSERT INTO VehicleModels (model_name, base_price, battery_capacity_kWh, production_start_year, production_end_year)
VALUES
    ('Model 3',  39999.00, 50,  2017, NULL),
    ('Model S',  89999.00, 100, 2012, NULL),
    ('Model X',  99999.00, 100, 2015, NULL),
    ('Model Y',  49999.00, 75,  2020, NULL);

-- 3.4 Vehicles
INSERT INTO Vehicles (model_id, vin, production_date, color, status)
VALUES
    (1, '5YJ3E1EA7KF317000', '2024-01-15', 'Pearl White', 'In Production'),
    (1, '5YJ3E1EA7KF317001', '2024-01-16', 'Solid Black', 'Completed'),
    (2, '5YJSA1E16JF250000', '2024-01-20', 'Midnight Silver', 'In Production'),
    (4, '7SAYGDEE0NF450123', '2024-01-25', 'Red Multi-Coat', 'In Production');

-- 3.5 Customers
INSERT INTO Customers (first_name, last_name, email, phone, address)
VALUES
    ('Michael', 'Jordan', 'mjordan@example.com', '+1-202-555-4001', '101 Main St, Chicago, IL, USA'),
    ('Sara',    'Connor', 'sconnor@example.com', '+1-202-555-4002', '202 Lakeside Dr, Orlando, FL, USA'),
    ('Tony',    'Stark',  'tstark@example.com',  '+1-202-555-4003', '10880 Malibu Point, Malibu, CA, USA'),
    ('Bruce',   'Wayne',  'bwayne@example.com',  '+1-202-555-4004', '1007 Mountain Dr, Gotham');

-- 3.6 Orders
INSERT INTO Orders (customer_id, model_id, order_date, total_price, status)
VALUES
    (1, 1, '2024-01-18', 39999.00, 'In Production'),  -- Michael Jordan orders a Model 3
    (2, 4, '2024-01-20', 49999.00, 'Confirmed'),      -- Sara Connor orders a Model Y
    (3, 2, '2024-01-22', 89999.00, 'In Production'),  -- Tony Stark orders a Model S
    (4, 3, '2024-01-25', 99999.00, 'Confirmed');      -- Bruce Wayne orders a Model X

-- 3.7 Shipments
INSERT INTO Shipments (order_id, factory_id, shipping_date, arrival_date, shipping_status)
VALUES
    (1, 1, '2024-01-25', NULL, 'In Transit'),  -- Order #1 shipped from Fremont
    (2, 4, '2024-01-30', NULL, 'In Transit');  -- Order #2 shipped from Giga Texas

-- 3.8 ServiceCenters
INSERT INTO ServiceCenters (center_name, location, phone)
VALUES
    ('Tesla Service - Chicago', 'Chicago, IL, USA', '+1-312-555-5000'),
    ('Tesla Service - Berlin',  'Berlin, Germany',  '+49-30-5555-5000'),
    ('Tesla Service - Shanghai','Shanghai, China',  '+86-21-5555-5000');

-- 3.9 ServiceAppointments
INSERT INTO ServiceAppointments (vehicle_id, center_id, appointment_date, service_needed, appointment_status)
VALUES
    (2, 1, '2024-02-15 10:00:00', 'Software Update', 'Scheduled'),      -- VIN '5YJ3E1EA7KF317001' at Chicago center
    (1, 1, '2024-02-20 09:00:00', 'Annual Maintenance', 'Scheduled');   -- VIN '5YJ3E1EA7KF317000' at Chicago center

