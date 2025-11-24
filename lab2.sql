CREATE DATABASE ComputerRepairShop;
USE ComputerRepairShop;

-- IN IDNETITY FIRST PARAMETER IS START AND OTHER IS INCREMENT
CREATE TABLE CustomersDetails1(
customer_ID INT PRIMARY KEY IDENTITY(1,1),
full_Name VARCHAR(50) NOT NULL,
phone_Number VARCHAR(20),
city_Name VARCHAR(20),
entering_Date DATE
);


INSERT INTO CustomersDetails1(full_Name, phone_Number, city_Name, entering_Date)
VALUES
('Abdul Haq', '03483457892', 'Lahore', '2014-03-24'),
('Ali Khan', '03001234567', 'Karachi', '2015-06-12'),
('Sara Ahmed', '03124567890', 'Islamabad', '2016-09-05'),
('Zain Malik', '03339876543', 'Lahore', '2017-11-22'),
('Ayesha Noor', '03217894561', 'Karachi', '2018-01-14'),
('Hamza Iqbal', '03098765432', 'Faisalabad', '2019-07-30');

select * from CustomersDetails1;

INSERT INTO CustomersDetails1(full_Name,phone_Number,city_Name,entering_Date)
VALUES
('Ahmad waraich','498379483279','Lahore','2025-02-18'),
('abdullah ali','03343923232','Karachi','2025-09-10');

select * from CustomersDetails1;

CREATE TABLE TechnicianDetails1(
technician_Id INT PRIMARY KEY IDENTITY(1,1),
technician_name VARCHAR(50),
phone_number VARCHAR(20),
specialization VARCHAR(30)
);

INSERT INTO TechnicianDetails1 (technician_name, phone_number, specialization)
VALUES
('Ali Raza', '03001234567', 'Laptop Repair'),
('Sara Ahmed', '03121234567', 'Networking'),
('Bilal Khan', '03211234567','Hardware Troubleshooting'),
('Zain Malik', '03331234567', 'Software Installation'),
('Ayesha Noor', '03451234567', 'Data Recovery');


CREATE TABLE MachineDetails1 (
    machine_Id INT PRIMARY KEY IDENTITY(1,1),
    brand VARCHAR(20),
    receiving_date DATE NOT NULL,
    returning_date DATE,
    status VARCHAR(20) DEFAULT 'received'
        CHECK (status IN ('received','diagnosed','repairing','repaired')),
    customer_ID INT NOT NULL,
    FOREIGN KEY (customer_ID) REFERENCES CustomersDetails1(customer_ID)
);


INSERT INTO MachineDetails1 (brand, receiving_date, returning_date, status, customer_ID)
VALUES ('Lenovo', '2025-01-01', NULL, 'received', 3);

INSERT INTO MachineDetails1(brand , receiving_date , returning_date , status , customer_ID)
VALUES ('Dell','2025-10-09',NULL,'diagnosed',1);


CREATE TABLE issues(
issue_id INT PRIMARY KEY ,
issue_description VARCHAR(50)
);

INSERT INTO issues (issue_id, issue_description)
VALUES
(1, 'Screen Replacement'),
(2, 'RAM Replacement'),
(3, 'Hard Disk Failure'),
(4, 'Keyboard Not Working'),
(5, 'Operating System Reinstallation');


CREATE TABLE machineIssue(
machineIssues_Id INT PRIMARY KEY IDENTITY (1,1) ,
customer_ID int not null,
issue_Id int not null,
technician_Id int not null,
FOREIGN KEY (customer_ID) REFERENCES customersDetails1(customer_ID),
FOREIGN KEY (issue_Id) REFERENCES issues(issue_id),
FOREIGN KEY (technician_Id) REFERENCES technicianDetails1(technician_Id)
);

insert into machineIssue(customer_ID,issue_Id,technician_Id)
values
(3,1,4);
insert into machineIssue(customer_ID,issue_Id,technician_Id)
values
(3,2,5);
insert into machineIssue(customer_ID,issue_Id,technician_Id)
values
(1,2,3);


