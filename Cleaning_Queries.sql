SELECT COUNT (*) AS Records_Count FROM [Human Resources];

SELECT * FROM [Human Resources];

ALTER TABLE [Human Resources]
ALTER COLUMN id varchar(20);

EXEC sp_help [Human Resources];

SELECT TRY_CONVERT(date,termdate)
FROM [Human Resources]

SELECT * FROM [Human Resources]
WHERE termdate IS NOT NULL
AND TRY_CONVERT(date,termdate) IS NULL

UPDATE [Human Resources]
SET termdate = LEFT(termdate,10)
WHERE TRY_CONVERT(date, LEFT(termdate,10)) IS NOT NULL;

ALTER TABLE [Human Resources]
ALTER COLUMN termdate date;

ALTER TABLE [Human Resources]
ADD Age INT;

UPDATE [Human Resources]
SET Age = DATEDIFF(year,birthdate,GETDATE());

ALTER TABLE [Human Resources]
ADD Length_Of_Employment DECIMAL(4,2);

UPDATE [Human Resources]
SET Length_Of_Employment = DATEDIFF(DAY,hire_date,termdate)/365.0
WHERE termdate IS NOT NULL;

UPDATE [Human Resources]
SET Length_Of_Employment = DATEDIFF(DAY,hire_date,GETDATE())/365.0
WHERE termdate IS NULL;

SELECT min(Age),max(Age) FROM [Human Resources];

