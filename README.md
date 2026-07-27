# Fraz Shafique — Data Analytics Portfolio

### E-Commerce Analyst | BI Developer | Digital Marketing Analytics

Data analyst with an international business background spanning the UAE, GCC, UK, Pakistan, Canada and the USA — across sales, food \& beverage, marketing brands and imports/exports. Currently based in Vancouver, BC.

I combine hands-on analytics skills (Power BI, Tableau, R) with deep domain knowledge in ecommerce, digital marketing, retail and F\&B — building dashboards that go beyond visuals to drive real business decisions.

📧 frazbama@gmail.com  |  🔗 [GitHub](https://github.com/frazbama/daportfolio)  |  🌐 [Milestone Studio X](https://milestonestudiox.com)

\---

## 🛠️ Skills \& Tools

|Category|Tools|
|-|-|
|**BI \& Visualization**|Power BI Desktop, Power Query, DAX, Tableau|
|**Data Analysis**|R, Google Data Analytics Framework|
|**Data Modeling**|Star Schema, Tabular Editor, Relationship Management|
|**Digital Marketing Analytics**|ROAS, CPA, CTR, CVR, Ad Spend Analysis|
|**Other**|GitHub, Excel, SQL (basic), Python (basic)|

\---

## 📁 Portfolio Projects

---

### 🌟 Project 1 — Trueleaf Provisions: F&B Market Expansion Dashboard
[**View Project →**](https://github.com/frazbama/daportfolio/tree/main/Trueleaf%20Provisions)

A full-stack Power BI analytics project for an alternative-sweeteners F&B brand planning expansion from its established North American base (Canada, USA, Mexico) into three new international markets (UAE, UK, Saudi Arabia). The dashboard pressure-tests which markets to enter first, models entry scenarios, and flags the channels and products that protect margin as the brand scales.

**The Story:** Growth ambition was outrunning evidence. Leadership wanted to expand into the Gulf and UK, but had no ranked view of which market to prioritise, what entry would cost, or which channels would quietly erode margin at scale. The board needed a decision, not a hunch. This dashboard turned three candidate markets into a ranked, defensible entry plan.

**Key Findings:**
* 🎯 ⟨Market⟩ ranks highest on the composite Market Attractiveness score, outscoring ⟨Market⟩ on demand, competition and regulatory fit
* 📈 The Market Entry Simulator shows breakeven at ⟨X months⟩ under the base-case entry scenario using What-If parameters
* 💡 ⟨Channel⟩ carries the strongest Channel Health Score, while ⟨Channel⟩ shows margin leakage from elevated return rates
* 👥 Returns & margin analysis isolates the product-market pairs where high revenue masks poor net margin quality

**Dashboard Pages:**
|Page|Purpose|
|-|-|
|Introduction|Project overview and analyst profile|
|Executive Summary|Cross-market KPI snapshot|
|Sales Performance|Revenue by product, category and geography|
|Market Attractiveness|Composite scoring across candidate markets|
|Market Entry Simulator|What-If scenario modelling for entry decisions|
|Returns & Margin Quality|Net margin analysis and return-rate leakage|
|Channel Health & Predictive Quality|Composite Channel Health Score|
|About This Project|Storytelling arc and analytical process|

**Technical Highlights:**
* Star schema data model with a dedicated `_Measures` table
* What-If parameters driving the Market Entry Simulator scenarios
* Composite scoring built with `ADDCOLUMNS` + `ALL()` for correct global min/max ranges under row-level filter context
* `TREATAS` used to resolve returns-trend sparklines where `USERELATIONSHIP` failed in sparkline context
* Two stakeholder personas framing strategic vs. operational pages (Founder/CEO and Head of Growth)
* Google Data Analytics Framework: Ask → Prepare → Process → Analyze → Share → Act

**Tools:** Power BI Desktop · Power Query · DAX · Tabular Editor · Star Schema Modeling · What-If Parameters
**Sector:** F&B · Market Expansion · Digital Marketing Analytics
**Data:** ⟨N orders⟩ · ⟨N markets⟩ · synthetic dataset · ⟨date range⟩

---

### Project 2 — AdventureWorks: Sales & Returns Performance Dashboard
[**View Project →**](https://github.com/frazbama/daportfolio/tree/main/Adventure%20Works)

A multi-page Power BI dashboard analysing three years of AdventureWorks sales, returns and customer data across a global bike-and-accessories retailer. The build tracks revenue and profit performance, surfaces return-rate hotspots by product and territory, and profiles the customer base driving repeat purchases.

**The Story:** Sales were climbing, but nobody could say whether the growth was healthy. Returns were rising in the background and the mix of who was buying — and what — kept shifting. The business needed one view that connected revenue, returns and customer behaviour so it could tell profitable growth from noisy growth. This dashboard delivered that view.

**Key Findings:**
* 🎯 Revenue grew across 2015–2017, with ⟨category⟩ contributing the largest share of total sales
* 📈 ⟨Territory/region⟩ posted the strongest revenue growth over the three-year window
* 💡 ⟨Product/subcategory⟩ carries the highest return rate, concentrating margin risk in a small set of SKUs
* 👥 Customer profiling by income, occupation and household surfaces the segments driving repeat orders

**Dashboard Pages:**
|Page|Purpose|
|-|-|
|Executive Summary|3-year KPI snapshot|
|Sales Performance|Revenue and orders by category, product and territory|
|Returns Analysis|Return quantity and rate by product and region|
|Customer Intelligence|Segments by income, occupation and demographics|
|Product Detail|Drill-through to product-level metrics|

**Technical Highlights:**
* Star schema data model connecting Sales, Returns, Products, Customers, Territories and Calendar
* Consolidated three yearly sales tables (2015–2017) via Power Query append
* Dedicated Calendar table with `YearMonthSort` column for correct chronological sorting
* DAX measures for return rate, revenue, profit and YoY growth
* Google Data Analytics Framework: Ask → Prepare → Process → Analyze → Share → Act

**Tools:** Power BI Desktop · Power Query · DAX · Star Schema Modeling
**Sector:** Retail · Tourism · Sales & Returns Analytics
**Data:** 56,046 orders · 18,148 customers · 1,809 returns · 3 years (2015–2017) · 10 territories

---

### 🌟 Project 3 — GlowCo: Health, Wellness & Beauty Ecommerce Dashboard
[**View Project →**](https://github.com/frazbama/daportfolio/tree/main/GlowCo%20Ecommerce)
> *Company name anonymised as GlowCo to protect client confidentiality.*

A full-stack Power BI analytics project for a direct-to-consumer health, wellness and beauty brand operating across Canada, USA, UK and Australia. The dashboard investigates declining ROAS across paid channels and identifies the product-channel combinations driving the highest profit margins.

![GlowCo Executive Summary](GlowCo%20Ecommerce/screenshots/01_executive_summary.png)

**The Story:** Revenue was growing but profitability was under pressure. Ad spend was increasing year over year yet ROAS was quietly declining on the highest-funded channels. Someone needed to connect the dots. That someone was me.

**Key Findings:**
* 🎯 Supplements category delivers **68.2% gross profit margin** — highest in the catalogue — yet receives disproportionately low ad budget
* 📈 TikTok Ads ROAS **improved 31%** from 2023 to 2025 while Meta ROAS **declined 22%**
* 💡 Email Marketing has the **lowest CPA ($18 avg)** of any channel yet sits at the bottom of budget allocation
* 👥 High-LTV customers (top 15%) generate **52% of total revenue** — predominantly acquired via Google Search and Email

**Dashboard Pages:**
|Page|Purpose|
|-|-|
|Introduction|Project overview and analyst profile|
|Executive Summary|3-year KPI snapshot|
|Sales Performance|Revenue by product, category and geography|
|Marketing & Ad Spend|ROAS, CPA, CTR, CVR by channel|
|Customer Intelligence|Segments, LTV, acquisition channel analysis|
|Product Profitability|Margin analysis by category and SKU|
|Data Explorer|Raw data validation tables|
|About This Project|Storytelling arc and analytical process|

**Technical Highlights:**
* Star schema data model — 6 tables, 7 relationships (6 active, 1 inactive)
* 46 DAX measures across 5 display folders
* Inactive relationship activated via `USERELATIONSHIP` for acquisition channel analysis
* Full data storytelling arc: Setting → Rising Action → Climax → Falling Action → Resolution
* Google Data Analytics Framework: Ask → Prepare → Process → Analyze → Share → Act

**Tools:** Power BI Desktop · Power Query · DAX · Tabular Editor · Star Schema Modeling
**Sector:** Ecommerce · Digital Marketing · Paid Media Analytics
**Data:** 17,775 orders · 5,000 customers · 3 years (2023–2025) · 7 paid channels

---

### Project 4 — Bellabeat Smart Device Case Study

[**View Project →**](https://github.com/frazbama/daportfolio/tree/main/Bellabeat%20Case%20Study)

Google Data Analytics capstone case study using R — analysing Fitbit smart device usage data to identify trends and provide marketing recommendations for Bellabeat, a wellness technology company.

**Tools:** R · RStudio · ggplot2 · tidyverse
**Sector:** Health \& Wellness · Consumer Analytics
**Framework:** Google Data Analytics — Ask → Prepare → Process → Analyze → Share → Act

\---

## 📊 Portfolio Projects

A growing collection of Power BI projects spanning multiple industry verticals:

As part of an ongoing portfolio development programme the following Power BI projects are in development:

| # | Project | Sector | Status |
|---|---------|--------|--------|
| 1 | Trueleaf Provisions Marketing Dashboard | F&B | ✅ Completed |
| 2 | GlowCo Dashboard | Ecommerce | ✅ Completed |
| 3 | AdventureWorks Dashboard | Retail | ✅ Completed |
| 4 | Dashboards for Canadian Food and Beverage Brands | F&B | 🔄 In Progress & Ongoing |
| 5 | Dental Clinic Performance Dashboard | Healthcare | 🔄 In Progress |
| 6 | Digital Marketing Agency Dashboard | Marketing Analytics | 📋 Planned |
| 7 | Retail Clothing Store Ad Spend Analysis | Retail | 📋 Planned |
| 8 | BC Ski Resort 3-Year Performance Dashboard | Tourism | 📋 Planned |

Each project incorporates digital marketing and ad spend data alongside core business metrics — demonstrating cross-functional analytical thinking across multiple industry verticals.

\---

## 📚 Education \& Credentials

|Credential|Institution|Year|
|-|-|-|
|Microcredential in Data Visualization with MS Power BI | BCIT | 2026 |
|Google Data Analytics Certificate|Google / Coursera|2024|

\---

## 📬 Contact

I am available for data analytics consulting, freelance dashboard development and full-time analyst roles.

* 📧 Email: frazbama@gmail.com
* 🔗 GitHub: github.com/frazbama/daportfolio
* 🌐 Agency: Milestone Studio X (MSX) — Digital Marketing \& Analytics

\---

*Portfolio actively maintained and updated. Last updated: June 2026.*

