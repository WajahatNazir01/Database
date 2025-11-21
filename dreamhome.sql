create database dreamHome

use dreamHome

create table branch(

branchNo char(5) primary key NOT NULL, --length should be 5 characters fixed 
street varchar(50),	-- length should be 50
city varchar(30),      --length should be upto 30
postCode varchar(15)   -- length should be upto 15
);


insert into Branch ( branchNo , street,city,postcode)
values ( 'B005', '22 Deer rd ', 'London','SW1 4EH') ,
( 'B007', '22 Deer rd ', 'Aberdeen','AB2 35U') ,
( 'B003', '16 Argyll St ', 'Glasgow','G11 9QX') ,
( 'B004', '163 Manse Rd ', 'Bristol ','BS99 1NZ') ,
( 'B002', '56 Clover Dr', 'London','NW10 6EU')


create table staff(
staffNo char(5) primary key ,    --Length should be fixed 5 characters
fname varchar (25),	--length should be upto 25 characters
lName varchar(25),     --length should be upto 25 characters
position varchar(25),  --length should be upto 25 characters
sex char check (sex in('M','F')),               -- to insert M or F
DOB date,
salary Decimal(8,2),		--Upto eight 8 digit with 2 decimal points
branchNo char(5) foreign key REFERENCES branch(branchNo)   -- should be same length as in primary key value
)

 insert into staff(staffNo,fName,lName,position,sex,DOB,salary,branchNo)values('SL21','John','White','Manager','M','1-Oct-45',30000.00,'B005'),
('SG37','Ann','Beech','Assistant','F','10-Nov-60',12000.00,'B003'),
('SG14','David','Ford','Supervisor','M','24-Mar-58',18000.00,'B003'),
('SA9','Mary','Howe','Assistan','F','19-Feb-70',9000.00,'B007'),
('SG5','Susan','Brand','Manager','F','3-Jun-40',24000.00,'B003'),
('SL41','Julie','Lee','Assistan','F','13-Jun-65',9000.00,'B005')


create table privateOwner(
ownerNo char(5) primary key,   --fixed to 5 characters
fNAme varchar(25),		    --length should be upto 25 characters
lname varchar(25),		    --length should be upto 25 characters
address varchar(50),		    --length should be upto 50 characters
telNo varchar(13),		    --length should be upto 13 characters
eMail varchar(50),		    --length should be upto 50 characters
password varchar(50),		    --length should be upto 50 characters
)

insert into privateOwner(ownerNo,fName,lName,address,telNo,eMail,password)values('CO46','Joe','Keogh','2 Fergus Dr, Aberdeen AB2 7SX','01224-861212','john.kay@gmail.com','********'),
('CO87','Carol','Farrel','6 Achray St, Glasgow G32 9DX','0141-357-7419','cfarrel@gmail.com','********'),
('CO40','Tina','Murphy','63 Well St, Glasgow G42','0141-943-1728','tinam@hotmail.com','********'),
('CO93','Tony','Shaw','12 Park Pl, Glasgow G4 0QR','0141-225-7025','tony.shaw@ark.com','********')


create table propertyForRent(
propertyNo char(5) primary key,    --Same as in primary key value
street varchar(50),			--length should be upto 50 characters
city varchar(25),			--length should be upto 25 characters
postCode varchar(15),			--length should be upto 15 characters
type varchar(15),			--length should be upto 15 characters
rooms int,
rent money,
ownerNo char(5) foreign key REFERENCES privateOwner(ownerNo) , --Same as primary key
staffNo char(5) foreign key REFERENCES staff(staffNo) ,		--Same as primary key
branchNo char(5) foreign key REFERENCES branch(branchNo)		--Same as primary key
)

insert into PropertyForRent ( propertyNo , street,city,postcode,type,rooms,rent,ownerNo,staffNo,branchNo)
values ('PA14','16 Holhead','Aberdeen','Ab7 5SU','House',6,650,'CO46','SA9','B007'),
 ('PL94','16 Argyll St ','London','NW2','Flat',4,400,'CO87','SL41','B005'),
 ('PG4','6 Lawerence St','Glassgow','G11 9QX','Flat',3,350,'CO40',Null,'B003'),
 ('PG36','Manor Rd','Glassgow','G11 4QX','Flat',3,375,'CO93','SG37','B003'),
 ('PG21','18 Dale Rd','Glassgow','G12','House',5,600,'CO87','SG37','B003'),
 ('PG16','5 Novar St','Glassgow','G12 9AX','Flat',4,450,'CO93','SG14','B003')

