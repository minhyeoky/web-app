-- search all roles grades given in the course Computer Science 143 (4 rows)
SELECT
    *
FROM
    `courses`
    JOIN `grades` ON courses.id = grades.course_id
WHERE
    name = 'Computer Science 143' -- search names and grades of all students who took Computer Science 143 and got a B- or better (2 rows)
SELECT
    `courses`.name As `course_name`,
    `students`.name As `student_name`,
    grade
FROM
    `courses`
    JOIN `grades` ON courses.id = grades.course_id
    JOIN `students` ON students.id = grades.student_id
WHERE
    `courses`.name = 'Computer Science 143'
    and `grades`.grade IN ('B-', 'B', 'B+', 'A-', 'A', 'A+');

-- search names of all students who got a B- or better in any course, along with the names of the course and the grades (5 rows)
SELECT
    `students`.name As `student_name`,
    `grades`.grade
FROM
    `courses`
    JOIN `grades` ON `courses`.id = `grades`.course_id
    JOIN `students` ON `grades`.student_id = `students`.id
WHERE
    `grades`.grade IN ('B-', 'B', 'B+', 'A-', 'A', 'A+');

-- search names of all courses that have been taken by 2 or more students (2 rows)
SELECT
    name,
    COUNT(`courses`.id) As `number_of_students`
FROM
    `courses`
    JOIN `grades` ON `courses`.id = `grades`.course_id
GROUP BY
    `courses`.id
HAVING
    COUNT(`courses`.id) >= 2