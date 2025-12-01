USE Canada_CPI_Project
GO

--Set primary key in loaded tables
ALTER TABLE dbo.CPI_Over_Time
add Id INT IDENTITY(1,1) NOT NULL;

ALTER TABLE dbo.CPI_Over_Time
ADD CONSTRAINT PK_CPI_Over_Time PRIMARY KEY (Id);

ALTER TABLE dbo.CPI_Summary
add Id INT IDENTITY(1,1) NOT NULL;

ALTER TABLE dbo.CPI_Summary
ADD CONSTRAINT PK_CPI_Summary PRIMARY KEY (Id);

--Uniqueness integrity check
ALTER TABLE dbo.CPI_Over_Time 
ADD CONSTRAINT UQ_CPI_Over_Time_CategoryDate
	UNIQUE (Category, [Date]);

ALTER TABLE dbo.CPI_Summary
ADD CONSTRAINT UQ_CPI_Summary_CategoryYear
	UNIQUE (Category, [Year]);

--Check years and # of categories 
SELECT
	MIN([Year]) as Minyear,
	MAX([Year]) as Maxyear,
	COUNT(DISTINCT Category) as DistinctCategories
FROM dbo.CPI_Over_Time

--List of CPI Categories
SELECT DISTINCT Category
FROM dbo.CPI_Over_Time
ORDER BY Category;

--Annual CPI and YoY inflation for 'all-items' category
SELECT
	Category,
	[Year],
	avg_cpi,
	prev_year_cpi,
	yoy_inflation_rate
FROM dbo.CPI_Summary
WHERE Category = 'All-items'
ORDER BY [Year];

--Compare Food vs Shelter inflation over time
SELECT
	category,
	[year],
	avg_cpi,
	yoy_inflation_rate
FROM dbo.CPI_Summary
WHERE category IN ('food', 'shelter')
ORDER BY category, [Year];

--Monthly YoY CPI change over a 12 month period by category
WITH MonthlyYoy AS (
	SELECT
		category,
		[date],
		[year],
		[month],
		CPI,
		LAG(CPI, 12) OVER (
			PARTITION BY category
			ORDER BY [date]
		) AS CPI_12M_Ago
	FROM dbo.CPI_Over_Time
)
SELECT 
	category,
	[date],
	[year],
	[month],
	CPI,
	CPI_12M_Ago,
	CASE
		WHEN CPI_12M_Ago IS NULL THEN NULL
		ELSE (CPI - CPI_12M_Ago) / CPI_12M_Ago * 100
	END AS YoY_12M_Change
FROM MonthlyYoY
WHERE CPI_12M_Ago IS NOT NULL
ORDER BY category, [date];


--Top 5 categories by average YoY inflation for COVID shock and early inflation surge
SELECT TOP (5)
	category,
	AVG(yoy_inflation_rate) AS avgyoyinflation_2021_2022
FROM dbo.CPI_Summary
WHERE [Year] BETWEEN 2010 and 2022
GROUP BY Category
ORDER BY avgyoyinflation_2021_2022 DESC;


--Top 5 categories by average YoY inflation for peak inflation and gradual cooling
SELECT TOP (5)
	category,
	AVG(yoy_inflation_rate) AS avgyoyinflation_2022_2025
FROM dbo.CPI_Summary
WHERE [Year] BETWEEN 2022 and 2025
GROUP BY Category
ORDER BY avgyoyinflation_2022_2025 DESC;

--Monthly CPI enriched with annual YoY inflation 
SELECT
	t.[date],
	t.[year],
	t.[month],
	t.category,
	t.cpi,
	s.yoy_inflation_rate AS AnnualYoYRate
FROM dbo.CPI_Over_Time as t
LEFT JOIN dbo.CPI_Summary as s
	ON t.category = s.category
	AND t.[year] = s.[year]
ORDER BY t.category, t.[date];
