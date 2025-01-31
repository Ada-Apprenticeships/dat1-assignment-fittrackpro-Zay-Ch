-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support
PRAGMA foreign_keys = ON;

-- Class Scheduling Queries

-- 1. List all classes with their instructors
-- TODO: Write a query to list all classes with their instructors

SELECT DISTINCT c.class_id, c.name AS class_name, CONCAT(s.first_name, ' ', s.last_name) AS instructor_name
FROM classes c
JOIN class_schedule cs ON c.class_id = cs.class_id
JOIN staff s ON cs.staff_id = s.staff_id;

-- Joins classes, class_schedule, and staff to get class names and instructor names.
-- Removes duplicates


-- 2. Find available classes for a specific date
-- TODO: Write a query to find available classes for a specific date

SELECT c.class_id, c.name, cs.start_time, cs.end_time, (c.capacity - COUNT(ca.class_attendance_id)) AS available_spots
FROM class_schedule cs
JOIN classes c ON cs.class_id = c.class_id
LEFT JOIN class_attendance ca ON cs.schedule_id = ca.schedule_id
WHERE DATE(cs.start_time) = '2025-02-01'
GROUP BY c.class_id, c.name, cs.start_time, cs.end_time, c.capacity;

-- Filters classes scheduled on '2025-02-01'.
-- Counts how many members have registered and calculates available_spots.
-- Includes start_time and end_time


-- 3. Register a member for a class
-- TODO: Write a query to register a member for a class

INSERT INTO class_attendance (schedule_id, member_id, attendance_status)
VALUES (3, 11, 'Registered');

-- Registers member_id = 11 for class_id = 3.


-- 4. Cancel a class registration
-- TODO: Write a query to cancel a class registration

DELETE FROM class_attendance
WHERE schedule_id = 7 AND member_id = 2;

-- Removes a member from the scheduled class (schedule_id 7).


-- 5. List top 3 most popular classes
-- TODO: Write a query to list top 3 most popular classes

SELECT c.class_id, c.name AS class_name, COUNT(ca.class_attendance_id) AS registration_count
FROM classes c
JOIN class_schedule cs ON c.class_id = cs.class_id
JOIN class_attendance ca ON cs.schedule_id = ca.schedule_id
GROUP BY c.class_id, c.name
ORDER BY registration_count DESC
LIMIT 3;

-- Counts registrations for each class.
-- Orders by highest registration count and limits to top 3.


-- 6. Calculate average number of classes per member
-- TODO: Write a query to calculate average number of classes per member

SELECT ROUND(AVG(class_count), 2) AS avg_classes_per_member
FROM (
    SELECT member_id, COUNT(*) AS class_count
    FROM class_attendance
    GROUP BY member_id
) subquery;

-- Calculates how many classes each member attended.
-- Averages that count across all members.
-- Rounds to 2 decimal places

