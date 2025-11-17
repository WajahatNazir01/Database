create database nhl;
use nhl;

create table teams(
team_id int primary key identity(1,1),
team_name varchar(20) not null,
city varchar(20) ,
coach varchar(20),
captain_id int null
);
create table player(
player_id int primary key identity(1,1),
player_name varchar(20),
position varchar(10),
skill_level int ,
team_id int foreign key references teams(team_id)
);
create table injury_record(
injury_id int primary key identity(1,1),
player_id int foreign key references player(player_id),
injury_type varchar(20),
injury_date date
);
create table match(
match_id int primary key identity(1,1),
match_date date,
host_team_id int foreign key references teams(team_id),
guest_team_id int foreign key references teams(team_id),
host_score int ,
guest_score int 
);

INSERT INTO teams(team_name, city, coach)
VALUES
('Sharks', 'Karachi', 'Ahmed'),
('Falcons', 'Lahore', 'Hassan'),
('Titans', 'Islamabad', 'Kashif'),
('Wolves', 'Peshawar', 'Rizwan'),
('Eagles', 'Quetta', 'Imran');
INSERT INTO player (player_name, position, skill_level, team_id)
VALUES
('Rehan', 'Goalie', 8, 1),
('Asad', 'Left Wing', 7, 1),
('Bilal', 'Goalie', 9, 2),
('Salman', 'Right Wing', 6, 2),
('Umar', 'Center', 7, 3),
('Hassan', 'Goalie', 8, 3),
('Ali', 'Defense', 7, 4),
('Waleed', 'Goalie', 6, 4),
('Zain', 'Center', 8, 5),
('Nabeel', 'Goalie', 7, 5);

INSERT INTO match (match_date, host_team_id, guest_team_id, host_score, guest_score)
VALUES
('2025-01-01', 1, 2, 3, 2),  -- Sharks beat Falcons
('2025-01-05', 2, 1, 1, 1),  -- Falcons draw Sharks
('2025-01-10', 1, 3, 4, 1),  -- Sharks beat Titans
('2025-01-15', 3, 1, 2, 3),  -- Titans lose to Sharks
('2025-01-20', 2, 4, 0, 2),  -- Falcons lose to Wolves
('2025-01-25', 4, 2, 1, 0),  -- Wolves beat Falcons
('2025-02-01', 3, 5, 2, 2),  -- Titans draw Eagles
('2025-02-05', 5, 3, 3, 1),  -- Eagles beat Titans
('2025-02-10', 4, 5, 1, 4),  -- Wolves lose to Eagles
('2025-02-15', 5, 4, 2, 2);  -- Eagles draw Wolves



select * from player;


UPDATE teams SET captain_id = 1 WHERE team_name = 'Sharks';
UPDATE teams  SET captain_id = 3 WHERE team_name = 'Falcons';
UPDATE teams SET captain_id = 5 WHERE team_name = 'Titans';
UPDATE teams SET captain_id = 7 WHERE team_name = 'Wolves';
UPDATE teams SET captain_id = 9 WHERE team_name = 'Eagles';


ALTER TABLE teams
ADD CONSTRAINT FK_Teams_Captain
FOREIGN KEY (captain_id)
REFERENCES player(player_id);

INSERT INTO teams(team_name, city, coach)
VALUES
('Panthers', 'Multan', 'Junaid'),
('Rangers', 'Sialkot', 'Faizan'),
('Dragons', 'Hyderabad', 'Tariq'),
('Hawks', 'Faisalabad', 'Saad'),
('Spartans', 'Rawalpindi', 'Noman');

INSERT INTO player (player_name, position, skill_level, team_id)
VALUES
-- Panthers (team_id = 6)
('Farhan', 'Goalie', 8, 6),
('Tahir', 'Left Wing', 7, 6),

-- Rangers (team_id = 7)
('Rameez', 'Goalie', 9, 7),
('Zeeshan', 'Center', 8, 7),

-- Dragons (team_id = 8)
('Daniyal', 'Goalie', 7, 8),
('Usman', 'Right Wing', 6, 8),

-- Hawks (team_id = 9)
('Kashan', 'Goalie', 8, 9),
('Arham', 'Defense', 7, 9),

-- Spartans (team_id = 10)
('Muneeb', 'Goalie', 9, 10),
('Hamza', 'Center', 8, 10);

