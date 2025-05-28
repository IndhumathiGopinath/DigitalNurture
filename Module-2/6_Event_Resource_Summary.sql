-- 6

SELECT event_id,
SUM(resource_type = 'pdf') AS pdf_count,
SUM(resource_type = 'image') AS image_count,
SUM(resource_type = 'link') AS link_count,
COUNT(*) AS total_resources
FROM Resources
GROUP BY event_id;

