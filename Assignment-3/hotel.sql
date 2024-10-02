CREATE DATABASE IF NOT EXISTS hotel;

-- DROP DATABASE hotel;
SET SQL_SAFE_UPDATES=0;

USE hotel;

-- ===================================================================================                               
--                             SECTION 1: TABLE CREATION   
-- ===================================================================================        

-- GUESTS
CREATE TABLE IF NOT EXISTS guests (
	guest_id INT AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    dob DATE,
    email VARCHAR(50),
    contact_number VARCHAR(11),
    address VARCHAR(50) NOT NULL,
    CONSTRAINT pk_guest_id PRIMARY KEY (guest_id)
    );

-- ROOM TYPES
CREATE TABLE IF NOT EXISTS roomtypes (
	room_type_id INT AUTO_INCREMENT,
    type_name VARCHAR(50),
    base_price_per_night DECIMAL(10, 2),
    capacity INT,
    CONSTRAINT pk_room_type_id PRIMARY KEY (room_type_id)
    );

ALTER TABLE roomtypes AUTO_INCREMENT=1001;

-- ROOMS
CREATE TABLE IF NOT EXISTS rooms (
	room_id INT AUTO_INCREMENT,
    room_number INT,
    floor_level INT,
    rooms_room_type_id INT,
    availability VARCHAR(50),
    CONSTRAINT pk_room_id PRIMARY KEY (room_id),
    CONSTRAINT fk_rooms_room_type_id FOREIGN KEY (rooms_room_type_id) REFERENCES roomtypes(room_type_id)
    );

ALTER TABLE rooms AUTO_INCREMENT=2001;

CREATE TABLE IF NOT EXISTS bookings (
	booking_id INT AUTO_INCREMENT,
    check_in_date DATE,
    check_out_date DATE,
    number_of_guests INT,
    total_price DECIMAL(10, 2),
    booking_status VARCHAR(50),
    bookings_guest_id INT,
    bookings_room_id INT,
    CONSTRAINT pk_booking_id PRIMARY KEY (booking_id),
	CONSTRAINT fk_bookings_guest_id FOREIGN KEY (bookings_guest_id) REFERENCES guests(guest_id),
    CONSTRAINT fk_bookings_rooms_id FOREIGN KEY (bookings_room_id) REFERENCES rooms(room_id)
    );

ALTER TABLE bookings AUTO_INCREMENT=3001;

-- PAYMENTS
CREATE TABLE IF NOT EXISTS payments (
	payment_id INT AUTO_INCREMENT,
    amount_paid DECIMAL(10, 2),
    payment_date DATE,
    payment_method VARCHAR(50),
    payment_status VARCHAR(50),
    transaction_reference VARCHAR(50),
    payments_booking_id INT,
    CONSTRAINT pk_payment_id PRIMARY KEY (payment_id),
    CONSTRAINT fk_payments_booking_id FOREIGN KEY (payments_booking_id) REFERENCES bookings(booking_id)
    );

ALTER TABLE payments AUTO_INCREMENT=4001;

-- SERVICES
CREATE TABLE IF NOT EXISTS services (
	service_id INT AUTO_INCREMENT,
    service_name VARCHAR(50),
    service_price DECIMAL(10, 2) NOT NULL,
    CONSTRAINT pk_service_id PRIMARY KEY (service_id)
    );

-- SERVICE BOOKINGS
CREATE TABLE IF NOT EXISTS servicebookings (
	service_booking_id INT AUTO_INCREMENT,
    quantity INT,
    sb_service_id INT,
    sb_booking_id INT,
    CONSTRAINT pk_service_booking_id PRIMARY KEY (service_booking_id),
    CONSTRAINT fk_sb_service_id FOREIGN KEY (sb_service_id) REFERENCES services(service_id),
    CONSTRAINT fk_sb_booking_id FOREIGN KEY (sb_booking_id) REFERENCES bookings(booking_id)
    );

ALTER TABLE servicebookings AUTO_INCREMENT=5001;


