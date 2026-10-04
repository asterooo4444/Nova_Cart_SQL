USE NovaCartDB;
GO

INSERT INTO Categories (category_name) VALUES
('Electronics'),('Fashion'),('Home Appliances'),('Books'),('Accessories'),
('Gaming'),('Mobile'),('Computers'),('Office'),('Smart Home');

INSERT INTO Customers (full_name,email,phone,home_address,join_date) VALUES
('Ahmed Hassan','ahmed.hassan@example.com','01010000001','Cairo','2026-01-05'),
('Omar Ali','omar.ali@example.com','01010000002','Giza','2026-01-10'),
('Mariam Samir','mariam.samir@example.com','01010000003','Alexandria','2026-01-15'),
('Youssef Adel','youssef.adel@example.com','01010000004','Mansoura','2026-02-01'),
('Salma Tarek','salma.tarek@example.com','01010000005','Zagazig','2026-02-12'),
('Karim Mostafa','karim.mostafa@example.com','01010000006','Tanta','2026-02-20'),
('Nour Ahmed','nour.ahmed@example.com','01010000007','Ismailia','2026-03-03'),
('Hana Mahmoud','hana.mahmoud@example.com','01010000008','Port Said','2026-03-15'),
('Amr Khaled','amr.khaled@example.com','01010000009','Suez','2026-04-01'),
('Laila Nabil','laila.nabil@example.com','01010000010','Cairo','2026-04-12');

INSERT INTO Products (product_name,category_id,price,stock_quantity) VALUES
('Laptop Pro 15',8,32000,8),
('Wireless Headphones',1,4500,25),
('Smart Watch',7,6500,18),
('Office Chair',9,5200,12),
('SQL Fundamentals Book',4,900,40),
('Gaming Keyboard',6,2800,20),
('USB-C Hub',5,1800,30),
('Smart Speaker',10,3500,15),
('Smartphone X',7,18500,10),
('Air Fryer',3,7200,9);

INSERT INTO Orders (customer_id,order_date,status) VALUES
(1,'2026-04-15','Delivered'),
(1,'2026-05-02','Shipped'),
(2,'2026-05-05','Delivered'),
(3,'2026-05-10','Pending'),
(4,'2026-05-18','Delivered'),
(5,'2026-06-01','Cancelled'),
(6,'2026-06-07','Delivered'),
(7,'2026-06-15','Shipped'),
(8,'2026-07-01','Delivered'),
(9,'2026-07-12','Pending');

INSERT INTO OrderDetails (order_id,product_id,quantity,unit_price) VALUES
(1,1,1,30000),(1,2,2,4200),(2,3,1,6200),(2,6,2,2600),
(3,9,1,18000),(3,7,2,1700),(4,4,1,5000),(5,10,1,7000),
(5,5,3,850),(6,8,1,3300),(7,1,1,31000),(7,7,1,1750),
(8,2,1,4300),(8,6,1,2700),(9,3,2,6300),(9,5,2,900),
(10,4,1,5100);

INSERT INTO Payments (order_id,payment_date,payment_amount,payment_method) VALUES
(1,'2026-04-15',38400,'Credit Card'),
(2,'2026-05-02',11400,'PayPal'),
(3,'2026-05-05',21400,'Cash on Delivery'),
(4,'2026-05-10',5000,'Credit Card'),
(5,'2026-05-18',9550,'PayPal'),
(6,'2026-06-01',3300,'Cash on Delivery'),
(7,'2026-06-07',32750,'Credit Card'),
(8,'2026-06-15',7000,'PayPal'),
(9,'2026-07-01',14400,'Credit Card'),
(10,'2026-07-12',5100,'Cash on Delivery');

INSERT INTO Reviews (customer_id,product_id,rating,comment,review_date) VALUES
(1,1,5,'Excellent laptop','2026-04-20'),
(1,2,4,'Good sound quality','2026-04-21'),
(2,9,5,'Great phone','2026-05-12'),
(2,7,4,'Useful accessory','2026-05-13'),
(3,4,3,'Comfortable enough','2026-05-20'),
(4,10,5,'Works very well','2026-05-25'),
(5,5,4,'Helpful book','2026-06-05'),
(6,8,3,'Good speaker','2026-06-12'),
(7,1,5,'Very fast','2026-06-20'),
(8,3,4,'Nice watch','2026-07-05');
GO
