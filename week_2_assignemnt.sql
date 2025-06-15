-- to be able to work on this assignment I used chat gpt and google to narrow down my 
--reserch to east african country I was able to generate a csv that i imported from my schema
-- my table contains the country name,
--country code --type of debt or indicator name and code the year as from 1970 to 2015
-- debt amount
--below is my sql code
CREATE TABLE east_africa_debt (
  country_name TEXT,
  country_code TEXT,
  indicator_name TEXT,
  indicator_code TEXT,
  year INT,
  debt_amount NUMERIC
);

select*from east_africa_debt ead --checking on all the datasets uploaded after aploading using the csv

--questions
--1. What is the total amount of debt owed by all countries?

with total_debt as(
select sum(debt_amount) as madeni -- trying to also play around with alias
from east_africa_debt)
SELECT * FROM total_debt;
-- I have used Cte to display the total debt 

--2. How many distinct countries are recorded?

-- am now working on the second question i use conunt to help count rows 
--and the distinct country name to help with the clarification that for the rows
-- the country names should only be counted once

SELECT COUNT(
DISTINCT country_name) 
AS total_countries 
FROM east_africa_debt ead 

--3. What are the distinct types of debt indicators, and what do they represent?

-- we will use almost the same synthax for the third question
--What are the distinct types of debt indicators, and what do they represent?
--however on what they represent we will have to use the indicator name, take note that we dont use count on the third question

select distinct ead.indicator_code, indicator_name   from east_africa_debt ead 

-- under my case study I only have external debt only 

--4. Which country has the highest total debt?

select country_name, sum(debt_amount)  as the_country_with_madeni_mob
from east_africa_debt ead 
GROUP BY country_name
ORDER BY the_country_with_madeni_mob desc 
limit 1;
-- this one as honestly been tough as a beginer 
--what weve done is we have selected the country and the debt that are the primary details we want to 
--display
--then we have used alias just playing with it for fun then again brought up the madeni
--we have grouped the data using country name and ordered the madeni list in a descending order
--lastly we have limited the results to only one row

--5. What is the average debt across different indicators?
SELECT indicator_name, AVG(debt_amount) AS avg_debt
FROM east_africa_debt ead 
GROUP BY indicator_name
ORDER BY avg_debt DESC;
-- we have used avg to check the average of the debt
--used the indicator name for grouping on the type/name of the indicator


--6. Which country has made the highest amount of principal repayments?

SELECT country_name, SUM(debt_amount) AS total_repayment
FROM east_africa_debt ead 
WHERE indicator_name ILIKE '%principal repayments%' -- ilike helps check all the indicator name irigardles of the case sensitivity
GROUP BY country_name
ORDER BY total_repayment DESC
LIMIT 1;
--Principal repayments mean returning the original amount borrowed.
--Finding the country that repaid the most shows financial responsibility or large loans.

--7. What is the most common debt indicator across all countries?
SELECT indicator_name, COUNT(*) AS occurrences
FROM east_africa_debt ead 
GROUP BY indicator_name
ORDER BY occurrences DESC
LIMIT 1;
--This tells which metric (like total external debt or short-term debt) is most frequently reported.
--It can suggest where most data is focused.


--8. Identify any key debt trends

SELECT year, SUM(debt_amount) AS yearly_debt
FROM east_africa_debt ead 
GROUP BY year
ORDER BY year;