-- ===================================================================================        
--                          SECTION 2: VALUE INSERTION
-- ===================================================================================        


-- inserting values into each table
INSERT INTO guests (first_name, last_name, dob, email, contact_number, address)
VALUES
('Alastair', 'Montgomery', '1985-05-12', 'alastair.montgomery@yahoo.com', '07123456789', '1001 Kensington Avenue, London'),
('Mei', 'Zhang', '1990-07-25', 'mei.zhang@hotmail.com', '07987654321', '732 Belgrave Road, Manchester'),
('Marcus', 'Cavendish', '2000-09-17', NULL, '07456789012', '78 Maple Grove, Edinburgh'),
('Cecila', 'Winchester', '1992-11-08', 'cecila.winchester@yahoo.com', '07234567890', '659 Pine Street, Bristol'),
('Sebastian', 'Hawthorne', '1980-02-14', NULL, NULL, '943 Elm Street, Liverpool'),
('Omar', 'Hassan', '1987-06-30', 'omar.hassan@outlook.com', '07567890123', '120 Birch Street, Cardiff'),
('Evelyn', 'Pemberton', '1995-03-23', 'evelyn.pemberton@gmail.com', '07890123456', '2 Oak Hill, Birmingham'),
('Liam', 'O''Sullivan', '1982-10-19', 'liam.osullivan@yahoo.com', '07801234567', '184 Cedar Street, Glasgow'),
('Anika', 'Singh', '1993-08-03', 'anika.singh@gmail.com', NULL, '478 Willow Lane, Leeds'),
('Sofia', 'Garcia', '1998-01-29', 'sofia.garcia@outlook.com', '07012345678', '222 Redwood Street, Sheffield');

INSERT INTO roomtypes (type_name, base_price_per_night, capacity)
VALUES
('Single', 100.00, 1),
('Double', 150.00, 2),
('Suite', 250.00, 3),
('Family Room', 200.00, 4),
('Twin Room', 180.00, 2);

INSERT INTO rooms (room_number, floor_level, rooms_room_type_id, availability)
VALUES
(101, 1, 1001, 'Available'), -- Single room
(102, 1, 1002, 'Occupied'),  -- Double room
(103, 1, 1003, 'Available'), -- Suite room
(201, 2, 1004, 'Available'), -- Family Room
(202, 2, 1005, 'Occupied'),  -- Twin Room
(301, 3, 1001, 'Available'), -- Single room
(302, 3, 1002, 'Available'), -- Double room
(303, 3, 1003, 'Occupied'),  -- Suite room
(401, 4, 1004, 'Occupied'),  -- Family Room
(402, 4, 1005, 'Available'); -- Twin Room

INSERT INTO bookings (check_in_date, check_out_date, number_of_guests, total_price, booking_status, bookings_guest_id, bookings_room_id)
VALUES
('2024-09-01', '2024-09-05', 1, 400.00, 'Confirmed', 1, 2001),
('2024-09-03', '2024-09-06', 2, 450.00, 'Confirmed', 2, 2002),
('2024-09-10', '2024-09-15', 3, 1250.00, 'Confirmed', 3, 2003),
('2024-09-05', '2024-09-10', 4, 1000.00, 'Confirmed', 4, 2004),
('2024-09-12', '2024-09-14', 2, 360.00, 'Confirmed', 5, 2005),
('2024-09-15', '2024-09-18', 1, 300.00, 'Pending', 6, 2001),
('2024-09-20', '2024-09-25', 2, 900.00, 'Confirmed', 7, 2002),
('2024-09-18', '2024-09-20', 2, 360.00, 'Cancelled', 8, 2005),
('2024-09-22', '2024-09-27', 4, 1000.00, 'Pending', 9, 2004),
('2024-09-25', '2024-09-30', 3, 1250.00, 'Confirmed', 10, 2003);

