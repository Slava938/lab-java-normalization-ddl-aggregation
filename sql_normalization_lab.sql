-- Ironhack LAB | SQL Normalization, DDL & Aggregation
-- Generated: 2025-10-05T15:43:49.533193Z
-- Target: MySQL 8.x

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS=0;

-- Create and use a dedicated database (optional)
DROP DATABASE IF EXISTS ironhack_lab;
CREATE DATABASE ironhack_lab CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE ironhack_lab;

-- =============================
-- Exercise 1: BLOG schema
-- =============================
DROP TABLE IF EXISTS posts;
DROP TABLE IF EXISTS authors;

CREATE TABLE authors (
  author_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE posts (
  post_id INT AUTO_INCREMENT PRIMARY KEY,
  author_id INT NOT NULL,
  title VARCHAR(255) NOT NULL,
  word_count INT CHECK (word_count >= 0),
  views INT CHECK (views >= 0),
  CONSTRAINT fk_posts_author FOREIGN KEY (author_id) REFERENCES authors(author_id)
) ENGINE=InnoDB;

-- Authors
INSERT INTO authors (author_id, name) VALUES (1, 'Gemma Alcocer');
INSERT INTO authors (author_id, name) VALUES (2, 'Juan Perez');
INSERT INTO authors (author_id, name) VALUES (3, 'Maria Charlotte');

-- Posts
INSERT INTO posts (author_id, title, word_count, views) VALUES (3, 'Best Paint Colors', 814, 14);
INSERT INTO posts (author_id, title, word_count, views) VALUES (2, 'Small Space Decorating Tips', 1146, 221);
INSERT INTO posts (author_id, title, word_count, views) VALUES (3, 'Hot Accessories', 986, 105);
INSERT INTO posts (author_id, title, word_count, views) VALUES (3, 'Mixing Textures', 765, 22);
INSERT INTO posts (author_id, title, word_count, views) VALUES (2, 'Kitchen Refresh', 1242, 307);
INSERT INTO posts (author_id, title, word_count, views) VALUES (3, 'Homemade Art Hacks', 1002, 193);
INSERT INTO posts (author_id, title, word_count, views) VALUES (1, 'Refinishing Wood Floors', 1571, 7542);

-- =============================
-- Exercise 2: AIRLINE schema
-- =============================
DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS flights;
DROP TABLE IF EXISTS aircrafts;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
  customer_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE,
  status ENUM('None','Silver','Gold') NOT NULL DEFAULT 'None',
  total_mileage INT NOT NULL CHECK (total_mileage >= 0)
) ENGINE=InnoDB;
CREATE TABLE aircrafts (
  aircraft_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE,
  total_seats INT NOT NULL CHECK (total_seats > 0)
) ENGINE=InnoDB;
CREATE TABLE flights (
  flight_number VARCHAR(10) PRIMARY KEY,
  aircraft_id INT NOT NULL,
  mileage INT NOT NULL CHECK (mileage >= 0),
  CONSTRAINT fk_flights_aircraft FOREIGN KEY (aircraft_id) REFERENCES aircrafts(aircraft_id)
) ENGINE=InnoDB;
CREATE TABLE bookings (
  booking_id INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT NOT NULL,
  flight_number VARCHAR(10) NOT NULL,
  booked_at TIMESTAMP NULL DEFAULT NULL,
  CONSTRAINT fk_bookings_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
  CONSTRAINT fk_bookings_flight FOREIGN KEY (flight_number) REFERENCES flights(flight_number)
) ENGINE=InnoDB;

-- Aircrafts
INSERT INTO aircrafts (aircraft_id, name, total_seats) VALUES (1, 'Airbus A330', 236);
INSERT INTO aircrafts (aircraft_id, name, total_seats) VALUES (2, 'Boeing 747', 400);
INSERT INTO aircrafts (aircraft_id, name, total_seats) VALUES (3, 'Boeing 777', 264);

-- Customers
INSERT INTO customers (customer_id, name, status, total_mileage) VALUES (1, 'Agustine Rivera', 'Silver', 115235);
INSERT INTO customers (customer_id, name, status, total_mileage) VALUES (2, 'Alaina Sepulvida', 'None', 6008);
INSERT INTO customers (customer_id, name, status, total_mileage) VALUES (3, 'Ana Janco', 'Silver', 136773);
INSERT INTO customers (customer_id, name, status, total_mileage) VALUES (4, 'Christian Janco', 'Silver', 14642);
INSERT INTO customers (customer_id, name, status, total_mileage) VALUES (5, 'Jennifer Cortez', 'Gold', 300582);
INSERT INTO customers (customer_id, name, status, total_mileage) VALUES (6, 'Jessica James', 'Silver', 127656);
INSERT INTO customers (customer_id, name, status, total_mileage) VALUES (7, 'Sam Rio', 'None', 2653);
INSERT INTO customers (customer_id, name, status, total_mileage) VALUES (8, 'Tom Jones', 'Gold', 205767);

