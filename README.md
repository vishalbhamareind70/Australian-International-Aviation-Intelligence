
<div align="center">

# ✈️ Australian International Aviation Intelligence

### 📊 Data Analytics | Business Intelligence | Machine Learning

**Turning Australian aviation data into meaningful insights and future passenger forecasts.**

![Python](https://img.shields.io/badge/Python-Data%20Analysis-3776AB?style=flat-square&logo=python&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-SQL-4169E1?style=flat-square&logo=postgresql&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-F2C811?style=flat-square&logo=powerbi&logoColor=black)
![Machine Learning](https://img.shields.io/badge/Machine%20Learning-XGBoost-198754?style=flat-square)

</div>

---

## 🌏 Project at a Glance

Australia connects millions of international passengers to destinations around the world every year.

But which airports are the busiest? Which airlines carry the most passengers? How did the industry recover from COVID-19? And can we predict future passenger demand?

This project answers these questions using real aviation data, SQL analysis, interactive dashboards and machine learning.

### 🎯 What This Project Delivers

- 📈 Understand international passenger growth and recovery.
- 🛫 Identify leading airports, airlines and international routes.
- 🌍 Explore popular overseas travel markets.
- 📅 Discover seasonal travel patterns.
- 💺 Analyse international flights and seat capacity.
- 🤖 Forecast passenger demand for the next 12 months.
- 💡 Turn analytical findings into practical business recommendations.

---

## 🔍 Key Findings

### 📈 1. International Travel Has Recovered

| Metric | Result |
|---|---|
| International passengers in 2009 | 24.41 million |
| International passengers in 2025 | 44.85 million |
| Growth compared with 2019 | +5.5% |

**💡 What this means:**

Australia's international aviation industry has recovered strongly from the COVID-19 disruption.

**✅ Recommendation:** Airports and airlines should regularly review passenger growth when planning future services and capacity.

### 🏆 2. Sydney Leads International Airport Traffic

| Rank | Airport | Historical Passengers |
|---|---|---:|
| 🥇 | Sydney | 199.48 million |
| 🥈 | Melbourne | 125.20 million |
| 🥉 | Brisbane | 73.85 million |
| 4 | Perth | 56.74 million |

**💡 What this means:**

Sydney and Melbourne are Australia's major international passenger hubs.

**✅ Recommendation:** Focus on operational efficiency and capacity planning at major airports while monitoring growth at other airports.

### 🛩️ 3. Qantas Leads Airline Passenger Traffic

| Airline | Passengers | Market Share |
|---|---:|---:|
| Qantas | 83.55M | 16.99% |
| Jetstar | 46.40M | 9.44% |
| Singapore Airlines | 43.03M | 8.75% |

**💡 What this means:**

Qantas is the leading individual airline in the analysed historical data, followed by Jetstar and Singapore Airlines.

**✅ Recommendation:** Airlines should monitor passenger trends and market share to understand their competitive position.

### 🌍 4. New Zealand and Singapore Are Major Markets

- **Largest country market:** New Zealand — 89.20M passengers.
- **Second-largest market:** Singapore — 72.07M passengers.
- **Busiest route:** Sydney–Auckland — 20.30M passengers.
- **Second-busiest route:** Sydney–Singapore — 19.79M passengers.

**💡 What this means:**

New Zealand and Singapore are important international travel markets for Australia.

**✅ Recommendation:** Airlines should regularly evaluate demand on these routes before making scheduling and capacity decisions.

### 📅 5. Passenger Demand Changes by Season

- **December:** 3.24M average monthly passengers.
- **January:** 3.18M average monthly passengers.
- **May:** 2.44M average monthly passengers.

*Seasonal averages are based on 2009–2019.*

**💡 What this means:**

International travel is generally busier in December and January and quieter in May.

**✅ Recommendation:** Use seasonal patterns to support staffing, flight scheduling and operational planning.

> **Data note:** Historical airport, airline, country and route rankings exclude 2020–2022 and 2026. Their passenger totals are cumulative across the selected years, not annual figures.

---

## 🤖 Machine Learning: Predicting Future Demand

Beyond understanding historical aviation performance, this project also explores an important question:

**Can we predict how many international passengers Australia may handle in the coming months?**

To answer this, I compared two forecasting techniques:

- **SARIMA:** A statistical model that learns from historical passenger patterns.
- **XGBoost:** A machine learning model that uses historical passenger information to make predictions.

### 🧪 Model Performance

Models were evaluated against actual passenger data from January 2025 to June 2026.

| Model | MAE | RMSE |
|---|---:|---:|
| SARIMA — Full History | 562,681 | 634,857 |
| SARIMA — Post-COVID | 403,685 | 476,516 |
| **🏆 XGBoost — Full History** | **241,890** | **300,352** |
| XGBoost — Post-COVID | 258,176 | 328,226 |

**🏆 Best-performing model: XGBoost (Full History)**

It achieved the lowest errors among the four tested approaches.

**In simple words:** MAE measures how far predictions were from actual passenger numbers on average. Lower values mean better performance.

### 🔮 Passenger Forecast: July 2026 – June 2027

After selecting XGBoost, the model was retrained using available historical data through June 2026.

| Forecast Highlight | Predicted Passengers |
|---|---:|
| 🔺 Highest — January 2027 | 4.32 million |
| 🔺 December 2026 | 4.30 million |
| 🔻 Lowest — May 2027 | 3.35 million |

**💡 Business value:**

These forecasts can help airports and airlines anticipate busy periods, plan staffing and review flight capacity.

*Forecasts are estimates, not guaranteed outcomes. Additional independent testing would strengthen confidence in future performance.*

---

## 🛠️ Tools & Technologies

| Technology | How I Used It |
|---|---|
| 🐍 Python & Pandas | Cleaned and prepared aviation datasets |
| 🗄️ PostgreSQL | Analysed passenger trends, airlines, airports and routes |
| 📊 Power BI | Built an interactive aviation dashboard |
| 🤖 SARIMA & XGBoost | Compared forecasting approaches and predicted demand |
| ☁️ Google Colab | Developed and evaluated Python notebooks |
| 📁 Excel & CSV | Managed original, cleaned and forecast datasets |

---

## 📂 Project Structure

```text
Australian-Aviation-Intelligence/
│
├── 01_Raw_Data/
│   └── Original aviation datasets
│
├── 02_Cleaned_Data/
│   ├── Cleaned passenger data
│   ├── Cleaned airline data
│   ├── Cleaned flight and seat data
│   └── 12-month passenger forecast
│
├── 03_Python/
│   ├── Data cleaning notebook
│   └── Machine learning forecasting notebook
│
├── 04_SQL/
│   └── PostgreSQL analysis
│
├── 05_PowerBI/
│   └── Aviation intelligence dashboard
│
├── 06_Documentation/
│   ├── Problem statement
│   └── Project outcome report
│
└── README.md
```

---

## 📊 About the Datasets

This project uses three aviation datasets.

| Dataset | Records | Period |
|---|---:|---|
| International City Pair | 32,808 | Jan 2009 – Jun 2026 |
| Airlines by Country | 22,466 | Jan 2009 – Jun 2026 |
| International Flights and Seats | 36,723 | Sep 2003 – Jun 2026 |

**What the data helps us understand:**

- **Passenger data:** Where and when people travel internationally.
- **Airline data:** Which airlines carry international passengers.
- **Flight and seat data:** How many flights operate and what seat capacity is reported.

Some passenger records contain missing values, especially around COVID-19. These limitations should be considered when interpreting the results.

---

## 🔄 Project Workflow

**Step 1 — Data Collection**

Collected three historical aviation datasets in Excel format.

**Step 2 — Data Cleaning**

Used Python and Pandas to check missing values, duplicates and data types, then exported cleaned CSV files.

**Step 3 — SQL Analysis**

Used PostgreSQL to analyse passenger growth, leading airports, airline market share, routes, flight activity and seat capacity.

**Step 4 — Data Visualisation**

Built an interactive Power BI dashboard to explore historical aviation performance.

**Step 5 — Machine Learning**

Developed and evaluated SARIMA and XGBoost forecasting models.

**Step 6 — Forecasting & Recommendations**

Generated 12-month passenger forecasts and developed practical business recommendations.

---

## 💼 Business Recommendations

Based on the project findings:

1. **Plan for peak demand:** Prepare additional operational resources during busy travel periods.
2. **Monitor important routes:** Regularly evaluate high-demand international markets.
3. **Improve capacity planning:** Compare passenger demand with available flights and seats.
4. **Use predictive analytics:** Update forecasting models as new data becomes available.
5. **Strengthen data quality:** Monitor missing values to improve the reliability of analysis.

These recommendations are analytical suggestions and would require further operational and financial evaluation before implementation.

---

## 🚀 Explore the Project

You can explore the work in the folders above:

- **Python notebooks:** Review the data cleaning and forecasting process.
- **SQL analysis:** Explore the queries and business findings.
- **Power BI dashboard:** Download the `.pbix` file and open it using Power BI Desktop.
- **Cleaned datasets:** Examine the prepared data and forecast results.
- **Documentation:** Read the detailed problem statement and outcome report.

---

## 🎓 Skills Demonstrated

`Python` · `Pandas` · `Data Cleaning` · `PostgreSQL` · `SQL` · `Power BI` · `Business Intelligence` · `Exploratory Data Analysis` · `Time Series Forecasting` · `XGBoost` · `Business Recommendations`

---

## 📝 Final Takeaway

This project demonstrates how historical aviation data can be transformed into meaningful business insights and future passenger demand forecasts.

By combining **Python, SQL, Power BI and Machine Learning**, it provides a practical example of using data to understand industry performance, identify patterns and support business decision-making.

---

<div align="center">

### ✈️ From Raw Data to Business Decisions

**Data Cleaning → SQL Analysis → Power BI → Machine Learning → Business Insights**

</div>
