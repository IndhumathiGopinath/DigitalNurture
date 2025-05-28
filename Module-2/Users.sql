CREATE DATABASE EventsDb;
USE EventsDb;

CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Unique user identifier',
    full_name VARCHAR(100) NOT NULL COMMENT 'User\'s full name',
    email VARCHAR(100) UNIQUE NOT NULL COMMENT 'User\'s email',
    city VARCHAR(100) NOT NULL COMMENT 'City of the user',
    registration_date DATE NOT NULL COMMENT 'Date when user registered'
) 

CREATE TABLE Events (
    event_id INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Unique event identifier',
    title VARCHAR(200) NOT NULL COMMENT 'Title of the event',
    description TEXT COMMENT 'Event description',
    city VARCHAR(100) NOT NULL COMMENT 'City where event is held',
    start_date DATETIME NOT NULL COMMENT 'Start date and time of event',
    end_date DATETIME NOT NULL COMMENT 'End date and time of event',
    status ENUM('upcoming', 'completed', 'cancelled') COMMENT 'Current status of the event',
    organizer_id INT COMMENT 'User who organized the event',
    FOREIGN KEY (organizer_id) REFERENCES Users(user_id)
) 

CREATE TABLE Sessions (
    session_id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique session identifier',
    event_id INT COMMENT 'Associated event',
    title VARCHAR(200) NOT NULL COMMENT 'Title of the session',
    speaker_name VARCHAR(200) NOT NULL COMMENT 'Name of speaker',
    start_time DATETIME NOT NULL COMMENT 'Session start time',
    end_time DATETIME NOT NULL COMMENT 'Session end time',
    FOREIGN KEY (event_id) REFERENCES Events(event_id)
) 

CREATE TABLE Registrations (
    registration_id INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Unique registration ID',
    user_id INT NOT NULL COMMENT 'User who registered',
    event_id INT NOT NULL COMMENT 'Registered event',
    registration_date DATE NOT NULL COMMENT 'Date of registration',
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (event_id) REFERENCES Events(event_id)
) 

CREATE TABLE Feedback (
    feedback_id INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Unique feedback ID',
    user_id INT NOT NULL COMMENT 'User who gave feedback',
    event_id INT NOT NULL COMMENT 'Event for which feedback is given',
    rating INT CHECK (rating BETWEEN 1 AND 5) COMMENT 'Rating out of 5',
    comments TEXT COMMENT 'Optional comments',
    feedback_date DATE NOT NULL COMMENT 'Date of feedback',
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (event_id) REFERENCES Events(event_id)
) 

CREATE TABLE Resources (
    resource_id INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Unique resource ID',
    event_id INT NOT NULL COMMENT 'Associated event',
    resource_type ENUM('pdf', 'image', 'link') COMMENT 'Type of resource',
    resource_url VARCHAR(255) COMMENT 'Path or link to resource',
    uploaded_at DATETIME NOT NULL COMMENT 'Upload timestamp',
    FOREIGN KEY (event_id) REFERENCES Events(event_id)
) 

INSERT INTO Users (user_id, full_name, email, city, registration_date) VALUES
(1, 'Alice Johnson', 'alice@example.com', 'New York', '2024-12-01'),
(2, 'Bob Smith', 'bob@example.com', 'Los Angeles', '2024-12-05'),
(3, 'Charlie Lee', 'charlie@example.com', 'Chicago', '2024-12-10'),
(4, 'Diana King', 'diana@example.com', 'New York', '2025-01-15'),
(5, 'Ethan Hunt', 'ethan@example.com', 'Los Angeles', '2025-02-01');

