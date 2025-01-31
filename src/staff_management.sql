-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support
PRAGMA foreign_keys = ON;


-- Staff Management Queries

-- 1. List all staff members by role
-- TODO: Write a query to list all staff members by role

SELECT staff_id, first_name, last_name, position 
FROM staff
ORDER BY position;


-- 2. Find trainers with one or more personal training session in the next 30 days
-- TODO: Write a query to find trainers with one or more personal training session in the next 30 days

SELECT s.staff_id AS trainer_id, CONCAT(s.first_name, ' ', s.last_name) AS trainer_name, COUNT(pt.session_id) AS session_count
FROM staff s
JOIN personal_training_sessions pt ON s.staff_id = pt.staff_id
WHERE pt.session_date BETWEEN CURRENT_DATE AND DATE(CURRENT_DATE, '+30 days')
GROUP BY s.staff_id, trainer_name;

-- Sets staff id to be trainer id, to fulfill the read me requirement
-- Counts trainers with upcoming personal training sessions.

