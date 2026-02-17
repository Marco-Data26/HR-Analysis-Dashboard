USE HR;

SELECT * FROM [Human Resources]

-- 1. How many Emloyees in the company?
SELECT COUNT(*) AS Number_Of_Employees FROM [Human Resources]
WHERE termdate IS NULL

-- 2. What is the gender breakdown of employees in the company?
SELECT gender, COUNT(*) AS Count FROM [Human Resources]
WHERE termdate IS NULL
GROUP BY gender ORDER BY Count DESC; 

-- 3. What is the race/ethnicity breakdown of employees in the company?
SELECT race, COUNT(*) AS Count FROM [Human Resources]
WHERE termdate IS NULL
GROUP BY race ORDER BY Count DESC

-- 4. What is the age distribution of employees in the company?
SELECT 	
        CASE 
		 WHEN Age < 35 THEN '18-34'
		 WHEN Age BETWEEN 35 AND 49 THEN '35-49'
		 ELSE '50-65'
	    END AS Age_Group
	, COUNT(*) AS Count FROM [Human Resources]
WHERE termdate IS NULL
GROUP BY 
		CASE 
		 WHEN Age < 35 THEN '18-34'
		 WHEN Age BETWEEN 35 AND 49 THEN '35-49'
		 ELSE '50-65'
	    END 
ORDER BY Age_Group;

-- 5. How many employees work at headquarters versus remote locations?
SELECT location , COUNT(*) AS Count FROM [Human Resources]
WHERE termdate IS NULL
GROUP BY location 
ORDER BY Count DESC;

-- 6. What is the average length of employment for employees who have been terminated?
SELECT AVG(Length_Of_Employment) AS the_average_length_of_employment 
FROM [Human Resources]
WHERE termdate IS NOT NULL AND termdate <= GETDATE();

-- 7. How does the gender distribution vary across departments and job titles?
SELECT department, jobtitle, gender, COUNT(*) AS Count 
FROM [Human Resources]
WHERE termdate IS NULL
GROUP BY department, jobtitle, gender
ORDER BY department, jobtitle, Count DESC 

-- 8. What is the distribution of job titles across the company?
SELECT jobtitle, COUNT(*) AS Count FROM [Human Resources]
WHERE termdate IS NULL
GROUP BY jobtitle
ORDER BY jobtitle 

-- 9. Which department has the highest turnover rate?
SELECT department, total_count, terminated_count,
terminated_count/total_count AS Turnover_Rate
FROM (SELECT department,COUNT(*) AS total_count,
SUM(CASE WHEN termdate IS NOT NULL AND
termdate <= GETDATE() THEN 1.0 ELSE 0 END)AS terminated_count
FROM [Human Resources]
GROUP BY department) AS Subquery
ORDER BY Turnover_Rate DESC

-- 10. What is the distribution of employees across locations by state?
SELECT location_state, COUNT(*) AS Count
FROM [Human Resources]
WHERE termdate IS NULL
GROUP BY location_state
ORDER BY Count DESC;

-- 11. How has the company's employee count changed over time based on hire and term dates?
SELECT year, hires, terminations, 
((hires - terminations)/ (hires))*100 AS net_hiring_rate
FROM( SELECT YEAR(hire_date) As year,
COUNT(*) AS hires,
SUM(CASE WHEN termdate IS NOT NULL AND termdate <= GETDATE() 
THEN 1.0 ELSE 0 END) AS terminations
FROM [Human Resources]
GROUP BY YEAR(hire_date)) AS Subquery
ORDER BY year ASC;

-- 12. What is the tenure distribution for each department?
SELECT department, CAST(AVG(Length_Of_Employment) AS INT) AS Avg_tenure
FROM [Human Resources]
WHERE termdate IS NOT NULL AND termdate <= GETDATE()
GROUP BY department
ORDER BY Avg_tenure DESC;



