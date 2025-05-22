-- Exploratory Data Analysis
-- This script is used to perform exploratory data analysis on the dataset.

-- Exploratory Data Analysis


-- View all records in the layoffs_staging2 table to get an initial look at the data
SELECT *
FROM layoffs_staging2;

-- Identify the maximum number of people laid off in a single entry and the highest percentage of layoffs
SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;

-- Find companies with 100% layoffs, ordered by total number laid off (biggest to smallest)
SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;

-- Total layoffs per company, sorted by the companies with the highest total layoffs
SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

-- Identify the time range of the dataset (earliest to latest layoff date)
SELECT MIN(`date`), MAX(`date`)
FROM layoffs_staging2;

-- Total layoffs per industry, ordered by industries with the most layoffs
SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;

-- Total layoffs by year, ordered from most recent to oldest
SELECT YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 1 DESC;

-- Total layoffs by company stage (e.g. startup, public, etc.), ordered by most affected stage
SELECT stage, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;


-- Total layoffs per month (formatted as YYYY-MM), ordered chronologically
SELECT SUBSTRING(`date`, 1, 7) AS `MONTH`, SUM(total_laid_off)
FROM layoffs_staging2
WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC;

-- Monthly layoffs along with a running total (cumulative layoffs over time)
WITH Rolling_Total AS 
(
SELECT SUBSTRING(`date`, 1, 7) AS `MONTH`, SUM(total_laid_off) AS total_off
FROM layoffs_staging2
WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC
)
SELECT `MONTH`, total_off,
SUM(total_off) OVER(ORDER BY `MONTH`) as rolling_total
FROM Rolling_Total;
