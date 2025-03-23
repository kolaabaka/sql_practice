CREATE SCHEMA practice_1;

--Exercise 1
CREATE TABLE practice_1.authors
(
  id SERIAL PRIMARY KEY, 
  NAME VARCHAR(128), 
  second_name VARCHAR(127)
);
CREATE TABLE practice_1.books (
  id SERIAL PRIMARY KEY, 
  book_name VARCHAR(128), 
  create_date DATE, 
  page_count INT, 
  author_id SERIAL REFERENCES practice_1.authors(id) ON DELETE 
  SET 
    NULL
);

--Exercise 2
INSERT INTO practice_1.authors
(NAME, second_name) 
VALUES 
  ('Alexandr', 'Pishkin'), 
  ('Maliksandr', 'Bebrev'), 
  ('Lol', 'Durkovich'), 
  ('Pops', 'Mel'), 
  ('Kaka', 'Baka'), 
  ('Mikhail', 'Chispanovich'), 
  ('Maslo', 'Kilka');
SELECT 
  id, 
  NAME, 
  second_name 
FROM 
  practice_1.authors;

--Exercise 3
INSERT INTO practice_1.books
(
  book_name, create_date, page_count, 
  author_id
) 
VALUES 
  (
    'Война и мир', '2023-01-15', 
    1225, 2
  ), 
  ('1984', '2023-02-20', 328, 2), 
  (
    'Убить пересмешника', 
    '2023-03-10', 281, 3
  ), 
  (
    'Гарри Поттер и философский камень', 
    '2023-04-05', 223, 4
  ), 
  (
    'Мастер и Маргарита', 
    '2023-05-12', 400, 5
  ), 
  (
    'Преступление и наказание', 
    '2023-06-18', 430, 7
  ), 
  (
    'Тихий Дон', '2023-07-25', 
    600, 1
  ), 
  (
    'Анна Каренина', '2023-08-30', 
    864, 2
  ), 
  (
    'Братья Карамазовы', 
    '2023-09-15', 796, 3
  ), 
  (
    'Собачье сердце', '2023-10-20', 
    192, 4
  ), 
  (
    'Над пропастью во ржи', 
    '2023-11-05', 277, 5
  ), 
  (
    'Маленький принц', 
    '2023-12-01', 96, 6
  );
SELECT 
  book_name, 
  create_date, 
  page_count, 
  author_id 
FROM 
  practice_1.books;

--Exercise 4
SELECT   book_name,
create_date, 
(
  SELECT 
    NAME || ' ' || second_name 
  FROM 
    practice_1.authors 
  WHERE 
    practice_1.authors.id = practice_1.books.author_id
) AS fio 
FROM 
  practice_1.books 
ORDER BY 
  create_date ASC;
SELECT 
  book_name, 
  create_date, 
  (
    SELECT 
      NAME || ' ' || second_name 
    FROM 
      practice_1.authors 
    WHERE 
      practice_1.authors.id = practice_1.books.author_id
  ) AS fio 
FROM 
  practice_1.books 
ORDER BY 
  create_date DESC;

--Exercise 5
SELECT Count(*)
FROM 
  practice_1.books 
WHERE 
  practice_1.books.author_id IN (
    SELECT 
      id 
    FROM 
      practice_1.authors 
    WHERE 
      practice_1.authors.NAME = 'Pops'
  );

--Exercise 6
SELECT book_name,
create_date, 
page_count 
FROM 
  practice_1.books 
WHERE 
  page_count > (
    SELECT 
      Avg(page_count) 
    FROM 
      practice_1.books
  );

--Excercise 7
SELECT   book_name,
create_date, 
page_count 
FROM 
  practice_1.books 
ORDER BY 
  create_date ASC 
limit 
  5;
SELECT 
  Sum(t.page_count) 
FROM 
  (
    SELECT 
      page_count 
    FROM 
      practice_1.books 
    ORDER BY 
      create_date ASC 
    limit 
      5
  ) AS t;

--Excercise 8
UPDATE practice_1.books
SET 
  page_count = 28 
WHERE 
  id = 12
RETURNING *;

--Excercise 9
DELETE
FROM 
  practice_1.books 
WHERE 
  id = (
    SELECT 
      id 
    FROM 
      practice_1.books 
    ORDER BY 
      page_count DESC 
    limit 
      1
  );
