# Indian Healthcare Operations Analysis

## Overview
SQL-based analysis of 20,000+ patient records across 33 Indian states to evaluate disease burden, treatment costs, and healthcare access gaps using SQLite.

## Dataset
- **Source:** Kaggle (Public Dataset)
- **Size:** 20,000 patient records
- **Coverage:** 33 Indian states and UTs, 32 disease categories
- **Variables:** 31 columns including demographics, disease type, severity, treatment cost, hospital type, insurance status, and outcomes

## Key Findings

### 1. Disease Cost Disparity
- Non-Communicable diseases average INR 3,58,371 per patient vs INR 3,634 for Waterborne diseases — a **99x cost difference**
- Top 6 diseases (all NCDs) account for **82% of total healthcare spend**
- Lung Cancer alone averages INR 9.8L per patient

### 2. Healthcare Access Gap
- **40.4% of patients are uninsured**
- **17.5% of all patients** are uninsured AND facing severe or critical conditions
- Uttar Pradesh accounts for 15% of all uninsured severe/critical cases nationally

### 3. Operational Inefficiency
- Critical cases average **35.5 hospitalization days** vs 0.2 days for mild cases — a **178x difference**
- Meghalaya, Manipur, and Chhattisgarh have the highest severe case rates (46-54%)

## SQL Techniques Used
- `GROUP BY` with aggregate functions (`AVG`, `SUM`, `COUNT`)
- **Window functions:** `RANK() OVER()`, `SUM() OVER()` for rankings and percentages
- **Subqueries** for multi-level aggregation
- **CASE WHEN** for conditional segmentation
- **Cohort analysis** — filtering and ranking high-risk patient segments

## Files
- `healthcare_analysis.sql` — all 6 queries with comments
- `indian_diseases_dataset.csv` — raw dataset

## Consulting Implications
1. **Resource allocation** — 82% of spend concentrated in 6 disease categories suggests targeted procurement and specialist staffing can drive major efficiency gains
2. **Insurance coverage gap** — 17.5% of patients facing critical conditions without 
   coverage represents a critical policy intervention opportunity
3. **State prioritization** — UP, Bihar, and Maharashtra together account for 31% 
   of uninsured severe cases, making them priority targets for Ayushman Bharat expansion
