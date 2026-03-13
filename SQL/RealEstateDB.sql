-- RealEstateDB
/* 
select * from realestatedb.agents; -- 4
select * from realestatedb.clients; -- 5
select * from realestatedb.listings; -- 4
select * from realestatedb.offers; -- 5
select * from realestatedb.offices; -- 3
select * from realestatedb.properties; -- 5
select * from realestatedb.propertytypes; -- 4
select * from realestatedb.showings; -- 6
select * from realestatedb.transactions; -- 1
*/
/*1. Create the Database
You can skip this step if you already have a database created. */
DROP DATABASE IF EXISTS RealEstateDB;
CREATE DATABASE RealEstateDB;
USE RealEstateDB;
/*2. Create Tables
Below are the 9 tables in a logical order to satisfy the foreign key constraints.
2.1 Offices
Stores information about the real estate offices of the agency.*/

CREATE TABLE IF NOT EXISTS Offices (
    office_id INT AUTO_INCREMENT PRIMARY KEY,
    office_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    address VARCHAR(200),
    city VARCHAR(100),
    state VARCHAR(50),
    zip_code VARCHAR(20)
);
/*2.2 Agents
Stores information about the agents who work at a particular office.
Agents reference an office_id from the Offices table.*/
CREATE TABLE IF NOT EXISTS Agents (
    agent_id INT AUTO_INCREMENT PRIMARY KEY,
    office_id INT NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(20),
    license_number VARCHAR(50),
    CONSTRAINT fk_agents_offices
        FOREIGN KEY (office_id) REFERENCES Offices(office_id)
);
/*2.3 Clients
Stores information about clients (both buyers and sellers).*/
CREATE TABLE IF NOT EXISTS Clients (
    client_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(20),
    client_type VARCHAR(20)  -- e.g., 'Buyer', 'Seller', etc.
);
/*2.4 PropertyTypes
Stores different types of properties (e.g., Single Family, Condo, etc.).*/
CREATE TABLE IF NOT EXISTS PropertyTypes (
    type_id INT AUTO_INCREMENT PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL
);
/*2.5 Properties
Stores information about properties (address, square feet, etc.).
References type_id from the PropertyTypes table.*/
CREATE TABLE IF NOT EXISTS Properties (
    property_id INT AUTO_INCREMENT PRIMARY KEY,
    type_id INT NOT NULL,
    address VARCHAR(200) NOT NULL,
    city VARCHAR(100),
    state VARCHAR(50),
    zip_code VARCHAR(20),
    square_feet INT,
    bedrooms INT,
    bathrooms DECIMAL(3,1),  -- e.g. 3.5 bathrooms
    year_built INT,
    CONSTRAINT fk_properties_propertytypes
        FOREIGN KEY (type_id) REFERENCES PropertyTypes(type_id)
);
/*2.6 Listings
A listing represents a property that is listed by a particular agent.
References property_id from Properties and agent_id from Agents.*/

CREATE TABLE IF NOT EXISTS Listings (
    listing_id INT AUTO_INCREMENT PRIMARY KEY,
    property_id INT NOT NULL,
    agent_id INT NOT NULL,
    listing_price DECIMAL(12,2),
    listing_date DATE,
    status VARCHAR(50),      -- e.g. 'Active', 'Pending', 'Sold'
    CONSTRAINT fk_listings_properties
        FOREIGN KEY (property_id) REFERENCES Properties(property_id),
    CONSTRAINT fk_listings_agents
        FOREIGN KEY (agent_id) REFERENCES Agents(agent_id)
);
/*2.7 Showings
A showing is a scheduled visit to a specific listing by a client.
References listing_id from Listings and client_id from Clients.*/

CREATE TABLE IF NOT EXISTS Showings (
    showing_id INT AUTO_INCREMENT PRIMARY KEY,
    listing_id INT NOT NULL,
    client_id INT NOT NULL,
    showing_date DATETIME NOT NULL,
    notes TEXT,
    CONSTRAINT fk_showings_listings
        FOREIGN KEY (listing_id) REFERENCES Listings(listing_id),
    CONSTRAINT fk_showings_clients
        FOREIGN KEY (client_id) REFERENCES Clients(client_id)
);
/*2.8 Offers
When a client makes an offer on a listing, it is recorded here.
References listing_id from Listings and client_id from Clients.*/
CREATE TABLE IF NOT EXISTS Offers (
    offer_id INT AUTO_INCREMENT PRIMARY KEY,
    listing_id INT NOT NULL,
    client_id INT NOT NULL,
    offer_price DECIMAL(12,2),
    offer_date DATE,
    offer_status VARCHAR(50),  -- e.g. 'Submitted', 'Accepted', 'Rejected'
    CONSTRAINT fk_offers_listings
        FOREIGN KEY (listing_id) REFERENCES Listings(listing_id),
    CONSTRAINT fk_offers_clients
        FOREIGN KEY (client_id) REFERENCES Clients(client_id)
);
/*2.9 Transactions
When an offer is accepted and the deal closes, it becomes a transaction.
References offer_id from Offers, and references listing_id again for clarity.*/
CREATE TABLE IF NOT EXISTS Transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    offer_id INT NOT NULL,
    listing_id INT NOT NULL,
    closing_date DATE,
    final_sale_price DECIMAL(12,2),
    CONSTRAINT fk_transactions_offers
        FOREIGN KEY (offer_id) REFERENCES Offers(offer_id),
    CONSTRAINT fk_transactions_listings
        FOREIGN KEY (listing_id) REFERENCES Listings(listing_id)
);
/*3. Insert Sample Data
Below are some sample records to populate the tables and demonstrate the relationships.
3.1 Offices */
INSERT INTO Offices (office_name, phone, address, city, state, zip_code)
VALUES
    ('Downtown Realty',  '+1-202-555-1000', '123 Main St', 'New York', 'NY', '10001'),
    ('Coastal Homes',    '+1-202-555-2000', '456 Ocean Ave', 'Miami', 'FL', '33101'),
    ('Mountain Villas',  '+1-202-555-3000', '789 Pine Rd', 'Denver', 'CO', '80202');
