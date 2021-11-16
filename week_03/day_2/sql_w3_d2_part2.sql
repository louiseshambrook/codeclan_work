-- Joins

-- Get a list of all the animals that have diet plans together with the diets they're on
-- use an inner join


-- Syntax for INNER JOIN

SELECT
	animals.*,
	diets.*
FROM animals INNER JOIN DIETS
ON animals.diet_id = diets.id;
	
-- we can control the columns returned

SELECT
	animals.name,
	animals.species,
	diets.diet_type
FROM animals INNER JOIN DIETS
ON animals.diet_id = diets.id;

-- we can also use tables aliases to write more succintly

SELECT
	a.name,
	a.species,
	d.diet_type
FROM animals AS a INNER JOIN DIETS AS d
ON a.diet_id = d.id;

-- you can combine joins with all the other syntax. Find any known dietary requirements for animals over 4 years old

SELECT
	a.id,
	a.name,
	a.species,
	a.age,
	d.diet_type
FROM animals AS a INNER JOIN diets AS d
ON a.diet_id = d.id
WHERE a.age > 4;

-- break down the numbers of all the other animals by diet type

SELECT
	d.diet_type,
	COUNT(a.id)
FROM animals AS a INNER JOIN diets AS d
ON a.diet_id = d.id
GROUP BY d.diet_type;

-- task. get the details of all herbivores 

SELECT 
	a.id,
	a.name,
	a.age,
	a.species,
	d.diet_type
FROM animals AS a INNER JOIN diets AS d
ON a.diet_id = d.id
WHERE diet_type = 'herbivore'

-- LEFT JOIN

-- where an inner join will only join where there is a match on the joining key, left joins will return
-- all rows regardless

SELECT
	a.*,
	d.*
FROM animals AS a LEFT JOIN diets as d
ON a.diet_id = d.id;


-- TASK. Do the same but with a right join.

SELECT
	a.*,
	d.*
FROM animals as a RIGHT JOIN diets as d
ON a.diet_id = d.id

-- how many animals follow each diet type, incl any diets which no animals follow

SELECT
	d.diet_type,
	COUNT (a.id) AS num_animals
FROM animals as a RIGHT JOIN diets as d
ON a.diet_id = d.id
GROUP BY d.diet_type;

-- running this query again as a left join

SELECT
	d.diet_type,
	COUNT (a.id) AS num_animals
FROM diets as d LEFT JOIN animals as a
ON a.diet_id = d.id
GROUP BY d.diet_type;

-- full outer join

SELECT
	a.*,
	d.*
FROM animals as a FULL OUTER JOIN diets as d
ON a.diet_id = d.id;

 -- Joins on many-to-many relationships
-- get a rota for the keepers and the animals they care for, first by animal and then by day

SELECT
	a.name AS animal_name,
	a.species,
	cs.day,
	k.name AS keeper_name
FROM (animals AS a INNER JOIN care_schedule AS cs ON a.id = cs.animal_id) INNER JOIN keepers AS k
ON cs.keeper_id = k.id
ORDER BY a.name, cs.day

-- TASK - how would you change the query to show schedule for only Ernest the Snake

SELECT
	a.name AS animal_name,
	a.species,
	cs.day,
	k.name AS keeper_name
FROM (animals AS a INNER JOIN care_schedule AS cs ON a.id = cs.animal_id) INNER JOIN keepers AS k
ON cs.keeper_id = k.id
WHERE a.name = 'Ernest'

-- Self-joins

-- e.g. in keepers, there is a manager_id, which references id(which looks like a foreign key),
-- which is the primary key, so it would be good to add the names

SELECT *
FROM keepers;

-- get a table showing the name of each keeper and the name of their manager if they have one

SELECT
	k.name AS employee_name,
	m.name AS manager_name
FROM keepers AS k LEFT JOIN keepers AS m
ON k.manager_id = m.id

