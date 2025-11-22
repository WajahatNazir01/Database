
--SP24-BSE-122-(B)
--task1
CREATE DATABASE Dental_Solutions;

USE Dental_Solutions;

CREATE TABLE Dentist_Information (
    Dentist_ID INT PRIMARY KEY NOt Null,
    First_Name VARCHAR(20),
    Last_Name VARCHAR(20),
    Joining_Date DATE,
    PMDC_Number VARCHAR(50) NULL,
    Email VARCHAR(50),
    Phone VARCHAR(15) NOT NULL,
    City_Name VARCHAR(50),
    Last_Degree VARCHAR(100),
    Specialization VARCHAR(100)
);

CREATE TABLE Patient_Detail (
    Patient_ID INT PRIMARY KEY,
    First_Name VARCHAR(100),
    Last_Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15) NOT NULL,
    City_Name VARCHAR(100)
);

CREATE TABLE Services (
    Service_ID INT PRIMARY KEY,
    Service_Detail VARCHAR(100),
    Service_Name VARCHAR(100)
);

INSERT INTO Services (Service_ID, Service_Detail, Service_Name)
VALUES
(1, 'Get your scaling done', 'Scaling'),
(2, 'Get your teeth polished for a brighter smile', 'Polishing'),
(3, 'Comprehensive dental check-up and consultation', 'Check-up'),
(4, 'Get your cavity filled with high-quality material', 'Filling'),
(5, 'Professional tooth extraction service', 'Extraction');

insert into Dentist_Information
(Dentist_ID, First_Name, Last_Name, Joining_Date, PMDC_Number, Email,
Phone, City_Name, Last_Degree, Specialization)
VALUES
(1, 'Abdul', 'Hadi', '2005-10-02', '1', 'abdulhadi@email.com',
'03012345', 'Lahore', 'BDS', 'Orthodontics'),
(2, 'Ali', 'Hamza', '2012-11-02', '2', 'alihamza@email.com',
'03022345', 'Multan', 'MDS', 'Endodontics'),
(3, 'Ahmed', 'Mustafa', '2020-12-02', '3', 'ahmedmustafa@email.com',
'03034567', 'Faisalabad', 'BDS', 'Prosthodontics'),
(4, 'Hashir', 'Jutt', '2015-12-13', '4', 'hashirjutt@email.com',
'03045678', 'Islamabad', 'MDS', 'Periodontics'),
(5, 'Faisal', 'Khan', '2000-12-14', '5', 'faisalkhan@email.com',
'03056789', 'Farooqabad', 'BDS', 'General Dentistry');

INSERT INTO Patient_Detail (Patient_ID, First_Name, Last_Name, Email, Phone, City_Name)
VALUES
(1, 'Ali', 'Khan', 'ali.khan@example.com', '03001234567', 'Lahore'),
(2, 'Sara', 'Malik', 'sara.malik@example.com', '03019876543', 'Karachi'),
(3, 'Usman', 'Sheikh', 'usman.sheikh@example.com', '03121234567', 'Islamabad'),
(4, 'Hina', 'Riaz', 'hina.riaz@example.com', '03234567890', 'Faisalabad'),
(5, 'Bilal', 'Ahmed', 'bilal.ahmed@example.com', '03349876543', 'Multan');


SELECT * FROM Dentist_Information
WHERE dentist_id=1 or dentist_id=3;

--1. List of names of Dentist ID, name and PMDC number.

SELECT Dentist_ID,First_Name, Last_Name,PMDC_Number FROM Dentist_Information;

--2. Names of Dentist with their email and phone number.

SELECT First_Name, Last_Name, Email FROM Dentist_Information;

--3. List of dentist with their specialization.

SELECT First_Name, Last_Name,Specialization FROM Dentist_Information;

--4. Dentist Id, name and their Last degree.

SELECT Dentist_ID , First_Name, Last_Name,Last_Degree FROM Dentist_Information;

--5. Total number of dentists.

SELECT COUNT(Dentist_ID) FROM Dentist_Information;

--6. Dentist name and their city name.

SELECT Dentist_ID , First_Name, City_Name FROM Dentist_Information;

--7. City name from which the dentist are.

SELECT DISTINCT City_Name FROM Dentist_Information;

--8. Detail of services offered by the clinic.

SELECT Service_Detail FROM Services;
--9. Detail of patients.

SELECT * FROM Patient_Detail;

--10. Display the Email, city and name of dentists.

SELECT First_Name,Last_Name,City_Name,Email FROM Dentist_Information;

--11. How many patients are their in the system.

SELECT COUNT(Patient_ID) FROM Patient_Detail;

--12. Detail of patient whose ID is 5

SELECT * FROM Patient_Detail
WHERE Patient_ID = 5;

--13. Detail of patient whose Id is 2 and 4

SELECT * FROM Patient_Detail
WHERE Patient_ID=2 or Patient_ID=4;

--14. Detail of all patients order by their name.

SELECT * FROM Patient_Detail
ORDER BY First_Name ASC; 

--15. Detail of patients belong from Lahore city.

SELECT * FROM Patient_Detail
WHERE City_Name like 'Lahore';

--16. Detail of dentists who join the clinic before 2015.

SELECT * FROM Dentist_Information
WHERE Joining_Date< '2015-01-01';



--------------------------------------------------------------------


--TASK2
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

CREATE TABLE TechnicianDetails2(
technician_Id INT PRIMARY KEY IDENTITY(1,1),
technician_name VARCHAR(50),
phone_number VARCHAR(20),
specialization VARCHAR(30)
);

