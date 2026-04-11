/* Hotel Management SQL Database
1. Create the Database */
-- You can skip this step if you already have a database created.
-- select * from HotelDB.guests; -- 4
-- select * from HotelDB.hotels; -- 3
-- select * from HotelDB.housekeeping; -- 4
-- select * from HotelDB.payments; -- 3
-- select * from HotelDB.reservations; -- 5
-- select * from HotelDB.rooms; -- 6
-- select * from HotelDB.services; -- 4
-- select * from HotelDB.servicetransactions; -- 4
-- select * from HotelDB.staff; -- 6

DROP DATABASE IF EXISTS HotelDB;
CREATE DATABASE HotelDB;
USE HotelDB;
/* 2. Create Tables
We will create 9 tables in a logical order to satisfy the foreign key constraints. */

/* 2.1 Hotels
Stores basic information about different hotel locations (if the company manages more than one).*/

CREATE TABLE IF NOT EXISTS Hotels (
    hotel_id     INT AUTO_INCREMENT PRIMARY KEY,
    hotel_name   VARCHAR(100) NOT NULL,
    city         VARCHAR(100),
    country      VARCHAR(100),
    phone        VARCHAR(20),
    rating       DECIMAL(2,1)  -- e.g. 4.5 for a 4.5-star rating
);
/* 2.2 Staff
Information about staff who work at a specific hotel.*/

CREATE TABLE IF NOT EXISTS Staff (
    staff_id     INT AUTO_INCREMENT PRIMARY KEY,
    hotel_id     INT NOT NULL,
    first_name   VARCHAR(50) NOT NULL,
    last_name    VARCHAR(50) NOT NULL,
    position     VARCHAR(50),        -- e.g., Manager, Receptionist, Housekeeper
    phone        VARCHAR(20),
    email        VARCHAR(100),
    CONSTRAINT fk_staff_hotel
        FOREIGN KEY (hotel_id) REFERENCES Hotels(hotel_id)
);
/* 2.3 Guests
Information about guests/customers who may stay in any hotel. */

CREATE TABLE IF NOT EXISTS Guests (
    guest_id   INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name  VARCHAR(50) NOT NULL,
    phone      VARCHAR(20),
    email      VARCHAR(100),
    address    VARCHAR(200),
    city       VARCHAR(100),
    country    VARCHAR(100)
);
/* 2.4 Rooms
Information about each room at a particular hotel (room type, capacity, price per night, etc.).*/

CREATE TABLE IF NOT EXISTS Rooms (
    room_id          INT AUTO_INCREMENT PRIMARY KEY,
    hotel_id         INT NOT NULL,
    room_number      VARCHAR(10) NOT NULL,    -- e.g., "101", "A12"
    room_type        VARCHAR(50),             -- e.g., "Single", "Double", "Suite"
    price_per_night  DECIMAL(10,2),
    capacity         INT,                     -- how many guests can stay
    status           VARCHAR(50),             -- e.g., "Available", "Occupied", "Out-of-Service"
    CONSTRAINT fk_rooms_hotel
        FOREIGN KEY (hotel_id) REFERENCES Hotels(hotel_id)
);
/* 2.5 Reservations
When a guest reserves a specific room for a date range, we store that in this table.*/

CREATE TABLE IF NOT EXISTS Reservations (
    reservation_id   INT AUTO_INCREMENT PRIMARY KEY,
    guest_id         INT NOT NULL,
    room_id          INT NOT NULL,
    check_in_date    DATE NOT NULL,
    check_out_date   DATE NOT NULL,
    total_amount     DECIMAL(10,2),
    reservation_status VARCHAR(50) DEFAULT 'Confirmed',  -- e.g. "Confirmed", "Cancelled", "Checked-In", "Checked-Out"
    CONSTRAINT fk_reservations_guest
        FOREIGN KEY (guest_id) REFERENCES Guests(guest_id),
    CONSTRAINT fk_reservations_room
        FOREIGN KEY (room_id) REFERENCES Rooms(room_id)
);
/* 2.6 Services
Hotel services that can be offered to guests, such as spa treatments, laundry, etc.*/

