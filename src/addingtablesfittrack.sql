-- Database Schema for FitTrack Pro

.open TablesFitTrackPro.sqlite
DROP TABLE IF EXISTS locations;
DROP TABLE IF EXISTS members;
DROP TABLE IF EXISTS staff;
DROP TABLE IF EXISTS equipment;
DROP TABLE IF EXISTS classes;
DROP TABLE IF EXISTS class_schedule;
DROP TABLE IF EXISTS membership;
DROP TABLE IF EXISTS attendance;
DROP TABLE IF EXISTS class_attendance;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS personal_training_sessions;
DROP TABLE IF EXISTS member_health_metrics;
DROP TABLE IF EXISTS equipment_maintenance_log;

-- 1. Locations Table
CREATE TABLE locations (
    location_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address TEXT NOT NULL,
    phone_number VARCHAR(20),
    email VARCHAR(100),
    opening_hours VARCHAR(255)
);

-- 2. Members Table
CREATE TABLE members (
    member_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(20),
    date_of_birth DATE,
    join_date DATE DEFAULT CURRENT_DATE,
    emergency_contact_name VARCHAR(100),
    emergency_contact_phone VARCHAR(20)
);

-- 3. Staff Table
CREATE TABLE staff (
    staff_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(20),
    position VARCHAR(50) CHECK (position IN ('Trainer', 'Manager', 'Receptionist')),
    hire_date DATE DEFAULT CURRENT_DATE,
    location_id INT REFERENCES locations(location_id)
);

-- 4. Equipment Table
CREATE TABLE equipment (
    equipment_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    type VARCHAR(50) CHECK (type IN ('Cardio', 'Strength')),
    purchase_date DATE,
    last_maintenance_date DATE,
    next_maintenance_date DATE,
    location_id INT REFERENCES locations(location_id)
);

-- 5. Classes Table
CREATE TABLE classes (
    class_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    capacity INT NOT NULL,
    duration INT NOT NULL,
    location_id INT REFERENCES locations(location_id)
);

-- 6. Class Schedule Table
CREATE TABLE class_schedule (
    schedule_id SERIAL PRIMARY KEY,
    class_id INT REFERENCES classes(class_id),
    staff_id INT REFERENCES staff(staff_id),
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL
);

-- 7. Memberships Table
CREATE TABLE memberships (
    membership_id SERIAL PRIMARY KEY,
    member_id INT REFERENCES members(member_id),
    type VARCHAR(50) NOT NULL,
    start_date DATE DEFAULT CURRENT_DATE,
    end_date DATE,
    status VARCHAR(20) CHECK (status IN ('Active', 'Inactive'))
);

-- 8. Attendance Table
CREATE TABLE attendance (
    attendance_id SERIAL PRIMARY KEY,
    member_id INT REFERENCES members(member_id),
    location_id INT REFERENCES locations(location_id),
    check_in_time TIMESTAMP NOT NULL,
    check_out_time TIMESTAMP
);

-- 9. Class Attendance Table
CREATE TABLE class_attendance (
    class_attendance_id SERIAL PRIMARY KEY,
    schedule_id INT REFERENCES class_schedule(schedule_id),
    member_id INT REFERENCES members(member_id),
    attendance_status VARCHAR(20) CHECK (attendance_status IN ('Registered', 'Attended', 'Unattended'))
);

-- 10. Payments Table
CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    member_id INT REFERENCES members(member_id),
    amount DECIMAL(10,2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method VARCHAR(50) CHECK (payment_method IN ('Credit Card', 'Bank Transfer', 'PayPal')),
    payment_type VARCHAR(50) CHECK (payment_type IN ('Monthly membership fee', 'Day pass'))
);

-- 11. Personal Training Sessions Table
CREATE TABLE personal_training_sessions (
    session_id SERIAL PRIMARY KEY,
    member_id INT REFERENCES members(member_id),
    staff_id INT REFERENCES staff(staff_id),
    session_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    notes TEXT
);

-- 12. Member Health Metrics Table
CREATE TABLE member_health_metrics (
    metric_id SERIAL PRIMARY KEY,
    member_id INT REFERENCES members(member_id),
    measurement_date DATE NOT NULL,
    weight DECIMAL(5,2),
    body_fat_percentage DECIMAL(5,2),
    muscle_mass DECIMAL(5,2),
    bmi DECIMAL(5,2)
);

-- 13. Equipment Maintenance Log Table
CREATE TABLE equipment_maintenance_log (
    log_id SERIAL PRIMARY KEY,
    equipment_id INT REFERENCES equipment(equipment_id),
    maintenance_date DATE NOT NULL,
    description TEXT,
    staff_id INT REFERENCES staff(staff_id)
);
