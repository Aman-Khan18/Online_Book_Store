create database Online_bookstore;

CREATE TABLE BOOKS(
    BOOK_ID SERIAL PRIMARY KEY,
	TITLE VARCHAR(100),	
	AUTHOR VARCHAR(100),
	GENRE VARCHAR(50),
	PUBLISHED_YEAR INT,
	PRICE NUMERIC(10,2),
	STOCK INT 
);


CREATE TABLE CUSTOMERS(
    CUSTOMER_ID SERIAL PRIMARY KEY,
	NAME VARCHAR(100),
    EMAIL VARCHAR(50),
	PHONE VARCHAR (15),
	CITY VARCHAR (50),
	COUNTRY VARCHAR (150)

);


CREATE TABLE ORDERS (
    ORDER_ID SERIAL PRIMARY KEY,
	CUSTOMER_ID INT REFERENCES CUSTOMERS(CUSTOMER_ID),
	BOOK_ID INT REFERENCES BOOKS (BOOK_ID),
	ORDER_DATE DATE,
	QUANTITY INT,
	TOTAL_AMOUNT NUMERIC(10,2)
	
);


SELECT * FROM BOOKS;

SELECT * FROM CUSTOMERS;

SELECT * FROM ORDERS;


-- IMPORTING DATA INTO BOOKS TABLE 
COPY BOOKS (BOOK_ID, TITLE, AUTHOR, GENRE, PUBLISHED_YEAR, PRICE, STOCK)
FROM 'C:\All Excel Practice Files\Books.csv'
CSV HEADER;

-- IMPORTNG DATA INTO CUSTOMERS TABLE
COPY CUSTOMERS (CUSTOMER_ID, NAME, EMAIL, PHONE, CITY, COUNTRY)
FROM 'C:\All Excel Practice Files\Customers.csv'
CSV HEADER;


-- IMPORTING DATA INTO ORDERS TABLE 
COPY ORDERS (ORDER_ID, CUSTOMER_ID, BOOK_ID, ORDER_DATE, QUANTITY, TOTAL_AMOUNT)
FROM 'C:\All Excel Practice Files\Orders.csv'
CSV HEADER;


-- Q1) RETRIVE ALL BOOKS IN THE 'FICTION' GENRE
SELECT * FROM BOOKS
WHERE GENRE = 'Fiction';

-- Q2) FIND BOOKS PUBLISHED AFTER THE YEAR 1950
SELECT * FROM BOOKS 
WHERE PUBLISHED_YEAR > 1950;

-- Q3) LIST ALL THE CUSTOMERS FROM THE CANADA 
SELECT * FROM CUSTOMERS 
WHERE COUNTRY = 'Canada';

-- Q4) SHOW ORDER PLACED IN NOVEMBER 2023
SELECT * FROM ORDERS 
WHERE ORDER_DATE BETWEEN '2023-11-01' AND '2023-11-30';

-- Q5) RETRIVE THE TOTAL STOCKS OF BOOK AVAILABLE 
SELECT SUM (STOCK) FROM BOOKS AS SUM_STOCK;

-- Q6) FIND THE LIST OF THE MOST EXPENSIVE BOOK
SELECT * FROM BOOKS ORDER BY PRICE DESC LIMIT 1;

-- Q7) SHOW ALL THE CUSTOMERS WHO ORDERED MORE THAN 1 QUANTITY OF A BOOK
SELECT * FROM ORDERS
WHERE QUANTITY > 1 ;

-- Q8) RETRIVE ALL ORDERS WHERE THE TOTAL AMOUNT EXCEEDS $20
SELECT * FROM ORDERS 
WHERE TOTAL_AMOUNT > 20;

-- Q9) LIST ALL GENRES AVAILABLE IN THE BOOKS TABLE 
SELECT DISTINCT GENRE FROM BOOKS;

-- Q10) FIND THE BOOK WITH THE LOWEST STOCK
SELECT * FROM BOOKS ORDER BY STOCK ASC LIMIT 1;

-- Q11) CALCULATE THE TOTAL REVENUE GENERATED FROM ALL ORDERS
SELECT SUM (TOTAL_AMOUNT) AS TOTAL_REVENUE FROM ORDERS;



-- ADVANCED QUESTIONS

-- Q1) RETRIVE THE TOTAL NUMBER OF BOOKS SOLD FOR EACH GENRE 
SELECT * FROM ORDERS;
SELECT * FROM BOOKS;

SELECT B.GENRE, SUM(O.QUANTITY)
FROM ORDERS O
JOIN BOOKS B ON O.BOOK_ID = B.BOOK_ID
GROUP BY GENRE;

-- Q2) FIND THE AVERAGE PRICE OF BOOKS IN THE 'Fantasy' GENRE 
SELECT AVG(PRICE) AS AVG_PRICE
FROM BOOKS
WHERE GENRE = 'Fantasy';

-- Q3) LIST CUSTOMERS WHO HAVE PLACED AT LEAST 2 ORDERS
SELECT O.CUSTOMER_ID, C.NAME, COUNT (O.ORDER_ID) AS ORDER_COUNT
FROM ORDERS O
JOIN CUSTOMERS C ON O.CUSTOMER_ID = C.CUSTOMER_ID
GROUP BY O.CUSTOMER_ID, C.NAME
HAVING COUNT (ORDER_ID) >= 2;

-- Q4) FIND THE MOST FREQUENTLY ORDERED BOOK
SELECT O.BOOK_ID, B.TITLE, COUNT (O.ORDER_ID) AS ORDER_COUNT
FROM ORDERS O
JOIN BOOKS B ON O.BOOK_ID = B.BOOK_ID
GROUP BY O.BOOK_ID, B.TITLE
ORDER BY ORDER_COUNT DESC LIMIT 1;

-- Q5) SHOW THE TOP 3 MOST EXPENSIVE BOOKS OF 'Fantasy' GENRE 
SELECT * FROM BOOKS 
WHERE GENRE = 'Fantasy'
ORDER BY PRICE DESC LIMIT 3;

-- Q6) RETRIVE THE TOTAL QUANTITY OF BOOKS SOLD BY EACH AUTHOR 
SELECT B.AUTHOR, SUM (O.QUANTITY) AS TOTAL_BOOKS_SOLD
FROM ORDERS O
JOIN BOOKS B ON O.BOOK_ID = B.BOOK_ID
GROUP BY B.AUTHOR;

-- Q7) LIST THE CITY WHERE CUSTOMERS WHO SPENT OVER $30 ARE LOCATED 
SELECT DISTINCT C.CITY, O.TOTAL_AMOUNT 
FROM ORDERS O
JOIN CUSTOMERS C ON O.CUSTOMER_ID = C.CUSTOMER_ID
WHERE O.TOTAL_AMOUNT > 30;

-- Q8) FIND THE CUSTOMERS WHO SPENT THE MOST ON ORDERS 
SELECT C.CUSTOMER_ID, C.NAME, SUM(O.TOTAL_AMOUNT) AS TOTAL_SPENT
FROM ORDERS O
JOIN CUSTOMERS C ON O.CUSTOMER_ID = C.CUSTOMER_ID
GROUP BY C.CUSTOMER_ID, C.NAME
ORDER BY TOTAL_SPENT DESC LIMIT 1;









