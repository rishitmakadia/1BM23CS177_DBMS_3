create database test;
use test;
drop database test;

create table Passenger(P_Id int(5), P_name varchar(10), Mobile int(10), Email varchar(30), Age int(3), City varchar(10), State varchar(10), primary key(P_Id));
create table Train(Train_Id int(5), Train_name varchar(10), T_From varchar(15), T_To varchar(15), J_Date Date, primary key(Train_Id));
create table Ticket(Ticket_Id int(10), B_Date Date, No_Seat int(3), P_Id int(5), T_Status varchar(10), primary key(Ticket_Id), foreign key (P_Id) references Passenger(P_Id));
create table Payment(Pay_Id varchar(10), P_Date Date, Amount int(5), Ticket_Id int(10), P_Id int(5), primary key(Pay_Id), foreign key (P_Id) references Passenger(P_Id), foreign key (Ticket_Id) references Ticket(Ticket_Id));
create table Seats(Seat_Id varchar(10), Category varchar(15), Ticket_Id int(10), foreign key (Ticket_Id) references Ticket(Ticket_Id));
create table Looks_For(P_Id int(5), Train_Id int(5), Ticket_Id int(10), foreign key (P_Id) references Passenger(P_Id), foreign key (Ticket_Id) references Ticket(Ticket_Id),
foreign key (Train_Id) references Train(Train_Id));

insert into Passenger values (12345, "Ria", 709604040, "ria@gmail.com", 21, "Rajkot", "Gujarat");
insert into Passenger values (23451, "Tinky", 706904040, "tinky@gmail.com", 44, "Chennai", "TN");
insert into Passenger values (34512, "Kia", 999604040, "kia@gmail.com", 37, "Thar", "Rajasthan");
insert into Passenger values (45123, "Jiya", 709655840, "jiya@gmail.com", 17, "Cochin", "Kerala");
insert into Passenger values (51234, "Rinky", 709604657, "rinky@gmail.com", 29, "Jaipur", "Rajasthan");

insert into Train values (17524, "Duronto", "Delhi", "Pondichery", "2024-12-21");
insert into Train values (75241, "Rajdhani", "Lucknow", "Mumbai", "2024-12-17");
insert into Train values (52417, "Local", "Bngalore", "Pondichery", "2025-02-21");
insert into Train values (24175, "Duronto", "Raipur", "Pondichery", "2025-01-01");
insert into Train values (41752, "Vande", "Delhi", "Mumbai", "2025-01-11");

insert into Ticket values (152790, "2024-12-21", 3, 12345, "Confirmd"); 
insert into Ticket values (127905, "2024-11-25", 1, 23451, "Waiting"); 
insert into Ticket values (179052, "2024-12-21", 1, 34512, "Waiting"); 
insert into Ticket values (190527, "2025-01-01", 2, 45123, "Waiting"); 
insert into Ticket values (105279, "2024-12-17", 4, 51234, "Waiting"); 

insert into Payment values ("7590FS", "2024-12-21", 3000, 152790, 12345);
insert into Payment values ("5907FS", "2024-11-25", 3500, 127905, 23451);
insert into Payment values ("9075FS", "2024-12-21", 5500, 179052, 34512);
insert into Payment values ("0759FS", "2025-01-01", 300, 190527, 45123);
insert into Payment values ("7590JS", "2024-12-17", 2500, 105279, 51234);

insert into Seats values ("CNF07/8/3", "3AC", 152790);
insert into Seats values ("WAIT003", "2AC", 127905);
insert into Seats values ("WAIT008", "1AC", 179052);
insert into Seats values ("WAIT003/8", "General", 190527);
insert into Seats values ("WAIT5-9", "AC3", 105279);

insert into Looks_For values (12345, 17524, 152790);
insert into Looks_For values (23451, 75241, 127905);
insert into Looks_For values (34512, 52417, 179052);
insert into Looks_For values (45123, 24175, 190527);
insert into Looks_For values (51234, 41752, 105279);

select * from Passenger;

select p.P_Id, p.P_name from Passenger p JOIN Ticket t ON P.P_Id=t.P_Id JOIN Seats s ON t.Ticket_Id=s.Ticket_Id
where t.T_Status like "%Waiting%" AND s.Category like "%AC%";

UPDATE Train
SET Train.T_To="Puduchery"
where Train.T_To="Pondichery";
select * from Train;

-- (P_Id int(5), P_name varchar(10), Mobile int(10), Email varchar(30), Age int(3), City varchar(10), State varchar(10), 
-- Train_Id int(5), Train_name varchar(10), T_From varchar(15), T_To varchar(15), J_Date Date) 

CREATE VIEW Pass_Detail
AS (select p.P_Id, p.P_name, p.Mobile, p.Email, p.Age, p.City, p.State, t.Train_Id, t.Train_name, t.T_From, t.T_To, t.J_Date 
from Passenger p JOIN Looks_For l ON p.P_Id=l.P_Id JOIN Train t ON l.Train_Id=t.Train_Id 
where l.Ticket_Id is not null and p.Age between 20 AND 40);
select * from Pass_Detail;