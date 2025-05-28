-- 5
SELECT u.city, COUNT(DISTINCT r.user_id) AS distinct_user_registrations
FROM Registrations r
JOIN Users u ON r.user_id = u.user_id
GROUP BY u.city ORDER BY distinct_user_registrations DESC
LIMIT 5;