create table client(
clientNo char(5) primary key,	--length fixed to 5 characters
fName varchar(25),			--length should be upto 25 characters
lName varchar(25),			--length should be upto 25 characters
telNo varchar(13),			--length should be upto 13 characters
prefType varchar(15),			--length should be upto 15 characters
maxRent decimal(8,2),				--Upto 8 digitd with 2 decimal points
eMail varchar(25)			--length should be upto 25 characters

)

insert into client(clientNo,fName,lName,telNo,prefType,maxRent,eMail) values('CR76','John','Kay','0207-774-5632','Flat',425,'john.kay@gmail.com'),
('CR56','Aline','Stewart','0141-848-1825','Flat',350,'astewart@hotmail.com'),
('CR74','Mike','Ritchie','01475-392178','House',750,'mritchie01@yahoo.co.uk'),
('CR62','Mary','Tregear','01224-196720','Flat',600,'maryt@hotmail.co.uk')


create table viewing(
clientNO char(5) foreign key REFERENCES client(clientNo),	--Same as in primary key
propertyNO char(5) foreign key REFERENCES propertyForRent(propertyNo) ,   --Same as in primary key
primary key (clientNo,propertyNo),
viewDate date,
comment varchar(200)
)

 insert into Viewing ( clientNo ,propertyNo,viewDate,comment)
 values ( 'CR56','PA14','24-May-13','too small'),
 ( 'CR76','PG4','20-Apr-13','too remote'),
 ( 'CR56','PG4','26-May-13',Null),
 ( 'CR62','PA14','14-May-13','no dining room'),
 ( 'CR56','PG36','28-Apr-13',Null)

create table registration(

clientNo char(5) foreign key REFERENCES client(clientNo),	--Same as in primary key
branchNo char(5) foreign key REFERENCES branch(branchNo),	--Same as in primary key
primary key (clientNo,branchNo),
staffNo char(5) foreign key REFERENCES staff(staffNo),
dateJoined date

)

 insert into Registration ( clientNo ,branchNo, staffNo,dateJoined)
 values ('CR76','B005','Sl41','2-Jan-13'),
 ('CR56','B003','SG37','11-Apr-12'),
 ('CR74','B003','SG37','16-Nov-11'),
 ('CR62','B007','SA9','7-Mar-12')


 ------------------------------------------

--Task 5
--1. Retrieve data for branch "B005"

select * from branch where branchNo='B005';

--2. Retrieve data from branch table for "London" city.

select * from branch where city='London';

--3. Fetch data for branch number "B003" and "B005".

select * from branch where branchNo = 'B003' or branchNo = 'B005';

--4. Can you list down the city names where the branches are existed

select distinct city from branch ;

--5. Detail of staff members have more than 18000 salary.

select * from staff where salary>18000;

--6. Can you generate the list of male staff members.

select * from staff where sex = 'M';

--7. Please provide a list of managers names with their branch numbers.

select concat(fName , ' ' , lName) as full_name , position, branchNo from staff 
where position = 'Manager';

--8. Detail of private owners.

select * from privateOwner;

--9. Detail of properties available for rent.

select * from PropertyForRent;

--10. Can you display staff names in ascending order. 

select concat(fName , ' ' , lName) as full_name, branchNo from staff
order by full_name ASC;

--11. Detail of employees whose salary between 9000 and 18000.

select * from staff where salary between 9000 and 18000;

--12. Detail of employees from branch B003 and b005.

select * from staff where branchNo = 'B003' or branchNo = 'B005';


-------------------------------------------------------------------------------------------

 --Task 5.1
--1. Show properties that are owned by the owner "CO87".

select * from propertyForRent where ownerNo = 'CO87';

--2. Display the Properties address that were registered by staff number "SG37".