CREATE TABLE IF NOT EXISTS Services (
    service_id   INT AUTO_INCREMENT PRIMARY KEY,
    hotel_id     INT NOT NULL,
    service_name VARCHAR(100) NOT NULL,
    price        DECIMAL(10,2),
    description  VARCHAR(200),
    CONSTRAINT fk_services_hotel
        FOREIGN KEY (hotel_id) REFERENCES Hotels(hotel_id)
);
/* 2.7 ServiceTransactions
When a guest (via a reservation) uses a particular service, we log that here (like an itemized bill).*/

CREATE TABLE IF NOT EXISTS ServiceTransactions (
    service_transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    service_id             INT NOT NULL,
    reservation_id         INT NOT NULL,
    quantity               INT DEFAULT 1,
    total_price            DECIMAL(10,2),
    CONSTRAINT fk_st_service
        FOREIGN KEY (service_id) REFERENCES Services(service_id),
    CONSTRAINT fk_st_reservation
        FOREIGN KEY (reservation_id) REFERENCES Reservations(reservation_id)
);
/* 2.8 Housekeeping
Tracks housekeeping tasks performed on rooms. Often assigned to a staff member (housekeeper) for a particular room.*/

CREATE TABLE IF NOT EXISTS Housekeeping (
    housekeeping_id INT AUTO_INCREMENT PRIMARY KEY,
    room_id         INT NOT NULL,
    staff_id        INT NOT NULL,
    cleaning_date   DATE NOT NULL,
    remarks         VARCHAR(200),
    CONSTRAINT fk_housekeeping_room
        FOREIGN KEY (room_id) REFERENCES Rooms(room_id),
    CONSTRAINT fk_housekeeping_staff
        FOREIGN KEY (staff_id) REFERENCES Staff(staff_id)
);
/* 2.9 Payments
Stores payment information for reservations (e.g., partial deposit, full payment at checkout).*/

CREATE TABLE IF NOT EXISTS Payments (
    payment_id      INT AUTO_INCREMENT PRIMARY KEY,
    reservation_id  INT NOT NULL,
    payment_date    DATE NOT NULL,
    payment_method  VARCHAR(50),           -- e.g. "Credit Card", "Cash", "Online"
    amount_paid     DECIMAL(10,2),
    CONSTRAINT fk_payments_reservations
        FOREIGN KEY (reservation_id) REFERENCES Reservations(reservation_id)
);
/* 3. Insert Sample Data
Below are some sample records to populate the tables and demonstrate the relationships.*/
/*3.1 Hotels */

INSERT INTO Hotels (hotel_name, city, country, phone, rating)
VALUES
    ('Grand Plaza',    'New York',   'USA', '+1-202-555-1111', 4.5),
    ('Sunny Beach',    'Miami',      'USA', '+1-202-555-2222', 4.0),
    ('Mountain Retreat','Denver',    'USA', '+1-202-555-3333', 4.2);
/* 3.2 Staff*/

INSERT INTO Staff (hotel_id, first_name, last_name, position, phone, email)
VALUES
    (1, 'Alice',  'Johnson', 'Manager',         '+1-202-555-1001', 'alice.johnson@grandplaza.com'),
    (1, 'Bob',    'Miller',  'Receptionist',    '+1-202-555-1002', 'bob.miller@grandplaza.com'),
    (1, 'Carol',  'Smith',   'Housekeeper',     '+1-202-555-1003', 'carol.smith@grandplaza.com'),
    (2, 'David',  'Wong',    'Manager',         '+1-202-555-2001', 'david.wong@sunnybeach.com'),
    (2, 'Eve',    'Evans',   'Receptionist',    '+1-202-555-2002', 'eve.evans@sunnybeach.com'),
    (3, 'Frank',  'Taylor',  'Housekeeping',    '+1-202-555-3001', 'frank.taylor@mountainretreat.com');
/* 3.3 Guests */