UPDATE teams SET captain_id = 11 WHERE team_name = 'Panthers';
UPDATE teams SET captain_id = 13 WHERE team_name = 'Rangers';
UPDATE teams SET captain_id = 15 WHERE team_name = 'Dragons';
UPDATE teams SET captain_id = 17 WHERE team_name = 'Hawks';
UPDATE teams SET captain_id = 19 WHERE team_name = 'Spartans';


INSERT INTO match (match_date, host_team_id, guest_team_id, host_score, guest_score)
VALUES
('2025-02-20', 6, 1, 2, 3),  -- panthers lose to sharks
('2025-02-25', 7, 2, 1, 0),  -- rangers beat falcons
('2025-03-01', 8, 3, 2, 2),  -- dragons draw titans
('2025-03-05', 9, 4, 3, 1),  -- hawks beat wolves
('2025-03-10', 10, 5, 1, 2), -- spartans lose to eagles

('2025-03-15', 1, 6, 2, 2),  -- sharks draw panthers
('2025-03-20', 2, 7, 0, 1),  -- falcons lose to rangers
('2025-03-25', 3, 8, 3, 0),  -- titans beat dragons
('2025-03-30', 4, 9, 1, 1),  -- wolves draw hawks
('2025-04-05', 5, 10, 4, 2), -- eagles beat spartans
('2025-04-10', 6, 2, 1, 3),  -- panthers lose to falcons
('2025-04-15', 7, 3, 2, 2),  -- rangers draw titans
('2025-04-20', 8, 4, 0, 1),  -- dragons lose to wolves
('2025-04-25', 9, 5, 1, 2),  -- hawks lose to eagles
('2025-04-30', 10, 1, 2, 3), -- spartans lose to sharks
('2025-05-05', 1, 7, 4, 1),  -- sharks beat rangers
('2025-05-10', 2, 8, 1, 0),  -- falcons beat dragons
('2025-05-15', 3, 9, 2, 3),  -- titans lose to hawks
('2025-05-20', 4, 10, 2, 2), -- wolves draw spartans
('2025-05-25', 5, 6, 1, 1);  -- eagles draw panthers
INSERT INTO injury_record (player_id, injury_type, injury_date)
VALUES
(2, 'Knee Sprain', '2025-01-05'),
(4, 'Shoulder Dislocation', '2025-01-12'),
(6, 'Ankle Twist', '2025-01-20'),
(7, 'Back Strain', '2025-01-25'),
(9, 'Concussion', '2025-02-02'),
(11, 'Hamstring Pull', '2025-03-05'),
(13, 'Wrist Fracture', '2025-03-18'),
(15, 'Groin Injury', '2025-04-01'),
(17, 'Elbow Dislocation', '2025-04-12'),
(19, 'Knee Ligament', '2025-04-20');



--1. Details of NHL

select t.team_name,t.team_id,t.city,t.coach,p.player_name,p.position,p.skill_level,i.injury_type,i.injury_date
from teams t join player p on t.team_id = p.player_id
left join injury_record i on  p.player_id = i.player_id


--2. Details of all the teams registered in NHL

select * from teams
--3. Name of captains with their team name

select t.team_id,t.team_name , p.player_name as captain_name
from teams t 
join player p on t.captain_id = p.player_id;

--4. Name of goalkeepers of each team with team name
select t.team_name, p.player_name as goalkeeper
from player p
join teams t on p.team_id = t.team_id
where p.position = 'goalie';


--5. Detail fo players of team 1.

select * from player where team_id =1;

--6. Detail of players with the name of "Rehan"

select * from player where player_name = 'rehan'


--7. Detail of players whose name end with characters "am"
select * from player where player_name like '%am';

--8. Deail of goalkeepers with the detail of their teams.
select t.team_id, t.team_name, t.coach from teams t 
join player p on t.team_id=p.team_id
where p.position='goalie';

--9. Detail of postions held in the team.

select distinct position from player

--10. Detail of skills players have.

select player_name, skill_level
from player;

--11. Detail of match 1.

select * from match where match_id=1;

--12. Which team won the match number 10.
select
case when host_score> guest_score then t1.team_name 
     when guest_score>host_score then t2.team_name 
     else 'draw'
end as winner

     from match m 
     join teams t1 on m.host_team_id= t1.team_id
     join teams t2 on m.guest_team_id = t2.team_id
     where match_id=10;