INSERT INTO payments (amount_paid, payment_date, payment_method, payment_status, transaction_reference, payments_booking_id)
VALUES
(400.00, '2024-09-01', 'Credit Card', 'Completed', 'TXN1234567890', 3001),
(450.00, '2024-09-03', 'Debit Card', 'Completed', 'TXN1234567891', 3002),
(1250.00, '2024-09-10', 'Credit Card', 'Completed', 'TXN1234567892', 3003),
(1000.00, '2024-09-05', 'Cash', 'Completed', 'TXN1234567893', 3004),
(360.00, '2024-09-12', 'Credit Card', 'Completed', 'TXN1234567894', 3005),
(300.00, '2024-09-15', 'Debit Card', 'Pending', 'TXN1234567895', 3006),
(900.00, '2024-09-20', 'Credit Card', 'Completed', 'TXN1234567896', 3007),
(360.00, '2024-09-18', 'Credit Card', 'Refunded', 'TXN1234567897', 3008),
(1000.00, '2024-09-22', 'Cash', 'Pending', 'TXN1234567898', 3009),
(1250.00, '2024-09-25', 'Credit Card', 'Completed', 'TXN1234567899', 3010);

INSERT INTO services (service_name, service_price)
VALUES
('Gym Access', 20.00),
('Spa Treatment', 80.00),
('Airport Transfer', 50.00),
('Room Service', 20.00),
('Laundry Service', 10.00),
('Guided City Tour', 60.00),
('Pool Access', 25.00);

INSERT INTO servicebookings (quantity, sb_service_id, sb_booking_id)
VALUES
(2, 1, 3001),   -- Gym Access - booking_id 3001
(1, 6, 3002),   -- Guided City Tour - booking_id 3002
(1, 5, 3003),   -- Laundry Service - booking_id 3003
(3, 4, 3004),   -- Room Service - booking_id 3004
(2, 5, 3005),   -- Laundry Service - booking_id 3005
(1, 6, 3006),   -- Guided City Tour - booking_id 3006
(2, 2, 3007),   -- Spa Treatment - booking_id 3007
(1, 7, 3008),   -- Pool Access - booking_id 3008
(1, 6, 3009),   -- Guided City Tour - booking_id 3009
(1, 3, 3010);  -- Airport Transfer - booking_id 3010


-- ===================================================================================        
--                       SECTION 3: QUERYING THE DATABASE    
-- ===================================================================================                

-- What are the details of all the guests staying in our hotel?
SELECT * FROM guests;

-- Only retrieve the first name, surnames and guest_id of guests that provided their email
SELECT g.guest_id, g.first_name, g.last_name, g.email
FROM guests AS g
WHERE g.email IS NOT NULL
ORDER BY last_name;

-- Identify guests that did not provide an email or a phone number
SELECT g.guest_id, CONCAT(g.first_name, ' ', g.last_name) AS 'Full Name',
COALESCE(g.email, 'No Email Provided') AS Email, COALESCE(g.contact_number, 'No Contact Number Provided') AS 'Contact Number'
FROM guests AS g;

-- What are the details of all the bookings in our hotel?
SELECT * FROM bookings;

-- Return all the bookings, including the booking id and the guest id, that cost more than £500
SELECT b.booking_id, b.bookings_guest_id, b.total_price 
FROM bookings AS b
WHERE b.total_price > 500
ORDER BY total_price DESC;

-- Update this query to include the first name and last name of the guests
SELECT g.guest_id, g.first_name, g.last_name,
b.booking_id, b.total_price
FROM guests AS g
INNER JOIN bookings AS b ON g.guest_id = b.bookings_guest_id
WHERE b.total_price > 500
ORDER BY total_price DESC;

-- Get all bookings with guest details
SELECT b.booking_id, g.first_name, g.last_name, b.check_in_date, b.check_out_date, b.total_price
FROM bookings b
LEFT JOIN guests g ON b.bookings_guest_id = g.guest_id;

-- Return guest full names and the type of rooms they booked
SELECT CONCAT(g.first_name, ' ', g.last_name) AS 'Guest''s Full Name', rt.type_name
FROM guests AS g
LEFT JOIN bookings AS b ON g.guest_id = b.bookings_guest_id
LEFT JOIN rooms as r ON b.bookings_room_id = r.room_id
LEFT JOIN roomtypes AS rt ON r.rooms_room_type_id = rt.room_type_id
ORDER BY g.last_name;

