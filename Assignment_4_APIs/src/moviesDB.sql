

-- 1. Create the database
CREATE DATABASE IF NOT EXISTS movie_rental_db;

-- 2. Use the database
USE movie_rental_db;

-- 3. Create the movies table
CREATE TABLE IF NOT EXISTS movies (
    movie_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    genre VARCHAR(100),
    release_year INT,
    is_available BOOLEAN DEFAULT 1
);

-- 4. Create the customers table
CREATE TABLE IF NOT EXISTS customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(20)
);

-- 5. Create the actors table
CREATE TABLE IF NOT EXISTS actors (
    actor_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    birthdate DATE
);

-- 6. Create the movie_actors table
CREATE TABLE IF NOT EXISTS movie_actors (
    movie_id INT,
    actor_id INT,
    PRIMARY KEY (movie_id, actor_id),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id) ON DELETE CASCADE,
    FOREIGN KEY (actor_id) REFERENCES actors(actor_id) ON DELETE CASCADE
);

-- 7. Create the rentals table
CREATE TABLE IF NOT EXISTS rentals (
    rental_id INT PRIMARY KEY AUTO_INCREMENT,
    movie_id INT,
    customer_id INT,
    rental_date DATE NOT NULL,
    return_date DATE,
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id) ON DELETE CASCADE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
);

-- 8. Insert sample data into movies
INSERT INTO movies (title, genre, release_year, is_available) VALUES
('Inception', 'Sci-Fi', 2010, 1),
('The Matrix', 'Sci-Fi', 1999, 1),
('The Dark Knight', 'Action', 2008, 1),
('Interstellar', 'Sci-Fi', 2014, 1),
('Forrest Gump', 'Drama', 1994, 1);

-- 9. Insert sample data into customers
INSERT INTO customers (name, email, phone) VALUES
('John Doe', 'johndoe@example.com', '123-456-7890'),
('Jane Smith', 'janesmith@example.com', '098-765-4321'),
('Alice Johnson', 'alicej@example.com', '555-123-4567'),
('Bob Brown', 'bobbrown@example.com', '444-555-6666'),
('Charlie Davis', 'charlied@example.com', '777-888-9999');

-- 10. Insert sample data into actors
INSERT INTO actors (name, birthdate) VALUES
('Leonardo DiCaprio', '1974-11-11'),
('Keanu Reeves', '1964-09-02'),
('Christian Bale', '1974-01-30'),
('Matthew McConaughey', '1969-11-04'),
('Tom Hanks', '1956-07-09');

-- 11. Insert sample data into movie_actors
-- Leonardo DiCaprio in 'Inception' (movie_id=1)
INSERT INTO movie_actors (movie_id, actor_id) VALUES (1, 1);

-- Keanu Reeves in 'The Matrix' (movie_id=2)
INSERT INTO movie_actors (movie_id, actor_id) VALUES (2, 2);

-- Christian Bale in 'The Dark Knight' (movie_id=3)
INSERT INTO movie_actors (movie_id, actor_id) VALUES (3, 3);

-- Matthew McConaughey in 'Interstellar' (movie_id=4)
INSERT INTO movie_actors (movie_id, actor_id) VALUES (4, 4);

-- Tom Hanks in 'Forrest Gump' (movie_id=5)
INSERT INTO movie_actors (movie_id, actor_id) VALUES (5, 5);

-- Additional Associations
-- Leonardo DiCaprio in 'Interstellar' (movie_id=4)
INSERT INTO movie_actors (movie_id, actor_id) VALUES (4, 1);

-- Tom Hanks in 'Inception' (movie_id=1)
INSERT INTO movie_actors (movie_id, actor_id) VALUES (1, 5);

-- 12. Insert sample data into rentals
INSERT INTO rentals (movie_id, customer_id, rental_date, return_date) VALUES
(1, 1, '2024-10-01', NULL),  -- John Doe rents 'Inception'
(2, 2, '2024-10-02', '2024-10-05'),  -- Jane Smith rents and returns 'The Matrix'
(3, 3, '2024-10-03', NULL),  -- Alice Johnson rents 'The Dark Knight'
(4, 4, '2024-10-04', NULL),  -- Bob Brown rents 'Interstellar'
(5, 5, '2024-10-05', '2024-10-10');  -- Charlie Davis rents and returns 'Forrest Gump'

USE movie_rental_db;
SELECT * FROM movies;