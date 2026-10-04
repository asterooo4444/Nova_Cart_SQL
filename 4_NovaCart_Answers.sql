USE NovaCartDB;
GO

-- Mission 1
SELECT * FROM Customers;
SELECT product_name, category_id, price FROM Products;
SELECT * FROM Products WHERE price > 5000;
SELECT * FROM Customers ORDER BY join_date DESC;
SELECT COUNT(*) AS total_customers FROM Customers;

-- Mission 2
SELECT AVG(price) AS average_product_price FROM Products;
SELECT MAX(price) AS highest_price, MIN(price) AS lowest_price FROM Products;
SELECT SUM(stock_quantity) AS total_available_stock FROM Products;
SELECT SUM(payment_amount) AS total_payment_amount FROM Payments;
SELECT status, COUNT(*) AS order_count FROM Orders GROUP BY status;
SELECT payment_method, SUM(payment_amount) AS total_amount
FROM Payments GROUP BY payment_method;

-- Mission 3
SELECT o.order_id, SUM(od.quantity * od.unit_price) AS total_sales
FROM Orders o JOIN OrderDetails od ON o.order_id = od.order_id
GROUP BY o.order_id;

SELECT o.order_id, SUM(od.quantity * od.unit_price) AS total_sales
FROM Orders o JOIN OrderDetails od ON o.order_id = od.order_id
GROUP BY o.order_id
HAVING SUM(od.quantity * od.unit_price) > 5000;

SELECT o.order_id, c.full_name, o.order_date, o.status
FROM Orders o JOIN Customers c ON o.customer_id = c.customer_id;

SELECT od.order_id, p.product_name, od.quantity, od.unit_price
FROM OrderDetails od JOIN Products p ON od.product_id = p.product_id
ORDER BY od.order_id;

SELECT c.customer_id, c.full_name,
       COALESCE(SUM(p.payment_amount),0) AS total_spent
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
LEFT JOIN Payments p ON o.order_id = p.order_id
GROUP BY c.customer_id, c.full_name;

-- Mission 4
SELECT p.product_id, p.product_name, COUNT(r.review_id) AS review_count
FROM Products p LEFT JOIN Reviews r ON p.product_id = r.product_id
GROUP BY p.product_id, p.product_name;

SELECT r.review_id, c.full_name, p.product_name, r.rating, r.comment, r.review_date
FROM Reviews r
JOIN Customers c ON r.customer_id = c.customer_id
JOIN Products p ON r.product_id = p.product_id;

SELECT DISTINCT c.*
FROM Customers c JOIN Orders o ON c.customer_id = o.customer_id;

SELECT p.*
FROM Products p
WHERE NOT EXISTS (
    SELECT 1 FROM OrderDetails od WHERE od.product_id = p.product_id
);

SELECT p.*
FROM Products p
WHERE NOT EXISTS (
    SELECT 1 FROM Reviews r WHERE r.product_id = p.product_id
);

SELECT c.customer_id, c.full_name, COUNT(o.order_id) AS order_count
FROM Customers c LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name;

-- Mission 5
WITH CustomerOrders AS (
    SELECT c.customer_id, c.full_name, COUNT(o.order_id) AS order_count
    FROM Customers c
    JOIN Orders o ON c.customer_id = o.customer_id
    GROUP BY c.customer_id, c.full_name
)
SELECT *
FROM CustomerOrders
WHERE order_count > (SELECT AVG(CAST(order_count AS DECIMAL(10,2))) FROM CustomerOrders);

SELECT *
FROM Products
WHERE price > (SELECT AVG(price) FROM Products);

-- Mission 6
WITH MonthlyRevenue AS (
    SELECT YEAR(p.payment_date) AS revenue_year,
           MONTH(p.payment_date) AS revenue_month,
           SUM(p.payment_amount) AS total_revenue
    FROM Payments p
    GROUP BY YEAR(p.payment_date), MONTH(p.payment_date)
)
SELECT * FROM MonthlyRevenue
ORDER BY revenue_year, revenue_month;

WITH CustomerSpending AS (
    SELECT c.customer_id, c.full_name, COALESCE(SUM(p.payment_amount),0) AS total_spending
    FROM Customers c
    JOIN Orders o ON c.customer_id = o.customer_id
    JOIN Payments p ON o.order_id = p.order_id
    GROUP BY c.customer_id, c.full_name
)
SELECT * FROM CustomerSpending
WHERE total_spending > 10000;

WITH CustomerSpending AS (
    SELECT c.customer_id, c.full_name, SUM(p.payment_amount) AS total_spending
    FROM Customers c
    JOIN Orders o ON c.customer_id = o.customer_id
    JOIN Payments p ON o.order_id = p.order_id
    GROUP BY c.customer_id, c.full_name
)
SELECT *
FROM CustomerSpending
WHERE total_spending > (SELECT AVG(total_spending) FROM CustomerSpending);

-- Mission 7
WITH CustomerSpending AS (
    SELECT c.customer_id, c.full_name, COALESCE(SUM(p.payment_amount),0) AS total_spending
    FROM Customers c
    LEFT JOIN Orders o ON c.customer_id = o.customer_id
    LEFT JOIN Payments p ON o.order_id = p.order_id
    GROUP BY c.customer_id, c.full_name
)
SELECT *, RANK() OVER (ORDER BY total_spending DESC) AS spending_rank
FROM CustomerSpending;

WITH ProductSales AS (
    SELECT p.product_id, p.product_name, COALESCE(SUM(od.quantity),0) AS total_quantity_sold
    FROM Products p LEFT JOIN OrderDetails od ON p.product_id = od.product_id
    GROUP BY p.product_id, p.product_name
)
SELECT *, DENSE_RANK() OVER (ORDER BY total_quantity_sold DESC) AS quantity_rank
FROM ProductSales;

SELECT payment_id, payment_date, payment_amount,
       LAG(payment_amount) OVER (ORDER BY payment_date, payment_id) AS previous_payment_amount
FROM Payments;

SELECT payment_id, payment_date, payment_amount,
       SUM(payment_amount) OVER (
           ORDER BY payment_date, payment_id
           ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
       ) AS running_total
FROM Payments;

-- Mission 8
CREATE VIEW vw_revenue_by_month AS
SELECT YEAR(payment_date) AS revenue_year,
       MONTH(payment_date) AS revenue_month,
       SUM(payment_amount) AS monthly_revenue
FROM Payments
GROUP BY YEAR(payment_date), MONTH(payment_date);
GO

CREATE VIEW vw_best_selling_products AS
SELECT p.product_name,
       COALESCE(SUM(od.quantity),0) AS total_quantity_sold,
       COALESCE(SUM(od.quantity * od.unit_price),0) AS total_revenue
FROM Products p
LEFT JOIN OrderDetails od ON p.product_id = od.product_id
GROUP BY p.product_name;
GO

CREATE VIEW vw_customer_summary AS
SELECT c.full_name,
       COUNT(DISTINCT o.order_id) AS number_of_orders,
       COALESCE(SUM(p.payment_amount),0) AS total_amount_spent
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
LEFT JOIN Payments p ON o.order_id = p.order_id
GROUP BY c.customer_id, c.full_name;
GO
