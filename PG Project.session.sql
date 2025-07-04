-- Droping Table

-- We are Dropping the Table here because it is a very good practice to use in the code. It helps to avoid old data or schema conflicts.

DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS number_1 CASCADE;
DROP TABLE IF EXISTS number_2 CASCADE;
DROP TABLE IF EXISTS for_functions_example CASCADE;
DROP TABLE IF EXISTS scm_orders_schema.orders CASCADE;
DROP SCHEMA IF EXISTS scm_orders_schema CASCADE;
DROP ROLE IF EXISTS testing_user_vahe;

-- Crateing Table 

-- To create a table, we write the CREATE TABLE command, but it is more professional to write IF NOT EXISTS after creating the table
-- because it checks if the table has already been created and does not create it again.

CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY, -- Here SERIAL means that the value obtained inside the id must be unique and it provides an integer for each new row.
    first_name VARCHAR(50), -- VARCHAR(50) is used for text values ​​and the number in parentheses indicates how many characters can be contained in the table.
    last_name VARCHAR(50), -- VARCHAR(50) is used for text values ​​and the number in parentheses indicates how many characters can be contained in the table.
    age INT, -- INT is used for numeric values.
    born_date DATE, -- DATE is used to store a date.
    test INT
);

CREATE TABLE IF NOT EXISTS number_1 (
    num_value_1 INT -- INT is used for numeric values.
);

CREATE TABLE IF NOT EXISTS number_2 (
    num_value_2 INT -- INT is used for numeric values.
);

CREATE TABLE IF NOT EXISTS for_functions_example (
    lengt_h INT,
    words VARCHAR(50),
    num INT,
    dat_e DATE,
    newSum_function_res VARCHAR(50)
);

-- adding data to the table

INSERT INTO users (first_name,last_name,age,born_date) VALUES 
('Vahe','Xachatryan',14,'2011-07-20'),
('Joe','Smith',23,'2002-03-26'),
('John','Wathney',45,'1980-09-1'),
('Ann','Alderson',34,'1991-08-21'),
('Walter','White',52,'1973-04-30');

INSERT INTO number_1 (num_value_1) VALUES
(3),
(5),
(1),
(2),
(4);

INSERT INTO number_2 (num_value_2) VALUES
(3),
(5),
(1),
(2),
(4);

-- Here, using INSERT INTO, we specify which table we need to add the data to, and in parentheses, we specify the rows to which we need to add the data.
-- Then we write VALUES and parentheses, and in parentheses, we specify what data is needed for which row.

SELECT * FROM users;

-- SELECT is used to select and retrieve data from a database.If we look there is something like * which means 
-- to retrieve all the data from the users table, its place could be age or first_name etc.;

SELECT first_name,last_name,age FROM users WHERE age > 40;

-- Here, using the SELECT command, we get the data of people whose age is above 40. To get this, we have used the WHERE command, which is a very useful command.

ALTER TABLE users 
DROP COLUMN test;

-- The ALTER statement allows us to make changes to an already created table.
-- For example, here we are deleting the test column from the users table.

-- ASC and DESC commands with SELECT

SELECT num_value_1
FROM number_1 
ORDER BY num_value_1 ASC;  

-- Thanks to ASC, we can sort values ​​in ascending order.

SELECT num_value_2
FROM number_2 
ORDER BY num_value_2 DESC;  

-- DESC is the opposite of ASC, it sorts data in descending order.

-- Schema's

CREATE SCHEMA IF NOT EXISTS scm_orders_schema;

-- SCHEMAs are a very useful and convenient tool.

CREATE TABLE IF NOT EXISTS scm_orders_schema.orders (
    products_name VARCHAR(50), -- VARCHAR(50) is used for text values ​​and the number in parentheses indicates how many characters can be contained in the table. 
    products_quantity INT, -- INT is used for numeric values. 
    purchased INT, -- INT is used for numeric values. 
    day_of_reckoning DATE -- DATE is used to store a date. 
);

-- We can create tables or VIEWs in SCHEMAs, which we will talk about a little later. We can give that table attributes, add rows, etc.

-- Index's

CREATE INDEX IF NOT EXISTS idx_products_quantity_index ON scm_orders_schema.orders (products_quantity);

-- INDEXes help to search data very quickly. To create an INDEX, you need to write CREATE INDEX followed by the name of the 
-- INDEX and write on which table column the INDEX should be created.

DROP INDEX IF EXISTS idx_products_quantity_index;

-- To delete an INDEX, we use the DROP INDEX command and write the name of the INDEX we want to delete in its body.

-- Views

CREATE VIEW info_users_view AS
SELECT first_name,last_name,age 
FROM users 
WHERE age > 30;

-- VIEWs are very useful, they are virtual tables that can take data from different tables and store it within themselves.
-- VIEWs are very useful for privacy, security, access control, and simplifying complex queries.

