#create a students db (students.db) and a table (students) with the following columns: id, name, age, grade
CREATE DATABASE students;
USE students;
CREATE TABLE students (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    grade VARCHAR(10)
);

#input values into the students table
INSERT INTO students (id, name, age, grade) VALUES (1, 'Alice', 20, 'A');
INSERT INTO students (id, name, age, grade) VALUES (2, 'Bob', 21, 'B');
INSERT INTO students (id, name, age, grade) VALUES (3, 'Charlie', 22, 'C');

#print all the values in the students table
SELECT * FROM students;

#update the grade of a student with id 2 to 'A'
UPDATE students SET grade = 'A' WHERE id = 2;

#print all the values in the students table after the update
SELECT * FROM students;

# add a new student with id 4, name 'David', age 23, and grade 'B'
INSERT INTO students (id, name, age, grade) VALUES (4, 'David', 23, 'B');

# add a new column 'email' to the students table
ALTER TABLE students ADD COLUMN email VARCHAR(100);

#update the email of student with id 1 to 'alice@example.com'
UPDATE students SET email = 'alice@example.com' WHERE id = 1;

#print all the values in the students table after updating the email
SELECT * FROM students;

# add primary key constraint to the id column of the students table
ALTER TABLE students ADD PRIMARY KEY (id);




# create a new table called 'courses' with the following columns: course_id, course_name, instructor
CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    instructor VARCHAR(100)
);

#insert values into the courses table
INSERT INTO courses (course_id, course_name, instructor) VALUES (1, 'Mathematics', 'Dr. Smith');
INSERT INTO courses (course_id, course_name, instructor) VALUES (2, 'Physics', 'Dr. Johnson');

# print all the values in the courses table
SELECT * FROM courses;

#drop the courses table
DROP TABLE courses;

#drop the students table
DROP TABLE students;

#delete the students database
DROP DATABASE students;