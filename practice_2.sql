 CREATE SCHEMA practice_2;
--Exercise 1
CREATE TABLE practice_2."airport"
             (
                          code    CHAR(3) PRIMARY KEY,
                          country VARCHAR(128) NOT NULL,
                          city    VARCHAR(128) NOT NULL
             );CREATE TABLE practice_2."aircraft"
             (
                          id SERIAL PRIMARY KEY,
                          model VARCHAR(128) UNIQUE NOT NULL
             );CREATE TABLE practice_2."seat"
             (
                          id      INT,
                          seat_no VARCHAR(4) NOT NULL,
                          FOREIGN KEY (id) REFERENCES practice_2."aircraft"(id),
                          PRIMARY KEY(id, seat_no)
             );CREATE TABLE practice_2."flight"
             (
                          id BIGSERIAL PRIMARY KEY,
                          flight_no VARCHAR(16) NOT NULL,
                          departure_date TIMESTAMP NOT NULL,
                          departure_airport_code CHAR(3),
                          arrival_date TIMESTAMP NOT NULL,
                          arrival_airport_code CHAR(3) NOT NULL,
                          aircraft_id          INT,
                          status               VARCHAR(32),
                          FOREIGN KEY (departure_airport_code) REFERENCES practice_2.airport(code),
                          FOREIGN KEY (arrival_airport_code) REFERENCES practice_2.airport(code),
                          FOREIGN KEY (aircraft_id) REFERENCES practice_2.aircraft(id)
             );CREATE TABLE practice_2."ticket"
             (
                          id BIGSERIAL PRIMARY KEY,
                          passenger_no   VARCHAR(32) NOT NULL,
                          passenger_name VARCHAR(128) NOT NULL,
                          flight_id      BIGINT,
                          seat_no        VARCHAR(4) NOT NULL,
                          cost           NUMERIC(8,2) NOT NULL,
                          FOREIGN KEY (flight_id) REFERENCES practice_2.flight(id)
             );

--Exercise 2
INSERT INTO practice_2.airport
            (
                        code,
                        country,
                        city
            )
            VALUES
            (
                        'MNK',
                        'Беларусь',
                        'Минск'
            )
            ,
            (
                        'LDN',
                        'Англия',
                        'Лондон'
            )
            ,
            (
                        'MSK',
                        'Россия',
                        'Москва'
            )
            ,
            (
                        'BSL',
                        'Испания',
                        'Барселона'
            );
INSERT INTO practice_2.aircraft
            (
                        model
            )
            VALUES
            (
                        'Боинг 777-300'
            )
            ,
            (
                        'Боинг 737-300'
            )
            ,
            (
                        'Аэробус A320-200'
            )
            ,
            (
                        'Суперджет-100'
            );
INSERT INTO practice_2.seat
            (
                        id,
                        seat_no
            )
SELECT     id,
           s.column1
FROM       practice_2.aircraft
CROSS JOIN (VALUES
           (
                      'A1'
           )
           , ('A2'), ('B1'), ('B2'), ('C1'), ('C2'), ('D1'), ('D2') order BY 1) s;INSERT INTO practice_2.flight
            (
                        flight_no,
                        departure_date,
                        departure_airport_code,
                        arrival_date,
                        arrival_airport_code,
                        aircraft_id,
                        status
            )
            VALUES
            (
                        'MN3002',
                        '2020-06-14T14:30',
                        'MNK',
                        '2020-06-14T18:07',
                        'LDN',
                        1,
                        'ARRIVED'
            )
            ,
            (
                        'MN3002',
                        '2020-06-16T09:15',
                        'LDN',
                        '2020-06-16T13:00',
                        'MNK',
                        1,
                        'ARRIVED'
            )
            ,
            (
                        'BC2801',
                        '2020-07-28T23:25',
                        'MNK',
                        '2020-07-29T02:43',
                        'LDN',
                        2,
                        'ARRIVED'
            )
            ,
            (
                        'BC2801',
                        '2020-08-01T11:00',
                        'LDN',
                        '2020-08-01T14:15',
                        'MNK',
                        2,
                        'DEPARTED'
            )
            ,
            (
                        'TR3103',
                        '2020-05-03T13:10',
                        'MSK',
                        '2020-05-03T18:38',
                        'BSL',
                        3,
                        'ARRIVED'
            )
            ,
            (
                        'TR3103',
                        '2020-05-10T07:15',
                        'BSL',
                        '2020-05-10T012:44',
                        'MSK',
                        3,
                        'CANCELLED'
            )
            ,
            (
                        'CV9827',
                        '2020-09-09T18:00',
                        'MNK',
                        '2020-09-09T19:15',
                        'MSK',
                        4,
                        'SCHEDULED'
            )
            ,
            (
                        'CV9827',
                        '2020-09-19T08:55',
                        'MSK',
                        '2020-09-19T10:05',
                        'MNK',
                        4,
                        'SCHEDULED'
            )
            ,
            (
                        'QS8712',
                        '2020-12-18T03:35',
                        'MNK',
                        '2020-12-18T06:46',
                        'LDN',
                        2,
                        'ARRIVED'
            );
