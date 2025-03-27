create schema practice_2;
--Exercise 1
create table practice_2."airport"(
code char(3) primary key,
country varchar(128) not null,
city varchar(128) not null
);

create table practice_2."aircraft"(
id serial primary key,
model varchar(128) unique not null
);

create table practice_2."seat"(
id int,
seat_no varchar(4) not null,
foreign key (id) references practice_2."aircraft"(id),
primary key(id, seat_no)
);

create table practice_2."flight"(
id bigserial primary key,
flight_no varchar(16) not null,
departure_date timestamp not null,
departure_airport_code char(3),
arrival_date timestamp not null,
arrival_airport_code char(3) not null,
aircraft_id int,
status varchar(32),
foreign key (departure_airport_code) references practice_2.airport(code),
foreign key (arrival_airport_code) references practice_2.airport(code),
foreign key (aircraft_id) references practice_2.aircraft(id)
);

create table practice_2."ticket"(
id bigserial primary key,
passenger_no varchar(32) not null,
passenger_name varchar(128) not null,
flight_id bigint,
seat_no varchar(4) not null,
cost NUMERIC(8,2) not null,
foreign key (flight_id) references practice_2.flight(id)
);

--Exercise 2
insert into practice_2.airport (code, country, city)
values ('MNK', 'Беларусь', 'Минск'),
       ('LDN', 'Англия', 'Лондон'),
       ('MSK', 'Россия', 'Москва'),
       ('BSL', 'Испания', 'Барселона');

insert into practice_2.aircraft (model)
values ('Боинг 777-300'),
       ('Боинг 737-300'),
       ('Аэробус A320-200'),
       ('Суперджет-100');

insert into practice_2.seat (id, seat_no)
select id, s.column1
from practice_2.aircraft
         cross join (values ('A1'), ('A2'), ('B1'), ('B2'), ('C1'), ('C2'), ('D1'), ('D2') order by 1) s;

insert into practice_2.flight (flight_no, departure_date, departure_airport_code, arrival_date, arrival_airport_code, aircraft_id,
                    status)
values
('MN3002', '2020-06-14T14:30', 'MNK', '2020-06-14T18:07', 'LDN', 1, 'ARRIVED'),
('MN3002', '2020-06-16T09:15', 'LDN', '2020-06-16T13:00', 'MNK', 1, 'ARRIVED'),
('BC2801', '2020-07-28T23:25', 'MNK', '2020-07-29T02:43', 'LDN', 2, 'ARRIVED'),
('BC2801', '2020-08-01T11:00', 'LDN', '2020-08-01T14:15', 'MNK', 2, 'DEPARTED'),
('TR3103', '2020-05-03T13:10', 'MSK', '2020-05-03T18:38', 'BSL', 3, 'ARRIVED'),
('TR3103', '2020-05-10T07:15', 'BSL', '2020-05-10T012:44', 'MSK', 3, 'CANCELLED'),
('CV9827', '2020-09-09T18:00', 'MNK', '2020-09-09T19:15', 'MSK', 4, 'SCHEDULED'),
('CV9827', '2020-09-19T08:55', 'MSK', '2020-09-19T10:05', 'MNK', 4, 'SCHEDULED'),
('QS8712', '2020-12-18T03:35', 'MNK', '2020-12-18T06:46', 'LDN', 2, 'ARRIVED');

