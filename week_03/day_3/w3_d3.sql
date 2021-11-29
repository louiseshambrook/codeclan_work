-- Week 3 day 3


-- Quick tour of advanced SQL

-- will include explain, analyze, and index

-- to create a function in SQL
CREATE / REPLACE FUNCTION
--name of function--
-- what we want function to do --

e.g.

CREATE FUNCTION
percent_change(new_value NUMERIC, old_value NUMERIC, decimals INT DEFAULT 2 )
RETURNS NUMERIC AS 
	'SELECT ROUND (100 * (new_value - old_value) / old_value, decimals)'
LANGUAGE SQL 
IMMUTABLE
RETURNS NULL ON NULL INPUT;
-- returns an error as the only place to save functions is on the database, not in a local environment

SELECT
	percent_change(107, 98) AS default_decimals,
	percent_change(50, 65, 4) AS four_decimals;
	
-- queries in SQL can run pretty slowly, which can be quite common. This can depend on poor databases, and/or poorly written queries
-- explain analyze can help with this, at least partly

EXPLAIN ANALYZE
SELECT
  department,
    AVG(salary) AS avg_salary
FROM employees 
WHERE country IN ('Germany', 'France', 'Italy', 'Spain')
GROUP BY department
ORDER BY AVG(salary);

-- by indexing the countries, it should process a lot faster (not allowed to create, but this is the syntax)

CREATE INDEX employees_indexed _country ON employees_indexed(country ASC NULLS last)

EXPLAIN ANALYZE
SELECT
  department,
    AVG(salary) AS avg_salary
FROM employees_indexed
WHERE country IN ('Germany', 'France', 'Italy', 'Spain')
GROUP BY department
ORDER BY AVG(salary);

-- Common table expressions
-- a way to split up longer queries, and make them more readable
-- they're basically temporary tables

SELECT *
FROM employees
WHERE country = 'United States' AND fte_hours IN (
  SELECT fte_hours
  FROM employees
  GROUP BY fte_hours
  HAVING COUNT(*) = (
    SELECT MAX(count)
    FROM (
      
    ) AS temp
  )
);

-- CTE always begin with WITH

WITH fte_count AS (
	SELECT 
		fte_hours,
		COUNT(*) AS count
    FROM employees
    GROUP BY fte_hours
),
max_fte_count AS (
	SELECT
		MAX(count) AS max_count
		FROM fte_count
),
most_common_fte AS (
	SELECT 
		fte_hours
	FROM fte_count
	
	WHERE count = (
	SELECT 
		max_count
	FROM max_fte_count
	)
)
SELECT *
FROM employees
WHERE country = 'United States' AND fte_hours IN (
	SELECT
		fte_hours
	FROM most_common_fte);
	

-- Window functions
-- Keeping our data and also have an aggregate in a new column
-- e.g. show each employee's salary, but also them and their department (and min/max?)


SELECT
	first_name,
	last_name,
	department
	salary,
	MIN(salary) OVER (PARTITION BY department) AS min_salary_dept,
	MAX(salary) OVER (PARTITION BY department) AS max_salary_dept
FROM employees
ORDER BY id

-- 
-- After lunch
-- CTE's

-- There are several more functions which go with OVER
-- ORDER BY
-- RANK
-- DENSE_RANK
-- ROW_NUMBER
-- NTILE
