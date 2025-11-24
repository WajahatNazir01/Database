CREATE DATABASE bikesdata;
USE bikesdata;

create table Company(
company_id int identity(1,1) primary key,
company_name varchar(30) not null,
type varchar(20) not null check(type in('manufacturer','assembler','both')),
city varchar(20),
country varchar(20)
);

INSERT INTO Company (company_name, [type], city, country)
VALUES
('Honda', 'both', 'Tokyo', 'Japan'),
('Yamaha', 'manufacturer', 'Karachi', 'Pakistan'),
('Suzuki', 'assembler', 'Lahore', 'Pakistan'),
('KTM', 'manufacturer', 'Mattighofen', 'Austria'),
('Hero', 'manufacturer', 'Gurgaon', 'India');

INSERT INTO Company (company_name, [type], city, country)
VALUES
('Bandan','assembler','Karachi','Pakistan'),
('Velocity','assembler','Karachi','Pakistan');

create table bikes(
bike_id int identity(1000,1) primary key,
company_id int foreign key references Company(company_id),
bike_name varchar(20) not null,
cc int not null,
type_of_bike varchar(20) check(type_of_bike in ('petrol','electric')),
power_watt int null,
price int not null,
);

INSERT INTO Bikes (company_id, bike_name, cc, type_of_bike, power_watt, price)
VALUES
(2, 'YBR', 125, 'petrol', 0, 500000),        
(1, 'CBR150', 150, 'petrol', 0, 250000),
(3, 'GS150', 150, 'petrol', 0, 230000),
(4, 'Duke390', 390, 'petrol', 0, 800000),
(5, 'Splendor', 125, 'petrol', 0, 120000),
(2, 'FZ-S', 150, 'petrol', 0, 270000),
(1, 'Honda Electric X', 0, 'electric', 1500, 300000),   
(3, 'Suzuki E-Rider', 0, 'electric', 1500, 220000);    


--1.Detail of motorbikes manufacturers in Pakistan 

select * from company where type= 'manufacturer';

--2.  How many companies motorbikes available in Pakistan.

select count(company_id) as number_of_companies from company;

--3. Detail of motorbikes assembled in Pakistan

select * from company where type= 'assembler' and country = 'pakistan';

--4. Detail of motorbikes according to power (CC)

select * from bikes 
order by cc asc;
--5. Price comparison of 70CC of each company

select b.bike_id,b.bike_name,b.cc,b.company_id
from bikes b 
join Company c 
on c.company_id = b.company_id
where b.cc = 70;

--6. Detail of companies which sell 150CC motorbike.

select c.company_id, c.company_name,c.type,c.city,c.country
from Company c
join bikes b 
on c.company_id = b.company_id
where b.cc=150;

--7. Price comparison of 125CC motorbikes.

select bike_id,bike_name,cc,company_id from bikes
where cc= 125;

--8. Detail of companies which provide more than 150CC motorbikes.

select c.company_id, c.company_name, c.type, c.city, c.country
from Company c
join Bikes b
on b.company_id = c.company_id
where b.cc > 150;

--9. Detail of companies which sell electric bikes.

select c.company_id, c.company_name, c.type, c.city, c.country
from Company c
join bikes b
on b.company_id=c.company_id
where b.type_of_bike='electric';

--10. Comparison of price of electric bikes with 1500 watt capacity.

select bike_name, price, power_watt
from Bikes
where type_of_bike='electric' and power_watt=1500
order by price asc;

--11. Detail of electric bikes which have price more than Rupees 200,000.

select * from bikes 
where type_of_bike='electric' and price > 200000;

--12. Detail of motorbike assembler based in Lahore.

select * from Company
where type='assembler' and city='Lahore';

--13. Detail of motorbike assembler based in Karachi.

select b.bike_id, b.bike_name, b.cc, b.type_of_bike, b.price
from bikes b
join company c
on b.company_id = c.company_id
where c.type = 'assembler' and c.city = 'karachi';

--14. Delete the data of 500CC motorbikes, we don't need that.

delete from bikes
where cc=500;

----------------------------------------------------

--Task 2

create database LeagueDataStorage
use LeagueDataStorage

create table team(
team_id int primary key,
team_name varchar(30),
captain_name varchar(20),
wicket_keeper_name varchar(20)
);

insert into team (team_id,team_name, captain_name, wicket_keeper_name)
values
(77,'Falcons', 'Shaheen Afridi', 'M Azam'),
(78,'Warriors', 'Babar Azam', 'M Rizwan'),
(79,'Rangers', 'Shadab Khan', 'Fahim Ashraf'),
(80,'Dragons', 'Mohammad Rizwan', 'Sarfaraz Ahmed'),
(81,'Titans', 'Imad Wasim', 'Kamran Akmal'),
(82,'Knights', 'Shoaib Malik', 'Mushfiqur Rahim');


create table player(
player_id int primary key,
nam varchar(20),
shirt_number int not null,
team_id int foreign key references team(team_id)
);

insert into player (player_id, nam, shirt_number, team_id)
values
(2, 'Ahsan', 11, 77),
(3, 'Shahbaz', 9, 78),
(4, 'Imran', 12, 78),
(5, 'Fahad', 7, 79),
(6, 'Usman', 8, 79),
(7, 'Bilal', 13, 80),
(8, 'Owais', 14, 80),
(9, 'Hamza', 15, 81),
(10, 'Rizwan', 16, 81),
(11, 'Sami', 17, 82),
(12, 'Noman', 18, 82);

create table matches(
match_id int identity(1,1) primary key,
match_number int ,
team1_id int foreign key references team(team_id),
team2_id int foreign key references team(team_id),
team1_score int,
team2_score int,
winner_team_id int foreign key references team(team_id),
date_of_match date not null
);

INSERT INTO matches (match_number, team1_id, team2_id, team1_score, team2_score, winner_team_id, date_of_match)
VALUES
(1, 77, 78, 150, 145, 77, '2025-09-01'),  -- Falcons vs Warriors
(2, 79, 80, 160, 170, 80, '2025-09-02'),  -- Titans vs Knights
(3, 81, 82, 180, 175, 81, '2025-09-03'),  -- Rangers vs Dragons
(4, 77, 79, 140, 142, 79, '2025-09-04'),  -- Falcons vs Titans
(5, 78, 82, 155, 160, 82, '2025-09-05');  -- Warriors vs Dragons



--1. Detail of teams

select * from team;

--2. Total number of teams participated in the tournament.

select count(distinct team_id) as total_teams_participated
from (
    select team1_id as team_id from matches
    union
    select team2_id as team_id from matches
) as all_teams;

--3. Total number of matches played in the league so far.

select count(match_id) as total_matches_played
from matches;

--4. Which two teams played match number 1.

select team1_id , team2_id from matches
where match_id = 1;

--5. What was the total score of team1 in first match.

select team1_id,team1_score from matches
where match_id = 1;

--6. What was the total score of the match in first match.

select sum(team1_score+team2_score) as total_score
from matches;

--7. Which team won the first match.

select t.team_id,t.team_name
from team t 
join matches m 
on t.team_id=m.winner_team_id
where m.match_id =1;

--8. Name of each player of each team with his shirt number.

SELECT t.team_name, p.nam AS player_name, p.shirt_number
FROM player p
JOIN team t ON p.team_id = t.team_id
ORDER BY t.team_name, p.shirt_number;


--9. Name of the team captain of each team.

SELECT team_name, captain_name
FROM team;


--10.Name of wicket keeper of each team.

SELECT team_name, wicket_keeper_name
FROM team;


-------------------------------------------------------