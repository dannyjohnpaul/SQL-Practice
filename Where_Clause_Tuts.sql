-- WHERE Clause

SELECT *
FROM employee_salary
WHERE first_name = 'Leslie';

SELECT *
FROM employee_demographics
WHERE gender = 'Female';

-- AND OR NOT -- Logical Operators
SELECT *
FROM employee_demographics
WHERE (first_name = 'Leslie' AND age = 44) OR age > 55;

-- LIKE Statement
-- % and _
SELECT *
FROM employee_demographics
WHERE first_name LIKE 'Jer%';