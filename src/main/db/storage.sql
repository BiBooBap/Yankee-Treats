DROP DATABASE IF EXISTS storage;
CREATE DATABASE storage;
USE storage;

DROP TABLE IF EXISTS product;

CREATE TABLE product (
                         code int primary key AUTO_INCREMENT,
                         name char(50) not null,
                         description char(100),
                         price int default 0,
                         quantity int default 0,
                         bestseller	TINYINT(1),
                         dolce			TINYINT(1),
                         salato		TINYINT(1),
                         bevanda		TINYINT(1),
                         trend			TINYINT(1),
                         novita		TINYINT(1),
                         offerta		TINYINT(1),
                         bundle		TINYINT(1),
                         B2B        TINYINT(1),
                         active 	TINYINT(1) DEFAULT 1
);


-- Bestseller = 1 	| il prodotto è anche un bestseller
-- Trend = 1 		| il prodotto è anche un trend
-- Novità = 1 		| il prodotto è anche una novità
-- Offerta = 1 		| il prodotto è anche in offertà

-- Da qui in giù inserire esclusivamente 1 per l'attributo indicato nel commento + uno o più degli attributi riportati sopra dalle linee 24 a 27
-- (code esiste anche se non specificato)

-- Dolci
INSERT INTO product (name, description, price, quantity, dolce, bestseller, trend, novita, offerta)
VALUES
    ('Reeses Peanut Butter Cups', 'Caramella al burro di arachidi e cioccolato', 2, 100, 1, 0, 1, 0, 0),
    ('Hersheys White Chocolate Bar', 'Barretta di cioccolato bianco al latte', 1.50, 150, 1, 1, 0, 0, 0),
    ('Oreo Mint Cookies', 'Biscotto al gusto di menta e cioccolato', 3, 80, 1, 0, 1, 1, 0),
    ('Twinkies', 'Torta snack soffice e farcita con crema', 1.75, 120, 1, 0, 2, 0, 0),
    ('Pop-Tarts', 'Pasticcini rettangolari glassati al cioccolato', 2.25, 90, 1, 0, 0, 0, 1);

-- Salati
INSERT INTO product (name, description, price, quantity, salato, bestseller, trend, novita, offerta)
VALUES
    ('Lays Potato Chips', 'Classiche potato chips', 1.25, 200, 1, 0, 0, 0, 1),
    ('Cheetos Crunchy', 'Snack a base di mais e formaggio', 1.50, 150, 1, 1, 0, 0, 0),
    ('Doritos Nacho Cheese', 'Tortilla chips triangolari', 2, 120, 1, 0, 1, 0, 1),
    ('Pretzels', 'Snack salato a forma di ciambella', 1.75, 100, 1, 0, 0, 0, 1),
    ('Beef Jerky', 'Snack di carne essiccata e stagionata', 3, 80, 1, 0, 1, 1, 0);

-- Bevande
INSERT INTO product (name, description, price, quantity, bevanda, bestseller, trend, novita, offerta)
VALUES
    ('Coca-Cola', 'Classica bibita gassata', 2, 150, 1, 0, 0, 0, 0),
    ('Monster Energy Classic', 'Bevanda energetica ad alto contenuto di caffeina', 3, 100, 1, 1, 0, 0, 1),
    ('Monster Strawberry Kiwi', 'Bevanda energetica al gusto di fragola e kiwi', 3, 100, 1, 0, 1, 1, 0),
    ('Monster Energy Ultra Paradise', 'Bevanda energetica al gusto tropicale', 3, 100, 1, 1, 0, 0, 0),
    ('Monster Super Dry Nitro', 'Bibita gassata al gusto di arancia', 3, 100, 1, 0, 0, 0, 1),
    ('Mountain Dew Classic', 'Bibita gassata al gusto agrumato', 2, 120, 1, 0, 0, 0, 0),
    ('Mountain Dew Voltage', 'Bibita gassata al gusto di lampone e gingeng', 2, 120, 1, 1, 0, 0, 0),
    ('Mountain Dew Frost Bite', 'Bibita gassata al gusto di mirtillo e melone', 2, 120, 1, 0, 1, 0, 0),
    ('Mountain Dew Code Red', 'Bibita gassata al gusto di ciliegia', 2, 120, 1, 0, 1, 1, 0),
    ('Gatorade G Zero', 'Bevanda sportiva senza zuccheri e calorie', 2.50, 130, 1, 0, 0, 0, 1),
    ('Gatorade Fierce Grape', 'Bevanda sportiva al gusto di uva', 2.50, 130, 1, 1, 0, 0, 0),
    ('Gatorade Cucumber', 'Bevanda sportiva al gusto di cetriolo', 2.50, 130, 1, 0, 0, 1, 0),
    ('Arizona Half & Half Tropical Tea', 'Tè freddo dolce al gusto di tè nero e succo di mango', 2, 110, 1, 1, 0, 0, 0),
    ('Arizona Raspberry Flavor Tea', 'Tè freddo dolce al gusto di lampone', 2, 110, 1, 0, 1, 0, 0),
    ('Arizona Ginseng and Honey Tea', 'Tè freddo dolce al gusto di zenzero e limone', 2, 110, 1, 0, 0, 0, 0);

