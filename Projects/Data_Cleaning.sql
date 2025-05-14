-- Data Cleaning

SELECT *
FROM layoffs;

-- 1. Remove duplicates
-- 2. Standardize the data
-- 3. Null values or blank values
-- 4. Remove any empty columns


CREATE TABLE layoffs_staging
LIKE layoffs;

SELECT *
FROM layoffs_staging;









