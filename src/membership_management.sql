-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support
PRAGMA foreign_keys = ON;

-- Membership Management Queries

-- 1. List all active memberships
-- TODO: Write a query to list all active memberships

SELECT m.member_id, m.first_name, m.last_name, mem.type AS membership_type, m.join_date
FROM memberships mem
JOIN members m ON mem.member_id = m.member_id
WHERE mem.status = 'Active';

-- Retrieves all active memberships with member details.


-- 2. Calculate the average duration of gym visits for each membership type
-- TODO: Write a query to calculate the average duration of gym visits for each membership type

SELECT mem.type AS membership_type, AVG(JULIANDAY(a.check_out_time) - JULIANDAY(a.check_in_time)) * 1440 AS avg_visit_duration_minutes
FROM attendance a
JOIN memberships mem ON a.member_id = mem.member_id
WHERE a.check_out_time IS NOT NULL
GROUP BY mem.type;

-- Calculates the average visit duration in minutes per membership type.


-- 3. Identify members with expiring memberships this year
-- TODO: Write a query to identify members with expiring memberships this year

SELECT m.member_id, m.first_name, m.last_name, m.email, mem.end_date
FROM memberships mem
JOIN members m ON mem.member_id = m.member_id
WHERE mem.end_date BETWEEN CURRENT_DATE AND DATE(CURRENT_DATE, '+1 year');

-- Finds memberships expiring within the next 12 months.

