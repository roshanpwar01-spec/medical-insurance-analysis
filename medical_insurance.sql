use medical_insurance;
select count(*) from insurance;

select * from insurance limit 5;
-- 1. What is the average premium and medical expenses by **region**? Which region has the highest claim burden?

SELECT
    region,
    COUNT(*)                    AS total_policies,
    ROUND(AVG(expenses), 2)     AS avg_expenses,
    ROUND(AVG(premium), 2)      AS avg_premium,
    ROUND(SUM(expenses), 2)     AS total_expenses,
    ROUND(SUM(premium), 2)      AS total_premium
FROM insurance
GROUP BY region
ORDER BY avg_expenses DESC;

-- 2. How does **BMI category** (Underweight / Normal / Overweight / Obese) affect average expenses and premium?

SELECT
    CASE
        WHEN bmi < 18.5 THEN '1. Underweight (<18.5)'
        WHEN bmi < 25.0 THEN '2. Normal (18.5–24.9)'
        WHEN bmi < 30.0 THEN '3. Overweight (25–29.9)'
        ELSE                  '4. Obese (30+)'
    END                         AS bmi_category,
    COUNT(*)                    AS total_policyholders,
    ROUND(AVG(bmi), 2)          AS avg_bmi,
    ROUND(AVG(expenses), 2)     AS avg_expenses,
    ROUND(AVG(premium), 2)      AS avg_premium
FROM insurance
GROUP BY bmi_category
ORDER BY bmi_category;

-- 3. What is the **expense-to-premium ratio** per policyholder — who are the most and least profitable customers?

select 
  case 
	when (expenses/premium) <0.5 then 'hightly profitable (ratio <0.5)'
	when (expenses/premium) <1.0 then 'profitable (ratio <0.5-1.0)'
	when (expenses/premium) <2.0 then 'loss (ratio <1.0-2.0)'
	else                              'high loss (ratio >2.0)'
  end 	as profitablity_segment,
count(*) as total_policyholders,
round(avg (expenses/premium),2) as avg_ratio,
round(avg(expenses),2) as avg_expenses,
round(avg(premium),2) as avg_premium
from insurance
group by profitablity_segment 
order by avg_ratio;
SELECT
    age, gender, bmi, region,
    expenses, premium,
    ROUND(expenses / premium, 2)    AS expense_premium_ratio
FROM insurance
ORDER BY expense_premium_ratio DESC
LIMIT 10;

--  4 How do **age groups** (18–25, 26–35, 36–45, 46–55, 56–64) differ in average expenses and premium paid?

SELECT 
	CASE
		WHEN age between 18 and 25 then '18-25'
        when age between 26 and 35 then '26-35'
        when age between 36 and 45 then '36-45'
        when age between 46 and 55 then '46-55'
        else '56-64'        
	end  as age_group,
count(*) as total_policyholder,
round(avg(expenses),2) as avg_expenses,
round(avg(premium),2) as avg_premium,
round(min(expenses),2) as  min_expenses,
round(max(expenses),2) as max_expenses
from insurance
group by age_group
order by age_group;

-- 5. Is there a significant difference in **expenses between male and female** policyholders across regions?

 SELECT
    gender,
    COUNT(*)                        AS total_policyholders,
    ROUND(AVG(expenses), 2)         AS avg_expenses,
    ROUND(AVG(premium), 2)          AS avg_premium
FROM insurance
GROUP BY gender;

-- 6. Does having **more children/dependents** lead to higher medical expenses?

SELECT
    children                        AS num_dependents,
    COUNT(*)                        AS total_policyholders,
    ROUND(AVG(expenses), 2)         AS avg_expenses,
    ROUND(AVG(premium), 2)          AS avg_premium,
    ROUND(SUM(expenses), 2)         AS total_expenses
FROM insurance
GROUP BY children
ORDER BY children;

-- 7. Which **customer segment** (age group + region combination) is highest risk (highest avg expenses)?

SELECT
    CASE
        WHEN age BETWEEN 18 AND 25 THEN '18–25'
        WHEN age BETWEEN 26 AND 35 THEN '26–35'
        WHEN age BETWEEN 36 AND 45 THEN '36–45'
        WHEN age BETWEEN 46 AND 55 THEN '46–55'
        ELSE                            '56–64'
    END                             AS age_group,
    region,
    COUNT(*)                        AS total_policyholders,
    ROUND(AVG(expenses), 2)         AS avg_expenses,
    ROUND(AVG(bmi), 2)              AS avg_bmi
FROM insurance
GROUP BY age_group, region
ORDER BY avg_expenses DESC
LIMIT 10;

-- 8. Do **discount-eligible policyholders** have higher or lower medical expenses than non-eligible ones — is the discount justified?

SELECT
    discount_eligibility,
    COUNT(*)                        AS total_policyholders,
    ROUND(AVG(expenses), 2)         AS avg_expenses,
    ROUND(AVG(premium), 2)          AS avg_premium,
    ROUND(AVG(expenses / premium), 2) AS avg_expense_premium_ratio,
    ROUND(SUM(premium) - SUM(expenses), 2) AS net_profit
FROM insurance
GROUP BY discount_eligibility;

-- 9. What percentage of policyholders are **high-cost outliers** (expenses above ₹40,000) and what's their profile?

SELECT
    COUNT(*)                                        AS outlier_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM insurance), 2) AS pct_of_total,
    ROUND(AVG(expenses), 2)                         AS avg_expenses,
    ROUND(AVG(age), 1)                              AS avg_age,
    ROUND(AVG(bmi), 2)                              AS avg_bmi
FROM insurance
WHERE expenses > 40000;

-- 10. What is the overall **Claims Ratio** (total expenses / total premium)? Which segment is unprofitable (ratio > 1)?

SELECT
    ROUND(SUM(expenses), 2)                         AS total_expenses,
    ROUND(SUM(premium), 2)                          AS total_premium,
    ROUND(SUM(expenses) / SUM(premium), 4)          AS overall_claims_ratio,
    ROUND(SUM(premium) - SUM(expenses), 2)          AS net_profit_loss
FROM insurance;

SELECT
    region,
    ROUND(SUM(expenses), 2)                         AS total_expenses,
    ROUND(SUM(premium), 2)                          AS total_premium,
    ROUND(SUM(expenses) / SUM(premium), 4)          AS claims_ratio,
    CASE
        WHEN SUM(expenses) / SUM(premium) > 1 THEN 'Unprofitable'
        ELSE 'Profitable'
    END                                             AS profitability_status
FROM insurance
GROUP BY region
ORDER BY claims_ratio DESC;

SELECT
    CASE
        WHEN age BETWEEN 18 AND 25 THEN '18–25'
        WHEN age BETWEEN 26 AND 35 THEN '26–35'
        WHEN age BETWEEN 36 AND 45 THEN '36–45'
        WHEN age BETWEEN 46 AND 55 THEN '46–55'
        ELSE                            '56–64'
    END                             AS age_group,
    ROUND(SUM(expenses) / SUM(premium), 4)          AS claims_ratio,
    CASE
        WHEN SUM(expenses) / SUM(premium) > 1 THEN 'Unprofitable'
        ELSE 'Profitable'
    END                                             AS profitability_status
FROM insurance
GROUP BY age_group
ORDER BY claims_ratio DESC;