insert into practice_2.ticket (passenger_no, passenger_name, flight_id, seat_no, cost)
values ('112233', 'Иван Иванов', 1, 'A1', 200),
       ('23234A', 'Петр Петров', 1, 'B1', 180),
       ('SS988D', 'Светлана Светикова', 1, 'B2', 175),
       ('QYASDE', 'Андрей Андреев', 1, 'C2', 175),
       ('POQ234', 'Иван Кожемякин', 1, 'D1', 160),
       ('898123', 'Олег Рубцов', 1, 'A2', 198),
       ('555321', 'Екатерина Петренко', 2, 'A1', 250),
       ('QO23OO', 'Иван Розмаринов', 2, 'B2', 225),
       ('9883IO', 'Иван Кожемякин', 2, 'C1', 217),
       ('123UI2', 'Андрей Буйнов', 2, 'C2', 227),
       ('SS988D', 'Светлана Светикова', 2, 'D2', 277),
       ('EE2344', 'Дмитрий Трусцов', 3, 'А1', 300),
       ('AS23PP', 'Максим Комсомольцев', 3, 'А2', 285),
       ('322349', 'Эдуард Щеглов', 3, 'B1', 99),
       ('DL123S', 'Игорь Беркутов', 3, 'B2', 199),
       ('MVM111', 'Алексей Щербин', 3, 'C1', 299),
       ('ZZZ111', 'Денис Колобков', 3, 'C2', 230),
       ('234444', 'Иван Старовойтов', 3, 'D1', 180),
       ('LLLL12', 'Людмила Старовойтова', 3, 'D2', 224),
       ('RT34TR', 'Степан Дор', 4, 'A1', 129),
       ('999666', 'Анастасия Шепелева', 4, 'A2', 152),
       ('234444', 'Иван Старовойтов', 4, 'B1', 140),
       ('LLLL12', 'Людмила Старовойтова', 4, 'B2', 140),
       ('LLLL12', 'Роман Дронов', 4, 'D2', 109),
       ('112233', 'Иван Иванов', 5, 'С2', 170),
       ('NMNBV2', 'Лариса Тельникова', 5, 'С1', 185),
       ('DSA586', 'Лариса Привольная', 5, 'A1', 204),
       ('DSA583', 'Артур Мирный', 5, 'B1', 189),
       ('DSA581', 'Евгений Кудрявцев', 6, 'A1', 204),
       ('EE2344', 'Дмитрий Трусцов', 6, 'A2', 214),
       ('AS23PP', 'Максим Комсомольцев', 6, 'B2', 176),
       ('112233', 'Иван Иванов', 6, 'B1', 135),
       ('309623', 'Татьяна Крот', 6, 'С1', 155),
       ('319623', 'Юрий Дувинков', 6, 'D1', 125),
       ('322349', 'Эдуард Щеглов', 7, 'A1', 69),
       ('DIOPSL', 'Евгений Безфамильная', 7, 'A2', 58),
       ('DIOPS1', 'Константин Швец', 7, 'D1', 65),
       ('DIOPS2', 'Юлия Швец', 7, 'D2', 65),
       ('1IOPS2', 'Ник Говриленко', 7, 'C2', 73),
       ('999666', 'Анастасия Шепелева', 7, 'B1', 66),
       ('23234A', 'Петр Петров', 7, 'C1', 80),
       ('QYASDE', 'Андрей Андреев', 8, 'A1', 100),
       ('1QAZD2', 'Лариса Потемнкина', 8, 'A2', 89),
       ('5QAZD2', 'Карл Хмелев', 8, 'B2', 79),
       ('2QAZD2', 'Жанна Хмелева', 8, 'С2', 77),
       ('BMXND1', 'Светлана Хмурая', 8, 'В2', 94),
       ('BMXND2', 'Кирилл Сарычев', 8, 'D1', 81),
       ('SS988D', 'Светлана Светикова', 9, 'A2', 222),
       ('SS978D', 'Андрей Желудь', 9, 'A1', 198),
       ('SS968D', 'Дмитрий Воснецов', 9, 'B1', 243),
       ('SS958D', 'Максим Гребцов', 9, 'С1', 251),
       ('112233', 'Иван Иванов', 9, 'С2', 135),
       ('NMNBV2', 'Лариса Тельникова', 9, 'B2', 217),
       ('23234A', 'Петр Петров', 9, 'D1', 189),
       ('123951', 'Полина Зверева', 9, 'D2', 234);

