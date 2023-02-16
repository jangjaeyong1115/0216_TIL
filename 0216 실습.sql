-- 문제 1

select 
	productCode,productName,MSRP 
from 
	products 
where 
	MSRP > (select avg(MSRP) from products)
order by
	MSRP asc;
    
-- 문제2
SELECT customerNumber, customerName
FROM customers
WHERE customerNumber IN
    (
        SELECT customerNumber
        FROM orders
        WHERE orderDate BETWEEN '2003-01-06' AND '2003-03-26'
    )
ORDER BY customerNumber;

-- 문제 3
SELECT * FROM productlines;
SELECT * FROM products;

SELECT productCode , productName , productLine , MSRP
FROM products
WHERE productLine = 'Classic Cars' AND
    MSRP = (
    SELECT MAX(MSRP)
    FROM products
    );
    
-- 문제 4
SELECT customerNumber , customerName , country 
FROM customers
WHERE country = (
    SELECT MAX(country)
    FROM customers
)
ORDER BY
    customerNumber;
    
-- 문제 5
SELECT customerNumber, customerName, country
FROM customers
WHERE country = (
     -- 서브쿼리 안에서 리밋을 사용하기 위해 묶고 별칭
    SELECT * FROM (
    SELECT country
    FROM customers
    GROUP BY country
    HAVING count(country) 
    ORDER BY count(country) DESC
    LIMIT 1) as tmp)
ORDER BY customerNumber;

-- 문제 6
SELECT DISTINCT productCode , productName
FROM orderdetails
INNER JOIN orders USING (orderNumber)
INNER JOIN products USING (productCode)
WHERE year(orderDate) = '2004'
ORDER BY productCode DESC;