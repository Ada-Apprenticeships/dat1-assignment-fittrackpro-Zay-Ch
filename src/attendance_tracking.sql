-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support
PRAGMA foreign_keys = ON;

-- Attendance Tracking Queries

-- 1. Record a member's gym visit
-- TODO: Write a query to record a member's gym visit

INSERT INTO attendance (member_id, location_id, check_in_time)
VALUES (7, 1, CURRENT_TIMESTAMP);

-- Records check-in time for member_id = 7 at location_id = 1.


-- 2. Retrieve a member's attendance history
-- TODO: Write a query to retrieve a member's attendance history

SELECT DATE(check_in_time) AS visit_date, check_in_time, check_out_time
FROM attendance
WHERE member_id = 5;

-- Retrieves all past check-ins and check-outs for member_id = 5.


-- 3. Find the busiest day of the week based on gym visits
-- TODO: Write a query to find the busiest day of the week based on gym visits

SELECT
    -- to get date as day of the week
    -- Use CASE to name to display full day name
    CASE strftime('%w', check_in_time)
        WHEN '0' THEN 'Sunday'
        WHEN '1' THEN 'Monday'
        WHEN '2' THEN 'Tuesday'
        WHEN '3' THEN 'Wednesday'
        WHEN '4' THEN 'Thursday'
        WHEN '5' THEN 'Friday'
        WHEN '6' THEN 'Saturday'
    END AS day_of_week,
    COUNT(*) AS visit_count
FROM attendance
GROUP BY day_of_week
ORDER BY visit_count DESC
LIMIT 1;

-- Also listing all the numbers in co-ord to the days
-- Groups visits by day of the week and finds the busiest day.



-- 4. Calculate the average daily attendance for each location
-- TODO: Write a query to calculate the average daily attendance for each location

SELECT 
    l.name AS location_name, 
    ROUND(AVG(daily_visits), 2) AS avg_daily_attendance
FROM (
    SELECT 
        location_id, 
        DATE(check_in_time) AS visit_date, 
        COUNT(*) AS daily_visits
    FROM attendance
    GROUP BY location_id, visit_date
) subquery
JOIN locations l ON subquery.location_id = l.location_id
GROUP BY l.name;


-- Calculates the average daily attendance per gym location.