-- What is the average amount spent by guests when booking a stay at our hotel?
SELECT
AVG(b.total_price) AS AvgBookingSpend
FROM bookings AS b;

-- What is the highest amount spent by a guest when booking?
SELECT
MAX(b.total_price) AS MaxBookingSpend
FROM bookings AS b;

-- How many times has each room type been booked?
SELECT COUNT(b.bookings_room_id) AS 'No. of Bookings', rt.type_name AS 'Room Type' FROM bookings AS b
LEFT JOIN rooms AS r ON r.room_id = b.bookings_room_id 
LEFT JOIN roomtypes AS rt ON r.rooms_room_type_id = rt.room_type_id
GROUP BY rt.type_name;

-- What is the average length of stay for our guests?
SELECT b.booking_id, CONCAT(g.first_name, ' ', g.last_name) AS 'Full Name',
DATEDIFF(b.check_out_date, b.check_in_date) AS 'Stay Length (Days)',
AVG(DATEDIFF(b.check_out_date, b.check_in_date)) OVER() AS 'Average Stay Length (Days)'
FROM bookings AS b
LEFT JOIN guests AS g ON b.bookings_guest_id = g.guest_id;

-- Retrieve all bookings with payment details
SELECT b.booking_id, g.first_name, g.last_name, p.amount_paid, p.payment_date, p.payment_status
FROM bookings b
JOIN guests g ON b.bookings_guest_id = g.guest_id
JOIN payments p ON b.booking_id = p.payments_booking_id;


-- USING TRANSACTIONS
-- Update the costs for Room Service and Laundry Service which have increased by £10
SELECT * FROM services;

START TRANSACTION;

	UPDATE services
	SET
	services.service_price = 30
	WHERE services.service_name = 'Room Service';

	UPDATE services
	SET
	services.service_price = 20
	WHERE services.service_name = 'Laundry Service';

SELECT * FROM services;

COMMIT;

-- Guests have adjusted their booked services

START TRANSACTION;

	SELECT * FROM servicebookings;

	DELETE FROM servicebookings
	WHERE service_booking_id = 5002;

	UPDATE servicebookings
	SET quantity = 2
	WHERE service_booking_id = 5004;
    
    UPDATE servicebookings
	SET quantity = 3
	WHERE service_booking_id = 5010;

	DELETE FROM servicebookings
	WHERE service_booking_id = 5009;

	SELECT * FROM servicebookings;

COMMIT;

SELECT * FROM servicebookings;


-- Inserting new values into guests

INSERT INTO guests (first_name, last_name, dob, email, contact_number, address)
VALUES
('Hannah', 'Martin', '1999-04-07', 'hannah.martin2@gmail.com', '07865478932', '34 Woodhall Lane, London'),
('Nathan', 'Scott', '2006-03-05', 'nathanscott@hotmail.com', NULL, '489 Prescott Street, Manchester'),
('Zainab', 'Hussar', '1996-12-05', 'zainabh@gmail.com', '07547823458', '7 Montagu Road, London');

SELECT * FROM guests;

DELETE FROM guests
WHERE guest_id = 12; -- Removal of guest 12 due to being too young to create own booking

SELECT * FROM guests;

-- Select guests who have booked a suite and booked the 'Airport Transfer' service
SELECT CONCAT(g.first_name, ' ', g.last_name) AS 'Full Name', rt.type_name AS 'Room Type'
FROM guests AS g
JOIN bookings AS b ON g.guest_id = b.bookings_guest_id
JOIN rooms AS r ON b.bookings_room_id = r.room_id
JOIN roomtypes AS rt ON r.rooms_room_type_id = rt.room_type_id
JOIN servicebookings AS sb ON b.booking_id = sb.sb_booking_id
JOIN services AS s ON sb.sb_service_id = s.service_id
WHERE rt.type_name = 'Suite' AND s.service_name = 'Airport Transfer';