INSERT INTO Events (event_id, title, description, city, start_date, end_date, status, organizer_id) VALUES
(1, 'Tech Innovators Meetup', 'A meetup for tech enthusiasts.', 'New York', '2025-06-10 10:00:00', '2025-06-10 16:00:00', 'upcoming', 1),
(2, 'AI & ML Conference', 'Conference on AI and ML advancements', 'Chicago', '2025-05-15 09:00:00', '2025-05-15 17:00:00', 'completed', 3),
(3, 'Frontend Development Bootcamp', 'Hands-on training on frontend tech.', 'Los Angeles', '2025-07-03 10:00:00', '2025-07-03 16:00:00', 'upcoming', 2);

INSERT INTO Sessions (session_id, event_id, title, speaker_name, start_time, end_time) VALUES
(1, 1, 'Opening Keynote', 'Dr. Tech', '2025-06-10 10:00:00', '2025-06-10 16:00:00'),
(2, 1, 'Future of Web Dev', 'Alice Johnson', '2025-06-10 10:00:00', '2025-06-10 12:00:00'),
(3, 2, 'AI in Healthcare', 'Charlie Lee', '2025-05-15 09:30:00', '2025-05-15 10:30:00'),
(4, 3, 'Intro to HTML5', 'Bob Smith', '2025-07-01 10:00:00', '2025-07-01 12:00:00');

INSERT INTO Registrations (registration_id, user_id, event_id, registration_date) VALUES
(1, 1, 1, '2025-05-01'),
(2, 3, 2, '2025-05-02'),
(3, 2, 1, '2025-04-28'),
(4, 4, 3, '2025-06-13'),
(5, 5, 3, '2025-06-15');

INSERT INTO Feedback (feedback_id, user_id, event_id, rating, comments, feedback_date) VALUES
(1, 1, 1, 4, 'Great insights!', '2025-05-16'),
(2, 3, 2, 5, 'Very informative.', '2025-05-16'),
(3, 2, 1, 3, 'Could be better.', '2025-06-11');


INSERT INTO Resources (resource_id, event_id, resource_type, resource_url, uploaded_at) VALUES
(1, 1, 'pdf', 'https://portal.com/resources/tech_meetup_agenda.pdf', '2025-05-01 10:00:00'),
(2, 2, 'image', 'https://portal.com/resources/ai_poster.jpg', '2025-05-10 14:30:00'),
(3, 3, 'link', 'https://portal.com/resources/html5_docs', '2025-06-25 16:00:00');


-- 1
SELECT e.event_id, e.title, e.city, e.start_date, e.end_date
FROM Registrations r JOIN Events e ON r.event_id = e.event_id
JOIN Users u ON r.user_id = u.user_id
WHERE r.user_id = 1  
AND e.status = 'upcoming' AND e.city = u.city
ORDER BY e.start_date ASC;
    
    
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

-- 3

SELECT u.user_id, u.full_name, u.email, u.city, u.registration_date
FROM Users u
LEFT JOIN Registrations r ON u.user_id = r.user_id AND r.registration_date >= DATE_SUB('2025-05-26', INTERVAL 90 DAY)
WHERE r.registration_id IS NULL;

  
-- 4

SELECT event_id, COUNT(*) AS session_count
FROM Sessions
WHERE TIME(start_time) < '12:00:00' AND TIME(end_time) > '10:00:00'
GROUP BY event_id;


-- 5
SELECT u.city, COUNT(DISTINCT r.user_id) AS distinct_user_registrations
FROM Registrations r
JOIN Users u ON r.user_id = u.user_id
GROUP BY u.city ORDER BY distinct_user_registrations DESC
LIMIT 5;


-- 6

SELECT event_id,
SUM(resource_type = 'pdf') AS pdf_count,
SUM(resource_type = 'image') AS image_count,
SUM(resource_type = 'link') AS link_count,
COUNT(*) AS total_resources
FROM Resources
GROUP BY event_id;

-- 7

SELECT u.full_name, e.title AS event_name,
f.rating, f.comments
FROM Feedback f
JOIN Users u ON f.user_id = u.user_id
JOIN Events e ON f.event_id = e.event_id
WHERE f.rating < 3;

-- 8

