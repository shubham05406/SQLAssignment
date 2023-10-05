create table SalesPeople (
    Snum INT PRIMARY KEY,
    Sname VARCHAR(255) UNIQUE,
    City VARCHAR(255),
    Comm DECIMAL(5, 2)
);

insert into SalesPeople VALUES
(1001, 'Peel', 'London', 0.12),
(1002, 'Serres', 'Sanjose', 0.13),
(1004, 'Motika', 'London', 0.11),
(1007, 'Rifkin', 'Barcelona', 0.15),
(1003, 'Axelrod', 'Newyork', 0.10);

select * from SalesPeople;

create table Customers (
    Cnum INT PRIMARY KEY,
    Cname VARCHAR(255),
    City VARCHAR(255) NOT NULL,
    Snum INT,
    FOREIGN KEY (Snum) REFERENCES SalesPeople(Snum)
);

insert into Customers 
VALUES
(2001, 'Hoffman', 'London', 1001),
(2002, 'Giovanni', 'Rome', 1003),
(2003, 'Liu', 'Sanjose', 1002),
(2004, 'Grass', 'Berlin', 1002),
(2006, 'Clemens', 'London', 1001),
(2008, 'Cisneros', 'Sanjose', 1007),
(2007, 'Pereira', 'Rome', 1004);

select * from Customers;

create table Orders (
    Onum INT PRIMARY KEY,
    Amt DECIMAL(10, 2),
    Odate DATE,
    Cnum INT,
    Snum INT,
    FOREIGN KEY (Cnum) REFERENCES Customers(Cnum),
    FOREIGN KEY (Snum) REFERENCES SalesPeople(Snum)
);

insert into  Orders VALUES
(3001, 18.69, '1990-10-03', 2008, 1007),
(3003, 767.19, '1990-10-03', 2001, 1001),
(3002, 1900.10, '1990-10-03', 2007, 1004),
(3005, 5160.45, '1990-10-03', 2003, 1002),
(3006, 1098.16, '1990-10-03', 2008, 1007),
(3009, 1713.23, '1990-10-04', 2002, 1003),
(3007, 75.75, '1990-10-04', 2004, 1002),
(3008, 4273.00, '1990-10-05', 2006, 1001),
(3010, 1309.95, '1990-10-06', 2004, 1002),
(3011, 9891.88, '1990-10-06', 2006, 1001);

select * from Orders;

-- Q1) Count the number of Salesperson whose name begin with ‘a’/’A’.
-- Solution:
select count(*) from SalesPeople 
where Sname like "%A" or "%a";

-- Q2) Display all the Salesperson whose all orders worth is more than Rs. 2000.
-- Solution:
SELECT Snum, Sname, City, Comm
FROM SalesPeople 
WHERE Snum IN (
    SELECT Snum
    FROM Orders 
    GROUP BY Snum
    HAVING SUM(Amt) > 2000
);

-- Q3) Count the number of Salesperson belonging to Newyork.
-- Solution:
SELECT COUNT(*)
FROM SalesPeople
WHERE City = 'Newyork';

-- Q4) Display the number of Salespeople belonging to London and belonging to Paris.
-- Solution:
SELECT City, COUNT(*) as NumberOfSalespeople
FROM SalesPeople
WHERE City IN ('London', 'Paris')
GROUP BY City;

-- Q5) Display the number of orders taken by each Salesperson and their date of orders.
-- Solution:
SELECT S.Snum, S.Sname, O.Odate, COUNT(*) AS NumberOfOrders
FROM SalesPeople as S
JOIN Orders as O ON S.Snum = O.Snum
GROUP BY S.Snum, S.Sname, O.Odate
ORDER BY S.Snum, O.Odate;

