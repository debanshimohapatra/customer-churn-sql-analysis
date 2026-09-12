
-- Customer Churn Analysis
-- SQL Portfolio Project

-- 1. Overall Churn
SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS churn_rate
FROM customers;


-- 2. Churn by Contract
SELECT
    Contract,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS churn_rate
FROM customers
GROUP BY Contract
ORDER BY churn_rate DESC;


-- 3. Churn by Internet Service
SELECT
    InternetService,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS churn_rate
FROM customers
GROUP BY InternetService
ORDER BY churn_rate DESC;


-- 4. Churn by Tenure Group
SELECT
    CASE
        WHEN tenure <= 12 THEN '0-12 months'
        WHEN tenure <= 24 THEN '13-24 months'
        WHEN tenure <= 48 THEN '25-48 months'
        ELSE '49+ months'
    END AS tenure_group,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS churn_rate
FROM customers
GROUP BY tenure_group
ORDER BY churn_rate DESC;


-- 5. Churn by Payment Method
SELECT
    PaymentMethod,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS churn_rate
FROM customers
GROUP BY PaymentMethod
ORDER BY churn_rate DESC;


-- 6. Churn by Senior Citizen Status
SELECT
    SeniorCitizen,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS churn_rate
FROM customers
GROUP BY SeniorCitizen
ORDER BY churn_rate DESC;


-- 7. Churn by Online Security
SELECT
    OnlineSecurity,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS churn_rate
FROM customers
GROUP BY OnlineSecurity
ORDER BY churn_rate DESC;


-- 8. Churn by Tech Support
SELECT
    TechSupport,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS churn_rate
FROM customers
GROUP BY TechSupport
ORDER BY churn_rate DESC;


-- 9. Contract + Payment Method
SELECT
    Contract,
    PaymentMethod,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS churn_rate
FROM customers
GROUP BY Contract, PaymentMethod
ORDER BY churn_rate DESC;


-- 10. High-Risk Customer Segments
SELECT
    Contract,
    InternetService,
    OnlineSecurity,
    TechSupport,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS churn_rate
FROM customers
GROUP BY
    Contract,
    InternetService,
    OnlineSecurity,
    TechSupport
HAVING COUNT(*) >= 50
ORDER BY churn_rate DESC;


-- 11. CTE Example
WITH churn_summary AS (
    SELECT
        Contract,
        COUNT(*) AS total_customers,
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers
    FROM customers
    GROUP BY Contract
)
SELECT
    Contract,
    total_customers,
    churned_customers,
    ROUND(
        100.0 * churned_customers / total_customers,
        2
    ) AS churn_rate
FROM churn_summary
ORDER BY churn_rate DESC;


-- 12. Subquery Example
SELECT
    Churn,
    COUNT(*) AS total_customers,
    ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charges
FROM customers
WHERE MonthlyCharges > (
    SELECT AVG(MonthlyCharges)
    FROM customers
)
GROUP BY Churn;


-- 13. Window Function Example
WITH segment_churn AS (
    SELECT
        Contract,
        InternetService,
        COUNT(*) AS total_customers,
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
        ROUND(
            100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
            2
        ) AS churn_rate
    FROM customers
    GROUP BY Contract, InternetService
)
SELECT
    Contract,
    InternetService,
    total_customers,
    churned_customers,
    churn_rate,
    RANK() OVER (ORDER BY churn_rate DESC) AS churn_rate_rank
FROM segment_churn
ORDER BY churn_rate_rank;


-- 14. Churned vs Retained
SELECT
    Churn,
    COUNT(*) AS total_customers,
    ROUND(AVG(tenure), 2) AS avg_tenure_months,
    ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charges,
    ROUND(AVG(TotalCharges), 2) AS avg_total_charges
FROM customers
GROUP BY Churn;


-- 15. Top Churned Customers by Monthly Charges
SELECT
    customerID,
    Contract,
    InternetService,
    tenure,
    MonthlyCharges,
    TotalCharges
FROM customers
WHERE Churn = 'Yes'
ORDER BY MonthlyCharges DESC
LIMIT 20;


-- 16. High-Risk Segment View
CREATE VIEW IF NOT EXISTS churn_risk_segments AS
SELECT
    Contract,
    InternetService,
    OnlineSecurity,
    TechSupport,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS churn_rate
FROM customers
GROUP BY
    Contract,
    InternetService,
    OnlineSecurity,
    TechSupport
HAVING COUNT(*) >= 50;
