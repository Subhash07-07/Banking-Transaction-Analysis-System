USE BankingSystem;

-- ADVANCED RISK ANALYSIS QUERY
WITH CustomerBalances AS (
    SELECT customer_id, SUM(balance) AS total_savings
    FROM Accounts
    GROUP BY customer_id
),
CustomerLoans AS (
    SELECT customer_id, SUM(loan_amount) AS total_debt
    FROM Loans
    WHERE status = 'Approved'
    GROUP BY customer_id
)
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COALESCE(cb.total_savings, 0)          AS total_savings,
    COALESCE(cl.total_debt, 0)             AS total_debt,
    (COALESCE(cl.total_debt, 0) - COALESCE(cb.total_savings, 0)) AS net_risk_exposure
FROM Customers c
LEFT JOIN CustomerBalances cb ON c.customer_id = cb.customer_id
LEFT JOIN CustomerLoans cl    ON c.customer_id = cl.customer_id
WHERE COALESCE(cl.total_debt, 0) > COALESCE(cb.total_savings, 0)
ORDER BY net_risk_exposure DESC;
