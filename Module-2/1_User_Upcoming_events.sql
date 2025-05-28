-- 1
SELECT e.event_id, e.title, e.city, e.start_date, e.end_date
FROM Registrations r JOIN Events e ON r.event_id = e.event_id
JOIN Users u ON r.user_id = u.user_id
WHERE r.user_id = 1  
AND e.status = 'upcoming' AND e.city = u.city
ORDER BY e.start_date ASC;