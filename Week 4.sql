show databases;
-- drop database lab;
create database DBMS_3_3; 
use DBMS_3_3;

create table DEPT(DeptNo int(5) , Dname varchar(25), Dloc varchar(25), PRIMARY KEY(DeptNo));
insert DEPT values  (1, "Manager", "DEL"),
(2, "Director", "BLR"), (3, "Executive", "DEL"),
(4, "Director", "DEL"),(5, "Manager", "BLR");
select * from Dept;

create table EMPLOYEE(EmpNo int(5), Ename varchar(25), MGR_No int(10), 
HireDate varchar(10), Salary int(10), DeptNo int(5), 
PRIMARY KEY(EmpNo), 
FOREIGN KEY(DeptNo) REFERENCES DEPT(DeptNo));
insert EMPLOYEE values (121, "Ria", 122, "21/10/2018", 30000, 4),
(122, "Kia", 121, "21/11/2020", 20000, 4),(123, "Jiya", 121, "1/10/2008", 70000, 4),
(124, "Lia", 122, "21/1/2019", 35000, 4),(125, "Piya", 121, "27/5/2017", 40000, 4);
select * from Employee;

create table PROJECT(Ploc varchar(25), Pname varchar(25), Pno int(5), 
PRIMARY KEY(Pno));
insert PROJECT values ("BLR", "A to B", 3),
("DEL", "D to E", 1),("HYD", "R to O", 2),
("DEL", "G to H", 5),("BLR", "P to Q", 4);
select * from Project;

create table AssignedTo(Pno int(5),EmpNo int(5), JobRole varchar(25), 
FOREIGN KEY(Pno) REFERENCES PROJECT(Pno),
FOREIGN KEY(EmpNo) REFERENCES EMPLOYEE(EmpNo));
insert AssignedTo values (3, 123, "Manager"),
(2, 122, "Director"),(5, 121, "Manager"),
(1, 124, "Executive"),(4, 125, "Director");
select * from AssignedTo;

create table INCENTIVES(EmpNo int(5), IncDate varchar(10), IncAmount int(10), PRIMARY KEY(EmpNo, IncDate),
FOREIGN KEY(EmpNo) REFERENCES EMPLOYEE(EmpNo));
insert INCENTIVES values (123, "12/3/2021", 20000),
(122, "21/3/2022", NULL),(124, "18/7/2023", 10000),
(125, "12/12/2022", 17000),(121, "11/5/2023", NULL);
select * from Incentives;

-- Retrieve the employee numbers of all employees who work on project located in Bengaluru, Hyderabad, or Mysuru?
select distinct a.EmpNo, p.Ploc from AssignedTo a
join PROJECT p on a.Pno = p.Pno where p.Ploc in ('BLR', 'HYD', 'MYS');

-- Get Employee ID’s of those employees who didn’t receive incentives?
SELECT e.EmpNo, i.IncAmount, e.Ename FROM EMPLOYEE e
LEFT JOIN INCENTIVES i ON e.EmpNo = i.EmpNo WHERE i.IncAmount IS NULL;

-- Write a SQL query to find the employees name, number, dept, job_role, department location and project location who are working for a project location same as his/her department location?
SELECT E.Ename, E.EmpNo, D.Dname AS Dept, A.JobRole, D.Dloc AS DeptLocation, P.Ploc AS ProjectLocation FROM EMPLOYEE E
JOIN DEPT D ON E.DeptNo = D.DeptNo JOIN AssignedTo A ON E.EmpNo = A.EmpNo JOIN PROJECT P ON A.Pno = P.Pno
WHERE D.Dloc = P.Ploc;

-- List the name of the managers with the maximum employees?
SELECT Ename FROM EMPLOYEE WHERE EmpNo = ( SELECT MGR_No FROM EMPLOYEE GROUP BY MGR_No ORDER BY COUNT(*) DESC LIMIT 1);

-- Display those managers name whose salary is more than average salary of his employee?
SELECT E1.Ename AS ManagerName FROM EMPLOYEE E1 WHERE E1.Salary > ( SELECT AVG(E2.Salary) FROM EMPLOYEE E2 WHERE E2.MGR_No = E1.EmpNo);

-- Find the name of the second top level managers of each department?
SELECT D.Dname, RankedManagers.Ename FROM ( SELECT D.DeptNo, E.Ename, RANK() OVER (PARTITION BY D.DeptNo ORDER BY E.Salary DESC) AS Ranks
FROM EMPLOYEE E JOIN DEPT D ON E.DeptNo = D.DeptNo WHERE E.MGR_No IS NOT NULL)
AS RankedManagers JOIN DEPT D ON RankedManagers.DeptNo = D.DeptNo WHERE RankedManagers.Ranks = 2;

-- Find the employee details who got second maximum incentive in January 2019? 

-- Display those employees who are working in the same department where his manager is working?
SELECT E1.Ename AS EmployeeName FROM EMPLOYEE E1 JOIN EMPLOYEE E2 ON E1.MGR_No = E2.EmpNo WHERE E1.DeptNo = E2.DeptNo;



