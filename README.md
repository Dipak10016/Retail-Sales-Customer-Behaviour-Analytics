# 🛍️ Retail Sales & Customer Behavior Analytics Dashboard

> **End-to-end data analytics project** analyzing 10,000 retail transactions to uncover customer purchasing patterns, top-performing products, regional performance, and actionable business insights.

---

## 📋 Project Overview

| Attribute | Details |
|-----------|---------|
| **Domain** | Retail / E-Commerce |
| **Dataset Size** | 10,000 transactions (2023–2024) |
| **Tools** | Python · Pandas · Matplotlib · Seaborn · Power BI · Excel · SQL |
| **Deliverables** | Clean dataset · 8 Charts · KPI Report · Power BI Blueprint · Insights Report |

---

## 🎯 Objective

Analyze retail sales data to:
- Identify top-performing product categories and individual products
- Understand customer demographics and purchasing behavior
- Evaluate regional sales performance
- Calculate key business KPIs (revenue, profit, growth rates)
- Generate actionable strategies to improve sales and profitability

---

## 📁 Dataset Description

### Columns

| Column | Type | Description |
|--------|------|-------------|
| `order_id` | String | Unique transaction identifier (ORD100000+) |
| `order_date` | Date | Date of purchase (Jan 2023 – Dec 2024) |
| `customer_id` | String | Unique customer identifier |
| `customer_age` | Integer | Customer age (18–70) |
| `customer_gender` | String | Male / Female / Other |
| `region` | String | North / South / East / West / Central |
| `product_category` | String | Electronics / Clothing / Home & Garden / Sports / Books / Beauty / Toys / Food & Grocery |
| `product_name` | String | Specific product within category |
| `quantity` | Integer | Number of units purchased |
| `price` | Float | Unit price (INR) |
| `discount` | Integer | Discount percentage applied |
| `total_sales` | Float | Revenue after discount |
| `payment_method` | String | UPI / Credit Card / Debit Card / Net Banking / Cash / EMI |

### Engineered Columns (post-cleaning)
- `cost` — COGS based on category margin
- `profit` — total_sales − cost
- `profit_margin` — (profit / total_sales) × 100
- `revenue` — alias for total_sales
- `year`, `month`, `quarter`, `day_of_week` — temporal features

---

## 🧰 Tools & Technologies

| Tool | Usage |
|------|-------|
| **Python 3.x** | Data generation, cleaning, EDA, visualization |
| **Pandas** | Data manipulation, aggregation, cleaning |
| **NumPy** | Random data generation, numerical operations |
| **Matplotlib** | Base visualizations (line charts, bar charts, scatter plots) |
| **Seaborn** | Statistical plots (heatmaps) |
| **Power BI Desktop** | Interactive dashboard (see blueprint below) |
| **Excel** | Pivot table analysis, data exploration |
| **SQL** | KPI queries, aggregations (see sql_queries.sql) |

---

## 🔄 Methodology

### 1. Dataset Generation
Synthetic realistic data generated using NumPy random sampling with:
- Seasonal multipliers (Q4 spike)
- Realistic price ranges per product category (INR)
- Weighted distributions for regions, payment methods, and genders
- ~2% intentional missing values and 100 duplicate rows for cleaning demo

### 2. Data Cleaning
```python
# Key cleaning steps
df.drop_duplicates(inplace=True)             # Remove 100 duplicates
df['customer_age'].fillna(median)            # Impute age with median
df['customer_gender'].fillna('Unknown')      # Fill missing gender
df['order_date'] = pd.to_datetime(...)       # Parse dates
df['profit'] = df['total_sales'] - df['cost'] # Derive profit
```

### 3. Exploratory Data Analysis
- Monthly sales trend analysis (24-month view)
- Regional performance comparison
- Product category revenue breakdown
- Customer demographic segmentation
- Payment method usage distribution

### 4. KPI Calculation
All KPIs are calculated with Python Pandas aggregations and exported to `kpis.json`

### 5. Visualization
8 charts created using Matplotlib + Seaborn with dark-mode professional styling

---

## 📊 Key KPIs

| Metric | Value |
|--------|-------|
| Total Revenue | ₹1,16,039,624 (~₹116M) |
| Total Orders | 10,000 |
| Total Customers | 5,327 |
| Average Order Value | ₹11,603.96 |
| Total Profit | ₹4,97,43,596 (~₹49.7M) |
| Average Profit Margin | 50.82% |
| Total Units Sold | 14,499 |

