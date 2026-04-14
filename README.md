# Grocery Sales Analytics | SQL & Power BI End-to-End Project

**🔗 [View Dashboard](#)** | **📄 [SQL Analysis](./sql_queries/)** | 📊 [Power BI Files](./powerbi/)
🔗Kaggle: https://www.kaggle.com/datasets/andrexibiza/grocery-sales-dataset
### Home
![Dashboard Page 1](/powerbi/images/Projet1_Page1.png)

### Overview Dashboard
![Dashboard Page 2](/powerbi/images/Projet1_Page2.png)

### Products Analysis
![Dashboard Page 3](/powerbi/images/Projet1_Page3.png)

### Trends & MoM Growth
![Dashboard Page 4](/powerbi/images/Projet1_Page4.png)

### Customer Segmentation
![Dashboard Page 5](/powerbi/images/Projet1_Page5.png)

### Insights & Patterns
![Dashboard Page 6](/powerbi/images/Projet1_Page6.png)

### Data Exploration
![Dashboard Page 7](/powerbi/images/Projet1_Page7.png)



> **Business Intelligence analysis of 6.7M transactions ($4.29B revenue) uncovering that 88% of income comes from non-discounted sales**

---

## 🎯 Business Problem

A US grocery retail chain needed to understand revenue drivers across 5 months of operations (Jan-May 2018). Key questions:

- Which products and categories drive profitability?
- **Do discounts actually increase revenue?** (Critical for margin optimization)
- Who are the high-value customers and what are their purchasing patterns?
- How does sales performance vary across time and geography?

---

## 💡 Key Findings & Business Impact

| Insight                                   | Business Value                                                                                  | Evidence                                                              |
| ----------------------------------------- | ----------------------------------------------------------------------------------------------- | --------------------------------------------------------------------- |
| **88% Revenue from Non-Discounted Sales** | Current discount strategy (10%, 20%) is ineffective; potential for immediate margin improvement | $3.7B (no discount) vs $400M (with discount)                          |
| **Wednesday Peak Performance**            | Optimize staffing and inventory for mid-week demand                                             | $632M (Wed) vs $599M daily average                                    |
| **Top Customer Segmentation**             | VIP retention program opportunity identified                                                    | Leley Perry: $260K revenue, $1,202 avg transaction (2x above average) |
| **Category Leadership**                   | Focus inventory investment on high-performers                                                   | Confections ($551M) > Meat ($487M) > Poultry ($435M)                  |
| **Data Quality Crisis**                   | Discovered critical ETL flaw requiring immediate attention                                      | TotalPrice column = 0 in 100% of source records                       |

---

## 🛠️ Technical Implementation

### Data Architecture & Engineering

- **Scale:** 521MB raw data, 7 tables, 6.7M transaction records
- **Data Quality Issues Resolved:**
  - Calculated true Revenue from scratch: `Quantity × Price × (1-Discount)` (source TotalPrice was NULL/0)
  - Excluded 67,526 invalid date records (`'0000-00-00'`)
  - Standardized inconsistent boolean flags (IsAllergic: "True"/"False"/"Unknown")
- **Performance Optimization:** Bypassed standard import wizard limitations using `LOAD DATA LOCAL INFILE` for 1.2M row ingestion

### SQL Analytics Layer

**Complex analytical queries featuring:**

- **Window Functions:** `DENSE_RANK()`, `RANK()`, `LAG()` for MoM growth and top-N analysis
- **CTEs:** Multi-level Common Table Expressions for customer segmentation and employee ranking
- **Advanced JOINs:** 3+ table relationships (sales → customers → cities → countries)
- **Date Intelligence:** Time-series analysis with proper date handling

**8 Business Questions Answered:**

1. Top 10 products by revenue
2. Best product per category (using window functions)
3. Monthly revenue trends
4. Day-of-week sales patterns
5. Category performance analysis
6. **Discount impact validation** (hypothesis testing)
7. High-value customer identification (RFM-style analysis)
8. Month-over-Month growth rates

### Power BI Visualization

- **Data Model:** Star schema with `sales_clean` as fact table, 6 dimension tables
- **DAX Measures:**
  - Time Intelligence (MoM%, YoY)
  - Customer metrics (Distinct count, Avg transaction value)
  - Revenue calculations with dynamic filtering
- **Dashboard Pages:** 5 interconnected views (Overview, Products, Trends, People, Insights)
- **Problem-Solving:** Resolved "ambiguous path" relationship errors between employees and sales

---

## 🚀 Critical Challenges Overcome

**1. The "Zero Revenue" Discovery**

- _Problem:_ Upon data exploration, discovered `TotalPrice = 0` in 100% of 6.7M rows — a critical ETL failure in source data
- _Solution:_ Engineered calculated column using business logic: `Quantity × Product.Price × (1-Discount)`
- _Impact:_ Saved project viability; enabled accurate financial analysis

**2. Incomplete Time-Series Data**

- _Problem:_ May 2018 data only available through 9th (9 days vs 31), causing misleading -33% "drop" in trend analysis
- _Solution:_ Implemented data quality filter excluding partial months from trend calculations
- _Result:_ Accurate MoM growth metrics showing true business performance

---

## 🛠️ Tech Stack

**Data Engineering:** `MySQL` • `SQL` • `Data Cleaning` • `ETL`

**Analytics:** `Power BI` • `DAX` • `Data Modeling` • `Time Intelligence`

**Development:** `Git` • `GitHub` • `VS Code`

---

## 📊 Dashboard Preview

_Screenshots to be added in `/images/` folder_

---

## 🎓 What I Learned

- **Data Validation First:** Always profile data before modeling — finding NULL TotalPrice early prevented incorrect business conclusions
- **Business Context Matters:** Technical "anomaly" (low May revenue) was actually data cutoff, not business decline
- **Discount Psychology:** Counter-intuitive finding that discounts didn't drive volume, reinforcing need for data-driven pricing strategy
- **Power BI Relationships:** Resolved circular reference errors between sales-employees-cities using proper star schema design

---

**Status:** ✅ Completed

---

_Project developed as part of career transition from Commercial Driver (Cat C+E) to Junior Data Analyst. Demonstrates end-to-end analytics capability from raw data ingestion to business insights presentation._