INSERT INTO practice_2.ticket
            (
                        passenger_no,
                        passenger_name,
                        flight_id,
                        seat_no,
                        cost
            )
            VALUES
            (
                        '112233',
                        'Иван Иванов',
                        1,
                        'A1',
                        200
            )
            ,
            (
                        '23234A',
                        'Петр Петров',
                        1,
                        'B1',
                        180
            )
            ,
            (
                        'SS988D',
                        'Светлана Светикова',
                        1,
                        'B2',
                        175
            )
            ,
            (
                        'QYASDE',
                        'Андрей Андреев',
                        1,
                        'C2',
                        175
            )
            ,
            (
                        'POQ234',
                        'Иван Кожемякин',
                        1,
                        'D1',
                        160
            )
            ,
            (
                        '898123',
                        'Олег Рубцов',
                        1,
                        'A2',
                        198
            )
            ,
            (
                        '555321',
                        'Екатерина Петренко',
                        2,
                        'A1',
                        250
            )
            ,
            (
                        'QO23OO',
                        'Иван Розмаринов',
                        2,
                        'B2',
                        225
            )
            ,
            (
                        '9883IO',
                        'Иван Кожемякин',
                        2,
                        'C1',
                        217
            )
            ,
            (
                        '123UI2',
                        'Андрей Буйнов',
                        2,
                        'C2',
                        227
            )
            ,
            (
                        'SS988D',
                        'Светлана Светикова',
                        2,
                        'D2',
                        277
            )
            ,
            (
                        'EE2344',
                        'Дмитрий Трусцов',
                        3,
                        'А1',
                        300
            )
            ,
            (
                        'AS23PP',
                        'Максим Комсомольцев',
                        3,
                        'А2',
                        285
            )
            ,
            (
                        '322349',
                        'Эдуард Щеглов',
                        3,
                        'B1',
                        99
            )
            ,
            (
                        'DL123S',
                        'Игорь Беркутов',
                        3,
                        'B2',
                        199
            )
            ,
            (
                        'MVM111',
                        'Алексей Щербин',
                        3,
                        'C1',
                        299
            )
            ,
            (
                        'ZZZ111',
                        'Денис Колобков',
                        3,
                        'C2',
                        230
            )
            ,
            (
                        '234444',
                        'Иван Старовойтов',
                        3,
                        'D1',
                        180
            )
            ,
            (
                        'LLLL12',
                        'Людмила Старовойтова',
                        3,
                        'D2',
                        224
            )
            ,
            (
                        'RT34TR',
                        'Степан Дор',
                        4,
                        'A1',
                        129
            )
            ,
            (
                        '999666',
                        'Анастасия Шепелева',
                        4,
                        'A2',
                        152
            )
            ,
            (
                        '234444',
                        'Иван Старовойтов',
                        4,
                        'B1',
                        140
            )
            ,
            (
                        'LLLL12',
                        'Людмила Старовойтова',
                        4,
                        'B2',
                        140
            )
            ,
            (
                        'LLLL12',
                        'Роман Дронов',
                        4,
                        'D2',
                        109
            )
            ,
            (
                        '112233',
                        'Иван Иванов',
                        5,
                        'С2',
                        170
            )
            ,
            (
                        'NMNBV2',
                        'Лариса Тельникова',
                        5,
                        'С1',
                        185
            )
            ,
            (
                        'DSA586',
                        'Лариса Привольная',
                        5,
                        'A1',
                        204
            )
            ,
            (
                        'DSA583',
                        'Артур Мирный',
                        5,
                        'B1',
                        189
            )
            ,
            (
                        'DSA581',
                        'Евгений Кудрявцев',
                        6,
                        'A1',
                        204
            )
            ,
            (
                        'EE2344',
                        'Дмитрий Трусцов',
                        6,
                        'A2',
                        214
            )
            ,
            (
                        'AS23PP',
                        'Максим Комсомольцев',
                        6,
                        'B2',
                        176
            )
            ,
            (
                        '112233',
                        'Иван Иванов',
                        6,
                        'B1',
                        135
            )
            ,
            (
                        '309623',
                        'Татьяна Крот',
                        6,
                        'С1',
                        155
            )
            ,
            (
                        '319623',
                        'Юрий Дувинков',
                        6,
                        'D1',
                        125
            )
            ,
            (
                        '322349',
                        'Эдуард Щеглов',
                        7,
                        'A1',
                        69
            )
            ,
            (
                        'DIOPSL',
                        'Евгений Безфамильная',
                        7,
                        'A2',
                        58
            )
            ,
            (
                        'DIOPS1',
                        'Константин Швец',
                        7,
                        'D1',
                        65
            )
            ,
            (
                        'DIOPS2',
                        'Юлия Швец',
                        7,
                        'D2',
                        65
            )
            ,
            (
                        '1IOPS2',
                        'Ник Говриленко',
                        7,
                        'C2',
                        73
            )
            ,
            (
                        '999666',
                        'Анастасия Шепелева',
                        7,
                        'B1',
                        66
            )
            ,
            (
                        '23234A',
                        'Петр Петров',
                        7,
                        'C1',
                        80
            )
            ,
            (
                        'QYASDE',
                        'Андрей Андреев',
                        8,
                        'A1',
                        100
            )
            ,
            (
                        '1QAZD2',
                        'Лариса Потемнкина',
                        8,
                        'A2',
                        89
            )
            ,
            (
                        '5QAZD2',
                        'Карл Хмелев',
                        8,
                        'B2',
                        79
            )
            ,
            (
                        '2QAZD2',
                        'Жанна Хмелева',
                        8,
                        'С2',
                        77
            )
            ,
            (
                        'BMXND1',
                        'Светлана Хмурая',
                        8,
                        'В2',
                        94
            )
            ,
            (
                        'BMXND2',
                        'Кирилл Сарычев',
                        8,
                        'D1',
                        81
            )
            ,
            (
                        'SS988D',
                        'Светлана Светикова',
                        9,
                        'A2',
                        222
            )
            ,
            (
                        'SS978D',
                        'Андрей Желудь',
                        9,
                        'A1',
                        198
            )
            ,
            (
                        'SS968D',
                        'Дмитрий Воснецов',
                        9,
                        'B1',
                        243
            )
            ,
            (
                        'SS958D',
                        'Максим Гребцов',
                        9,
                        'С1',
                        251
            )
            ,
            (
                        '112233',
                        'Иван Иванов',
                        9,
                        'С2',
                        135
            )
            ,
            (
                        'NMNBV2',
                        'Лариса Тельникова',
                        9,
                        'B2',
                        217
            )
            ,
            (
                        '23234A',
                        'Петр Петров',
                        9,
                        'D1',
                        189
            )
            ,
            (
                        '123951',
                        'Полина Зверева',
                        9,
                        'D2',
                        234
            );

