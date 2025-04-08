create database boutique;
use boutique;

    CREATE TABLE Customers (
    customer_id int PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    address varchar(50),
    date_joined TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
select * from Customers;

CREATE TABLE Orders (
    order_id int PRIMARY KEY,
    customer_id INT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10, 2) NOT NULL,
    order_status ENUM('Pending', 'Completed', 'Cancelled', 'Shipped') DEFAULT 'Pending',
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
select * from Orders;

CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    category VARCHAR(100),
    price int NOT NULL,
    stock_quantity INT DEFAULT 0,
    supplier_id INT,
    description varchar(50),
    date_added TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

select * from Products;

CREATE TABLE Suppliers (
    supplier_id INT PRIMARY KEY,
    supplier_name VARCHAR(255) NOT NULL,
    contact_person VARCHAR(255),
    contact_number VARCHAR(15),
    email VARCHAR(100),
    address varchar(60)
);

select * from Suppliers;

INSERT INTO Suppliers (supplier_id, supplier_name, contact_person, contact_number, email, address)
VALUES
(1, 'abc Supplies', 'Priya', '1223456789', 'priya@gmail.com', 'Madipakkam, Chennai'),
(2, 'XYZ Distributors', 'Prathee', '1234567890', 'prathee@gmail.com', 'Ranikunta, Andhra Pradesh'),
(3, 'Global Importers', 'Ramya', '2345678901', 'ramya@gmail.com', 'Nanmangalam, Chennai');

INSERT INTO Products (product_name, category, price, stock_quantity, supplier_id, description)
VALUES
('Floral Summer Dress', 'Clothing', 49.99, 30, 1, 'A lightweight, floral dress perfect for summer outings'),
('Leather Handbag', 'Accessories', 89.99, 15, 2, 'Stylish leather handbag with adjustable strap and spacious interior'),
('High Heels', 'Footwear', 59.99, 25, 3, 'Elegant high heels with a 4-inch stiletto heel'),
('Cotton T-shirt', 'Clothing', 19.99, 100, 1, 'Soft cotton t-shirt, available in various colors'),
('Perfume Set', 'Beauty', 39.99, 50, 2, 'A luxury perfume set with three different fragrances'),
('Sunglasses', 'Accessories', 24.99, 80, 3, 'Chic sunglasses with UV protection and stylish frame'),
('Cashmere Sweater', 'Clothing', 119.99, 20, 1, 'Premium cashmere sweater, soft and warm for winter'),
('Nail Polish Kit', 'Beauty', 15.99, 60, 2, 'A set of 6 nail polishes in trendy colors for all seasons'),
('Ballet Flats', 'Footwear', 39.99, 40, 3, 'Comfortable ballet flats with soft leather and padded insoles'),
('Chunky Knit Scarf', 'Accessories', 29.99, 50, 1, 'Cozy chunky knit scarf in neutral colors to match any outfit');

INSERT INTO Customers (customer_id, first_name, last_name, email, phone, address)
VALUES
(1, 'Priya', 'S', 'priyas@gmail.com', '1212121212', '123 Main St, Cityville'),
(2, 'Prathee', 'S', 'prathee@gmail.com', '2727272727', '456 Oak Rd, Townsville'),
(3, 'Ramya', 'Bn', 'ramyab@gmail.com', '1919191919', '789 Pine Ave, Villagetown'),
(4, 'Varsha', 'S', 'varshas@gmail.com', '1010101010', '101 Birch St, Cityville'),
(5, 'Roja', 'A.C', 'rojaac@gmail.com', '1111111111', '303 Elm St, Villagetown'),
(6, 'Savitha', 'E' 'savie@gmail.com', '0123456789', 'Medavakkam, Chennai'),
(7, 'Jayashree', 'G', 'jaya@gmail.com', '2424242424', '404 Maple St, Cityville'),
(8, 'Praveena', 'V', 'praveena@gmail.com', '9999999999', '505 Oak St, Townsville');

INSERT INTO Orders (order_id, customer_id, total_amount, order_status)
VALUES
(1, 101, 129.99, 'Pending'),
(2, 102, 89.99, 'Completed'),
(3, 103, 249.99, 'Shipped'),
(4, 104, 59.99, 'Cancelled'),
(5, 105, 199.99, 'Completed'),
(6, 106, 79.99, 'Pending'),
(7, 107, 319.99, 'Shipped'),
(8, 108, 159.99, 'Pending');

select * from Orders;

--------------- ADD NEW PRODUCTS

DELIMITER //
CREATE PROCEDURE AddProduct(
    IN p_product_name VARCHAR(45),
    IN p_category VARCHAR(50),
    IN p_price DECIMAL(10, 2),
    IN p_stock_quantity INT,
    IN p_supplier_id INT,
    IN p_description VARCHAR(100)
)
BEGIN
    INSERT INTO Products (Product_name, Category, Price, Stock_quantity, Supplier_id, Description)
    VALUES (p_product_name, p_category, p_price, p_stock_quantity, p_supplier_id, p_description);
END //
DELIMITER ;

--------------- UPDATE PRODUCTS STOCK

DELIMITER //
CREATE PROCEDURE UpdateProductStock(
    IN p_product_id INT,
    IN p_stock_quantity INT
)
BEGIN
    UPDATE Products
    SET Stock_quantity = p_stock_quantity
    WHERE Product_id = p_product_id;
END //
DELIMITER ;

-------------- GET PRODUCT DETAIL

DELIMITER //
CREATE PROCEDURE GetProductDetail(
    IN p_product_id INT
)
BEGIN
    SELECT * FROM Products WHERE Product_id = p_product_id;
END //
DELIMITER ;

---------------- ADD NEW SUPPLIERS

DELIMITER //
CREATE PROCEDURE AddSupplier(
    IN p_supplier_name VARCHAR(50),
    IN p_contact_name VARCHAR(255),
    IN p_phone VARCHAR(15),
    IN p_email VARCHAR(25),
    IN p_address VARCHAR(50)
)
BEGIN
    INSERT INTO Suppliers (Supplier_name, Contact_name, Phone, email, address)
    VALUES (p_supplier_name, p_contact_name, p_phone, p_email, p_address);
END //
DELIMITER ;

------------- UPDATE SUPPLIERS DETAILS

DELIMITER //
CREATE PROCEDURE UpdateSupplier(
    IN p_supplier_id INT,
    IN p_supplier_name VARCHAR(50),
    IN p_contact_name VARCHAR(255),
    IN p_phone VARCHAR(15),
    IN p_email VARCHAR(25),
    IN p_address VARCHAR(50)
)
BEGIN
    UPDATE Suppliers
    SET Supplier_name = p_supplier_name, 
        Contact_name = p_contact_name,
        Phone = p_phone,
        email = p_email,
        address = p_address
    WHERE Supplier_id = p_supplier_id;
END //
DELIMITER ;

------------- ADD NEW CUSTOMERS

DELIMITER //
CREATE PROCEDURE AddCustomer(
    IN p_first_name VARCHAR(100),
    IN p_last_name VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_phone VARCHAR(15),
    IN p_address VARCHAR(50)
)
BEGIN
    INSERT INTO Customers (first_name, last_name, email, phone, address)
    VALUES (p_first_name, p_last_name, p_email, p_phone, p_address);
END //
DELIMITER ;

------------------- Update Customer Information

DELIMITER //
CREATE PROCEDURE UpdateCustomer(
    IN p_customer_id INT,
    IN p_first_name VARCHAR(100),
    IN p_last_name VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_phone VARCHAR(15),
    IN p_address VARCHAR(50)
)
BEGIN
    UPDATE Customers
    SET first_name = p_first_name, 
        last_name = p_last_name, 
        email = p_email,
        phone = p_phone,
        address = p_address
    WHERE customer_id = p_customer_id;
END //
DELIMITER ;

-------------------- Create an Order

DELIMITER //
CREATE PROCEDURE CreateOrder(
    IN p_customer_id INT,
    IN p_total_amount DECIMAL(10, 2)
)
BEGIN
    INSERT INTO Orders (customer_id, total_amount, order_status)
    VALUES (p_customer_id, p_total_amount, 'Pending');
END //
DELIMITER ;

---------------------- Update Order Status

DELIMITER //
CREATE PROCEDURE UpdateOrderStatus(
    IN p_order_id INT,
    IN p_status ENUM('Pending', 'Completed', 'Cancelled', 'Shipped')
)
BEGIN
    UPDATE Orders
    SET order_status = p_status
    WHERE order_id = p_order_id;
END //
DELIMITER ;

------------------- Delete Product

DELIMITER //
CREATE PROCEDURE DeleteProduct(
    IN p_product_id INT
)
BEGIN
    DELETE FROM Products WHERE Product_id = p_product_id;
END //
DELIMITER ;










