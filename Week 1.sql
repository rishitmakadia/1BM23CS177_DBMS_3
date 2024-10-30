show databases;
create database IF NOT exists Demo;
use Demo;

CREATE TABLE STUDENT(stdid INT(5), stdname varchar(20), dob date, doj date, fee int(5), gender char);
select * from student;
desc student;

insert into STUDENT (stdid, stdname, dob, doj, fee, gender) 
VALUES (1, "JOHN", '2001-01-10', '2001-10-05', 10000, 'M');

insert into STUDENT (stdid, stdname, fee) 
VALUES (2, "KIA", 17000);

insert into STUDENT (stdid, stdname, dob, doj, fee, gender) 
VALUES (3, "TS", '2001-01-10', '2001-10-05', 20000, 'F');

-- Add a column to the student table (that is phone_no)?
alter table STUDENT add PHONE_NO int(10);
-- Modify the column name of phone_no to student_no?
alter table STUDENT 
rename column PHONE_NO to Std_No;
-- To drop a column from the table?
ALTER TABLE STUDENT DROP COLUMN gender;


