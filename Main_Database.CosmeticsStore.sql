DROP DATABASE IF EXISTS `cosmetics`;
CREATE DATABASE IF NOT EXISTS `cosmetics`;
USE `cosmetics`;

CREATE TABLE IF NOT EXISTS `department` (
    `department_id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(45) NOT NULL,
    `manager_id` INT NOT NULL,
    PRIMARY KEY (`department_id`),
    UNIQUE (`department_id`)
)  ENGINE=INNODB DEFAULT CHARACTER SET=UTF8MB4;


CREATE TABLE IF NOT EXISTS `Employee` (
    employee_id INT(10) NOT NULL,
    employee_name CHAR(25) NOT NULL,
    age INT(2) NOT NULL,
    phone_number NUMERIC(10) NOT NULL,
    email CHAR(30) NOT NULL,
    address CHAR(50) NOT NULL,
    salary FLOAT(5) NOT NULL,
    card_number VARCHAR(25) NOT NULL,
    position ENUM('manager', 'cashier', 'security', 'shop-assistent', 'marketing') DEFAULT NULL,
    department_id INT(10) NOT NULL,
    PRIMARY KEY (employee_id),
    CONSTRAINT did FOREIGN KEY (department_id)
        REFERENCES department (department_id)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    CHECK (age >= 18 AND age < 40)
)  ENGINE=INNODB DEFAULT CHARACTER SET=UTF8MB4;

CREATE TABLE IF NOT EXISTS brand (
    brand_name VARCHAR(25) NOT NULL,
    contact CHAR(25) NOT NULL,
    address CHAR(25) NOT NULL,
    category ENUM('makeup', 'hair care', 'skin care', 'body care', 'tools') DEFAULT NULL,
    PRIMARY KEY (brand_name)
)  ENGINE=INNODB DEFAULT CHARACTER SET=UTF8MB4;
 
CREATE TABLE IF NOT EXISTS products (
    name VARCHAR(40) NOT NULL,
    brandname VARCHAR(25) NOT NULL,
    expire_date DATE NOT NULL,
    produce_date DATE NOT NULL,
    product_description VARCHAR(90) NOT NULL,
    quantity INT(4) NOT NULL,
    price FLOAT(9) NOT NULL,
    product_id INT(9) NOT NULL,
    department_id INT(10) NOT NULL,
    PRIMARY KEY (product_id),
    CONSTRAINT bname FOREIGN KEY (brandname)
        REFERENCES brand (brand_name)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT depid FOREIGN KEY (department_id)
        REFERENCES department (department_id)
        ON DELETE NO ACTION ON UPDATE CASCADE
)  ENGINE=INNODB DEFAULT CHARACTER SET=UTF8MB4;

CREATE TABLE IF NOT EXISTS membership_clients (
    client_id INT(10) NOT NULL,
    client_name CHAR(25),
    address CHAR(50) NOT NULL,
    contact CHAR(40) NOT NULL,
    birthday DATE NOT NULL,
    points INT(5) NOT NULL,
    registration_date DATE NOT NULL,
    PRIMARY KEY (client_id)
)  ENGINE=INNODB DEFAULT CHARACTER SET=UTF8MB4;


CREATE TABLE IF NOT EXISTS invoice (
    invoice_id INT(10) NOT NULL AUTO_INCREMENT,
    balance FLOAT NOT NULL,
    date DATE NOT NULL,
    tax FLOAT NOT NULL,
    payment ENUM('cash', 'card') DEFAULT NULL,
    client_id INT(10),
    employee_id INT(10) NOT NULL,
    product_id INT(10) NOT NULL,
    PRIMARY KEY (invoice_id),
    CONSTRAINT clientid FOREIGN KEY (client_id)
        REFERENCES membership_clients (client_id)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FOREIGN KEY (employee_id)
        REFERENCES Employee (employee_id)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT productid FOREIGN KEY (product_id)
        REFERENCES products (product_id)
        ON DELETE NO ACTION ON UPDATE CASCADE
)  ENGINE=INNODB DEFAULT CHARACTER SET=UTF8MB4;

CREATE TABLE IF NOT EXISTS discounts (
    percentage FLOAT(3) NOT NULL,
    date DATE NOT NULL,
    duration DATE NOT NULL,
    product_id INT(10) NOT NULL,
    CONSTRAINT producttid FOREIGN KEY (product_id)
        REFERENCES products (product_id)
        ON DELETE NO ACTION ON UPDATE CASCADE
)  ENGINE=INNODB DEFAULT CHARACTER SET=UTF8MB4;

CREATE TABLE IF NOT EXISTS marketing (
    department_id INT NOT NULL AUTO_INCREMENT,
    employee_id INT(10) NOT NULL,
    cost FLOAT(6) NOT NULL,
    platform ENUM('social media', 'model campaign', 'ads') DEFAULT NULL,
    reach INT(9) NOT NULL,
    FOREIGN KEY (department_id)
        REFERENCES department (department_id),
    FOREIGN KEY (employee_id)
        REFERENCES Employee (employee_id)
);
 
insert into department (name, department_id, manager_id) values
('Hair care', '01','8001'),
('Make up', '02','8005'),
('Body care', '03','8009'),
('Skin care','04','8013'),
('Appliances and tools','05','8017');
insert into Employee(employee_id,employee_name,age,phone_number,email,address,salary,card_number,position,department_id) values
('8001','Mary John','24','684512362','maryjohn@cosmetics.com','980 Street,Essex','600','964-859-236-412','manager','01'),
('8002','Elisabet Williams','26','688745362','elisabetwi@cosmetics.com','236 Street,Essex','450','856-965-324-687','shop-assistent','01'),
('8003','Sarah Thomas','22','696541232','shthomas@cosmetics.com','910 Street,Essex','500','003-652-004-214','cashier','01'),
('8004','Frederick Edith','32','680002365','fedith@cosmetics.com','Churchill 23,Essex','500','445-852-974-225','security','01'),
('8005','Margret George','24','689992352','georgem@cosmetics.com','006 Street,Essex','600','841-859-269-412','manager','02'),
('8006','Jane Robert','19','684123569','janerob@cosmetics.com','113 Street,Essex','450','774-852-456-357','shop-assistent','02'),
('8007','Emma Richard','25','680065322','emmrich@cosmetics.com','B-park,Essex','500','522-474-666-525','cashier','02'),
('8008','Arthur Smith','25','697412220','arthsmith@cosmetics.com','74 Street,Essex','500','114-885-324-996','security','02'),
('8009','Emily Edward','29','541992662','emedw@cosmetics.com','1569 Street,Essex','600','996-544-885-412','manager','03'),
('8010','Eliza David','22','681142233','elizadavid@cosmetics.com','744 Palace,Essex','500','254-841-056-698','cashier','03'),
('8011','Annie Joseph','20','675212362','anniejoseph@cosmetics.com','900 Street,Essex','450','969-741-632-222','shop-assistent','03'),
('8012','Michael Scarlett','29','602512566','michaelsc@cosmetics.com','699 Street,Essex','500','856-813-369-997','security','03'),
('8013','Dorothy Peter','32','523699632','dorypetter@cosmetics.com','003 Street,Essex','600','746-522-233-412','manager','04'),
('8014','Susan Alfred','25','684523324','susanalfred@cosmetics.com','879 Palace,Essex','500','889-665-965-355','cashier','04'),
('8015','Catherine Walker','21','675333212','cathwalker@cosmetics.com','920 Street,Essex','450','900-751-362-202','shop-assistent','04'),
('8016','Peter Bloom','29','602512566','michaelsc@cosmetics.com','699 Street,Essex','500','856-813-369-997','security','04'),
('8017','Harriet Paul','31','412569996','harrypaul@cosmetics.com','North Gate,Essex','600','666-013-293-422','manager','05'),
('8018','Elsie Frank','24','685536425','elsief@cosmetics.com','91 Field,Essex','500','005-755-865-771','cashier','05'),
('8019','Ada Samuel','21','662583142','adasam@cosmetics.com','Mainhood,Essex','450','575-001-333-885','shop-assistent','05'),
('8020','Ernest Ethel','36','600023687','ernestethh@cosmetics.com','089 Street,Essex','500','123-657-596-652','security','05'),
('8021','Jacob Lorel','31','636223967','jacoblorel@cosmetics.com','Upphill,Essex','750','445-600-689-699','marketing','01'),
('8022','Jason Liu','34','674523667','jliu@cosmetics.com','Downtown,Essex','750','114-611-685-619','marketing','02'),
('8023','Alex Hills','33','042323120','tomhollie@cosmetics.com',' Pire Street ,Essex','750','853-634-002-213','marketing','03'),
('8024','George Bill','27','042323120','tomhollie@cosmetics.com','Exit Road ,Essex','750','132-874-924-853','marketing','04'),
('8025','Gabriel Conti','29','095633120','gabriconte@cosmetics.com','1150 Road,Essex','750','003-674-996-210','marketing','05')
;

insert into membership_clients(client_id, client_name,address, contact, birthday, points, registration_date) values
('9654','Alicia Perez','3-5 Wellesley Road','01255 222121','1997-05-09','6922','2020-04-06'),
('9655',null,'103 Clacton Road','01255 814936','1982-04-24','5326','2019-07-09'),
('9656','Alison Hastings','78 East Hill','01206 230224','1979-01-05','8411','2020-07-02'),
('9657','Agata Hilson','Harwich Road Gt Oakley','01255 201299','1986-09-04','3565','2021-03-07'),
('9658','Adriana Clarkson','Station Road','01255 556969','1994-11-05','3995','2020-05-01'),
('9659','Laura Venti','Bluebell Resource Centre','01206 314015','1984-08-26','6698','2019-11-03'),
('9660','Kimberly Jang','47 Mill Road','01206 573605','1990-09-05','5122','2019-05-26');
 insert into brand(brand_name,contact,address,category) values
  ('Estee Lauder','01206 382015','Paris, France','makeup'),
  ('MAC','01206 765667','California,USA','makeup'),
  ('NYX','O8445769445','New York,USA','makeup'),
  ('Versed','01206 734293','Los Angeles, USA', 'skin care'),
  ('Tata Harper','01206 824447','Montreal, Canada','skin care'),
  ('The Ordinary','01621 816475','Toronto, Canada','skin care'),
  ('L`Oréal','01255 851004','Paris, France','hair care'),
  ('Neutogena','01255 201270','Germany','hair care'),
  ('Pantene','01206 869054','Switzerland','hair care'),
  ('Aveeno','aveenoinfo@email.com','Madrid, Spain','body care'),
  ('Necesairee','necesairee@info.com','Nice, France','body care'),
  ('Morphe','morphe@contact.com','Los Angeles, USA','tools'),
  ('Golden','goldenhair@info.com','Milano, Italy','tools');
  insert into products(name,brandname,expire_date,produce_date,product_description,quantity,price,product_id,department_id) values
('Double Wear Stay in Place Makeup','Estee Lauder','2020-04-25','2019-04-25','MEDIUM-TO-FULL COVERAGE FOUNDATION, BUILDABLE','25','43.00','8520','02'),
('First Blossom Palette','MAC','2023-01-01','2020-01-01','6-PAN PALETTE WITH NEUTRAL SHADES FOR EYES.','36','25.00','8521','02'),
('Pure color envy','NYX','2023-05-30','2020-05-30','BRILLIANT, GLOSSY GLEAM—SPECTACULARLY VIBRANT','40','28.00','8522','02'),
('CETAPHIL','Versed','2022-01-01','2020-01-01','Gentle Skin Cleanser','15','12.80','8523','04'),
('Anti Aging Serum','Tata Harper','2021-05-01','2020-05-01','Smart Custom Repair Concentrate Serum',20,'61.50','8531','04'),
('Revitalift Volume Filler','The ordinary','2021-10-1','2019-10-01','Night Cream','25','22.95','8524','04'),
('Shampoo and Conditioner','L`Oreal','2022-07-31','2019-07-31','Haircare Oat Milk Blend Shampoo and Conditioner','55','25.50','8525','01'),
('Moroccanoil Treatment','Neutogena','2023-12-12','2020-01-01','A versatile, argan oil-infused hair treatment and styler','40','34.00','8526','01'),
('No. 5 Bond Maintenance™ Conditioner','Pantene','2023-08-12','2019-01-01','A highly-moisturizing, reparative conditioner','50','28.00','8527','01'),
('Soleil Blanc Shimmering Body Oil','Aveeno','2024-01-01','2020-01-01',' A shimmering body that oil captures the sultry effect of sunkissed summer skin','30','100.00','8528','03'),
('Fresh Cream Body Lotion','Necesairee','2023-08-31','2019-08-31','A hydrating, soothing, and softening lotion with a popular sweet, creamy scent.','25','25.00','8529','03'),
('Ready To Roll Brush Set','Morphe','2030-01-01','2018-12-20','A set of 10 brushes curated to include all the essentials for a look.','40','75.00','8532','05'),
('SinglePass Curl 1" Professional','Golden','2030-12-31','2018-01-01','A curling iron that is part of the T3 Convertible Collection.','20','120.00','8530','05');

 insert into discounts (percentage, date, duration, product_id) value
('0.4','2020-05-20','2020-06-20','8527'),
('0.5','2020-04-30','2020-07-31','8532'),
('0.7','2020-05-01','2020-05-31','8529'),
('0.75','2020-04-30','2020-05-20','8522'); 

insert into marketing (department_id,employee_id,cost,platform, reach) values
('01','8021','5500','ads','15000'),
('02','8022','650','social media','30000'),
('03','8023','10500','model campaign','25000'),
('04','8024','7000','model campaign', '50000'),
('05','8025','10500','ads','40000');
insert into invoice (invoice_id,balance,date,tax,payment,client_id,employee_id,product_id) values
('000001','34.00','2020-05-23','0.1','cash',null,'8003','8526'),
('000002','28.00','2020-05-18','0.1','cash','9654','8003','8527'),
('000003','75.00','2020-05-20','0.1','card','9657','8003','8526'),
('000004','61.50','2020-05-19','0.1','card','9660','8007','8531'),
('000005','25.00','2020-05-21','0.1','cash',null,'8007','8521');


delimiter \\
create procedure returngift ( out result char(25))
begin 
declare getpoints int(5) default 0;
select points into getpoints from membership_clients;
if getpoints>6000 then set result='Won a gift';
else set result='Did not win a gift';
end if;
 end\\
 delimiter ;
 
 
 delimiter \\
 create procedure countemployees(in city char(25),
 out manager int(3),
 out marketing int(3),
 out shopassistant int(3),
 out cashier int(3),
 out security int(3))
 begin
 select count(*) into manager 
 from Employee 
 where address regexp city and position='manager'; 
  select count(*) into marketing 
 from Employee 
 where address regexp city and position='marketing';
   select count(*) into shopassistant 
 from Employee 
 where address regexp city and position='shop-assistent';
   select count(*) into cashier
 from Employee 
 where address regexp city and position='cashier';
   select count(*) into security
 from Employee 
 where address regexp city and position='security';
 end\\
 delimiter ;
 
 delimiter \\
 create procedure runout(in productid int(9),inout count int(4))
 begin
 declare product int(9) default 0;
 SELECT product_id
    INTO product
    FROM products
    WHERE product_id = productid;
 set count=count-1;
 end\\
 delimiter ;
 
 delimiter \\
 create procedure expiredate(out newdate date)
 begin 
 select expire_date from products where expire_date <= '2021';
	set newdate= '2023-01-01' ;
end\\
 delimiter ;
 
USE `cosmetics`;
DROP function IF EXISTS `new_function`;

DELIMITER $$
USE `cosmetics`$$
CREATE FUNCTION `salaryupdate` (salary float (5))
RETURNS float(5)
deterministic
begin
declare newsalary float(5);
 if salary <500 then set newsalary = salary +0.2*salary;
 elseif salary <600 then set newsalary = salary +0.1*salary;
 elseif salary < 700 then set newsalary = salary + 0.05*salary; 
 end if;
RETURN (newsalary);
END$$brand

DELIMITER ;
USE `cosmetics`;
DROP function IF EXISTS `expiresale`;

DELIMITER $$
USE `cosmetics`$$
CREATE FUNCTION `expiresale` (expire_date date,price float(5) )returns float (5)
deterministic
BEGIN
declare newprice float(5);
if expire_date like '2020______' then set newprice = price -0.5*price;
end if;
RETURN newprice;
END$$

DELIMITER ;

USE `cosmetics`;
DROP function IF EXISTS `lastprice`;

DELIMITER $$
USE `cosmetics`$$
CREATE FUNCTION `lastprice` (tax float(5),percentage float(5),price float(5))
returns float(5)
deterministic
begin 
declare newprice float (5);
set newprice = price+ tax*price-percentage *price;

RETURN newprice;
END$$

DELIMITER ;



CREATE TABLE IF NOT EXISTS employee_new (
    address CHAR(50),
    salary FLOAT(5),
    position ENUM('manager', 'cashier', 'security', 'shop-assistent', 'marketing')
);
delimiter $$
CREATE TRIGGER employees
BEFORE update
ON employee FOR EACH ROW
BEGIN
    DECLARE errorMessage varchar (55);
    SET errorMessage = CONCAT('The new address ',NEW.address,' cannot be in another city ');
                        
     IF new.address not like '%Essex%' then SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = errorMessage;
    END IF;
END $$

DELIMITER ;
CREATE TABLE products_new (
    quantity INT(4)
);
 DELIMITER $$

CREATE TRIGGER before_runout
after INSERT
ON products FOR EACH ROW
BEGIN
    DECLARE rowcount INT;
    
    SELECT quantity into rowcount
    FROM products ;
    IF rowcount < 20 THEN
        UPDATE products
        SET rowcount=rowcount + 20;
	else insert into products_new(quantity) values (rowcount);
       END IF; 
END $$
 delimiter ;
    delimiter \\
CREATE TABLE brands_info (
    contact CHAR(25),
    address CHAR(25)
);
create trigger before_delete 
    before update on brand for each row
    begin 
    insert into brands_info (contact,address) values (new.contact,new.address);
	end \\ 
    delimiter ;
 