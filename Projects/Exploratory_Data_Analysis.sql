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
SUM(total_off) OVER(ORDER BY `MONTH`) AS rolling_total
FROM Rolling_Total;


-- Total layoffs per company per year, sorted alphabetically by company
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company,  YEAR(`date`)
ORDER BY company ASC;

-- CTE 1: Aggregate total layoffs by company and year
WITH Company_Year (company, years, total_laid_off) AS 
(
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company,  YEAR(`date`)
), 
-- CTE 2: Rank companies by total layoffs per year using DENSE_RANK
Company_Year_Rank AS 
(
SELECT *, DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM Company_Year
WHERE years IS NOT NULL
)
-- Final output: Top 5 companies with the most layoffs per year
SELECT *
FROM Company_Year_Rank
WHERE Ranking <= 5;