SELECT e.event_id, e.title AS event_name,
COUNT(s.session_id) AS session_count
FROM Events e
LEFT JOIN Sessions s ON e.event_id = s.event_id
WHERE e.status = 'upcoming'
GROUP BY e.event_id, e.title;

-- 9

SELECT u.user_id, u.full_name AS organizer_name, e.status,
COUNT(e.event_id) AS event_count
FROM Events e
JOIN Users u ON e.organizer_id = u.user_id
GROUP BY u.user_id, u.full_name, e.status
ORDER BY u.full_name, e.status;


-- 10

SELECT e.event_id, e.title
FROM Events e
JOIN Registrations r ON e.event_id = r.event_id
LEFT JOIN Feedback f ON e.event_id = f.event_id
WHERE f.feedback_id IS NULL
GROUP BY e.event_id, e.title;


-- 11


SELECT registration_date, COUNT(*) AS new_user_count
FROM Users
WHERE registration_date BETWEEN DATE_SUB('2025-05-26', INTERVAL 6 DAY) AND '2025-05-26'
GROUP BY registration_date
ORDER BY registration_date;


-- 12

SELECT e.event_id, e.title, 
COUNT(s.session_id) AS session_count
FROM Events e
JOIN Sessions s ON e.event_id = s.event_id
GROUP BY e.event_id, e.title
HAVING COUNT(s.session_id) = (
        SELECT MAX(session_total) FROM (
            SELECT COUNT(*) AS session_total FROM Sessions 
            GROUP BY event_id
        ) AS subq
    );
    
-- 13

SELECT e.city, AVG(f.rating) AS avg_rating
FROM Events e
JOIN Feedback f ON e.event_id = f.event_id
GROUP BY e.city;

-- 14


SELECT e.event_id, e.title,
COUNT(r.registration_id) AS total_registrations
FROM Events e
JOIN Registrations r ON e.event_id = r.event_id
GROUP BY e.event_id, e.title
ORDER BY total_registrations DESC
LIMIT 3;


-- 15

SELECT s1.event_id, s1.session_id AS session1_id,
s2.session_id AS session2_id, s1.title AS session1_title,
s2.title AS session2_title
FROM Sessions s1
JOIN Sessions s2 
ON s1.event_id = s2.event_id 
AND s1.session_id < s2.session_id
AND s1.start_time < s2.end_time
AND s1.end_time > s2.start_time;


-- 16


SELECT u.user_id, u.full_name, u.email, u.registration_date
FROM Users u
LEFT JOIN Registrations r ON u.user_id = r.user_id
WHERE u.registration_date >= DATE_SUB('2025-05-26', INTERVAL 30 DAY)
AND r.registration_id IS NULL;


-- 17

SELECT speaker_name,
COUNT(*) AS session_count
FROM Sessions
GROUP BY speaker_name
HAVING COUNT(*) > 1;


-- 18

SELECT e.event_id, e.title
FROM Events e
LEFT JOIN Resources r ON e.event_id = r.event_id
WHERE r.resource_id IS NULL;


-- 19
SELECT e.event_id, e.title,
COUNT(DISTINCT r.registration_id) AS total_registrations,
AVG(f.rating) AS avg_feedback_rating
FROM Events e
LEFT JOIN Registrations r ON e.event_id = r.event_id
LEFT JOIN Feedback f ON e.event_id = f.event_id
WHERE e.status = 'completed'
GROUP BY e.event_id, e.title;


-- 20


SELECT u.user_id, u.full_name,
COUNT(DISTINCT r.event_id) AS events_attended,
COUNT(DISTINCT f.feedback_id) AS feedbacks_submitted
FROM Users u
LEFT JOIN Registrations r ON u.user_id = r.user_id
LEFT JOIN Feedback f ON u.user_id = f.user_id
GROUP BY u.user_id, u.full_name;



-- 21


-- 22



-- 23


-- 24


-- 25








