-- ===================================================================================        
--                            SECTION 4: STORED PROCEDURES
-- ===================================================================================        

-- Procedure to add a new guest

DELIMITER //
CREATE PROCEDURE AddGuest (p_first_name VARCHAR(50), p_last_name VARCHAR(50), p_dob DATE, 
								p_email VARCHAR(50), p_contact_number VARCHAR(11), p_address VARCHAR(50))
BEGIN
	INSERT INTO guests (first_name, last_name, dob, email, contact_number, address)
	VALUES (p_first_name, p_last_name, p_dob, p_email, p_contact_number, p_address);
END //
DELIMITER ;

CALL AddGuest('Jace', 'Williams', '1996-02-19', 'jacewilliams96@hotmail.co.uk', '07754890341', '78 Morningstar Avenue, Birmingham');

SELECT * FROM guests;

-- Procedure to add a new booking

DELIMITER //
CREATE PROCEDURE AddBooking (p_check_in_date DATE, p_check_out_date DATE, p_number_of_guests INT, p_total_price DECIMAL(10, 2),
								p_booking_status VARCHAR(50), p_bookings_guest_id INT, p_bookings_room_id INT)
BEGIN
	INSERT INTO bookings (check_in_date, check_out_date, number_of_guests, total_price, booking_status, 
							bookings_guest_id, bookings_room_id)
	VALUES (p_check_in_date, p_check_out_date, p_number_of_guests, p_total_price, p_booking_status, 
			p_bookings_guest_id, p_bookings_room_id);
END //
DELIMITER ;

CALL AddBooking ('2024-09-25', '2024-09-30', 1, 500.00, 'Confirmed', 14, 2001);
CALL AddBooking('2024-10-01', '2024-10-07', 2, 1500.00, 'Pending', 11, 2003);

SELECT * FROM bookings;

-- Procedure to add a new payment

DELIMITER //
CREATE PROCEDURE AddPayment (p_amount_paid DECIMAL(10, 2), p_payment_date DATE, p_payment_method VARCHAR(50),
							p_payment_status VARCHAR(50), p_transaction_reference VARCHAR(50), P_payments_booking_id INT)
BEGIN
	INSERT INTO payments (amount_paid, payment_date, payment_method, payment_status, transaction_reference, payments_booking_id)
	VALUES (p_amount_paid, p_payment_date, p_payment_method, p_payment_status, p_transaction_reference, p_payments_booking_id) ;
END //
DELIMITER ;

CALL AddPayment (500.00, '2024-09-24', 'Credit Card', 'Completed', 'TXN1234567900', 3011);
CALL AddPayment (1500.00, '2024-09-26', 'Credit Card', 'Pending', 'TXN1234567901', 3012);

SELECT * FROM payments;

-- Procedure to add a new service booking

DELIMITER //
CREATE PROCEDURE AddServiceBooking (p_quantity INT, p_sb_service_id INT, p_sb_booking_id INT)
BEGIN
	INSERT INTO servicebookings (quantity, sb_service_id, sb_booking_id)
	VALUES (p_quantity, p_sb_service_id, p_sb_booking_id);
END //
DELIMITER ;

CALL AddServiceBooking (1, 1, 3011);
CALL AddServiceBooking (2, 2, 3012);
CALL AddServiceBooking (2, 4, 3012);

SELECT * FROM servicebookings;


-- Total price in bookings table does not account for services bought by guests. 
-- So to improve this DB, I want to create a procedure(s) that calculate the costs of room booking + services automatically
-- Then update any exisiting data in the bookings table


-- Calculate cost of total room + services bookings
DELIMITER //
CREATE PROCEDURE CalculateTotalBookingCost (IN input_booking_id INT)
BEGIN
	DECLARE room_cost DECIMAL(10, 2);
	DECLARE service_cost DECIMAL(10, 2);