--13. Which team won the most matches.
    select top 1 team_name , count(*) as wins
    from (
    select host_team_id as team_id from match where host_score>guest_score union all
    select guest_team_id as team_id from match where guest_score>host_score
    ) as winners join teams t on winners.team_id = t.team_id
    group by team_name order by wins desc



--14. How many total matches palyed in this league.

select count (*) as total_matches from match;

--15. Which team scored the most goals

select top 1 t.team_name ,sum(goals) as total_goals from (
select host_team_id as team_id ,host_score as goals from match union all
select guest_team_id as team_id,guest_score as goals from match)
as all_goals
join teams t on all_goals.team_id=t.team_id
group by t.team_name order by total_goals desc



--16. All the team names and the total players of each team .
select t.team_name , count(p.player_id) as tota_players
from teams t join player p on t.team_id=p.team_id
group by t.team_name;

--17. Score of match number 5
select * from match where match_id=5;

--18. Name of the coaches of each team

select team_name, coach from teams

--19. Detail of teams who won their home matches.

select distinct t.team_name, t.coach,t.team_id,m.match_id, m.match_date, m.host_score, m.guest_score
from match m
join teams t on m.host_team_id = t.team_id
where m.host_score > m.guest_score;

--20. Detail of matches played on Sunday.

select * from match where datename (weekday,match_date) ='Sunday'

--ANSWERED QUERIES
-- 1. details of nhl
select 
    t.team_name,
    t.city,
    t.coach,
    p.player_name,
    p.position,
    p.skill_level,
    i.injury_type,
    i.injury_date
from teams t
join player p on t.team_id = p.team_id
left join injury_record i on p.player_id = i.player_id
order by t.team_name, p.player_name;


-- 2. details of all the teams registered in nhl
select * from teams;

-- 3. name of captains with their team name
select t.team_name, p.player_name as captain_name
from teams t
join player p on t.captain_id = p.player_id;

-- 4. name of goalkeepers of each team with team name
select t.team_name, p.player_name as goalkeeper
from player p
join teams t on p.team_id = t.team_id
where p.position = 'goalie';

-- 5. detail of players of team 1
select * from player
where team_id = 1;

-- 6. detail of players with the name of "rehan"
select * from player
where player_name = 'rehan';

-- 7. detail of players whose name end with characters "am"
select * from player
where player_name like '%am';

-- 8. detail of goalkeepers with the detail of their teams
select p.*, t.team_name, t.city, t.coach
from player p
join teams t on p.team_id = t.team_id
where p.position = 'goalie';

-- 9. detail of positions held in the team
select distinct position
from player;

-- 10. detail of skills players have
select player_name, skill_level
from player;

-- 11. detail of match 1
select * from match
where match_id = 1;

-- 12. which team won the match number 10
select 
    case 
        when host_score > guest_score then t1.team_name
        when guest_score > host_score then t2.team_name
        else 'draw'
    end as winner
from match m
join teams t1 on m.host_team_id = t1.team_id
join teams t2 on m.guest_team_id = t2.team_id
where m.match_id = 10;

-- 13. which team won the most matches
select top 1 team_name, count(*) as wins
from (
    select host_team_id as team_id from match where host_score > guest_score
    union all
    select guest_team_id as team_id from match where guest_score > host_score
) as winners
join teams t on winners.team_id = t.team_id
group by team_name
order by wins desc;

-- 14. how many total matches played in this league
select count(*) as total_matches
from match;

-- 15. which team scored the most goals
select top 1 t.team_name, sum(goals) as total_goals
from (
    select host_team_id as team_id, host_score as goals from match
    union all
    select guest_team_id as team_id, guest_score as goals from match
) as all_goals
join teams t on all_goals.team_id = t.team_id
group by t.team_name
order by total_goals desc;

-- 16. all the team names and the total players of each team
select t.team_name, count(p.player_id) as total_players
from teams t
left join player p on t.team_id = p.team_id
group by t.team_name;

-- 17. score of match number 5
select host_score, guest_score
from match
where match_id = 5;

-- 18. name of the coaches of each team
select team_name, coach
from teams;

-- 19. detail of teams who won their home matches
select distinct t.team_name, m.match_id, m.match_date, m.host_score, m.guest_score
from match m
join teams t on m.host_team_id = t.team_id
where m.host_score > m.guest_score;

-- 20. detail of matches played on sunday
select *
from match
where datename(weekday, match_date) = 'sunday';