select * from propertyForRent where staffNo = 'SG37' ;

--3. Can you display number of room against each flat.

select propertyNo,rooms from propertyForRent where type = 'Flat';

--4. Is there any properties having rent less than 500.

select * from propertyForRent where rent < 500;

--exits command returns true when any of record is returns and first stt works 

select case when exists(select rent from propertyForRent where rent < 500) 
then 'Yes they are available'
else 'no they dont exist'
end as properties_under_500;

--5. Can you display the client name, number and email of those clients whose choice is flat.

select fName, lName,clientNo,email from client
where prefType='flat';

--6. Details of owners in ascending order by their name.

select * from privateOwner order by fName asc, lname asc;

--7. How many properties are viewed.

select count(distinct propertyNo) as total_viewd_properties from viewing;

--8. Detail of registration table.

select * from registration;

--9. Display the total number of staff in this system.   

select count(*) as total_staff from staff;

--10.Detail of staff members who born after 1960.

select * from staff where DOB > '31-dec-1960';

--11.Change branch "B005" from London to Bristol.

update branch set city = 'Bristol' where branchNo = 'B005' and city = 'London';

--12.Change "B005" from Bristol to London.

update branch set city = 'London' where branchNo = 'B005' and city = 'Bristol';

--13.Name of those properties that are not handled by any staff member.

select * from propertyForRent where staffNo is null;

--14.Name of those owner name whose name starts with character " J".

select * from privateOwner where fNAme like 'J%';

--15.Is there property number that is viewed by client but not give any comment.

select propertyNo , comment from viewing where comment is null;

--16. Can you display the number of employees in each branch.
select branchNo,count(staffNo) as number_of_members from staff 
group by branchNo;

-----------------------------------------------------------

 --Task 5.2

--1. Show the average salary of all employees.

select AVG(salary) as Average_salary from staff;

--2. Show the average salary of employees from branch B005.

select AVG(salary) as Average_salary from staff where branchNo='B005';

--3. Show the average salary of all managers from all branches.

select AVG(salary) as Average_salary_of_managers from staff where position = 'Manager';

--4. Show the name and designation of employee who is drawing the top most salary.

select concat(fName ,' ',lName) as full_name ,position,salary from staff where salary=(select max(salary) from staff);

--5. Show the name of a supervisor who is drawing top most salary.

select concat(fName ,' ',lName) as full_name ,position,salary from staff where salary=(select max(salary) from staff where position = 'Supervisor');

--6. Show the name and branch number of an employee who is drawing least salary of all

select branchNo , CONCAT(fName,' ',lName) as ful_name, salary from staff where salary=(select min(salary)from staff);

--7. Show the name, designation and branch number of a manager, who is drawing least salary from all managers.

select CONCAT(fName,' ',lName) as manager_name, position ,branchNo,salary from staff 
where salary=(select min(salary) from staff where position = 'Manager');

--8. How many supervisors are in the system and their total salary.

select count(*) as total_supervisors,
sum(salary) as total_salary from staff
where position='Supervisor';

--9. List of supervisors from the branch number B005 and B003.

select concat(fName , ' ' , lName) as full_name ,branchNo,salary from staff
where position='supervisor'
and branchNo in ('B005','B003');

--10. Show the total budget of salary. 
select sum(salary) as total_budget_of_salaries from staff;

-------------------------------------------------------

--lab 6.0


--1. All staff members data with their branch details.

SELECT s.staffNo, s.fName, s.lName, s.position, s.sex, s.DOB, s.salary, s.branchNo, b.street, b.city, b.postCode 
FROM staff s 
JOIN branch b ON s.branchNo = b.branchNo;

--2. All staff members data belongs to London city.

select s.staffNo, s.fName, s.lName, s.position, s.sex, s.DOB, s.salary, s.branchNo, b.city from staff s
join branch b on s.branchNo=b.branchNo
where b.city='London'

--3. Branch data where SA9 is working.

select b.branchNo,b.street,b.city,b.postcode ,s.staffNo from branch b 
join staff s on b.branchNo=s.branchNo
where s.staffNo='SA9'

--4. Detail of properties with staff details.

