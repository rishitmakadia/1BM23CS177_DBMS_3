show databases;
create database DBMS_3_4; 
use DBMS_3_4;

create table Suppliers (Sid int(10), Sname varchar(25), City varchar(15),
PRIMARY KEY (Sid));
insert Suppliers value (10001, "Acme Widget", "Bangalore"),
(10002, "Johns", "Kolkata"),(10003, "Vimal", "Mumbai"),
(10004, "Reliance", "Delhi");

create table Parts (Pid int(10), Pname varchar(25), Color varchar(15),
primary key (Pid));
insert Parts value (20001, "Book", "Red"),
(20002, "Pen", "Red"),(20003, "Pencil", "Green"),
(20004, "Mobile", "Green"),(20005, "Charger", "Black");

create table Catalog (Sid int(10), Pid int(10), Cost int(10),
foreign key (Sid) references Suppliers(Sid),
foreign key (Pid) references Parts(Pid));
insert Catalog values (10001, 20001, 10),(10001, 20002, 10),
(10001, 20003, 30),(10001, 20004, 10),(10001, 20005, 10),
(10002, 20001, 10),(10002, 20002, 20),(10003, 20003, 30),(10004, 20003, 40);

-- Find the pnames of parts for which there is some supplier?
select p.pname from Parts p where p.Pid IN (select c.pid from Catalog c);

-- Find the snames of suppliers who supply every part?

-- Find the snames of suppliers who supply every red part?  (Incomplete)
select s.Sname from Suppliers s, Catalog j where s.Sid=j.Pid IN (select p.Pid from Parts p, Catalog c where p.Color ='Red' and c.Pid=p.Pid);

-- Find the pnames of parts supplied by Acme Widget Suppliers and by no one else?
-- Find the sids of suppliers who charge more for some part than the average cost of that part (averaged over all the suppliers who supply that part)?
-- For each part, find the sname of the supplier who charges the most for that part?