-- Calculation of room cost
	SELECT DATEDIFF(check_out_date, check_in_date) * rt.base_price_per_night
	INTO room_cost
	FROM bookings AS b
	INNER JOIN rooms AS r ON b.bookings_room_id = r.room_id
	INNER JOIN roomtypes AS rt ON r.rooms_room_type_id = rt.room_type_id
	WHERE b.booking_id = input_booking_id;

-- Calculation of service cost
	SELECT IFNULL(SUM(sb.quantity * s.service_price), 0)
	INTO service_cost
	FROM servicebookings AS sb
	INNER JOIN services AS s ON sb.sb_service_id = s.service_id
	WHERE sb.sb_booking_id = input_booking_id ;

-- Update total price in bookings table
	UPDATE bookings
	SET total_price = room_cost + service_cost
	WHERE booking_id = input_booking_id;
END //
DELIMITER ;


-- Procedure to insert service booking & ensure total_price in bookings table is updated after services are booked
DELIMITER //
CREATE PROCEDURE InsertServiceBookingRecalculation (input_quantity INT, input_sb_service_id INT, input_sb_booking_id INT)
BEGIN
	-- Checks for existing data
    DECLARE existing_data INT;
    
    SELECT COUNT(*)
    INTO existing_data
    FROM servicebookings
    WHERE sb_service_id = input_sb_service_id AND sb_booking_id = input_sb_booking_id;
    
    IF existing_data > 0 THEN
    UPDATE servicebookings
    SET quantity = input_quantity
    WHERE sb_service_id = input_sb_service_id AND sb_booking_id = input_sb_booking_id;
    
    ELSE
	INSERT INTO servicebookings (quantity, sb_service_id, sb_booking_id)
	VALUES (input_quantity, input_sb_service_id, input_sb_booking_id);
    END IF;

	CALL CalculateTotalBookingCost(input_sb_booking_id);

END //
DELIMITER ;

-- Calling the procedures
START TRANSACTION;
	SELECT * FROM servicebookings;
    SELECT * FROM bookings;
    
	CALL InsertServiceBookingRecalculation(2, 1, 3001);
	CALL InsertServiceBookingRecalculation(1, 5, 3003);
	CALL InsertServiceBookingRecalculation(2, 4, 3004);
	CALL InsertServiceBookingRecalculation(2, 5, 3005);
	CALL InsertServiceBookingRecalculation(1, 6, 3006);
	CALL InsertServiceBookingRecalculation(2, 2, 3007);
	CALL InsertServiceBookingRecalculation(1, 7, 3008);
	CALL InsertServiceBookingRecalculation(3, 3, 3010);
    CALL InsertServiceBookingRecalculation(1, 1, 3011);
    CALL InsertServiceBookingRecalculation(2, 2, 3012);
    CALL InsertServiceBookingRecalculation(2, 4, 3012);

SELECT * FROM servicebookings;
SELECT * FROM bookings;

COMMIT;

-- Adjusting the AddBooking procedure to include the room+service booking costs calculations
DROP PROCEDURE AddBooking;

DELIMITER //
CREATE PROCEDURE AddBooking (p_check_in_date DATE, p_check_out_date DATE, p_number_of_guests INT, p_total_price DECIMAL(10, 2),
								p_booking_status VARCHAR(50), p_bookings_guest_id INT, p_bookings_room_id INT)
BEGIN
	INSERT INTO bookings (check_in_date, check_out_date, number_of_guests, total_price, booking_status,
							bookings_guest_id, bookings_room_id)
	VALUES (p_check_in_date, p_check_out_date, p_number_of_guests, 0, p_booking_status, p_bookings_guest_id, p_bookings_room_id);
    
    CALL CalculateTotalBookingCost(LAST_INSERT_ID());
    
END //
DELIMITER ;

-- Update payments table with newly calculated prices for amount_paid column
SELECT * FROM payments;

START TRANSACTION;

	UPDATE payments AS p
	JOIN bookings AS b ON p.payments_booking_id = b.booking_id
	SET p.amount_paid = b.total_price
	WHERE p.amount_paid != b.total_price;

SELECT * FROM payments;

COMMIT;

SELECT * FROM payments;