INSERT INTO Guests (first_name, last_name, phone, email, address, city, country)
VALUES
    ('Michael', 'Jordan', '+1-202-555-4001', 'mjordan@example.com', '101 Main St', 'Chicago', 'USA'),
    ('Sara',    'Connor', '+1-202-555-4002', 'sconnor@example.com', '202 Lakeside Dr', 'Orlando', 'USA'),
    ('Tony',    'Stark',  '+1-202-555-4003', 'tstark@example.com',  '303 Avengers Blvd', 'New York', 'USA'),
    ('Bruce',   'Wayne',  '+1-202-555-4004', 'bwayne@example.com',  'Wayne Manor', 'Gotham', 'USA');
/* 3.4 Rooms */

INSERT INTO Rooms (hotel_id, room_number, room_type, price_per_night, capacity, status)
VALUES
    (1, '101', 'Single', 150.00, 1, 'Available'),
    (1, '102', 'Double', 200.00, 2, 'Available'),
    (1, '201', 'Suite',  350.00, 4, 'Available'),
    (2, '301', 'Single', 120.00, 1, 'Available'),
    (2, '302', 'Double', 180.00, 2, 'Occupied'),
    (3, '401', 'Suite',  250.00, 4, 'Available');
/* 3.5 Reservations */

INSERT INTO Reservations (guest_id, room_id, check_in_date, check_out_date, total_amount, reservation_status)
VALUES
    -- Grand Plaza (hotel_id=1, room_id=1/2/3)
    (1, 1, '2024-01-05', '2024-01-10', 750.00, 'Confirmed'),   -- Michael Jordan in Room 101
    (2, 2, '2024-01-06', '2024-01-08', 400.00, 'Checked-In'),  -- Sara Connor in Room 102
    
    -- Sunny Beach (hotel_id=2, room_id=4/5)
    (3, 4, '2024-02-01', '2024-02-05', 480.00, 'Confirmed'),   -- Tony Stark in Room 301
    (4, 5, '2024-02-10', '2024-02-13', 540.00, 'Checked-In'),  -- Bruce Wayne in Room 302
    
    -- Mountain Retreat (hotel_id=3, room_id=6)
    (1, 6, '2024-03-01', '2024-03-05', 1000.00, 'Confirmed');  -- Michael Jordan in Room 401 (Suite)
/* 3.6 Services */

INSERT INTO Services (hotel_id, service_name, price, description)
VALUES
    (1, 'Laundry Service', 20.00, 'Per bag laundry service'),
    (1, 'Spa Treatment',   100.00,'Relaxing spa package'),
    (2, 'Gym Access',      15.00, 'Daily gym pass'),
    (3, 'Ski Rental',      80.00, 'Daily ski equipment rental');
/* 3.7 ServiceTransactions */

-- Track which reservations used specific services.
INSERT INTO ServiceTransactions (service_id, reservation_id, quantity, total_price)
VALUES
    (1, 1, 1, 20.00),    -- Laundry for reservation_id=1 (Michael Jordan, Room 101)
    (2, 1, 1, 100.00),   -- Spa for reservation_id=1
    (1, 2, 2, 40.00),    -- Laundry for Sara Connor, 2 bags
    (4, 5, 1, 80.00);    -- Michael Jordan used Ski Rental at Mountain Retreat (reservation_id=5)

/* 3.8 Housekeeping */
-- Logging cleaning tasks
INSERT INTO Housekeeping (room_id, staff_id, cleaning_date, remarks)
VALUES
    (1, 3, '2024-01-06', 'Daily cleaning for single room 101'),
    (2, 3, '2024-01-07', 'Requested extra towels in room 102'),
    (5, 6, '2024-02-11', 'Cleaning while guest is checked-in'),
    (6, 6, '2024-03-02', 'Suite cleaning, restock minibar');

/* 3.9 Payments */
INSERT INTO Payments (reservation_id, payment_date, payment_method, amount_paid)
VALUES
    (1, '2024-01-05', 'Credit Card', 750.00),  -- Payment for Michael Jordan's stay at Grand Plaza, Room 101
    (2, '2024-01-06', 'Credit Card', 200.00),  -- Partial payment from Sara Connor, remainder at check-out
    (5, '2024-03-01', 'Debit Card', 500.00);   -- Partial payment for Michael Jordan at Mountain Retreat


