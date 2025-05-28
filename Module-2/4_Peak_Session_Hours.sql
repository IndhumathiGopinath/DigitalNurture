-- 4

SELECT event_id, COUNT(*) AS session_count
FROM Sessions
WHERE TIME(start_time) < '12:00:00' AND TIME(end_time) > '10:00:00'
GROUP BY event_id;



