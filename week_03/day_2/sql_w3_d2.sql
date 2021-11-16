-- Notes 16/11

-- Grouping and subqueries


-- "Find the number of employees in each dept"

SELECT
	department,
	COUNT (id)
FROM employees
GROUP BY department;

-- "how many employees are there in each country"

SELECT
	country,
	COUNT (id)
FROM employees
GROUP BY country;

-- combination with WHERE
-- "How many employees in each department work 0.25 or 0.5 hours"

SELECT 
	department,
	COUNT (id) AS num_fte_quarter_or_half
FROM employees
WHERE fte_hours BETWEEN 0.25 AND 0.5
GROUP BY department

-- different counts

SELECT 
	COUNT(first_name) AS n_first_names
	COUNT (id) AS count_id
	COUNT(*) AS count_star
FROM employees

-- Another question
-- So Few Workers Go Home On Time
-- SELECT FROM WHERE GROUPBY HAVING ORDERBY LIMIT
-- SQL only runs select as the second to last OoO, despite being written first

-- "Find the longest time served by any one employee in EACH dept"

SELECT
	department,
	ROUND(EXTRACT(DAY FROM NOW() -MIN(start_date))/365.25) AS longest_time
FROM employees
GROUP BY department;

-- How does GROUP BY group by?
-- Sorts data into groups and then labels them (e.g. department; accounting, legal)

-- TASK TIME

-- 1. “How many employees in each department are enrolled in the pension scheme?”
-- 2. “Perform a breakdown by country of the number of employees that do not have a stored first name.”

-- Q1.
SELECT
	department,	
	COUNT (id) AS employees_pension_enrol
FROM employees
WHERE pension_enrol = TRUE
GROUP BY department
ORDER BY department
	
-- Q2.
SELECT
	country,
	COUNT (id)
FROM employees
WHERE first_name IS NULL
GROUP BY country;

-- 

-- HAVING

-- WHERE clause lets us filter rows
-- To filter groups, based on another function, HAVING lets us do this

-- "show the departments in which at least 40 employees work either 0.25 or .5 hours"

SELECT 
	department,
	COUNT (id) AS n_employees
FROM employees
WHERE fte_hours BETWEEN 0.25 AND 0.5
GROUP BY department
HAVING COUNT(id) >= 40;

-- important to refer to COUNT (id), because n_employees won't exist yet; HAVING occurs before SELECT

-- " Show any countries in which the minimum salary amongst pension enrolled employees is less than $21k"

SELECT
	country,
	MIN (salary) AS min_salary
FROM employees
WHERE pension_enrol = TRUE
GROUP BY country
HAVING MIN (salary) < 21000;

-- TASK: Task - 5 mins This is about as tough as SQL will get for us in this lesson!
-- Write a query using WHERE, GROUP BY and HAVING to solve the following:
-- “Show any departments in which the earliest start date amongst grade 1 employees is prior to 1991”

SELECT
	department,
	MAX(grade),
	MIN(start_date)
FROM employees
WHERE grade = 1
GROUP BY department
HAVING MIN (start_date) <= '1991-01-01'

-- subqueries

-- "find all the employees in Japan, who earn over the company wide average salary"

-- find the companywide average salay
-- use the value to filter

SELECT *
FROM employees
WHERE country = 'Japan' AND salary > AVG(salary)

-- nooooo - not possible to perform aggr functions in a where clause

SELECT AVG(salary)
FROM employees;

SELECT * 
FROM employees
WHERE country = 'Japan' AND
salary > (SELECT AVG(salary) FROM employees);

-- TASK “Find all the employees in Legal who earn less than the mean salary in that same department.”



SELECT *
FROM employees
WHERE department = 'Legal' AND salary < (
	SELECT AVG(salary)
	FROM employees
	WHERE department = 'Legal'
	);

-- TASK "“Find all the employees in the United States who work the most common full-time equivalent
-- hours across the corporation.”
-- Think of this as being two separate tasks combined:
-- Write a query to find the most common full-time equivalent hours across the corporation
-- Use this as a subquery in an outer query to find those employees in the United States who work those
-- hours"

SELECT * 
FROM employees
WHERE country = 'United States' AND fte_hours = ( 
	SELECT fte_hours
	FROM employees 
	GROUP BY fte_hours
	ORDER BY COUNT(id) DESC
	LIMIT 1
	);

SELECT fte_hours
FROM employees 
GROUP BY fte_hours
ORDER BY COUNT(id) DESC
LIMIT 1;

----- LUNCH

--- Joins






