DROP DATABASE IF EXISTS storage;
CREATE DATABASE storage;
USE storage;

DROP TABLE IF EXISTS product;

CREATE TABLE product (
                         code INT PRIMARY KEY AUTO_INCREMENT,
                         name VARCHAR(50) NOT NULL,
                         description VARCHAR(255),
                         price DECIMAL(10, 2) DEFAULT 0.00,
                         quantity INT DEFAULT 0
);

CREATE TABLE users (
                       code INT PRIMARY KEY AUTO_INCREMENT,
                       name VARCHAR(50) NOT NULL,
                       surname VARCHAR(50) NOT NULL,
                       date_of_birth DATE,
                       email VARCHAR(100) NOT NULL,
                       password VARCHAR(255) NOT NULL,
                       user_type ENUM('venditore', 'privato','admin') NOT NULL,
                       partita_iva VARCHAR(30),
                       CF VARCHAR(30)
);


INSERT INTO product values (1,"Milky Way","Barretta di cioccolato, con  cuore di caramello e fudge",3,100);
INSERT INTO product values (2,"David Seeds","Semi di girasole tostati e salati",6,60);
INSERT INTO product values (3,"Beef Jerky","Carne essiccata, snack ideale per i lunghi viaggi. È ricca di proteine e sapore! ",12,59);
INSERT INTO product values (4,"Nerds","Piccole caramelle colorate e croccanti",2,500);
INSERT INTO product values (5,"Hershey’s Bar","Una barretta al cioccolato con crema e biscotti",4,150);
INSERT INTO product values (6,"Doritos Tangy Cheese","Tortillas al formaggio",3.5,70);


