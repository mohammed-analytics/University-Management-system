create database universityDB;
use universityDB;

create table departments(dept_id int primary key, dept_name varchar(50));

create table students(student_id int primary key, student_name varchar(50),age int, gender varchar(50), email varchar(100) unique,
phone varchar(10), dept_id int,foreign key(dept_id) references departments(dept_id));

create table instructors(instructors_id int primary key, instructor_name varchar(100), email varchar(100)unique, salary int,dept_id int,foreign key(dept_id)
references departments(dept_id));

create table courses(course_id int primary key, course_name varchar(50),dept_id int,instructor_id int,foreign key (dept_id)
references departments(dept_id), foreign key(instructor_id) references instructors(instructors_id));

create table enrollments(enrollment_id int primary key,student_id int,course_id int, enrollment_date date, grade varchar(2), foreign key(student_id)
references students(student_id), foreign key(course_id) references courses(course_id));

create table class_schedule(schedule_id int primary key, course_id int, day_of_week varchar(50), start_time time, end_time time, classroom varchar(50)
foreign key (course_id) references courses(course_id));

insert into departments values
(101,'commerce'),
(102,'computer science'),
(103,'mathematics'),
(104,'physics'),
(105,'english');
select * from departments;

INSERT INTO students
VALUES
(1, 'Rahul', 21, 'Male', 'rahul@gmail.com', '9876543210', 101),
(2, 'Anu', 22, 'Female', 'anu@gmail.com', '9876543211', 102),
(3, 'Arun', 20, 'Male', 'arun@gmail.com', '9876543212', 101),
(4, 'Meera', 21, 'Female', 'meera@gmail.com', '9876543213', 103),
(5, 'Vishnu', 23, 'Male', 'vishnu@gmail.com', '9876543214', 104),
(6, 'Diya', 20, 'Female', 'diya@gmail.com', '9876543215', 102),
(7, 'Amal', 22, 'Male', 'amal@gmail.com', '9876543216', 105),
(8, 'Sneha', 21, 'Female', 'sneha@gmail.com', '9876543217', 103),
(9, 'Nikhil', 23, 'Male', 'nikhil@gmail.com', '9876543218', 101),
(10, 'Athira', 22, 'Female', 'athira@gmail.com', '9876543219', 102);
select * from students

INSERT INTO instructors
VALUES
(201, 'Suresh', 'suresh@gmail.com', 40000, 101),
(202, 'Priya', 'priya@gmail.com', 45000, 102),
(203, 'Ramesh', 'ramesh@gmail.com', 42000, 103),
(204, 'Lakshmi', 'lakshmi@gmail.com', 43000, 104),
(205, 'Anil', 'anil@gmail.com', 41000, 105);
select * from instructors

INSERT INTO courses
VALUES
(301, 'Financial Accounting',  101, 201),
(302, 'Business Management',  101, 201),
(303, 'Python Programming',  102, 202),
(304, 'Database Management',  102, 202),
(305, 'Statistics',  103, 203),
(306, 'Applied Mathematics',  103, 203),
(307, 'Modern Physics',  104, 204),
(308, 'English Literature',  105, 205);
select * from courses;

INSERT INTO enrollments
VALUES
(1, 1, 301, '2026-06-01', 'A'),
(2, 1, 303, '2026-06-01', 'B+'),
(3, 2, 303, '2026-06-02', 'A'),
(4, 2, 304, '2026-06-02', 'B'),
(5, 3, 301, '2026-06-03', 'A+'),
(6, 3, 302, '2026-06-03', 'A'),
(7, 4, 305, '2026-06-04', 'B+'),
(8, 4, 306, '2026-06-04', 'A'),
(9, 5, 307, '2026-06-05', 'B'),
(10, 5, 308, '2026-06-05', 'A'),
(11, 6, 303, '2026-06-06', 'A+'),
(12, 7, 308, '2026-06-06', 'B+'),
(13, 8, 305, '2026-06-07', 'A'),
(14, 9, 302, '2026-06-07', 'B'),
(15, 10, 304, '2026-06-08', 'A+');
select * from enrollments;


INSERT INTO class_schedule
(schedule_id, course_id, day_of_week, start_time, end_time, classroom)
VALUES
(1, 301, 'Monday', '09:00', '10:00', 'Room 101'),
(2, 302, 'Tuesday', '10:00', '11:00', 'Room 102'),
(3, 303, 'Wednesday', '09:00', '10:30', 'Lab 1'),
(4, 304, 'Thursday', '11:00', '12:00', 'Lab 2'),
(5, 305, 'Friday', '09:00', '10:00', 'Room 103'),
(6, 306, 'Monday', '11:00', '12:00', 'Room 104'),
(7, 307, 'Tuesday', '13:00', '14:00', 'Room 105'),
(8, 308, 'Wednesday', '14:00', '15:00', 'Room 106');
select * from class_schedule;

select * from departments;
select * from students;
select * from instructors;
select * from courses;
select * from enrollments;
select * from class_schedule;

update students
set phone=1275849384 where student_id=6;

delete from enrollments where course_id=303;
delete from class_schedule where course_id=303;
delete from courses where course_id=303;

insert into enrollments
values (16,10,301,'2026-06-10','A');

select student_id,student_name,age,gender,dept_name from students
inner join departments on students.dept_id=departments.dept_id;

select instructor_name,course_id,course_name from instructors inner join
courses on instructors.instructors_id=courses.instructor_id where instructors.instructors_id=203;

select students.student_id,student_name,course_id,grade from students inner join enrollments
on students.student_id=enrollments.student_id where enrollments.course_id=301;

SELECT
    departments.dept_name,
    COUNT(students.student_id) AS total_students
FROM students
INNER JOIN departments
    ON students.dept_id = departments.dept_id
GROUP BY departments.dept_name;

select 
instructors.instructor_name, 
count(courses.course_id)
as total_courses
from instructors
inner join courses on instructors.instructors_id=courses.instructor_id group by
instructors.instructor_name

SELECT
    courses.course_name,
    AVG(
        CASE enrollments.grade
            WHEN 'A+' THEN 10
            WHEN 'A'  THEN 9
            WHEN 'B+' THEN 8
            WHEN 'B'  THEN 7
        END
    ) AS average_grade
FROM courses
INNER JOIN enrollments
    ON courses.course_id = enrollments.course_id
GROUP BY courses.course_name;


SELECT TOP 1
    departments.dept_name,
    COUNT(students.student_id) AS total_students
FROM students
INNER JOIN departments
    ON students.dept_id = departments.dept_id
GROUP BY departments.dept_name
ORDER BY COUNT(students.student_id) DESC;


select student_id,student_name from students where student_id not in(select student_id from enrollments);

SELECT
    instructor_name,
    COUNT(course_id) AS total_courses
FROM instructors 
INNER JOIN courses 
    ON instructors_id = instructor_id
GROUP BY instructor_name
HAVING COUNT(course_id) = (
    SELECT MAX(course_count)
    FROM (
        SELECT COUNT(course_id) AS course_count
        FROM courses
        GROUP BY instructor_id
    ) AS course_totals
);

select s.student_name,c.course_name,e.grade
from enrollments as e inner join students as s on
e.student_id=s.student_id
inner join courses as c on 
e.course_id=c. course_id;

create index idx_student_name on students(student_name);
create index idx_course_name on courses(course_name);
exec sp_helpindex 'students';
exec sp_helpindex 'courses';


create view student_performance as 
select s.student_name,c.course_name,
e.grade from enrollments as e
inner join students as s 
on e.student_id=s.student_id
inner join courses as c
on e.course_id=c.course_id;

select * from student_performance