/*3.2 Agents*/
INSERT INTO Agents (office_id, first_name, last_name, email, phone, license_number)
VALUES
    (1, 'Alice',   'Johnson', 'alice.johnson@realestate.com', '+1-202-555-0101', 'NY12345'),
    (1, 'Bob',     'Miller',  'bob.miller@realestate.com',    '+1-202-555-0102', 'NY67890'),
    (2, 'Carla',   'Smith',   'carla.smith@realestate.com',   '+1-202-555-0201', 'FL12345'),
    (3, 'David',   'Wong',    'david.wong@realestate.com',    '+1-202-555-0301', 'CO12345');
/*3.3 Clients*/
INSERT INTO Clients (first_name, last_name, email, phone, client_type)
VALUES
    ('Michael', 'Jordan', 'mjordan@example.com', '+1-202-555-1111', 'Buyer'),
    ('Sara',    'Connor', 'sconnor@example.com', '+1-202-555-2222', 'Seller'),
    ('Tony',    'Stark',  'tstark@example.com',  '+1-202-555-3333', 'Buyer'),
    ('Bruce',   'Wayne',  'bwayne@example.com',  '+1-202-555-4444', 'Seller'),
    ('Diana',   'Prince', 'dprince@example.com', '+1-202-555-5555', 'Buyer');
/*3.4 PropertyTypes*/
INSERT INTO PropertyTypes (type_name)
VALUES
    ('Single Family'),
    ('Condo'),
    ('Townhouse'),
    ('Multi-Family');
/*3.5 Properties*/
INSERT INTO Properties (type_id, address, city, state, zip_code, square_feet, bedrooms, bathrooms, year_built)
VALUES
    (1, '101 Apple St',       'New York', 'NY', '10011', 2000, 3, 2.5,  1999),  -- Single Family
    (2, '202 Orange Ave #3A', 'Miami',    'FL', '33131', 1200, 2, 2.0,  2010),  -- Condo
    (3, '303 Pine Ct',        'Denver',   'CO', '80203', 1800, 3, 2.0,  2005),  -- Townhouse
    (1, '404 Peach Dr',       'Miami',    'FL', '33133', 2500, 4, 3.0,  2015),  -- Single Family
    (2, '505 Banana Blvd #12','New York', 'NY', '10012',  900, 1, 1.0,  2008);  -- Condo
/*3.6 Listings*/
INSERT INTO Listings (property_id, agent_id, listing_price, listing_date, status)
VALUES
    -- Alice (agent_id=1) in New York office
    (1, 1,  750000.00, '2024-01-05', 'Active'),   -- 101 Apple St (Single Family)
    (5, 1,  450000.00, '2024-01-10', 'Active'),   -- 505 Banana Blvd #12 (Condo)
    -- Carla (agent_id=3) in Miami office
    (2, 3,  350000.00, '2024-01-07', 'Active'),   -- 202 Orange Ave #3A (Condo)
    (4, 3,  950000.00, '2024-01-12', 'Active'),   -- 404 Peach Dr (Single Family)
    -- David (agent_id=4) in Denver office
    (3, 4,  500000.00, '2024-01-15', 'Active');   -- 303 Pine Ct (Townhouse)
/*3.7 Showings*/
INSERT INTO Showings (listing_id, client_id, showing_date, notes)
VALUES
    (1, 1, '2024-01-08 10:00:00', 'Client loved the backyard.'),
    (1, 3, '2024-01-09 14:00:00', 'Client asked about roof condition.'),
    (2, 5, '2024-01-11 09:30:00', 'Client wants to be near downtown.'),
    (3, 1, '2024-01-16 13:00:00', 'Client worried about HOA fees.'),
    (4, 2, '2024-01-20 16:00:00', 'Seller also looking to buy another property.'),
    (5, 5, '2024-01-25 12:00:00', 'Client liked the neighborhood.');
/*3.8 Offers*/
INSERT INTO Offers (listing_id, client_id, offer_price, offer_date, offer_status)
VALUES
    -- Michael Jordan (client_id=1) offers on listing_id=1
    (1, 1, 720000.00, '2024-01-10', 'Submitted'),
    -- Tony Stark (client_id=3) offers on listing_id=1 as well
    (1, 3, 710000.00, '2024-01-11', 'Rejected'),
    -- Diana Prince (client_id=5) offers on listing_id=2
    (2, 5, 340000.00, '2024-01-12', 'Accepted'),
    -- Michael Jordan (client_id=1) offers on listing_id=3
    (3, 1, 480000.00, '2024-01-20', 'Submitted'),
    -- Sara Connor (client_id=2) is a Seller, but let's assume she invests too:
    (4, 2, 900000.00, '2024-01-25', 'Submitted');
/*3.9 Transactions
Once an offer is accepted and finalized (closed), it becomes a transaction.*/
-- Based on the sample above, the only 'Accepted' offer is listing_id=2 (Diana Prince, client_id=5)
-- Let’s say it closed:
INSERT INTO Transactions (offer_id, listing_id, closing_date, final_sale_price)
VALUES
    (3, 2, '2024-02-01', 340000.00);
    
    
    
