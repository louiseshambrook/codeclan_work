SELECT * 
FROM employees 

-- Find all the employees working 0.5 full time
-- equivalent hours or greater

SELECT *
FROM employees 
WHERE fte_hours >= 0.5;

-- != not equal 
-- > greater than
-- < less than
-- >= - greater than or equal to
-- <= less than or equal to

/* this is also a comment but one that can go across multiple lines and ends with */

 
-- “Find all the employees not based in Brazil.”

SELECT *
FROM employees 
WHERE country != 'Brazil'

-- find all employees in China who started working for Omni in 2019

SELECT *
FROM employees
WHERE country = 'China' AND start_date >= '2019-01-01' AND start_date <= '2019-12-31'

/* of all employees based in China, find those who either started working for Omnicorps from 2019 onwards,
 *  or who are enrolled in the pension scheme.
 */

SELECT *
FROM employees
WHERE country = 'China' AND (start_date >= '2019-01-01' OR pension_enrol = TRUE)

/* find all employees who work between betwee 0.25 and 0.5 full time equivalent full time hours incl*/

SELECT *
FROM employees
WHERE fte_hours >= 0.25 AND fte_hours <= 0.5;

/* find all employees who started working for omnicorps who started working for omnicorps in years 
other than 2017 */

SELECT *
FROM employees
WHERE start_date < '2017-01-01' OR start_date > '2017-12-31'

-- BETWEEN, NOT and in 

SELECT *
FROM employees
WHERE fte_hours BETWEEN 0.25 AND 0.5;

SELECT *
FROM employees
WHERE start_date NOT BETWEEN '2017-01-01' AND '2017-12-31';

-- task - Find all employees who started work at OmniCorp in 2016 who work 0.5 full time
-- equivalent hours or greater.

SELECT *
FROM employees
WHERE fte_hours >= 0.5 AND (start_date BETWEEN '2016-01-01' AND '2016-12-31')

-- IN 

/* In operation - find all the employees based in spain, South africa, Ireland and Germany
*/

SELECT *
FROM employees
WHERE country = 'Spain' OR country = 'South Africa' OR country = 'Ireland' OR country = 'Germany'

-- Alternative

SELECT *
FROM employees 
WHERE country IN ('Spain', 'South Africa', 'Ireland', 'Germany'

/* Find all employees based in countries other than Argentina, Finland, or Canada
 * 
 */

SELECT *
FROM employees
WHERE country NOT IN ('Finland', 'Argentina', 'Canada')


-- SELECT - columnwise
-- FROM - table
-- WHERE - filter by rows
-- In the where statement, we have
-- AND, OR, BETWEEN, NOT IN 

-- COMING UP (similar to regex) - LIKE 
-- IS NULL 

/* “I was talking with a colleague from Greece last month, I can’t remember their last name exactly,
 * I think it began ‘Mc…’ something-or-other. Can you find them?” */

-- _ means a single character wildcard in the results
-- % is a wildcard, meaning 0 or more characters 
-- can only be used with LIKE 

SELECT *
FROM employees
WHERE country = 'Greece' AND last_name LIKE 'Mc%'

/* find all employees with last name containing phrase 'ere' anwyhere */

SELECT *
FROM employees
WHERE last_name LIKE '%ere%';

/* find all employees in the legal dept with a last name beginning with 'D\. */

SELECT *
FROM employees
WHERE department = 'Legal' AND last_name LIKE 'D%'

/* “Find all employees having ‘a’ as the second letter of their first names.” */

SELECT *
FROM employees
WHERE last_name LIKE '_a%'

-- to get a case insensitive version 

/* find all employees who last name contains the letter ha anywhere */

SELECT *
FROM employees
WHERE last_name ILIKE '%ha%';

-- Posix comparator
-- ~ : case sensitive matches
-- ~* : case insensitive matches 
-- !~ : case sensitive does not match
-- !~* : case insensitive does not match

/* find all employees for whom the second letter of their last name is 'r' or 's' and the the third
 letter is 'a' or 'o' */

SELECT *
FROM employees
WHERE last_name ~ '^.[rs][ao]'

-- negation of the same querytree

SELECT *
FROM employees
WHERE last_name !~* '^.[rs][ao]'

-- IS null 

/* we need to ensure our employee records are up to date. Find all the employees who do not have a
 * listed email adress.
 */

SELECT *
FROM employees
WHERE email IS NULL;