select p.propertyNo,p.street,p.city,p.postCode,p.type,p.rooms,p.rent,p.ownerNo,p.staffNo,p.branchNo,
s.fName,s.lName,s.position,s.sex,s.DOB,s.salary
from propertyForRent p left join staff s on p.staffNo=s.staffNo;

--5. Detail of properties with private owner details.

select p.propertyNo,p.street,p.city,p.postCode,p.type,p.rooms,p.rent,p.ownerNo,p.staffNo,p.branchNo,
o.ownerNo,o.fName,o.lname,o.address,o.telNo,o.eMail,o.password
from propertyForRent p left join privateOwner o on p.ownerNo=o.ownerNo

--6. Detail of properties with branch data.

select p.propertyNo,p.street,p.city,p.postCode,p.type,p.rooms,p.rent,p.ownerNo,p.staffNo,p.branchNo,
b.street,b.city,b.postCode from propertyForRent p left join branch b on p.branchNo=b.branchNo;

--7. Detail of clients with their preferences.

select * from client;

--8. Detail of clients with their comments while viewing properties.

select c.clientNo,c.fName,c.lName,c.telNo,c.eMail,c.maxRent,c.prefType,v.propertyNo,v.comment
from client c
inner join viewing v on c.clientNo=v.clientNo

--9. Detail of branch where only male staff members are working.

select distinct b.branchNo,b.street,b.city,b.postCode from branch b
join staff s on b.branchNo=s.branchNo 
where b.branchNo not in (
select s2.branchNo from staff s2 where s2.sex ='F'
);


--10. Branch detail with detail of properties registered in each branch.

select b.street,b.city,b.postCode,b.branchNo,
p.propertyNo,p.street,p.city,p.postCode,p.type,p.rooms,p.rent,p.ownerNo,p.staffNo
from branch b 
left join propertyForRent p on b.branchNo=p.branchNo;


--11. Each owner detail with the detail of their properties.

select o.ownerNo,o.fName,o.lname,o.address,o.telNo,o.eMail,o.password,
p.propertyNo,p.street,p.city,p.postCode,p.type,p.rooms,p.rent,p.staffNo from privateOwner o
full outer join propertyForRent p on o.ownerNo=p.ownerNo;


--12. Total salary of branch B003

select sum(salary)as total_salary from staff
where branchNo='B003';

--13. Total salary of whole system.

select sum(salary) as total_salaries from staff;
--or
select branchNo,sum(salary) as total_salaries from staff group by branchNo;

--14. Detail of employee who is drawing minimum salary.

select top 1 * from staff where salary=(select min(salary) as min_salary from staff);

--15. Detail of employee who is drawing maximum salary.

select * from staff where salary=(select max(salary) as max_salary from staff);

--16. Average salary of branch B005

select AVG(salary) as average_salary from staff where branchNo='B005';

--how to find number of properties registered under each owner name
select o.ownerNo, o.fName, o.lName, o.address, o.telNo,
       count(p.propertyNo) AS totalProperties
from privateOwner o
left join propertyForRent p ON o.ownerNo = p.ownerNo
group by o.ownerNo, o.fName, o.lName, o.address, o.telNo;



------------------------------------------------------------------------------------------


--lab task 6.1

--1. Can we find out the date when was the client 'John' was registered in DreamHome system.

select c.fName,r.dateJoined from registration r
join client c on r.clientNo=c.clientNo
where c.fName='John';

--2. Can we see the detail of Client 'CR76' and the detail of branch where he was registered 
--client to registration to branch
select c.* , b.* from client c
join registration r on c.clientNo=r.clientNo
join branch b on r.branchNo=b.branchNo
where c.clientNo='CR76';

--3. Is there any client who did not view even a single property.

select c.* from client c left join viewing v on c.clientNo=v.clientNo where v.clientNo is null;

--4. How many private owner have the first name 'Joe'

select count(fNAme) as total_owners from privateOwner where fNAme ='Joe';

--5. Is there any private owner who did not provide email address.

select * from privateOwner where eMail = '' or eMail is null;

--6. Is there any client who has the same email address as private owner.

select c.* from client c join privateOwner p on c.eMail=p.eMail;

