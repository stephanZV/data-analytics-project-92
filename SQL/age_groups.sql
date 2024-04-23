SELECT 
    CASE 
        WHEN age BETWEEN 16 AND 25 THEN '16-25'
        WHEN age BETWEEN 26 AND 40 THEN '26-40'
        ELSE '40+'
    END AS age_category,
    COUNT(*) AS count
FROM customers
GROUP BY age_category
ORDER BY age_category;
/* использовали кейс для группировки по возрасту*/
