-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support
PRAGMA foreign_keys = ON;

-- Personal Training Queries

-- 1. List all personal training sessions for a specific trainer
-- TODO: Write a query to list all personal training sessions for a specific trainer

SELECT pt.session_id, CONCAT(m.first_name, ' ', m.last_name) AS member_name, 
       pt.session_date, pt.start_time, pt.end_time
FROM personal_training_sessions pt
JOIN members m ON pt.member_id = m.member_id
JOIN staff s ON pt.staff_id = s.staff_id
WHERE CONCAT(s.first_name, ' ', s.last_name) = 'Ivy Irwin'
ORDER BY pt.session_date, pt.start_time;