--7. Is there any staff who is also a private owner.

select s.* from staff s join privateOwner p on s.fname = p.fNAme and s.lName = p.lname;

--8. Can we see the top three max rent of properties.

select top 3 * from propertyForRent 
order by rent desc;

--9. Display the private owner number who is registered in system but did not have any property yet.

select p.ownerNo from privateOwner p left join propertyForRent pr on p.ownerNo=pr.ownerNo
where pr.ownerNo is null;

--10. Detail of properties which are still not viewed.

select p.* from propertyForRent p left join viewing v on p.propertyNo=v.propertyNO 
where v.propertyNO is null; 

--11. Show the data of all staff members with the detail of properties they handled.

select s.*, p.* from staff s left join propertyForRent p on s.staffNo=p.staffNo

--------------------------------------------------------------------------------------
--lab task 6.2

--1. Is there any branch which does not have postcode.

select * from branch where postCode is null;

--2. Detail of branch whose city name has a character 'n'.

select * from branch where city like '%n%'

--3. Show all staff members salary after 15% increase.

select staffNo,fname,lName ,position , salary,
       salary*1.15 as increased_salary
       from staff;

--4. How many properties are available in each branch.

select b.branchNo,count(p.propertyNo) as properties from branch b join propertyForRent p 
on b.branchNo = p.branchNo
group by b.branchNo;

--5. Address of branch where 'PL4' property is registered.
--existing one
select b.* from branch b join propertyForRent p on b.branchNo = p.branchNo where p.propertyNo = 'PA14'
--non existing
select b.* from branch b join propertyForRent p on b.branchNo = p.branchNo where p.propertyNo = 'PL4'

--6. Detail of client with minimum rent.

select top 1 * from client 
order by maxRent asc
--or
select * from client 
where maxRent = (select min(maxRent) from client);

--7. Detail of all registered clients with thier properties viewing detail.

select c.* , v.* from client c left join viewing v on c.clientNo = v.clientNo;

--8. Detail of clients who regiered after 11-04-13.

select c.* , r.dateJoined from client c join registration r on c.clientNo=r.clientNo
where r.dateJoined > '2011-04-13'

--9. Detail of properties of 'Carol'

select p.*,o.fNAme,o.lname from propertyForRent p left join privateOwner o on p.ownerNo=o.ownerNo
where o.fNAme='Carol';

--10. How many properties belongs to private owner "CO87".

select o.fNAme,o.lname,o.ownerNo,count(p.propertyNo) as total_properties from propertyForRent p 
join privateOwner o on o.ownerNo=p.ownerNo
where o.ownerNo='CO87'
group by o.ownerNo,o.fNAme,o.lname;

--11. Name of the private owner whose property has highest rent.

select o.fNAme,o.lname,p.rent from propertyForRent p join privateOwner o 
on p.ownerNo=o.ownerNo
where p.rent = (select max(p.rent) from propertyForRent p);

--12. Detail of staff whose age is under 30 years.

select * from staff where datediff(year,DOB,getdate())<30;

--13. Is there any client who is also a priavte owner.

SELECT c.*, p.*
FROM client c
JOIN privateOwner p
     ON c.fName = p.fNAme 
    AND c.lName = p.lname;

--14. Is there any property where the rent is not mentioned against it.

SELECT *
FROM propertyForRent
WHERE rent IS NULL OR rent = 0;

-------------------------------------------------------------------------------------------------

/*
Create a clone table of privateOwner in dreamHome database. Split the address attribute into three attributes 
(Street,city and postCode).
Other attribute should be same.
Data types are same.
Remove the primary key constraint.
change the data type from varchar to char of postCode attribute.
Increase the length character of email attribute.
Insert a record with the some same owner number already in the table.
Apply the primary key constraint againn onn owner number attribute.
Check for the duplicate owner numbers.
drop the attribute password.
Settle down the duplicate values of owner numbers.
*/

--create clone
select *
into privateowner_clone
from privateOwner
--dropping address
alter table privateowner_clone
drop column address;
alter table privateowner_clone
add street varchar(50),
    city varchar(30),
    postcode varchar(10);