CREATE TABLE RepairLabour (
    LabourID INT PRIMARY KEY IDENTITY(1,1),
    machine_Id INT NOT NULL,
    technician_Id INT NOT NULL,
    LabourCost INT NOT NULL,
    PaymentStatus VARCHAR(10) DEFAULT 'Pending'
        CHECK (PaymentStatus IN ('Pending','Paid')),

    FOREIGN KEY (machine_Id) REFERENCES MachineDetails1(machine_Id),
    FOREIGN KEY (technician_Id) REFERENCES technicianDetails1(technician_Id)
);

insert into RepairLabour(machine_Id,technician_Id,LabourCost,PaymentStatus)
values
(1,4,3000,'Pending');

--1. Customer details.

select * from CustomersDetails1;

--2. Computer details

select * from machineDetails1;

--3. Issues diagnose for any computer.
--to show issue description that is in other table we need to use join here
SELECT mi.machineIssues_Id, 
       mi.customer_ID, 
       mi.issue_Id, 
       i.issue_description
FROM machineIssue mi
JOIN issues i ON mi.issue_Id = i.issue_id
JOIN MachineDetails1 m ON mi.customer_ID = m.customer_ID


--4. How much labour is due on any copmputer

Select machine_Id , sum(labourCost) As totalDue
from RepairLabour
where PaymentStatus= 'Pending'
group by machine_Id;


--5. How many computer received in a specific date.

select count(receiving_date) As computersReceivedinDate from MachineDetails1
where receiving_date='2025-10-09';

--6. How many computers returned after repaired.

Select count(machine_Id) as totalreturned from MachineDetails1
where status= 'repaired' and returning_date is not null;

--7. Search for any specific job (computer)

--based on id
select * from MachineDetails1
where machine_Id =1;
--based on brand type
select * from MachineDetails1
where brand ='dell';

--8. Seacrh for the technician details who repaired the computer

SELECT r.machine_id as machineId,t.technician_Id, t.technician_name, t.phone_number, t.specialization
FROM TechnicianDetails1 t
JOIN RepairLabour r ON t.technician_Id = r.technician_Id
WHERE r.machine_Id = 1; 


--9. Detail of computer with its customer name.

SELECT m.machine_Id, m.brand, m.receiving_date, m.returning_date, m.status,
       c.full_Name AS CustomerName
FROM MachineDetails1 m
JOIN CustomersDetails1 c 
    ON m.customer_ID = c.customer_ID
where c.full_Name = 'Abdul haq';

--10. Detail of customer for some computer he has.

SELECT c.customer_ID, c.full_Name, c.phone_Number, c.city_Name, c.entering_Date
FROM CustomersDetails1 c
JOIN MachineDetails1 m ON c.customer_ID = m.customer_ID
WHERE m.machine_Id = 1; 

--11. Detail of technician

select * from TechnicianDetails1;

--12. Technicians from Karachi city.

ALTER TABLE TechnicianDetails1
ADD city VARCHAR(30);
UPDATE TechnicianDetails1
SET city = 'Karachi'
WHERE technician_Id IN (1,3,5); 
Select * from TechnicianDetails1 where city = 'Karachi';

--13. How many customers have been served in current year.

select count(customer_ID) as customersServedThisYear from CustomersDetails1
where entering_Date > '2024-12-31';

--14. How many computers have been diagnosed with RAM replacement.
--both do same task
select count(machineIssues_Id) as RamReplacedcomputers from machineIssue
where issue_id = 2;

SELECT COUNT(DISTINCT m.machine_Id) AS RamReplacementComputers
FROM machineIssue i
JOIN issues ii ON ii.issue_id = i.issue_id
JOIN MachineDetails1 m ON i.customer_ID = m.customer_ID
WHERE ii.issue_description = 'RAM Replacement';


--15. How many DELL computers they received.

select * from machineDetails1
where brand='dell';


---------------------------------------------------------