---

## 💡 Key Insights

1. **Electronics Dominates** — 76% of revenue (₹88.6M) but only 40% margin. Accessory bundling can improve margins by 8–12%.

2. **East Region is #1** — ₹30M revenue (25.8% share). Increased marketing spend in East can yield disproportionate ROI.

3. **Q4 Seasonal Spike** — Oct–Dec drives 30–50% revenue uplift. Pre-stocking and early flash sales in September are critical.

4. **UPI Dominance** — 30.3% of all transactions. UPI cashback offers can improve mobile conversion by 15–20%.

5. **Core Customer: 26–45 years** — This age band generates 60.4% (₹70.1M) of total revenue. Loyalty programs and EMI offers target this segment perfectly.

6. **Books/Food: Hidden High-Margin Categories** — 65%+ margins. Subscription boxes can convert one-time buyers to recurring revenue.

7. **Discount Diminishing Returns** — 25–30% discounts show minimal volume uplift vs 10–15%. Capping at 20% protects ~₹2.5M annual profit.

---

## 📂 File Structure

```
retail-analytics/
├── retail_analysis.py          # Main Python script (EDA + charts)
├── README.md                   # This file
├── sql_queries.sql             # SQL KPI queries
├── data/
│   ├── raw_retail_data.csv     # Raw generated dataset (10,100 rows)
│   └── clean_retail_data.csv   # Cleaned dataset (10,000 rows)
├── outputs/
│   ├── kpis.json               # All KPI metrics
│   ├── dashboard_data.json     # Pre-aggregated dashboard data
│   ├── chart1_monthly_trend.png
│   ├── chart2_category_revenue.png
│   ├── chart3_regional_sales.png
│   ├── chart4_age_spending.png
│   ├── chart5_payment_methods.png
│   ├── chart6_quarterly.png
│   ├── chart7_top_products.png
│   └── chart8_heatmap.png
└── powerbi/
    └── retail_dashboard.pbix   # Power BI dashboard file
```

---

## 🚀 How to Run

```bash
# 1. Clone / download the project
git clone https://github.com/yourusername/retail-analytics.git
cd retail-analytics

# 2. Install dependencies
pip install pandas numpy matplotlib seaborn

# 3. Run the full pipeline
python retail_analysis.py

# 4. Open Power BI Desktop
# File → Open → powerbi/retail_dashboard.pbix
# or import clean_retail_data.csv fresh
```

---

## 📊 Power BI Dashboard

### Pages
1. **Executive Overview** — KPI cards, monthly trend, regional map
2. **Product Analysis** — Category revenue, top products matrix, discount analysis
3. **Customer Demographics** — Age/gender distribution, payment preferences
4. **Regional Deep Dive** — Region-wise comparisons, drill-through

### Key DAX Measures
```dax
Total Revenue = SUM(retail_data[total_sales])
Profit Margin % = DIVIDE(SUM(retail_data[profit]), SUM(retail_data[total_sales])) * 100
MoM Growth % = 
VAR CurrentMonth = [Total Revenue]
VAR PriorMonth = CALCULATE([Total Revenue], DATEADD('Date'[Date], -1, MONTH))
RETURN DIVIDE(CurrentMonth - PriorMonth, PriorMonth) * 100
YTD Revenue = TOTALYTD([Total Revenue], 'Date'[Date])
```

---

## 📋 Business Recommendations

| # | Recommendation | Expected Impact |
|---|----------------|----------------|
| 1 | Bundle accessories with Electronics | +₹4–7M revenue |
| 2 | Increase East region ad spend 30% | +₹3–4M revenue |
| 3 | Q4 pre-stock + early-bird deals | +20–30% Q4 uplift |
| 4 | Loyalty program for 26–45 segment | +15% repeat purchase rate |
| 5 | Subscription boxes (Books + Food) | ₹12–15M stable ARR |
| 6 | Cap discounts at 20% max | +₹2.5M profit protection |
| 7 | UPI cashback 2% | +15% mobile conversion |
| 8 | Central region activation campaign | +₹3–4M new revenue |

---

## 👤 Author

**Data Analyst Portfolio Project**  
Built with Python · Pandas · Matplotlib · Seaborn · Power BI

---

*Dataset is synthetic and generated for educational/portfolio purposes only.*
#   R e t a i l - S a l e s - C u s t o m e r - B e h a v i o u r - A n a l y t i c s  
 