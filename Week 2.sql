show databases;
create database IF NOT exists DBMS_3_1;
use DBMS_3_1;

create table PERSON (driver_id varchar(3), name_ varchar(10), address varchar(25), PRIMARY KEY(driver_id));
insert into PERSON values ('A01', 'Richard','Srinivas nagar'), 
('A02', 'Pradeep','Rajaji nagar'), ('A03', 'Smith','Ashok nagar'), 
('A04', 'Venu','N R Colony'),('A05', 'John','Hanumanth nagar');

create table CAR (reg_num varchar(10), model varchar(10), reg_year int(4), PRIMARY KEY(reg_num));
insert into CAR values ('KA052250','Indica', 1990),
('KA031181','Lancer', 1957), ('KA095477','Toyota', 1998), 
('KA053408','Honda', 2008), ('KA041702','Audi', 2005);

create table ACCIDENT (report_no int(2), acc_date varchar(15), location varchar(25), PRIMARY KEY(report_no));
insert into ACCIDENT values (11, "01-JAN-03", 'Mysore Road'), 
(12, "02-FEB-04", 'South end Circle'), (13, "21-JAN-03", 'Bull Temple Road'), 
(14, "17-FEB-08", 'Mysore Road'), (15, "04-MAR-05", 'Kanakpura Road');

create table OWNS(driver_id varchar(3), reg_num varchar(10), 
FOREIGN KEY(driver_id) REFERENCES PERSON(driver_id), 
FOREIGN KEY(reg_num) REFERENCES CAR(reg_num));
insert into OWNS values ('A01', 'KA052250'), 
('A02', 'KA031181'), ('A03', 'KA095477'), 
('A04', 'KA053408'), ('A05', 'KA041702');

create table PARTICIPATED (driver_id varchar(3), reg_num varchar(10), report_no int(2), damage_amt int(7), 
FOREIGN KEY(driver_id) REFERENCES PERSON(driver_id),
FOREIGN KEY(reg_num) REFERENCES CAR(reg_num),
FOREIGN KEY(report_no) REFERENCES ACCIDENT(report_no));
insert into PARTICIPATED values ('A01', 'KA052250', 11, 10000), 
('A02', 'KA031181', 12, 50000), ('A03', 'KA095477', 13, 25000),
('A04', 'KA053408', 14, 3000),('A05', 'KA041702', 15, 5000);

-- Display Accident date and location?
select acc_date,location from ACCIDENT;
-- Display driver id who did accident with damage amount greater than or equal to Rs.25000?
select driver_id, damage_amt from PARTICIPATED where damage_amt>=25000;



