# 🏥 Medical Insurance Risk & Premium Analytics
### MySQL + Power BI | End-to-End Data Analysis Project

---

## 📌 Project Overview

This project performs an end-to-end analysis of medical insurance policyholder data using **MySQL** for data analysis and **Power BI** for interactive dashboard reporting. The goal is to uncover premium pricing patterns, identify high-risk customer segments, and evaluate insurer profitability across demographic and regional dimensions.

---

## 📂 Dataset

| Attribute | Detail |
|---|---|
| **Source** | Kaggle (publicly available) |
| **Records** | 1,338 policyholders |
| **Columns** | 8 |
| **Missing Values** | None |

### Columns

| Column | Type | Description |
|---|---|---|
| `age` | INT | Policyholder age (18–64) |
| `gender` | VARCHAR | Male / Female |
| `bmi` | DECIMAL | Body Mass Index |
| `children` | INT | Number of dependents (0–5) |
| `discount_eligibility` | VARCHAR | Yes / No |
| `region` | VARCHAR | Northeast, Northwest, Southeast, Southwest |
| `expenses` | DECIMAL | Actual medical expenses incurred |
| `premium` | DECIMAL | Insurance premium charged |

---

## 🛠️ Tools & Technologies

![MySQL](https://img.shields.io/badge/MySQL-8.0-blue?logo=mysql)
![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-yellow?logo=powerbi)
![DAX](https://img.shields.io/badge/DAX-Measures-orange)

---

## 📁 Repository Structure

```
medical-insurance-analysis/
│
├── medical_insurance.sql       # All 10 SQL analysis queries
├── medical_insurance.pbix      # Power BI dashboard file
├── medical_insurance.csv       # Raw dataset
├── screenshots/
│   ├── page1_executive.png
│   ├── page2_demographics.png
│   └── page3_risk_profitability.png
└── README.md
```

---

## 🔍 SQL Analysis — 10 Business Questions

### 💰 Premium & Expenses Analysis

**Q1. Average premium and expenses by region — which region has the highest claim burden?**
- Southeast emerged as the highest-risk region with avg expenses of **$14,735** — 19.4% higher than Southwest ($12,346)

**Q2. How does BMI category affect average expenses and premium?**
- Obese policyholders (BMI 30+) incur significantly higher medical expenses than Normal BMI policyholders, confirming BMI as a key risk driver

**Q3. Expense-to-premium ratio — who are the most and least profitable customers?**
- Identified profitability segments ranging from Highly Profitable (ratio < 0.5) to High Loss (ratio > 2.0)
- Top 10 least profitable policyholders profiled for targeted risk pricing

### 👥 Demographic Segmentation

**Q4. How do age groups differ in average expenses and premium?**
- Clear cost escalation with age: 18–25 avg $9,087 → 56–64 avg $18,796 — a **106% increase** across age groups

**Q5. Gender-based expense difference across regions?**
- Male and female expenses are broadly comparable, with minor regional variation

**Q6. Do more dependents lead to higher medical expenses?**
- Analyzed expense trends across 0–5 dependents

### 🎯 Risk & Discount Analysis

**Q7. Which age group + region combination is highest risk?**
- Identified top 10 highest-risk segments combining age group and regional data

**Q8. Is the discount financially justified for the insurer?**
- Discount-eligible policyholders pay higher premiums ($608 avg) vs non-eligible ($174 avg) — but expense-to-premium ratio reveals true profitability impact

**Q9. Who are the high-cost outliers (expenses > $40,000)?**
- Profiled high-cost outliers by age group, gender, region, and BMI

### 📊 Business KPI

**Q10. Overall Claims Ratio — which segment is unprofitable?**
- Calculated Claims Ratio (Total Expenses / Total Premium) by region and age group to identify unprofitable segments

---

## 📊 Power BI Dashboard

### 3-Page Interactive Dashboard

**Page 1 — Executive Overview**
> KPI Cards: Total Policies · Total Expenses · Total Premium · Net Profit · Claims Ratio
> Bar Charts: Avg Expenses by Region · Avg Expenses by Age Group
> Slicers: Region · Gender

**Page 2 — Demographic Analysis**
> Avg Expenses by Age Group · Clustered Bar: Gender by Region
> BMI Category vs Expenses · Children vs Avg Expenses
> Slicers: Region · Gender · Age Group · BMI Category

**Page 3 — Risk & Profitability**
> Claims Ratio by Region · Claims Ratio by Age Group
> Donut: Outlier vs Normal Policyholders · Discount Eligibility vs Net Profit
> Profitability Segment Distribution
> KPI Cards: Claims Ratio · Net Profit · Outlier Count · Outlier %

---

## 💡 Key Insights

| # | Insight |
|---|---|
| 1 | **Southeast** is the highest-risk region — avg expenses 19.4% above Southwest |
| 2 | Medical expenses **double** from the youngest to oldest age group |
| 3 | **Obese policyholders** drive disproportionately higher claims |
| 4 | Discount-eligible policyholders pay **3.5x higher premiums** than non-eligible |
| 5 | High-cost outliers (expenses > $40,000) represent a small % but contribute significantly to total claims |
| 6 | Claims ratio analysis reveals which regions and age segments are **unprofitable** for the insurer |

---

## 🚀 How to Run This Project

**MySQL Setup**
1. Open MySQL Workbench
2. Create database: `CREATE DATABASE medical_insurance_db;`
3. Import `medical_insurance.csv` using Table Data Import Wizard
4. Run queries from `medical_insurance.sql`

**Power BI**
1. Open `medical_insurance.pbix` in Power BI Desktop
2. Update data source connection if needed: Home → Transform Data → Data Source Settings
3. Refresh data

---

## 👤 Author

**Roshan Panwar**
📧 Connect on [LinkedIn](https://linkedin.com/in/roshanpanwar-195048388)
💻 More projects on [GitHub](https://github.com/roshanpwar01-spec)
