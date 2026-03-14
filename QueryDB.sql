-- Which sessions are the most popular (have the highest number of participants)?
SELECT 
    s.session_id, s.session_date, s.type, COUNT(pa.person_id) AS total_participants
FROM 
    Session s
JOIN 
    Participation pa ON s.session_id = pa.session_id
GROUP BY 
    s.session_id, s.session_date, s.type
ORDER BY 
    total_participants DESC
LIMIT 10;

-- What is the average capacity of rooms in each fitness center?
SELECT 
    c.center_id, c.name AS center_name, AVG(r.capacity) AS average_room_capacity
FROM 
    Center c
JOIN 
    Rooms r ON c.center_id = r.center_id
GROUP BY 
    c.center_id, c.name;


-- Which trainers are leading the most sessions?

SELECT 
    t.trainer_id, p.first_name, p.family_name, COUNT(gs.session_id) AS total_sessions
FROM 
    Trainer t
JOIN 
    Person p ON t.person_id = p.person_id
JOIN 
    GroupSession gs ON t.trainer_id = gs.trainer_id
GROUP BY 
    p.first_name, p.family_name, t.trainer_id
ORDER BY 
    total_sessions DESC
LIMIT 10;


-- What is the distribution of session types (e.g., Yoga, Pilates, etc.) across all centers?
SELECT 
    s.type, COUNT(s.session_id) AS total_sessions
FROM 
    Session s
GROUP BY 
    s.type
ORDER BY 
    total_sessions DESC;
    
    
-- How many sessions are conducted per day in each center?
SELECT 
    c.center_id, c.name AS center_name, s.session_date, COUNT(s.session_id) AS total_sessions
FROM 
    Center c
JOIN 
    Session s ON c.center_id = s.center_id
GROUP BY 
    c.center_id, c.name, s.session_date
ORDER BY 
    s.session_date, total_sessions DESC;


-- Identify the busiest times of the day for sessions in each center.
SELECT 
    c.center_id, c.name AS center_name, s.start_hour, COUNT(s.session_id) AS total_sessions
FROM 
    Center c
JOIN 
    Session s ON c.center_id = s.center_id
GROUP BY 
    c.center_id, c.name, s.start_hour
ORDER BY 
    c.center_id, s.start_hour;

-- Which rooms are most frequently used for sessions?
SELECT 
    r.room_id, r.number AS room_number, COUNT(s.session_id) AS total_sessions
FROM 
    Rooms r
LEFT JOIN 
    Session s ON r.room_id = s.room_id
GROUP BY 
    r.room_id, r.number
ORDER BY 
    total_sessions DESC
LIMIT 10;

-- Find the ratio of group sessions to individual sessions in each center.
SELECT 
    c.center_id, c.name AS center_name, 
    SUM(CASE WHEN gs.session_id IS NOT NULL THEN 1 ELSE 0 END) AS group_sessions,
    SUM(CASE WHEN isession.session_id IS NOT NULL THEN 1 ELSE 0 END) AS individual_sessions,
    SUM(CASE WHEN gs.session_id IS NOT NULL THEN 1 ELSE 0 END) / 
    NULLIF(SUM(CASE WHEN isession.session_id IS NOT NULL THEN 1 ELSE 0 END), 0) AS ratio
FROM 
    Center c
LEFT JOIN 
    Session s ON c.center_id = s.center_id
LEFT JOIN 
    GroupSession gs ON s.session_id = gs.session_id
LEFT JOIN 
    IndividualSession isession ON s.session_id = isession.session_id
GROUP BY 
    c.center_id, c.name;

-- Which participants attend the most sessions?

SELECT 
    p.first_name, p.family_name, COUNT(pa.session_id) AS total_sessions
FROM 
    Person p
JOIN 
    Participation pa ON p.person_id = pa.person_id
GROUP BY 
    p.first_name, p.family_name
ORDER BY 
    total_sessions DESC
LIMIT 10;


-- What is the average age of participants in different types of sessions?

SELECT 
    s.type, AVG(DATEDIFF(CURDATE(), p.birth_date) / 365.25) AS average_age
FROM 
    Session s
JOIN 
    Participation pa ON s.session_id = pa.session_id
JOIN 
    Person p ON pa.person_id = p.person_id
GROUP BY 
    s.type
ORDER BY 
    average_age;