--Excercise 3
--Mine
select t.passenger_no || ' : '  || t.passenger_name as "passenger data"
from practice_2.ticket as t inner join (select from practice_2.flight f where departure_airport_code = 'MNK' and arrival_airport_code = 'LDN' and departure_date = (now() - interval '2 days')) as f on t.flight_id = t.id
where t.seat_no = 'B1';

--Solved example
select *
from practice_2.ticket
         join practice_2.flight f
              on practice_2.ticket.flight_id = f.id
where seat_no = 'B1'
  and f.departure_airport_code = 'MNK'
  and f.arrival_airport_code = 'LDN'
  and f.departure_date::date = (now() - interval '2 days')::date;
  
 --Excercise 4
 --Mine
select count(id) -  
( select count(id)
 from practice_2.ticket t 
 group by flight_id 
 having flight_id = (
 	select id
 	from practice_2.flight f 
 	where f.flight_no = 'MN3002' and date(departure_date) = '2020-06-14'
 ))
 from practice_2.seat s 
 where id = (
	select id
 	from practice_2.flight f 
 	where f.flight_no = 'MN3002' and date(departure_date) = '2020-06-14'
 );

--Solved example
select t2.count - t1.count
from (
         select f.aircraft_id, count(*)
         from practice_2.ticket t
                  join practice_2.flight f
                       on f.id = t.flight_id
         where f.flight_no = 'MN3002'
           and f.departure_date::date = '2020-06-14'
         group by f.aircraft_id) t1
         join (
    select id, count(*)
    from practice_2.seat
    group by id) t2
              on t1.aircraft_id = t2.id;

  --Excercise 5
             
  select *, f.arrival_date - f.departure_date as duration
  from practice_2.flight f
  order by duration desc
  limit 2;
  
   --Excercise 6
--Mine 
select min(f.arrival_date - f.departure_date) over() as minimal, max(f.arrival_date - f.departure_date) over() as maximum, count(*) over()
from practice_2.flight f
where id in (
	select id 
	from practice_2.flight f2 
	where (f2.departure_airport_code = 'MNK' and f2.arrival_airport_code = 'LDN')
		or (f2.departure_airport_code = 'LDN' and f2.arrival_airport_code = 'MNK')
)
limit 1;
  
--Solved example 
select
    first_value(f.arrival_date - f.departure_date) over (order by (f.arrival_date - f.departure_date) desc) max_value,
    first_value(f.arrival_date - f.departure_date) over (order by (f.arrival_date - f.departure_date)) min_value,
    count(*) OVER()
from practice_2.flight f
         join practice_2.airport a
              on a.code = f.arrival_airport_code
         join practice_2.airport d
              on d.code = f.departure_airport_code
where a.city = 'Лондон'
  and d.city = 'Минск'
limit 1;

--Excercise 7
--Mine
select t.passenger_name, 
count(passenger_name) as count_name, 
round(100.0 * count(passenger_name) / (select count(*) from practice_2.ticket), 2)
from practice_2.ticket t
group by t.passenger_name 
order by count_name desc;

--Solved example
select t.passenger_name,
       count(*),
       round(100.0 * count(*) / (select count(*) from practice_2.ticket), 2)
from practice_2.ticket t
group by t.passenger_name
order by 2 desc;

--Excercise 8
select t1.*,
       first_value(t1.cnt) over () - t1.cnt
from (
         select t.passenger_no,
                t.passenger_name,
                count(*) cnt
         from practice_2.ticket t
         group by t.passenger_no, t.passenger_name
         order by 3 desc) t1;
         
--Excercise 9
--Mine
select flight_id, sum(cost)
from practice_2.ticket t 
group by flight_id 
order by flight_id asc;

--Solved example
select t1.*,
       COALESCE(lead(t1.sum_cost) OVER(order by t1.sum_cost), t1.sum_cost) - t1.sum_cost
from (
         select t.flight_id,
                sum(t.cost) sum_cost
         from practice_2.ticket t
         group by t.flight_id
         order by 2 desc) t1
order by flight_id;