CREATE VIEW scm_orders_schema.info_users_view AS
SELECT first_name,last_name,age 
FROM users 
WHERE age > 30;

-- If we want to change the way the VIEW is created, i.e. in which SCHEMA it is created, we must specify the 
-- name of our SCHEMA before the name of the VIEW as shown in the code above.

-- User's

CREATE USER testing_user_vahe WITH PASSWORD 'security';

-- Here we create a USER which is one of the most important topics in PGSQL. 
-- To create a USER we write CREATE USER and its name and if we need it to have 
-- a password we need to add the WITH PASSWORD command and write the password 
-- that the USER should have next to it.

GRANT CONNECT ON DATABASE git_hub_project_6 TO testing_user_vahe;
-- here we give USER permission to connect to the Database
GRANT USAGE ON SCHEMA public TO testing_user_vahe;
-- here we grant USER access to public SCHEMA
GRANT SELECT ON ALL TABLES IN SCHEMA public TO testing_user_vahe; 
-- here we give USER permission to read all tables from public SCHEMA

-- We can grant rights and restrictions to USERS using the GRANT command, for example, 
-- we can give USERS the right to read tables or access SCHEMAs, etc. You can see all this in the code above.

-- There is also a similar command to USER called ROLE, it is a more advanced version and is very convenient 
-- for giving rights and restrictions to USERs.


CREATE ROLE roleing_users_for_github WITH LOGIN PASSWORD 'newpassword';
GRANT INSERT,DELETE,UPDATE ON TABLE scm_orders_schema.orders TO roleing_users_for_github;

-- Here in the code above we allow USER to insert data, delete data, and update data.
-- You can see more commands about Role here

-- LOGIN
-- NOLOGIN 
-- PASSWORD 'password'
-- SUPERUSER / NOSUPERUSER 
-- CREATEDB / NOCREATEDB 
-- CREATEROLE / NOCREATEROLE 
-- INHERIT / NOINHERIT
-- VALID UNTIL 'timestamp'

-- Function's 

-- String Functions 

INSERT INTO for_functions_example (lengt_h) VALUES (LENGTH('Hello World'));
-- The LENGTH() function shows how many characters of a string are contained within its parentheses.
INSERT INTO for_functions_example (words) VALUES (LOWER('Hello World'));
-- The LOWER() function converts all characters between its parentheses to lowercase.
INSERT INTO for_functions_example (words) VALUES (UPPER('Hello World'));
-- The UPPER() function makes all characters between its parentheses uppercase.
INSERT INTO for_functions_example (words) VALUES (SUBSTRING('Hello World',1, 5));
-- The SUBSTRING() function returns a set of characters within its parentheses, with the number we give it. 
-- The first number is the starting point for calculating the character, and the second number is the range 
-- up to which it should calculate the characters and return them.
INSERT INTO for_functions_example (words) VALUES (CONCAT('Hello' , ' ' , 'World'));
-- The CONCAT() function concatenates the text between its parentheses.

SELECT LENGTH('Hello World');

-- Digital Functions 

INSERT INTO for_functions_example (num) VALUES (ABS(-44));
-- The ABS() function returns the absolute value of the number in it.
INSERT INTO for_functions_example (num) VALUES (CEIL(8.9));
-- The CEIL() function returns the smallest integer greater than or equal to a given number.
INSERT INTO for_functions_example (num) VALUES (ROUND(4.6302, 2));
-- The ROUND() function rounds a number to the specified number of decimal places.
INSERT INTO for_functions_example (num) VALUES (FLOOR(4.4));
-- The FLOOR() function returns the largest integer less than or equal to a given number.

-- Data and Time Functuions 

INSERT INTO for_functions_example (dat_e) VALUES (NOW());
-- The NOW() function returns the current date and time, including time zone information.
INSERT INTO for_functions_example (dat_e) VALUES (CURRENT_DATE);
-- The CURRENT_DATE function returns only the current date, without time data.
INSERT INTO for_functions_example (dat_e) VALUES (EXTRACT(YEAR FROM '2025-06-30 10:30:00'));
-- The EXTRACT() function allows you to extract a specific component from a date/time or interval value.

-- Creating Function's 

CREATE OR REPLACE FUNCTION numSum (score DECIMAL)
RETURNS VARCHAR(50) AS $$
DECLARE
    result_text VARCHAR(50); 
BEGIN
    IF score > 50 THEN
        result_text := 'Good'; 
        INSERT INTO for_functions_example (newSum_function_res) VALUES (result_text);
    ELSE
        result_text := 'Bad'; 
        INSERT INTO for_functions_example (newSum_function_res) VALUES (result_text); 
    END IF;

    RETURN result_text;
END;
$$ LANGUAGE plpgsql;

SELECT numSum(75);
SELECT numSum(45);