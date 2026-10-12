-- COMPANY DATABASE SCRIPT (companydb.sql)
-- 1. DATABASE CREATION
DROP DATABASE IF EXISTS companydb;
CREATE DATABASE companydb;
USE companydb;

-- 2. TABLE CREATION (Base tables without all constraints to demonstrate ALTER later)
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(100) UNIQUE NOT NULL,
    location VARCHAR(100) DEFAULT 'Main HQ'
);

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT,
    salary DECIMAL(10, 2),
    dept_id INT,
    email VARCHAR(100)
);

CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL,
    budget DECIMAL(12, 2)
);

-- Junction table for Many-to-Many relationship between Employees and Projects
CREATE TABLE employee_projects (
    emp_id INT,
    project_id INT,
    hours_worked INT,
    PRIMARY KEY (emp_id, project_id)
);




-- 3. APPLYING CONSTRAINTS VIA ALTER TABLE (Foreign Keys & Checks)

-- Add Foreign Key constraint to employees table linking to departments
ALTER TABLE employees
ADD CONSTRAINT fk_emp_dept 
FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
ON DELETE SET NULL 
ON UPDATE CASCADE;

-- Add Foreign Keys to the junction table
ALTER TABLE employee_projects
ADD CONSTRAINT fk_ep_emp FOREIGN KEY (emp_id) REFERENCES employees(emp_id) ON DELETE CASCADE,
ADD CONSTRAINT fk_ep_proj FOREIGN KEY (project_id) REFERENCES projects(project_id) ON DELETE CASCADE;

-- Add CHECK constraints for age (must be >= 18) and salary (must be > 0)
ALTER TABLE employees 
ADD CONSTRAINT chk_age CHECK (age >= 18);

ALTER TABLE employees 
ADD CONSTRAINT chk_salary CHECK (salary > 0.00);


-- 4. USING "ALTER TABLE MODIFY" (Tricky / Advanced Modifications)

-- (Ensures any future inserts without email get a placeholder, and increases safety)
ALTER TABLE employees 
MODIFY COLUMN email VARCHAR(150) NOT NULL DEFAULT 'pending@company.com';

-- Tricky Method 2: Expand data type capacity safely after table creation
ALTER TABLE projects 
MODIFY COLUMN budget DECIMAL(15, 2);


-- 5. INSERTING RICH SAMPLE DATA
-- Departments
INSERT INTO departments (dept_id, dept_name, location) VALUES 
(1, 'Engineering', 'New York'),
(2, 'Human Resources', 'Chicago'),
(3, 'Marketing', 'San Francisco'),
(4, 'Finance', 'New York');

-- Employees
INSERT INTO employees (emp_id, name, age, salary, dept_id, email) VALUES 
(101, 'Alice Smith', 28, 75000.00, 1, 'alice.smith@company.com'),
(102, 'Bob Jones', 34, 92000.50, 1, 'bob.jones@company.com'),
(103, 'Charlie Brown', 42, 64000.00, 2, 'charlie.b@company.com'),
(104, 'Diana Prince', 29, 88000.00, 3, 'diana.p@company.com'),
(105, 'Evan Wright', 25, 48000.00, 3, 'evan.w@company.com'),
(106, 'Fiona Gallagher', 38, 115000.00, 4, 'fiona.g@company.com');

-- Projects
INSERT INTO projects (project_id, project_name, budget) VALUES 
(501, 'Cloud Migration', 250000.00),
(502, 'AI Chatbot', 150000.00),
(503, 'Global Rebrand', 80000.00),
(504, 'Tax Automation', 120000.00);

-- Employee Projects (Assignment)
INSERT INTO employee_projects (emp_id, project_id, hours_worked) VALUES 
(101, 501, 120),
(101, 502, 45),
(102, 501, 160),
(103, 503, 90),
(104, 503, 110),
(105, 502, 80),
(106, 504, 150);


-- 6. SORTING DATA USING SELECT * FROM
-- Sort employees by salary in descending order (highest earners first)
SELECT * FROM employees 
ORDER BY salary DESC;

-- Multi-level sort: Sort employees by department ID ascending, then by age descending
SELECT * FROM employees 
ORDER BY dept_id ASC, age DESC;



-- 7. PERFORMING ADVANCED QUERIES
-- Query 1: INNER JOIN to find each employee's department name and location
SELECT e.emp_id, e.name AS employee_name, d.dept_name, d.location, e.salary
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id;

-- Query 2: Aggregate Function with GROUP BY & HAVING (Average salary per department)
SELECT d.dept_name, ROUND(AVG(e.salary), 2) AS avg_salary, COUNT(e.emp_id) AS total_employees
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_id, d.dept_name
HAVING COUNT(e.emp_id) > 0;

-- Query 3: Subquery to find employees earning more than the overall average salary
SELECT name, salary 
FROM employees 
WHERE salary > (SELECT AVG(salary) FROM employees);



-- 8. SOMETHING MORE: INDEXES & VIEWS

-- Performance Optimization: Create an Index on employee names for faster searches
CREATE INDEX idx_emp_name ON employees(name);

-- Business Intelligence: Create a Secure View for high-level project summaries
CREATE VIEW v_project_summary AS
SELECT 
    p.project_id,
    p.project_name,
    p.budget,
    COUNT(ep.emp_id) AS assigned_staff,
    SUM(ep.hours_worked) AS total_hours_logged
FROM projects p
LEFT JOIN employee_projects ep ON p.project_id = ep.project_id
GROUP BY p.project_id, p.project_name, p.budget;

-- Test the newly created view
SELECT * FROM v_project_summary;


-- gfvjhbflihewgfhkbe


-- CLEANUP / DROP COMMANDS

-- 1. Drop the reporting view first
DROP VIEW IF EXISTS v_project_summary;

-- 2. Drop tables in correct order to avoid Foreign Key constraint errors
-- (Drop junction/child tables first, then parent tables)
DROP TABLE IF EXISTS employee_projects;
DROP TABLE IF EXISTS projects;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

-- 3. Finally, delete the entire database
DROP DATABASE IF EXISTS companydb;