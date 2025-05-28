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



    
    











