-- JOINS

SELECT *
FROM employee_demographics;

SELECT *
FROM employee_salary;

-- Inner Joins

SELECT dem.employee_id, age, occupation
FROM employee_demographics AS dem
JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id;

-- Outer Joins

SELECT *
FROM employee_demographics AS dem
LEFT JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id;    
    
-- Self Joins

SELECT sal1.employee_id AS sal_santa,
sal1.first_name as first_name_santa,
sal1.last_name as last_name_santa,
sal2.employee_id AS emp,
sal2.first_name as emp_first_name,
sal2.last_name as emp_last_name
FROM employee_salary AS sal1
JOIN employee_salary AS sal2
	ON sal1.employee_id + 1= sal2.employee_id;	
    
-- Joining Multiple Tables Together

SELECT *
FROM employee_demographics AS dem
JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
JOIN parks_departments AS pd
	ON sal.dept_id = pd.department_id;
    
SELECT *
FROM parks_departments;