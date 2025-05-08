-- GROUP BY

SELECT *
FROM employee_demographics;

SELECT gender, AVG(age), MAX(age)
FROM employee_demographics
GROUP BY gender;

-- ORDER BY

SELECT *
FROM employee_demographics
ORDER BY first_name DESC;
