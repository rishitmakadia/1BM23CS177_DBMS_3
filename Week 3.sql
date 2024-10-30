create database IF NOT exists DBMS_3_2;
use DBMS_3_2;

create table Branch(BranchName varchar(25), BranchCity varchar(10), Assets int(7), 
PRIMARY KEY (BranchName));
insert into Branch values ('SBI_Chamrajpet', 'Bangalore', 50000),
('SBI_ResidencyRoad', 'Bangalore', 10000), ('SBI_ShivajiRoad', 'Bombay', 20000),
('SBI_ParliamentRoad', 'Delhi', 10000), ('SBI_JantarMantar', 'Delhi', 20000);


create table BankAcc(AccNo int(2),BranchName varchar(25), Balance int(5), 
PRIMARY KEY (AccNo), 
FOREIGN KEY (BranchName) REFERENCES Branch(BranchName));
insert into BankAcc values (1, 'SBI_Chamrajpet', 2000), (2, 'SBI_ResidencyRoad', 5000),
(3, 'SBI_ShivajiRoad', 6000), (4, 'SBI_ParliamentRoad', 9000), (5, 'SBI_JantarMantar', 8000),
(6, 'SBI_ShivajiRoad', 4000),(8, 'SBI_ResidencyRoad', 4000),
(9, 'SBI_ParliamentRoad', 3000),(10, 'SBI_ResidencyRoad', 5000),(11, 'SBI_JantarMantar', 2000);


create table Depositor(CustomerName varchar(10),AccNo int(7),
FOREIGN KEY (AccNo) REFERENCES BankAcc(AccNo),
FOREIGN KEY (CustomerName) REFERENCES BankCustomer(CustomerName));
insert into Depositor values ('Avinash', 1), ('Dinesh', 2),
('Nikhil', 4), ('Ravi', 5), ('Avinash', 8),
('Nikhil', 9), ('Dinesh', 10), ('Nikhil', 11);


create table BankCustomer(CustomerName varchar(10), CustomerStreet varchar(25), City varchar(10), 
PRIMARY KEY (CustomerName));
insert into BankCustomer values ('Avinash', 'Bull_Temple_Road', 'Bangalore'),
('Dinesh', 'Baneargatta_Road', 'Bangalore'), ('Mohan', 'NationalCollege_Road', 'Bangalore'),
('Nikhil', 'Prithvi_Road', 'Delhi'), ('Ravi', 'Abrar_Road', 'Delhi');


create table Loan(LoanNo int(3), BranchName varchar(25), Ammount int(7),
FOREIGN KEY (BranchName) REFERENCES Branch(BranchName));
insert into Loan values (1, 'SBI_Chamrajpet', 10000),
(2, 'SBI_ResidencyRoad', 20000), (3, 'SBI_ShivajiRoad', 30000),
(4, 'SBI_ParliamentRoad', 40000), (5, 'SBI_JantarMantar', 50000);

-- Display the branch name and assets from all branches in lakhs of rupees and rename the assets column to 'assets in lakhs'?
select BranchName , Assets/100000.0 as Assets_in_Lakh from Branch;
-- Find all the customers who have at least two accounts at the same branch (ex. SBI_ResidencyRoad)?
SELECT d.CustomerName, b.BranchName, COUNT(d.AccNo) AS NumOfAccounts
FROM Depositor d
JOIN BankAcc b ON d.AccNo = b.AccNo
GROUP BY d.CustomerName, b.BranchName
HAVING COUNT(d.AccNo) >= 2;
-- CREATE A VIEW WHICH GIVES EACH BRANCH THE SUM OF THE AMOUNT OF ALL THE LOANS AT THE BRANCH?
CREATE VIEW BranchLoanSummary AS
SELECT BranchName, SUM(Ammount) AS TotalLoanAmount
FROM Loan
GROUP BY BranchName;
SELECT * FROM BranchLoanSummary;

SELECT * FROM Loan ORDER BY Ammount DESC;
-- (SELECT CustomerName FROM Depositor ) UNION (SELECT
-- CustomerName FROM BBankCustomer);
SELECT DISTINCT CustomerName
FROM Depositor
UNION
SELECT DISTINCT BankCustomer.CustomerName
FROM Loan
JOIN Branch ON Loan.BranchName = Branch.BranchName
JOIN BankCustomer ON BankCustomer.City = Branch.BranchCity;

CREATE VIEW BRANCH_TOTAL_LOAN (BRANCH_NAME,
TOTAL_LOAN) AS SELECT BranchName, SUM(Ammount) FROM Loan
GROUP BY BranchName;
select * from BRANCH_TOTAL_LOAN;
-- ALTER TABLE BankAcc MODIFY Balance INT(7);
-- ALTER TABLE BankAcc MODIFY Balance DECIMAL(10, 2);

-- Update the Balance of all accounts by 5% ?
UPDATE BankAcc SET Balance = Balance * 1.05 WHERE Balance IS NOT NULL;

