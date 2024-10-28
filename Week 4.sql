show databases;
-- drop database lab;
create database DBMS_3_3; 
use DBMS_3_3;

create table DEPT(DeptNo int(5) , Dname varchar(25), Dloc varchar(25), PRIMARY KEY(DeptNo));
insert DEPT values  (1, "Manager", "DEL"),
(2, "Director", "BLR"), (3, "Executive", "DEL"),
(4, "Director", "DEL"),(5, "Manager", "BLR");


create table EMPLOYEE(EmpNo int(5), Ename varchar(25), MGR_No int(10), 
HireDate varchar(10), Salary int(10), DeptNo int(5), 
PRIMARY KEY(EmpNo), 
FOREIGN KEY(DeptNo) REFERENCES DEPT(DeptNo));
insert EMPLOYEE values (121, "Ria", 51, "21/10/2018", 30000, 4),
(122, "Kia", 57, "21/11/2020", 20000, 4),(123, "Jiya", 77, "1/10/2008", 70000, 4),
(124, "Lia", 63, "21/1/2019", 35000, 4),(125, "Piya", 71, "27/5/2017", 40000, 4);


create table PROJECT(Ploc varchar(25), Pname varchar(25), Pno int(5), 
PRIMARY KEY(Pno));
insert PROJECT values ("BLR", "A to B", 3),
("DEL", "D to E", 1),("HYD", "R to O", 2),
("DEL", "G to H", 5),("BLR", "P to Q", 4);


create table AssignedTo(Pno int(5),EmpNo int(5), JobRole varchar(25), 
FOREIGN KEY(Pno) REFERENCES PROJECT(Pno),
FOREIGN KEY(EmpNo) REFERENCES EMPLOYEE(EmpNo));
insert AssignedTo values (3, 123, "Manager"),
(2, 122, "Director"),(5, 121, "Manager"),
(1, 124, "Executive"),(4, 125, "Director");


create table INCENTIVES(EmpNo int(5), IncDate varchar(10), IncAmount int(10), PRIMARY KEY(EmpNo, IncDate),
FOREIGN KEY(EmpNo) REFERENCES EMPLOYEE(EmpNo));
insert INCENTIVES values (123, "12/3/2021", 20000),
(122, "21/3/2022", NULL),(124, "18/7/2023", 10000),
(125, "12/12/2022", 17000),(121, "11/5/2023", NULL);

-- select e.EmpNo, p.Ploc from PROJECT p, EMPLOYEE e where p.Ploc = "BLR" or p.Ploc = "HYD";
select distinct a.EmpNo, p.Ploc
from AssignedTo a
join PROJECT p on a.Pno = p.Pno
where p.Ploc in ('BLR', 'HYD', 'MYS');

-- select i.IncAmount, e.Ename, e.EmpNo from Incentives i, Employee e where i.IncAmount =0;
SELECT e.EmpNo, i.IncAmount
FROM EMPLOYEE e
LEFT JOIN INCENTIVES i ON e.EmpNo = i.EmpNo
WHERE i.IncAmount IS NULL;

select e.EmpNo, e.Ename from PROJECT p, EMPLOYEE e where e.Dloc = p.Ploc