-- Bundle
INSERT INTO product (name, description, price, quantity, bundle, bestseller, trend, novita, offerta)
VALUES
    ('Gummy Bears Bundle', 'Assortimento di caramelle gommose americane', 5, 60, 1, 0, 0, 0, 1),
    ('Snack Mix Bundle', 'Varietà di snack salati americani', 8, 40, 1, 0, 0, 0, 0),
    ('Chocolate Sampler', 'Assortimento di barrette e dolci di cioccolato americani', 10, 30, 1, 0, 1, 0, 0),
    ('Soda Variety Pack', 'Assortimento di bibite gassate americane', 12, 20, 1, 0, 1, 0, 0),
    ('Energy Drink Combo', 'Varietà di bevande energetiche americane', 15, 15, 1, 1, 0, 0, 0);

-- Prodotti B2B
INSERT INTO product(name, description, price, quantity, B2B)
VALUES
    ('Chips Stock', '50 unità di potato chips di marche diverse di rilievo', 250, 70, 1),
    ('Soda Stock', '50 unità di bibite gassate di marche diverse di rilievo', 250, 65, 1),
    ('Chocolate Stock', '50 unità di confezioni di cioccolato di marche diverse di rilievo', 220, 80, 1);

CREATE TABLE users (
                       code INT PRIMARY KEY AUTO_INCREMENT,
                       name VARCHAR(50),
                       surname VARCHAR(50),
                       date_of_birth DATE,
                       email VARCHAR(60) UNIQUE NOT NULL,
                       password VARCHAR(60) NOT NULL,
                       user_type ENUM('venditore', 'privato', 'admin', 'guest') NOT NULL,
                       partita_iva VARCHAR(30),
                       CF VARCHAR(30),
                       UNIQUE KEY (email)
);


INSERT INTO users (name, surname, date_of_birth, email, password, user_type, partita_iva, CF)
VALUES ('Null', 'Null', '01-01-01', 'yankeetreats.confirm@gmail.com', '$2a$10$JUHkIAHbObWPDztGMuSuBuGfnaM7vrAU9ZjsT3yUrmkBAldUPO6BS', 'admin', NULL, NULL); /*YankeeTreats2024*/


CREATE TABLE billing_addresses (
                                   address_id INT PRIMARY KEY AUTO_INCREMENT,
                                   user_code INT,
                                   street VARCHAR(255),
                                   city VARCHAR(100),
                                   province VARCHAR(100),
                                   zip VARCHAR(20),
                                   active 	TINYINT(1) DEFAULT 1,
                                   FOREIGN KEY (user_code) REFERENCES users(code)
);

CREATE TABLE delivery_addresses (
                                    address_id INT PRIMARY KEY AUTO_INCREMENT,
                                    user_code INT,
                                    country VARCHAR(100),
                                    zip VARCHAR(20),
                                    city VARCHAR(100),
                                    street VARCHAR(255),
                                    province VARCHAR(100),
                                    active 	TINYINT(1) DEFAULT 1,
                                    FOREIGN KEY (user_code) REFERENCES users(code)
);

CREATE TABLE payment_method (
                                card_id INT PRIMARY KEY AUTO_INCREMENT,
                                user_code INT,
                                card_number VARCHAR(20) NOT NULL,
                                expiry_month TINYINT CHECK (expiry_month BETWEEN 1 AND 12),
                                expiry_year YEAR,
                                cvv VARCHAR(3),
                                cardholder_name VARCHAR(100),
                                active 	TINYINT(1) DEFAULT 1,
                                FOREIGN KEY (user_code) REFERENCES users(code)
);

CREATE TABLE orders (
                        order_id INT PRIMARY KEY AUTO_INCREMENT,
                        user_code INT,
                        payment_card_id INT,
                        delivery_address_id INT,
                        billing_address_id INT,
                        total_cost DECIMAL(10, 2),
                        order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                        FOREIGN KEY (user_code) REFERENCES users(code),
                        FOREIGN KEY (payment_card_id) REFERENCES payment_method(card_id),
                        FOREIGN KEY (delivery_address_id) REFERENCES delivery_addresses(address_id),
                        FOREIGN KEY (billing_address_id) REFERENCES billing_addresses(address_id)
);

CREATE TABLE order_items (
                             order_item_id INT PRIMARY KEY AUTO_INCREMENT,
                             order_id INT,
                             product_code INT,
                             product_name char(50) not null,
                             product_description char(100),
                             product_price int default 0,
                             quantity INT,
                             FOREIGN KEY (order_id) REFERENCES orders(order_id),
                             FOREIGN KEY (product_code) REFERENCES product(code)
);


-- sb-0lgkm31358344@personal.example.com
-- 0%P6o4nQ