create database ComputerRepairShop2;
use ComputerRepairShop2


create table customer (
    customer_id int identity(1,1) primary key,
    name varchar(100) not null,
    contact_number varchar(20),
    email varchar(100),
    address varchar(200)
);

create table computer (
    computer_id int identity(1,1) primary key,
    customer_id int not null,
    brand varchar(50),
    model varchar(50),
    serial_number varchar(50) unique,
    cpu varchar(50),
    ram varchar(20),
    storage varchar(50),
    received_date date,
    constraint fk_computer_customer foreign key (customer_id)
        references customer(customer_id)
        on delete cascade
);

create table technician (
    technician_id int identity(1,1) primary key,
    name varchar(100) not null,
    contact_number varchar(20),
    email varchar(100)
);

create table issue (
    issue_id int identity(1,1) primary key,
    computer_id int not null,
    issue_description varchar(255),
    diagnosed_date date,
    constraint fk_issue_computer foreign key (computer_id)
        references computer(computer_id)
        on delete cascade
);

create table repairjob(
repair_id int identity(1,1) primary key,
computer_id int foreign key references computer(computer_id),
technician_id int foreign key references technician(technician_id),
issue_id int foreign key references issue(issue_id),
repair_date date,
labour_cost int ,
payment_status varchar(10) check (payment_status in ('paid','pending')),
remarks varchar(70)
);

insert into customer (name, contact_number, email, address) values
('Ali Khan', '03001234567', 'ali.khan@gmail.com', 'Lahore, Pakistan'),
('Sara Ahmed', '03111234567', 'sara.ahmed@yahoo.com', 'Karachi, Pakistan'),
('Bilal Hussain', '03211234567', 'bilal.h@hotmail.com', 'Islamabad, Pakistan'),
('Zara Malik', '03331234567', 'zara.malik@gmail.com', 'Faisalabad, Pakistan'),
('Umar Farooq', '03451234567', 'umar.farooq@gmail.com', 'Multan, Pakistan');


-- 2. Insert into computer
insert into computer (customer_id, brand, model, serial_number, cpu, ram, storage, received_date) values
(1, 'Dell', 'Inspiron 15', 'SN1001', 'Intel i5', '8GB', '512GB SSD', '2025-10-01'),
(2, 'HP', 'Pavilion x360', 'SN1002', 'Intel i7', '16GB', '1TB SSD', '2025-10-02'),
(3, 'Lenovo', 'ThinkPad E14', 'SN1003', 'Intel i5', '8GB', '256GB SSD', '2025-10-03'),
(4, 'Asus', 'VivoBook 14', 'SN1004', 'AMD Ryzen 5', '8GB', '512GB SSD', '2025-10-04'),
(5, 'Acer', 'Aspire 5', 'SN1005', 'Intel i3', '4GB', '500GB HDD', '2025-10-05');



-- 3. Insert into technician
insert into technician (name, contact_number, email) values
('Ahmad Raza', '03004567891', 'ahmad.raza@techshop.com'),
('Nimra Iqbal', '03124567891', 'nimra.iqbal@techshop.com'),
('Hassan Ali', '03234567891', 'hassan.ali@techshop.com'),
('Fatima Noor', '03334567891', 'fatima.noor@techshop.com'),
('Imran Sheikh', '03454567891', 'imran.sheikh@techshop.com');



-- 4. Insert into issue
insert into issue (computer_id, issue_description, diagnosed_date) values
(1, 'System not booting properly', '2025-10-02'),
(2, 'Overheating during usage', '2025-10-03'),
(3, 'Blue screen error on startup', '2025-10-04'),
(4, 'Battery not charging', '2025-10-05'),
(5, 'SSD failure detected', '2025-10-06');


-- 5. Insert into repairjob
insert into repairjob (computer_id, technician_id, issue_id, repair_date, labour_cost, payment_status, remarks) values
(1, 1, 1, '2025-10-03', 2000, 'paid', 'Reinstalled OS and fixed boot issue'),
(2, 2, 2, '2025-10-04', 2500, 'pending', 'Cleaned fan and applied new thermal paste'),
(3, 3, 3, '2025-10-05', 1800, 'paid', 'Replaced RAM and fixed errors'),
(4, 4, 4, '2025-10-06', 1500, 'pending', 'Replaced charger port'),
(5, 5, 5, '2025-10-07', 3000, 'paid', 'Replaced SSD and reinstalled Windows');


--B
--1. Name and Id of technician with total number of computers they have been repaired.

select t.name,t.technician_id,count(r.computer_id)as total_repaird from technician t 
join repairjob r on t.technician_id=r.technician_id
group by t.technician_id,t.name

select 
    t.technician_id,
    t.name,
    count(distinct r.computer_id) as total_computers_repaired
from technician t
left join repairjob r on t.technician_id = r.technician_id
group by t.technician_id, t.name;


--2. Name and Id of technician with total number of computers they have been repaired in last month.



select 
    t.technician_id,
    t.name,
    count(distinct r.computer_id) as total_computers_repaired_last_month
from technician t
join repairjob r on t.technician_id = r.technician_id
where month(r.repair_date) = month(dateadd(month, -1, getdate()))
  and year(r.repair_date) = year(dateadd(month, -1, getdate()))
group by t.technician_id, t.name;


--3. List of computers which are still not repaired.

select * from computer where status!='Delivered'



select 
    c.computer_id,
    c.brand,
    c.model,
    c.received_date
from computer c
where c.computer_id not in (select computer_id from repairjob);


--4. Detail of technician who still didn't repair any computer.
select 
    t.technician_id,
    t.name,
    t.contact_number,
    t.email
from technician t
where t.technician_id not in (select distinct technician_id from repairjob);


--5. How many computers whose SSD have been replaced.
select 
    count(*) as total_ssd_replaced
from repairjob
where remarks like '%SSD%';


--6. Details of computers which are still not deliver back since 6 months.

select c.* from computer c 
left join repairjob r on c.computer_id=r.computer_id
where datediff(month,c.received_date,GETDATE())>=6;



select 
    c.computer_id,
    c.brand,
    c.model,
    c.received_date
from computer c
left join repairjob r on c.computer_id = r.computer_id
where r.repair_date is null 
   or datediff(month, c.received_date, getdate()) >= 6;


--7. How much labour cost we have received last month.


select sum(labour_cost) from repairjob where payment_status='paid'

and month(repair_date) = month(dateadd(month,-1,getDate()))
and year(repair_date) = year(dateadd(month,-1,getDate()));

select 
    sum(labour_cost) as total_received_last_month
from repairjob
where payment_status = 'paid'
  and month(repair_date) = month(dateadd(month, -1, getdate()))
  and year(repair_date) = year(dateadd(month, -1, getdate()));


--8. How much labour cost still due for last month.


select 
    sum(labour_cost) as total_due_last_month
from repairjob
where payment_status = 'pending'
  and month(repair_date) = month(dateadd(month, -1, getdate()))
  and year(repair_date) = year(dateadd(month, -1, getdate()));


--9. Detail of jobs that last week received with detail of technicians who repaired them.
select 
    r.repair_id,
    c.computer_id,
    c.brand,
    c.model,
    t.technician_id,
    t.name as technician_name,
    r.repair_date,
    r.labour_cost,
    r.payment_status
from repairjob r
join computer c on r.computer_id = c.computer_id
join technician t on r.technician_id = t.technician_id
where r.repair_date between dateadd(week, -1, getdate()) and getdate();


--10. Detail of customers with their cell number and email address.
select 
    customer_id,
    name as customer_name,
    contact_number,
    email
from customer;