INSERT INTO TechnicianDetails2 (technician_name, phone_number, specialization)
VALUES
('Ali Raza', '03001234567', 'Laptop Repair'),
('Sara Ahmed', '03121234567', 'Networking'),
('Bilal Khan', '03211234567','Hardware Troubleshooting'),
('Zain Malik', '03331234567', 'Software Installation'),
('Ayesha Noor', '03451234567', 'Data Recovery');


CREATE TABLE MachineDetails2 (
    machine_Id INT PRIMARY KEY IDENTITY(1,1),
    brand VARCHAR(20),
    receiving_date DATE NOT NULL,
    returning_date DATE,
    status VARCHAR(20) DEFAULT 'received'
        CHECK (status IN ('received','diagnosed','repairing','repaired')),
    customer_ID INT NOT NULL,
    FOREIGN KEY (customer_ID) REFERENCES CustomersDetails1(customer_ID)
);


INSERT INTO MachineDetails2 (brand, receiving_date, returning_date, status, customer_ID)
VALUES ('Lenovo', '2025-01-01', NULL, 'received', 3);

INSERT INTO MachineDetails2(brand , receiving_date , returning_date , status , customer_ID)
VALUES ('Dell','2025-10-09',NULL,'diagnosed',1);


CREATE TABLE issues1(
issue_id INT PRIMARY KEY ,
issue_description VARCHAR(50)
);

INSERT INTO issues1(issue_id, issue_description)
VALUES
(1, 'Screen Replacement'),
(2, 'RAM Replacement'),
(3, 'Hard Disk Failure'),
(4, 'Keyboard Not Working'),
(5, 'Operating System Reinstallation');


CREATE TABLE machineIssues1(
machineIssues_Id INT PRIMARY KEY IDENTITY (1,1) ,
customer_ID int not null,
issue_Id int not null,
technician_Id int not null,
FOREIGN KEY (customer_ID) REFERENCES customersDetails1(customer_ID),
FOREIGN KEY (issue_Id) REFERENCES issues1(issue_id),
FOREIGN KEY (technician_Id) REFERENCES technicianDetails2(technician_Id)
);

insert into machineIssues1(customer_ID,issue_Id,technician_Id)
values
(3,1,4);
insert into machineIssues1(customer_ID,issue_Id,technician_Id)
values
(1,2,3);


CREATE TABLE RepairLabour1 (
    LabourID INT PRIMARY KEY IDENTITY(1,1),
    machine_Id INT NOT NULL,
    technician_Id INT NOT NULL,
    LabourCost INT NOT NULL,
    PaymentStatus VARCHAR(10) DEFAULT 'Pending'
        CHECK (PaymentStatus IN ('Pending','Paid')),

    FOREIGN KEY (machine_Id) REFERENCES MachineDetails2(machine_Id),
    FOREIGN KEY (technician_Id) REFERENCES technicianDetails2(technician_Id)
);

insert into RepairLabour1(machine_Id,technician_Id,LabourCost,PaymentStatus)
values
(1,4,3000,'Pending');

--1. Customer details.

select * from CustomersDetails1;

--2. Computer details

select * from machineDetails2;

--3. Issues diagnose for any computer.

select * from machineIssues1
where customer_ID =3;

--4. How much labour is due on any copmputer

--select LabourID,labourCost,PaymentStatus from RepairLabour1;
Select machine_Id , sum(labourCost) As totalDue
from RepairLabour1
where PaymentStatus= 'Pending'
Group by machine_id;

--5. How many computer received in a specific date.

select count(receiving_date) As computersReceivedinDate from MachineDetails2
where receiving_date='2025-10-09';

--6. How many computers returned after repaired.

Select count(machine_Id) as totalreturned from MachineDetails2
where status= 'repaired' and returning_date is not null;

--7. Search for any specific job (computer)

--based on id
select * from MachineDetails2
where machine_Id =1;
--based on brand type
select * from MachineDetails2
where brand ='dell';

--8. Seacrh for the technician details who repaired the computer

SELECT t.technician_Id, t.technician_name, t.phone_number, t.specialization
FROM TechnicianDetails2 t
JOIN RepairLabour1 r ON t.technician_Id = r.technician_Id
WHERE r.machine_Id = 1; 

--9. Detail of computer with its customer name.

SELECT m.machine_Id, m.brand, m.receiving_date, m.returning_date, m.status,
       c.full_Name AS CustomerName
FROM MachineDetails2 m
JOIN CustomersDetails1 c 
    ON m.customer_ID = c.customer_ID;

--10. Detail of customer for some computer he has.

SELECT c.customer_ID, c.full_Name, c.phone_Number, c.city_Name, c.entering_Date
FROM CustomersDetails1 c
JOIN MachineDetails2 m ON c.customer_ID = m.customer_ID
WHERE m.machine_Id = 1; 

--11. Detail of technician

select * from TechnicianDetails2;

--12. Technicians from Karachi city.

ALTER TABLE TechnicianDetails2
ADD city VARCHAR(30);
UPDATE TechnicianDetails2
SET city = 'Karachi'
WHERE technician_Id IN (1,3,5); 
Select * from TechnicianDetails2 where city = 'Karachi';
select * from technicianDetails2
where technician_name = 'Zain Malik';


--13. How many customers have been served in current year.

select count(customer_ID) as customersServedThisYear from CustomersDetails1
where entering_Date > '2024-12-31';

--14. How many computers have been diagnosed with RAM replacement.

select count(machineIssues_Id) as RamReplacedcomputers from machineIssues1
where issue_id = 2;

--15. How many DELL computers they received.

select * from machineDetails2
where brand='dell';



-------------------------------------------------------------------------