--Excercise 3
--Mine
SELECT     t.passenger_no
                      || ' : '
                      || t.passenger_name AS "passenger data"
FROM       practice_2.ticket              AS t
INNER JOIN
           (
                  SELECT
                  from   practice_2.flight f
                  WHERE  departure_airport_code = 'MNK'
                  AND    arrival_airport_code = 'LDN'
                  AND    departure_date = (now() - interval '2 days')) AS f
ON         t.flight_id = t.id
WHERE      t.seat_no = 'B1';

--Solved example
SELECT *
FROM   practice_2.ticket
JOIN   practice_2.flight f
ON     practice_2.ticket.flight_id = f.id
WHERE  seat_no = 'B1'
AND    f.departure_airport_code = 'MNK'
AND    f.arrival_airport_code = 'LDN'
AND    f.departure_date::date = (now() - interval '2 days')::date;

--Excercise 4
--Mine
SELECT Count(id) -
       (
                SELECT   Count(id)
                FROM     practice_2.ticket t
                GROUP BY flight_id
                HAVING   flight_id =
                         (
                                SELECT id
                                FROM   practice_2.flight f
                                WHERE  f.flight_no = 'MN3002'
                                AND    Date(departure_date) = '2020-06-14' ))
FROM   practice_2.seat s
WHERE  id =
       (
              SELECT id
              FROM   practice_2.flight f
              WHERE  f.flight_no = 'MN3002'
              AND    Date(departure_date) = '2020-06-14' );

