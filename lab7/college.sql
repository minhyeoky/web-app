-- EX1. Create DB and tables
-- create student
CREATE TABLE IF NOT EXISTS `student` (
  `student_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  `year` SMALLINT NOT NULL DEFAULT 1,
  `dept_no` INT NOT NULL,
  `major` VARCHAR(20),
  PRIMARY KEY `pk_student_id`(`student_id`)
) ENGINE = InnoDB;

-- create department
CREATE TABLE IF NOT EXISTS `department` (
  `dept_no` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `dept_name` VARCHAR(40) UNIQUE NOT NULL,
  `office` VARCHAR(40) NOT NULL,
  `office_tel` VARCHAR(13),
  PRIMARY KEY `pk_dept_no`(`dept_no`)
) ENGINE = InnoDB;

-- modify student table
ALTER TABLE
  `student` CHANGE `major` `major` VARCHAR(40);

-- add column to table
ALTER TABLE
  `student`
ADD
  COLUMN `gender` CHAR(1) NOT NULL;

-- drop column gender from student table
ALTER TABLE
  `student` DROP COLUMN `gender`;

-- Ex2 insert data
-- insert student table
INSERT INTO
  `student`(`student_id`, `name`, `year`, `dept_no`, `major`)
VALUES
  (
    20070002,
    'Jane Smith',
    3,
    4,
    'Business Administration'
  ),
  (
    20060001,
    'Ashley Jackson',
    4,
    4,
    'Business Administration'
  ),
  (
    20030001,
    'Liam Johnson',
    4,
    2,
    'Electrical Engineering'
  ),
  (
    20040003,
    'Jacob Lee',
    3,
    2,
    'Electrical Engineering'
  ),
  (20060002, 'Noah Kim', 3, 1, 'Computer Science'),
  (
    20100002,
    'Ava Lim',
    3,
    4,
    'Business Administration'
  ),
  (
    20110001,
    'Emma Watson',
    2,
    1,
    'Computer Science'
  ),
  (20080003, 'Lisa Maria', 4, 3, 'Law'),
  (20040002, 'Jacob William', 4, 5, 'Law'),
  (
    20070001,
    'Emily Rose',
    4,
    4,
    'Business Administration'
  ),
  (
    20100001,
    'Ethan Hunt',
    3,
    4,
    'Business Administration'
  ),
  (
    20110002,
    'Jason Mraz',
    2,
    1,
    'Electrical Engineering'
  ),
  (20030002, 'John Smith', 5, 1, 'Computer Science'),
  (20070003, 'Sophia Park', 4, 3, 'Law'),
  (
    20070007,
    'James Michael',
    2,
    4,
    'Business Administration'
  ),
  (20100003, 'James Bond', 3, 1, 'Computer Science'),
  (
    20070005,
    'Olivia Madison',
    2,
    5,
    'English Language and Literature'
  ) -- major is too long.
;

-- insert department
INSERT INTO
  `department`(`dept_no`, `dept_name`, `office`, `office_tel`)
VALUES
  (
    1,
    'Computer Science',
    'Science Building 101',
    '02-3290-0123'
  ),
  (
    2,
    'Electrical Engineering',
    'Engineering Building 401',
    '02-3290-2345'
  ),
  (3, 'Law', 'Law Building 201', '02-3290-7896'),
  (
    4,
    'Business Administration',
    'Business Building 104',
    '02-3290-1112'
  ),
  (
    5,
    'English Language and Literature',
    'Language Building 303',
    '02-3290-4412'
  );

/* Ex 3: Update & delete data */
-- change major values
UPDATE
  `student`
SET
  `major` = 'Electrical and Electronics Engineering'
WHERE
  `major` = 'Electrical Engineering';

-- new department is created
INSERT INTO
  `department` (`dept_no`, `dept_name`, `office`, `office_tel`)
VALUES
  (
    6,
    'Special Education',
    'Education Building 403',
    '02-3290-2347'
  );

-- a student changed his department
UPDATE
  `student`
SET
  `dept_no` = 6,
  `major` = 'Special Education'
WHERE
  `name` = 'Emma Watson';

-- a studnet quit
DELETE FROM
  `student`
WHERE
  `name` = 'Jason Mraz';

-- a student kicked out
DELETE FROM
  `student`
WHERE
  `name` = 'John Smith';

/* Ex 4: Query data */
-- select all studnet from computer science
SELECT
  `student`.*
FROM
  `student`
WHERE
  `major` = 'Computer Science';

-- select id, year, major
SELECT
  `student`.student_id,
  `student`.year,
  `student`.major
FROM
  `student`;

-- select 3rd year students
SELECT
  `s`.*
FROM
  `student` AS `s`
WHERE
  `year` = 3;

-- select 1 and 2nd year students
SELECT
  `s`.*
FROM
  `student` AS `s`
WHERE
  `year` = 1
  or `year` = 2;

/* Ex 5: Advanced query */
-- select all students who have student_id contains 2007
-- Use LIKE
-- https://webisfree.com/2014-01-28/[mysql]-%ED%95%84%EB%93%9C%EC%97%90%EC%84%9C-%ED%8A%B9%EC%A0%95%EB%AC%B8%EC%9E%90-%ED%8F%AC%ED%95%A8-%EB%98%90%EB%8A%94-%EC%A0%9C%EC%99%B8%ED%95%9C-db-%EA%B2%80%EC%83%89-like-not
SELECT
  `s`.*
FROM
  `student` AS `s`
WHERE
  `student_id` LIKE '%2007%';

-- select all students and order by student_id
-- Use ORDER BY
-- https://extbrain.tistory.com/51
SELECT
  `s`.*
FROM
  `student` AS `s`
ORDER BY
  `student_id` ASC;

-- group students by major and search for the major where its students average year > 3
-- Use GROUP BY, HAVING
SELECT
  ANY_VALUE(name)
FROM
  `student` AS `s`
GROUP BY
  `s`.major
HAVING
  AVG(`year`) > 3;

-- select only two students
-- Use LIMIT
SELECT
  `s`.*
FROM
  `student` AS `s`
WHERE
  `student_id` LIKE '%2007%'
LIMIT
  2;