-- 2 

describe events

SELECT e.event_id AS event_id, e.title AS event_name,
AVG(f.rating) AS avg_rating,
COUNT(f.feedback_id) AS feedback_count FROM Events e
JOIN Feedback f ON e.event_id = f.event_id
GROUP BY e.event_id, e.title
HAVING COUNT(f.feedback_id) >= 10
ORDER BY avg_rating DESC
LIMIT 0, 1000;

