--drop primary key
alter table privateowner_clone
drop constraint pk__privateowner;  
--change datatype 
alter table privateowner_clone
alter column postcode char(10);
--increase email length
alter table privateowner_clone
alter column email varchar(100);
--duplication
insert into privateowner_clone (ownerno, fname, lname, street, city, postcode, telno, email, password)
values ('co87','ali','khan','street 12','lahore','54000','03001234567','ali@test.com','abc123');
--re addprimary key
alter table privateowner_clone
add constraint pk_privateowner_clone primary key (ownerno);
--check duplicates
select ownerno, count(*) as duplicates
from privateowner_clone
group by ownerno
having count(*) > 1;
--drop password
alter table privateowner_clone
drop column password;
--settle duplicate values of owner no
with cte as (
    select *,
           row_number() over (partition by ownerno order by ownerno) as rn
    from privateowner_clone
)
delete from cte where rn > 1;

--------------------------------------------------------------------------



-----------------------------------------------------------------------------------------------

--List all staff members who work in the Glasgow branch.
select b.city,s.* from staff s
join branch b 
on s.staff_id=branch_Id
where b.city= 'Glasgow';

--Display each property number along with the owner’s full name.
select 
    pr.propertyNo,
    concat(o.fName, ' ', o.lName) as OwnerFullName
from propertyForRent pr
join privateOwner o 
    on pr.ownerNo = o.ownerNo;


--Show the names of clients who prefer ‘House’ type properties.
select * from client 
where prefType = 'House';

--Find the staff members whose salary is above the average salary of all staff.
select * from staff
where salary>(select avg(salary) from staff);

--List all properties whose rent is higher than the maximum rent of any ‘Flat’.
select * from propertyForRent where rent > (select max(rent) from propertyForRent where type='Flat');

--Display all branches that have more than one staff member working in them.

select 
    b.branchNo, 
    b.city, 
    count(s.staffNo) as totalMembers
from staff s
join branch b 
    on s.branchNo = b.branchNo
group by b.branchNo, b.city
having count(s.staffNo) > 1;


--Show the details of properties along with the clients who viewed them and their comments.

select 
    pr.propertyNo,
    pr.street,
    pr.city,
    c.clientNo,
    c.fName,
    c.lName,
    v.comment
from propertyForRent pr
join viewing v 
    on pr.propertyNo = v.propertyNo
join client c 
    on v.clientNo = c.clientNo;

--Display all properties along with the city of the branch they belong to.

select 
    pr.propertyNo,
    pr.street,
    pr.city as property_city,
    b.city as branch_city
from propertyForRent pr
join branch b 
    on pr.branchNo = b.branchNo;



--Find the staff members who have both registered clients and handled properties.


--Show the average rent for each property type.

select 
    type,
    avg(rent) as average_rent
from propertyForRent
group by type;


--Display how many properties each staff member handles.

select 
    s.staffNo,
    s.fName,
    s.lName,
    count(p.propertyNo) as total_properties
from staff s
join propertyForRent p 
    on s.staffNo = p.staffNo
group by s.staffNo, s.fName, s.lName;


--Find how many clients are registered in each branch.
select 
    b.branchNo,
    b.city,
    count(r.clientNo) as totalClients
from branch b
left join registration r 
    on b.branchNo = r.branchNo
group by b.branchNo, b.city;


--Retrieve the details of the property (or properties) having the second highest rent.
select *
from propertyForRent
where rent = (
    select max(rent)
    from propertyForRent
    where rent < (select max(rent) from propertyForRent)
);


--List all private owners who own more than one property.

select 
    o.ownerNo,
    o.fName,
    o.lName,
    count(p.propertyNo) as total_properties
from privateOwner o
join propertyForRent p 
    on o.ownerNo = p.ownerNo
group by o.ownerNo, o.fName, o.lName
having count(p.propertyNo) > 1;


--Identify the staff member(s) who handle the most number of properties.
select top 1
    s.staffNo,
    s.fName,
    s.lName,
    count(p.propertyNo) as totalProps
from staff s
join propertyForRent p 
    on s.staffNo = p.staffNo
group by s.staffNo, s.fName, s.lName
order by totalProps desc;
