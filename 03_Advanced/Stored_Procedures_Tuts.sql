-- Stored Procedures

SELECT *
FROM employee_salary;

CREATE PROCEDURE large_salaries()
SELECT *
FROM employee_salary
WHERE salary>= 50000;

CALL large_salaries();


DELIMITER $$
CREATE PROCEDURE large_salaries2()
BEGIN
	SELECT *
	FROM employee_salary
	WHERE salary>= 50000;
	SELECT *
	FROM employee_salary
	WHERE salary>= 10000;
END $$
DELIMITER ;

CALL large_salaries2();


DELIMITER $$
CREATE PROCEDURE large_salaries3(employeed_id_param INT)
BEGIN
	SELECT salary
	FROM employee_salary
	WHERE employee_id = employeed_id_param;
END $$
DELIMITER ;

CALL large_salaries3(1);
