CREATE DATABASE NovaCartDB;
GO
USE NovaCartDB;
GO

CREATE TABLE Customers (
    customer_id INT IDENTITY(1,1) PRIMARY KEY,
    full_name NVARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    phone VARCHAR(20) NOT NULL,
    home_address NVARCHAR(250) NOT NULL,
    join_date DATE NOT NULL
);

CREATE TABLE Categories (
    category_id INT IDENTITY(1,1) PRIMARY KEY,
    category_name NVARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Products (
    product_id INT IDENTITY(1,1) PRIMARY KEY,
    product_name NVARCHAR(150) NOT NULL,
    category_id INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT NOT NULL,
    CONSTRAINT FK_Products_Categories FOREIGN KEY (category_id) REFERENCES Categories(category_id),
    CONSTRAINT CK_Products_Price CHECK (price >= 0),
    CONSTRAINT CK_Products_Stock CHECK (stock_quantity >= 0)
);

CREATE TABLE Orders (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL,
    CONSTRAINT FK_Orders_Customers FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    CONSTRAINT CK_Orders_Status CHECK (status IN ('Pending','Shipped','Delivered','Cancelled'))
);

CREATE TABLE OrderDetails (
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    CONSTRAINT PK_OrderDetails PRIMARY KEY (order_id, product_id),
    CONSTRAINT FK_OrderDetails_Orders FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    CONSTRAINT FK_OrderDetails_Products FOREIGN KEY (product_id) REFERENCES Products(product_id),
    CONSTRAINT CK_OrderDetails_Quantity CHECK (quantity > 0),
    CONSTRAINT CK_OrderDetails_UnitPrice CHECK (unit_price >= 0)
);

CREATE TABLE Payments (
    payment_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT NOT NULL UNIQUE,
    payment_date DATE NOT NULL,
    payment_amount DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(30) NOT NULL,
    CONSTRAINT FK_Payments_Orders FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    CONSTRAINT CK_Payments_Amount CHECK (payment_amount >= 0),
    CONSTRAINT CK_Payments_Method CHECK (payment_method IN ('Credit Card','PayPal','Cash on Delivery'))
);

CREATE TABLE Reviews (
    review_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    rating INT NOT NULL,
    comment NVARCHAR(500) NULL,
    review_date DATE NOT NULL,
    CONSTRAINT FK_Reviews_Customers FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    CONSTRAINT FK_Reviews_Products FOREIGN KEY (product_id) REFERENCES Products(product_id),
    CONSTRAINT CK_Reviews_Rating CHECK (rating BETWEEN 1 AND 5)
);
GO