-- Flights
INSERT INTO flights (flight_number, aircraft_id, mileage) VALUES ('DL122', 1, 4370);
INSERT INTO flights (flight_number, aircraft_id, mileage) VALUES ('DL143', 2, 135);
INSERT INTO flights (flight_number, aircraft_id, mileage) VALUES ('DL222', 3, 1765);
INSERT INTO flights (flight_number, aircraft_id, mileage) VALUES ('DL37', 2, 531);
INSERT INTO flights (flight_number, aircraft_id, mileage) VALUES ('DL53', 3, 2078);

-- Bookings (one per visible row)
INSERT INTO bookings (customer_id, flight_number) VALUES (1, 'DL143');
INSERT INTO bookings (customer_id, flight_number) VALUES (1, 'DL122');
INSERT INTO bookings (customer_id, flight_number) VALUES (2, 'DL122');
INSERT INTO bookings (customer_id, flight_number) VALUES (1, 'DL143');
INSERT INTO bookings (customer_id, flight_number) VALUES (8, 'DL122');
INSERT INTO bookings (customer_id, flight_number) VALUES (8, 'DL53');
INSERT INTO bookings (customer_id, flight_number) VALUES (1, 'DL143');
INSERT INTO bookings (customer_id, flight_number) VALUES (7, 'DL143');
INSERT INTO bookings (customer_id, flight_number) VALUES (1, 'DL143');
INSERT INTO bookings (customer_id, flight_number) VALUES (8, 'DL222');
INSERT INTO bookings (customer_id, flight_number) VALUES (6, 'DL143');
INSERT INTO bookings (customer_id, flight_number) VALUES (7, 'DL143');
INSERT INTO bookings (customer_id, flight_number) VALUES (3, 'DL222');
INSERT INTO bookings (customer_id, flight_number) VALUES (5, 'DL222');
INSERT INTO bookings (customer_id, flight_number) VALUES (6, 'DL122');
INSERT INTO bookings (customer_id, flight_number) VALUES (7, 'DL37');
INSERT INTO bookings (customer_id, flight_number) VALUES (4, 'DL222');

-- Helpful indexes
CREATE INDEX idx_customers_status ON customers(status);
CREATE INDEX idx_flights_mileage ON flights(mileage);
CREATE INDEX idx_aircrafts_name ON aircrafts(name);
CREATE INDEX idx_bookings_customer ON bookings(customer_id);
CREATE INDEX idx_bookings_flight ON bookings(flight_number);

-- =============================
-- Exercise 3: Queries
-- =============================
-- 1) Total number of flights
SELECT COUNT(DISTINCT flight_number) AS total_flights FROM flights;

-- 2) Average flight distance
SELECT AVG(mileage) AS avg_distance FROM flights;

-- 3) Average number of seats per aircraft
SELECT AVG(total_seats) AS avg_seats FROM aircrafts;

-- 4) Average miles flown by customers, grouped by status
SELECT status, AVG(total_mileage) AS avg_miles FROM customers GROUP BY status;

-- 5) Max miles flown by customers, grouped by status
SELECT status, MAX(total_mileage) AS max_miles FROM customers GROUP BY status;

-- 6) Number of aircrafts with 'Boeing' in their name
SELECT COUNT(*) AS boeing_aircrafts FROM aircrafts WHERE name LIKE '%Boeing%';

-- 7) Flights with distance between 300 and 2000 miles
SELECT * FROM flights WHERE mileage BETWEEN 300 AND 2000;

-- 8) Average flight distance booked, grouped by customer status
SELECT c.status, AVG(f.mileage) AS avg_booked_distance
FROM bookings b
JOIN customers c ON b.customer_id = c.customer_id
JOIN flights f ON b.flight_number = f.flight_number
GROUP BY c.status;

-- 9) Most booked aircraft among Gold status members
SELECT a.name, COUNT(*) AS total_bookings
FROM bookings b
JOIN customers c ON b.customer_id = c.customer_id
JOIN flights f ON b.flight_number = f.flight_number
JOIN aircrafts a ON f.aircraft_id = a.aircraft_id
WHERE c.status = 'Gold'
GROUP BY a.name
ORDER BY total_bookings DESC
LIMIT 1;

SET FOREIGN_KEY_CHECKS=1;