--Solved example
SELECT t2.count - t1.count
FROM   (
                SELECT   f.aircraft_id,
                         Count(*)
                FROM     practice_2.ticket t
                JOIN     practice_2.flight f
                ON       f.id = t.flight_id
                WHERE    f.flight_no = 'MN3002'
                AND      f.departure_date::date = '2020-06-14'
                GROUP BY f.aircraft_id) t1
JOIN
       (
                SELECT   id,
                         Count(*)
                FROM     practice_2.seat
                GROUP BY id) t2
ON     t1.aircraft_id = t2.id;

--Excercise 5
SELECT                  *,
         f.arrival_date - f.departure_date AS duration
FROM     practice_2.flight f
ORDER BY duration DESC limit 2;

--Excercise 6
--Mine
SELECT Min(f.arrival_date - f.departure_date) OVER() AS minimal,
       Max(f.arrival_date - f.departure_date) OVER() AS maximum,
       Count(*) OVER()
FROM   practice_2.flight f
WHERE  id IN
       (
              SELECT id
              FROM   practice_2.flight f2
              WHERE  (
                            f2.departure_airport_code = 'MNK'
                     AND    f2.arrival_airport_code = 'LDN')
              OR     (
                            f2.departure_airport_code = 'LDN'
                     AND    f2.arrival_airport_code = 'MNK') ) limit 1;

--Solved example
SELECT   First_value(f.arrival_date - f.departure_date) OVER (ORDER BY (f.arrival_date - f.departure_date) DESC) max_value,
         First_value(f.arrival_date - f.departure_date) OVER (ORDER BY (f.arrival_date - f.departure_date))      min_value,
         Count(*) OVER()
FROM     practice_2.flight f
JOIN     practice_2.airport a
ON       a.code = f.arrival_airport_code
JOIN     practice_2.airport d
ON       d.code = f.departure_airport_code
WHERE    a.city = 'Лондон'
AND      d.city = 'Минск' limit 1;

--Excercise 7
--Mine
SELECT   t.passenger_name,
         Count(passenger_name) AS count_name,
         Round(100.0 * Count(passenger_name) /
         (
                SELECT Count(*)
                FROM   practice_2.ticket), 2)
FROM     practice_2.ticket t
GROUP BY t.passenger_name
ORDER BY count_name DESC;

--Solved example
SELECT   t.passenger_name,
         Count(*),
         Round(100.0 * Count(*) /
         (
                SELECT Count(*)
                FROM   practice_2.ticket), 2)
FROM     practice_2.ticket t
GROUP BY t.passenger_name
ORDER BY 2 DESC;

--Excercise 8
SELECT t1.*,
       First_value(t1.cnt) OVER () - t1.cnt
FROM   (
                SELECT   t.passenger_no,
                         t.passenger_name,
                         Count(*) cnt
                FROM     practice_2.ticket t
                GROUP BY t.passenger_no,
                         t.passenger_name
                ORDER BY 3 DESC) t1;

--Excercise 9
--Mine
SELECT   flight_id,
         Sum(cost)
FROM     practice_2.ticket t
GROUP BY flight_id
ORDER BY flight_id ASC;

--Solved example
SELECT   t1.*,
         COALESCE(Lead(t1.sum_cost) OVER(ORDER BY t1.sum_cost), t1.sum_cost) - t1.sum_cost
FROM     (
                  SELECT   t.flight_id,
                           Sum(t.cost) sum_cost
                  FROM     practice_2.ticket t
                  GROUP BY t.flight_id
                  ORDER BY 2 DESC) t1
ORDER BY flight_id; 