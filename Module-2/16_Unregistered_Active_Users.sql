

-- 16


SELECT u.user_id, u.full_name, u.email, u.registration_date
FROM Users u
LEFT JOIN Registrations r ON u.user_id = r.user_id
WHERE u.registration_date >= DATE_SUB('2025-05-26', INTERVAL 30 DAY)
AND r.registration_id IS NULL;


