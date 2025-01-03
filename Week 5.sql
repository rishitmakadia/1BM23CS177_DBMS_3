show databases;
create database DBMS_3_4; 
use DBMS_3_4;

create table Suppliers (Sid int(10), Sname varchar(25), City varchar(15),
PRIMARY KEY (Sid));
insert Suppliers value (10001, "Acme Widget", "Bangalore"),
(10002, "Johns", "Kolkata"),(10003, "Vimal", "Mumbai"),
(10004, "Reliance", "Delhi");
select * from Suppliers;

create table Parts (Pid int(10), Pname varchar(25), Color varchar(15),
primary key (Pid));
insert Parts value (20001, "Book", "Red"),
(20002, "Pen", "Red"),(20003, "Pencil", "Green"),
(20004, "Mobile", "Green"),(20005, "Charger", "Black");
select * from Parts;

create table Catalog (Sid int(10), Pid int(10), Cost int(10),
foreign key (Sid) references Suppliers(Sid),
foreign key (Pid) references Parts(Pid));
insert Catalog values (10001, 20001, 10),(10001, 20002, 10),
(10001, 20003, 30),(10001, 20004, 10),(10001, 20005, 10),
(10002, 20001, 10),(10002, 20002, 20),(10003, 20003, 30),(10004, 20003, 40);
select * from Catalog;

-- Find the pnames of parts for which there is some supplier?
select p.pname from Parts p where p.Pid IN (select c.pid from Catalog c);
select distinct p.pname from Parts p, Catalog c where p.Pid = c.Pid;

-- Find the snames of suppliers who supply every part?
select s.sname from Suppliers s JOIN Catalog c ON s.sid = c.sid GROUP BY s.sname
HAVING COUNT(DISTINCT c.pid) = (SELECT COUNT(*) FROM Parts);

-- Find the snames of suppliers who supply every red part?  (Incomplete)
select s.sname from Suppliers s JOIN Catalog c ON s.sid = c.sid JOIN Parts p ON c.pid = p.pid
WHERE p.color = 'Red' GROUP BY s.sid, s.sname HAVING COUNT(DISTINCT p.pid) = (select COUNT(*) from Parts WHERE color = 'Red');

-- Find the pnames of parts supplied by Acme Widget Suppliers and by no one else?
SELECT P.Pname FROM Parts P JOIN Catalog C ON P.Pid = C.Pid JOIN Suppliers S ON C.Sid = S.Sid
WHERE S.Sname = 'Acme Widget' GROUP BY P.Pname HAVING COUNT(DISTINCT C.Sid) = 1;

-- Find the sids of suppliers who charge more for some part than the average cost of that part (averaged over all the suppliers who supply that part)?
select distinct c.sid from Catalog c where c.cost > (select AVG(c1.cost) from Catalog c1 where c1.pid = c.pid);

-- For each part, find the sname of the supplier who charges the most for that part?
select p.pname, s.sname from Parts p JOIN Catalog c ON p.pid = c.pid JOIN Suppliers s ON s.sid = c.sid 
WHERE c.Cost = (select MAX(c1.Cost) from Catalog c1 WHERE c1.pid = p.pid);