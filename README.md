# End-to-End Data Analytics Project Using Python, SQL Server & Power BI

![Dashboard Screenshot](CPI_Dashboard.png)

This project analyzes Canada’s Consumer Price Index (CPI) between 2020–2025, using Python for data cleaning and transformation, SQL Server for structured analysis, and Power BI for visualization.
The goal was to practice the full analytics pipeline: importing raw data, cleaning and modeling it, performing category-level inflation analysis, and building a clear dashboard that communicates key economic insights.

---

# Dataset

- **Source:** Statistics Canada — Table 18-10-0004-01
- **Years:** 2020–2025 (monthly CPI)
- The dataset includes CPI index values across major consumer categories, published with a base year 2002 = 100.

---

# Tools Used

- **Python** (pandas) — data cleaning, wrangling, feature creation
- **SQL Server Express** — inflation modeling, YoY analysis, category-level aggregation
- **Power BI Desktop** — interactive dashboard, KPIs, line charts, bar charts
- **DAX** — KPI measures (latest YoY inflation, surge/cooling averages)
- **GitHub** — documentation, reproducibility, version control

---

# This Project Walks Through 

## Python (Data Cleaning & Feature Engineering)

- Importing the raw StatsCan CSV
- Removing metadata rows and irrelevant columns
- Normalizing column names
- Converting monthly date fields
- Creating a clean long-format dataset
- Grouping to compute annual averages by category
- Calculating YoY inflation rates
- Exporting two final datasets
  - CPI_Over_Time.csv
  - CPI_Summary.csv

## SQL Server (Inflation Modeling & Analysis)

- Importing cleaned datasets into SQL Server
- Creating structured tables with primary keys
- Performing YoY calculations
- Identifying the 2021–2022 inflation surge
- Identifying the 2023–2025 cooling period
- Ranking categories by average inflation rates
- Stored results in `analysis.sql`  
  
## Power BI Dashboard (Visualisation) 

- KPI cards for: 
  - Latest YoY inflation (2025) 
  - Average surge-period inflation (2021–2022) 
  - Average cooling-period inflation (2023–2025)
- CPI index line chart (base year = 2002) including:
  - “Surge Period Begins” marker (2021)  
  - “Cooling Off Period Begins” marker (2023)  
  - Economic context footnote
- Category-level inflation bar charts for:
  - Surge period (2021–2022)
  - Cooling period (2023–2025)
- Category slicer for dynamic filtering

---

# Key Insights from the Dashboard

- Headline inflation has cooled significantly since its mid-2022 peak.  
- Gasoline and energy drove the early inflation surge, with average YoY increases exceeding 20–30%.  
- The cooling period (2023–2025) shows negative inflation in both gasoline and energy.  
- Most core categories (food, shelter, goods) show moderate inflation ranges aligned with the overall CPI trend.  
- The CPI Index has stabilized after a steep climb through 2021–2022.

---

# How to View This Project

## Power BI Dashboard

- Open `CPI_Dashboard.pbix` in Power BI Desktop  
- OR view the static image `CPI_Dashboard.png`

## Python Scripts

- View `cpi_cleaning.ipynb` or `cpi_cleaning.py`

## SQL Scripts

- Review `cpi_tables.sql` and `analysis.sql`  
- Scripts run on SQL Server Express Edition  

---

# Notes on Tooling
The project uses the latest free version of Power BI Desktop.
Some legacy formatting features (axis padding, label rotation) are no longer available in recent builds; equivalent alternatives (subtitles, layout adjustments) were used to maintain clarity. These limitations do not affect the analytical results.
