use Northwind
-- cleaning---

--Quations--

select * from Customers
--1.	Show the list of all customers from 'Germany?
select * from Customers
where Country = 'Germany'

--2.	What are the names of the products supplied by 'Exotic Liquid' ?
select productname,suppliername
from Products as pro
inner join Suppliers as sup
on pro.SupplierID=sup.SupplierID
where SupplierName='Exotic Liquid'
select * from Customers
select * from orders
select * from OrderDetails
-- 3	Which employee has the most orders?
select top 1 emp.EmployeeID, concat(emp.FirstName,' ',emp.LastName )As Full_name,count(*)AS Order_count
from Employees as emp
join Orders as o
on emp.EmployeeID=o.EmployeeID

group by emp.EmployeeID,emp.FirstName,emp.LastName
order by Order_count desc

--4-	List the products that have never been ordered?


select p.ProductID,productName
from Products as p
left join OrderDetails as o
on p.ProductID=p.ProductID
where o.ProductID is null 

--5--Calculate the total sales for each country ?

SELECT Customers.Country, SUM(OrderDetails.Quantity * Products.Price) AS TotalSales
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
JOIN Products ON OrderDetails.ProductID = Products.ProductID
GROUP BY Customers.Country;

--6--Show the top 5 products with the highest average order quantity?--


SELECT TOP 5 Products.ProductName, AVG(OrderDetails.Quantity) AS AvgOrderQuantity
FROM OrderDetails
 JOIN Products ON OrderDetails.ProductID = Products.ProductID
GROUP BY Products.ProductName
ORDER BY AvgOrderQuantity DESC;

--7 Identify products that are frequently ordered together  ?

WITH ProductPairs AS (
    SELECT 
        od1.ProductID AS ProductA,
        od2.ProductID AS ProductB,
        COUNT(*) AS PairCount
    FROM OrderDetails od1
    JOIN OrderDetails od2 
        ON od1.OrderID = od2.OrderID  -- Match orders
        AND od1.ProductID < od2.ProductID  -- Ensure pairs are not repeated (A, B and B, A)
    GROUP BY od1.ProductID, od2.ProductID
)
SELECT ProductA, ProductB, PairCount
FROM ProductPairs
ORDER BY PairCount DESC;
select * from Employees
--8-.	Calculate the average order value for each employee?

select emp.EmployeeID,firstName+' '+LastName As Full_name ,Avg(orderID) AS AVG_order
from Employees as emp
join Orders as o
on emp.EmployeeID=o.EmployeeID
group by emp.EmployeeID,FirstName,LastName

--9-	Which supplier provides the most expensive product?
select top 1 supplierName,Max(price) As MAx_price
from Suppliers as S
join Products as p
on s.SupplierID=p.SupplierID
group by SupplierName

--10-	Show the total quantity of each product sold?
select productName,sum(quantity) AS 'Total Quantity'
from Products as p
join OrderDetails as ord
on p.ProductID=ord.ProductID
group by ProductName

--11-	List all customers from countries that start with the letter 'S' ??
select customerName,country
from Customers
where Country like 'S%'

--12-  What is the total number of suppliers from each country? --
select  count(*)as 'Total Suplliers' ,country 
from Suppliers
group by Country
order by Country desc 

--13--	 What are the total sales per employee per year ?


SELECT 
    Employees.EmployeeID, 
    YEAR(Orders.OrderDate) AS Year, 
    SUM(OrderDetails.Quantity * Products.Price) AS TotalSales
FROM Orders
JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
JOIN Products ON OrderDetails.ProductID = Products.ProductID
GROUP BY Employees.EmployeeID, YEAR(Orders.OrderDate)
ORDER BY Employees.EmployeeID, Year;

--14-Calculate the total sales for each Cateegory ? 

select CategoryName,Sum(Quantity*Price) As 'TotalSales'
from OrderDetails as o
join products as p
on o.ProductID=p.ProductID
join Categories as c
on p.CategoryID=c.CategoryID
group by CategoryName
order by TotalSales Desc




-- Creating Realtion Betwwen Tables --

SELECT        Orders.OrderID, Customers.CustomerID, Employees.EmployeeID, Products.ProductID, OrderDetails.OrderDetailID, Suppliers.SupplierID, Categories.CategoryID, Shippers.ShipperID, Customers.City, Customers.Country, 
                         Employees.LastName, Employees.FirstName, OrderDetails.Quantity, Products.Unit, Products.Price, Suppliers.SupplierName, Shippers.ShipperName, Suppliers.City AS SupplierCity, Suppliers.Country AS SuppliersCountry, 
                         Categories.CategoryName
FROM            Orders INNER JOIN
                         Customers ON Orders.CustomerID = Customers.CustomerID INNER JOIN
                         Employees ON Orders.EmployeeID = Employees.EmployeeID INNER JOIN
                         OrderDetails ON Orders.OrderID = OrderDetails.OrderID INNER JOIN
                         Products ON OrderDetails.ProductID = Products.ProductID INNER JOIN
                         Categories ON Products.CategoryID = Categories.CategoryID INNER JOIN
                         Shippers ON Orders.ShipperID = Shippers.ShipperID INNER JOIN
                         Suppliers ON Products.SupplierID = Suppliers.SupplierID

---- Creating View Query --

Create view Northwindview As 

SELECT        Orders.OrderID, Customers.CustomerID, Employees.EmployeeID, Products.ProductID, OrderDetails.OrderDetailID, Suppliers.SupplierID, Categories.CategoryID, Shippers.ShipperID, Customers.City As CustomersCity , Customers.Country AS CustomersCountry, 
                         Employees.LastName, Employees.FirstName, OrderDetails.Quantity, Products.Unit, Products.Price, Suppliers.SupplierName, Shippers.ShipperName, Suppliers.City AS SupplierCity, Suppliers.Country AS SuppliersCountry, 
                         Categories.CategoryName
FROM            Orders INNER JOIN
                         Customers ON Orders.CustomerID = Customers.CustomerID INNER JOIN
                         Employees ON Orders.EmployeeID = Employees.EmployeeID INNER JOIN
                         OrderDetails ON Orders.OrderID = OrderDetails.OrderID INNER JOIN
                         Products ON OrderDetails.ProductID = Products.ProductID INNER JOIN
                         Categories ON Products.CategoryID = Categories.CategoryID INNER JOIN
                         Shippers ON Orders.ShipperID = Shippers.ShipperID INNER JOIN
                         Suppliers ON Products.SupplierID = Suppliers.SupplierID

						 select * from Northwindview












-- 



