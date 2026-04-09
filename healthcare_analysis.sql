-- Indian Healthcare Operations Analysis
-- Dataset: 20,000 patient records across 33 Indian states
-- Tool: SQLite via DBeaver

-- Query 1: Disease category cost breakdown
SELECT 
    disease_category,
    COUNT(*) AS total_patients,
    ROUND(AVG(treatment_cost_inr), 0) AS avg_cost_inr,
    ROUND(MIN(treatment_cost_inr), 0) AS min_cost,
    ROUND(MAX(treatment_cost_inr), 0) AS max_cost
FROM patient_records
WHERE treatment_cost_inr IS NOT NULL
GROUP BY disease_category
ORDER BY avg_cost_inr DESC;

-- Query 2: Hospitalization days by severity (178x finding)
SELECT 
    severity,
    COUNT(*) AS total_patients,
    ROUND(AVG(days_hospitalized), 1) AS avg_days_hospitalized,
    MIN(days_hospitalized) AS min_days,
    MAX(days_hospitalized) AS max_days
FROM patient_records
WHERE days_hospitalized IS NOT NULL
GROUP BY severity
ORDER BY avg_days_hospitalized DESC;

-- Query 3: Uninsured patient analysis with window function
SELECT 
    insurance_status,
    COUNT(*) AS total_patients,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 1) AS percentage,
    SUM(CASE WHEN severity IN ('Severe', 'Critical') THEN 1 ELSE 0 END) AS severe_critical_count,
    ROUND(SUM(CASE WHEN severity IN ('Severe', 'Critical') THEN 1 ELSE 0 END) * 100.0 / SUM(COUNT(*)) OVER(), 1) AS pct_of_total
FROM patient_records
GROUP BY insurance_status
ORDER BY total_patients DESC;

-- Query 4: State-wise severity ranking using RANK() window function
SELECT 
    state,
    total_patients,
    severe_critical,
    ROUND(severe_critical * 100.0 / total_patients, 1) AS severe_rate_pct,
    RANK() OVER(ORDER BY severe_critical * 100.0 / total_patients DESC) AS severity_rank
FROM (
    SELECT 
        state,
        COUNT(*) AS total_patients,
        SUM(CASE WHEN severity IN ('Severe', 'Critical') THEN 1 ELSE 0 END) AS severe_critical
    FROM patient_records
    GROUP BY state
) ranked_states
WHERE total_patients > 50
ORDER BY severity_rank;

-- Query 5: Top diseases by total cost burden
SELECT 
    disease_name,
    disease_category,
    COUNT(*) AS total_patients,
    ROUND(AVG(treatment_cost_inr), 0) AS avg_cost,
    ROUND(SUM(treatment_cost_inr), 0) AS total_cost_burden,
    ROUND(SUM(treatment_cost_inr) * 100.0 / SUM(SUM(treatment_cost_inr)) OVER(), 2) AS pct_of_total_spend
FROM patient_records
WHERE treatment_cost_inr IS NOT NULL
GROUP BY disease_name, disease_category
ORDER BY total_cost_burden DESC
LIMIT 10;

-- Query 6: Cohort analysis - uninsured high-risk patients by state
SELECT 
    state,
    COUNT(*) AS uninsured_severe_critical,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS pct_of_national_burden,
    RANK() OVER(ORDER BY COUNT(*) DESC) AS burden_rank
FROM patient_records
WHERE insurance_status = 'Uninsured'
AND severity IN ('Severe', 'Critical')
GROUP BY state
ORDER BY burden_rank
LIMIT 10;
