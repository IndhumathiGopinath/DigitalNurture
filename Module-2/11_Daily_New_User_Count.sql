-- 11


SELECT registration_date, COUNT(*) AS new_user_count
FROM Users
WHERE registration_date BETWEEN DATE_SUB('2025-05-26', INTERVAL 6 DAY) AND '2025-05-26'
GROUP BY registration_date
ORDER BY registration_date;


