use BookStoreDB;

CREATE TABLE country (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(100) NOT NULL
);

CREATE TABLE address_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL
);

CREATE TABLE shipping_method (
    shipping_method_id INT AUTO_INCREMENT PRIMARY KEY,
    method_name VARCHAR(100) NOT NULL
);

CREATE TABLE address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    street VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    zip_code VARCHAR(20),
    country_id INT,
    status_id INT,
    FOREIGN KEY (country_id) REFERENCES country(country_id),
    FOREIGN KEY (status_id) REFERENCES address_status(status_id)
);

CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    date_of_birth DATE
);

CREATE TABLE customer_address (
    customer_address_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    address_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id)
);

CREATE TABLE author (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    bio TEXT
);

CREATE TABLE publisher (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    publisher_name VARCHAR(100) NOT NULL,
    contact_info TEXT
);

CREATE TABLE book_language (
    language_id INT AUTO_INCREMENT PRIMARY KEY,
    language_name VARCHAR(50) NOT NULL
);

CREATE TABLE book (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    isbn VARCHAR(20) NOT NULL,
    publisher_id INT,
    language_id INT,
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL,
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id),
    FOREIGN KEY (language_id) REFERENCES book_language(language_id)
);

CREATE TABLE book_author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);

CREATE TABLE order_status (
    order_status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL
);

CREATE TABLE cust_order (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_status_id INT,
    shipping_method_id INT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (order_status_id) REFERENCES order_status(order_status_id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(shipping_method_id)
);

CREATE TABLE order_line (
    order_line_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    book_id INT,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);

CREATE TABLE order_history (
    order_history_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    status_id INT,
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (status_id) REFERENCES order_status(order_status_id)
);

INSERT INTO country (country_name) VALUES 
('Kenya'), 
('Uganda'), 
('Tanzania');

INSERT INTO address_status (status_name) VALUES 
('Active'), 
('Inactive');

INSERT INTO shipping_method (method_name) VALUES 
('Standard Shipping'), 
('Express Delivery'), 
('Same Day Delivery');

INSERT INTO address (street, city, zip_code, country_id, status_id) VALUES 
('123 Main St', 'Nairobi', '00100', 1, 1),
('456 Kampala Rd', 'Kampala', '00200', 2, 1),
('789 Uhuru St', 'Dar es Salaam', '00300', 3, 2);

INSERT INTO customer (first_name, last_name, email, phone, date_of_birth) VALUES 
('Alice', 'Mwangi', 'alice@gmail.com', '0712345678', '1995-05-12'),
('Brian', 'Okoth', 'brian@example.com', '0723456789', '1990-10-25');

INSERT INTO customer_address (customer_id, address_id) VALUES 
(1, 1), 
(2, 2);

INSERT INTO author (first_name, last_name, bio)
VALUES ('Chinua', 'Achebe', 'Famous Nigerian novelist'),
       ('Ngugi', 'Wa Thiongo', 'Kenyan writer and academic');
       
INSERT INTO publisher (publisher_name, contact_info)
VALUES ('East African Publishers', 'Nairobi, Kenya'),
       ('African Writers Trust', 'Kampala, Uganda');  
       
INSERT INTO book_language (language_name)
VALUES ('English'), ('Swahili');

INSERT INTO book (title, isbn, publisher_id, language_id, price, stock)
VALUES ('Things Fall Apart', '1234567890', 1, 1, 950.00, 20),
       ('Decolonising the Mind', '0987654321', 2, 1, 850.00, 15);
       
INSERT INTO book_author (book_id, author_id)
VALUES (1, 1), (2, 2);

INSERT INTO order_status (status_name)
VALUES ('Pending'), ('Shipped'), ('Delivered'), ('Cancelled');

INSERT INTO cust_order (customer_id, order_status_id, shipping_method_id)
VALUES (1, 1, 1), (2, 3, 2);

INSERT INTO order_line (order_id, book_id, quantity, price)
VALUES (1, 1, 1, 950.00),
       (2, 2, 2, 1700.00);
       
INSERT INTO order_history (order_id, status_id)
VALUES (1, 1), (2, 3);       

