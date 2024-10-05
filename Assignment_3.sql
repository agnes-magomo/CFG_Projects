CREATE DATABASE Car_dealership_assignment_3;

USE car_dealership_assignment_3;

CREATE TABLE customers
(
customer_id INT NOT NULL AUTO_INCREMENT,
customer_name VARCHAR(250) NOT NULL,
email VARCHAR (250) NOT NULL,
phone_number VARCHAR(15),
PRIMARY KEY(customer_id)
);

CREATE TABLE Cars
(
car_id int NOT NULL AUTO_INCREMENT,
make VARCHAR (50) NOT NULL,
model VARCHAR(50) NOT NULL,
Year YEAR NOT NULL,
price DECIMAL (10,2) NOT NULL,
customer_id INT,
PRIMARY KEY (car_id)
);

CREATE TABLE Finance_agreement
(
finance_id INT NOT NULL AUTO_INCREMENT,
start_date DATE NOT NULL,
end_date DATE NOT NULL,
monthly_payment DECIMAL (10,2) NOT NULL,
car_id INT UNIQUE, 
PRIMARY KEY (finance_id),
FOREIGN KEY (car_id) REFERENCES Cars(car_id) 
);

INSERT INTO customers (customer_name, email, phone_number)
VALUES
('Zephania Buttercup', 'z.mh@gmail.com','07684937562'),
('Amy Fischer', 'amyfischer@outlook.com', '07241773649'),
('Tanaka mvura',	'tanaka.m@yahoo.co.uk','07878512071'),
('Moyowashe Gwai', 'moyowashe@gmail.com','07944462194'),
('Charlie Brown', 'charlie.brown@gmail.com','07721239087'),
('Tawana Mari', 'tawamari@outlook.com','07457390648'),
('Raven Baxter', 'raven.baxter@yahoo.co.uk','07849562784'),
('Bob Marley', 'marleyman@gmail.com','07548920367');

INSERT INTO cars ( Make, Model, Year, Price, customer_id)
VALUES
('Audi', 'A3', 2018, 23000.00,1),
('BMW', 'X5', 2022, 50000.00,2),
('Mercedes', 'C-Class', 2020, 40000.00,3),
('Toyota', 'Yaris', 2024,24000.00,4),
('Toyota', 'Aygo',2020, 18000.00,5),
('Toyota','CHR', 2021,30000.00,6),
('Toyota','Corolla', 2015,15000.00,7),
('Volkswagen', 'Golf', 2021, 27000.00,8);


INSERT INTO finance_agreement (start_date, end_date, monthly_payment)
VALUES
('2021-01-01', '2026-01-01', 350.00),
('2022-03-15', '2027-03-15', 300.00),
('2020-09-01', '2025-09-01', 400.00),
('2022-02-10', '2027-02-10', 850.00),
('2018-06-15', '2023-06-15', 450.00),
('2020-11-05', '2025-11-05', 700.00),
('2019-08-22', '2024-08-22', 320.00),
('2021-09-30', '2026-09-30', 500.00);


SELECT * FROM cars;
SELECT * FROM finance_agreement;

UPDATE finance_agreement SET car_id = 1 WHERE finance_id = 1;
UPDATE finance_agreement SET car_id = 2 WHERE finance_id = 2;
UPDATE finance_agreement SET car_id = 3 WHERE finance_id = 3;
UPDATE finance_agreement SET car_id = 4 WHERE finance_id = 4;
UPDATE finance_agreement SET car_id = 5 WHERE finance_id = 5;
UPDATE finance_agreement SET car_id = 6 WHERE finance_id = 6;
UPDATE finance_agreement SET car_id = 7 WHERE finance_id = 7;
UPDATE finance_agreement SET car_id = 8 WHERE finance_id = 8;



-- Adding foreign key to car table 
ALTER TABLE cars
ADD CONSTRAINT fk_customers
FOREIGN KEY (customer_id) 
REFERENCES customers(customer_id)
ON DELETE CASCADE
ON UPDATE CASCADE;


-- Retrieving cars with associated customer details 
SELECT c.make, c.model, cu.customer_name, cu.email
FROM Cars c
JOIN Customers cu ON c.customer_id = cu.customer_id;

-- Finding all finance agreements ending within the next 6 months:
SELECT f.finance_id, c.make, c.model, f.end_date
FROM Finance_Agreement f
JOIN Cars c ON f.car_id = c.car_id
WHERE f.end_date <= DATE_ADD(CURDATE(), INTERVAL 6 MONTH);

-- Count the total number of cars sold 
SELECT COUNT(car_id) AS total_cars_sold FROM Cars;

--  Monthly payments sorted from highest to lowest:
SELECT f.monthly_payment, c.make, c.model
FROM Finance_Agreement f
JOIN Cars c ON f.car_id = c.car_id
ORDER BY f.monthly_payment DESC;

-- Update a car’s price:
UPDATE Cars
SET price = 19500.00
WHERE car_id = 2;

-- Delete a customer and cascade changes:
DELETE FROM Customers WHERE customer_id = 1;

-- Created a stored procedure that checks if a finance agreement 
-- is ending within the next month and returns the car’s details.
DELIMITER $$

CREATE PROCEDURE CheckFinanceEndingSoonn()
BEGIN
    SELECT c.make, c.model, f.end_date
    FROM Finance_Agreement f
    JOIN Cars c ON f.car_id = c.car_id
    WHERE f.end_date <= DATE_ADD(CURDATE(), INTERVAL 6 MONTH);
END $$

DELIMITER ;

--  Checking the length of customer names:
SELECT customer_name, LENGTH(customer_name) AS name_length FROM Customers;

-- CONCAT function to display customer’s full details :
SELECT CONCAT(customer_name, ', ', '    ', email, ', ','    ', phone_number) AS customer_details
FROM Customers;
