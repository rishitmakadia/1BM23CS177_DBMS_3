show databases;
create database IF NOT exists DBMS_3_1;
use DBMS_3_1;

create table PERSON (driver_id varchar(3), name_ varchar(10), address varchar(25), PRIMARY KEY(driver_id));
desc person;
insert into PERSON values ('A01', 'Richard','Srinivas nagar'), 
('A02', 'Pradeep','Rajaji nagar'), ('A03', 'Smith','Ashok nagar'), 
('A04', 'Venu','N R Colony'),('A05', 'John','Hanumanth nagar');
select * from person;

create table CAR (reg_num varchar(10), model varchar(10), reg_year int(4), PRIMARY KEY(reg_num));
desc car;
insert into CAR values ('KA052250','Indica', 1990),
('KA031181','Lancer', 1957), ('KA095477','Toyota', 1998), 
('KA053408','Honda', 2008), ('KA041702','Audi', 2005);
select * from CAR;

create table ACCIDENT (report_no int(2), acc_date varchar(15), location varchar(25), PRIMARY KEY(report_no));
desc ACCIDENT;
insert into ACCIDENT values (11, "01-JAN-03", 'Mysore Road'), 
(12, "02-FEB-04", 'South end Circle'), (13, "21-JAN-03", 'Bull Temple Road'), 
(14, "17-FEB-08", 'Mysore Road'), (15, "04-MAR-05", 'Kanakpura Road');
select * from ACCIDENT;

create table OWNS(driver_id varchar(3), reg_num varchar(10), 
FOREIGN KEY(driver_id) REFERENCES PERSON(driver_id), 
FOREIGN KEY(reg_num) REFERENCES CAR(reg_num));
desc OWNS;
insert into OWNS values ('A01', 'KA052250'), 
('A02', 'KA031181'), ('A03', 'KA095477'), 
('A04', 'KA053408'), ('A05', 'KA041702');
select * from OWNS;

create table PARTICIPATED (driver_id varchar(3), reg_num varchar(10), report_no int(2), damage_amt int(7), 
FOREIGN KEY(driver_id) REFERENCES PERSON(driver_id),
FOREIGN KEY(reg_num) REFERENCES CAR(reg_num),
FOREIGN KEY(report_no) REFERENCES ACCIDENT(report_no));
desc PARTICIPATED;
insert into PARTICIPATED values ('A01', 'KA052250', 11, 10000), 
('A02', 'KA031181', 12, 50000), ('A03', 'KA095477', 13, 25000),
('A04', 'KA053408', 14, 3000),('A05', 'KA041702', 15, 5000);
select * from PARTICIPATED;

-- Display Accident date and location?
select acc_date,location from ACCIDENT;

-- Display driver id who did accident with damage amount greater than or equal to Rs.25000?
select driver_id, damage_amt from PARTICIPATED where damage_amt>=25000;

-- Add new accident to the database
INSERT into accident values(16,'2008-03-08','Dolmor'); 
select * FROM accident;

-- Update the damage amount to 25000 for the car with a specific reg_num (example 'K A053408' ) for which the accident report number was 14.
UPDATE PARTICIPATED SET damage_amt = 25000 WHERE reg_num = 'KA053408' AND report_no = 14;
select * from PARTICIPATED;

-- Display the entire CAR relation in the ascending order of manufacturing year
SELECT * FROM CAR ORDER BY reg_year ASC;

-- Find the number of accidents in which cars belonging to a specific model (example'Lancer') were involved.
SELECT C.model, COUNT(*) AS num_accidents FROM PARTICIPATED P JOIN CAR C ON P.reg_num = C.reg_num WHERE C.model = 'Lancer';

 -- Find the total number of people who owned cars that involved in accidents in 2003.
SELECT COUNT(DISTINCT O.driver_id) AS num_people FROM OWNS O 
JOIN PARTICIPATED P ON O.reg_num = P.reg_num JOIN ACCIDENT A ON P.report_no = A.report_no WHERE A.acc_date LIKE '%-03';

-- List all the entire participated relation in descending order of damage_amount 
select * FROM participated ORDER BY damage_amt desc;

-- Find average damage_amount
select avg(damage_amt) from participated;

-- Delete the tuple whose damage_amount is below average amount  damage_amount
DELETE FROM PARTICIPATED WHERE damage_amt < (SELECT AVG(damage_amt) FROM PARTICIPATED);
SELECT * FROM PARTICIPATED WHERE damage_amt < (SELECT AVG(damage_amt) FROM PARTICIPATED);

-- List the name of drivers whose Damage is Greater than the Average Damage Amount.
SELECT P.name_ FROM PERSON P JOIN PARTICIPATED T ON P.driver_id = T.driver_id
WHERE T.damage_amt > (SELECT AVG(damage_amt) FROM PARTICIPATED);

-- Find the maximum damage_amount
select max(damage_amt) from participated;
