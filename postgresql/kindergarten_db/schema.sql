-- =====================================================================================
-- KINDERGARTEN DATABASE SCHEMA                                                        |
-- Description: Core database architecture for student, staff, and classroom tracking. |
-- Platform:    PostgreSQL                                                             |
-- Project:     Designing a Database from Scratch                                      |
-- =====================================================================================

-- DATABASE INITIALIZATION
-- =======================
CREATE DATABASE kindergarten_db;

-- TABLE SCHEMA ARCHITECTURE
-- =========================
-- 1. Create the STAFF table first (no dependencies)
CREATE TABLE Staff (
    staff_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    role_type VARCHAR(50) NOT NULL,
    job_title VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(20),
    hire_date DATE NOT NULL DEFAULT CURRENT_DATE,
    status BOOLEAN NOT NULL DEFAULT TRUE,
    cert_expiry DATE
);

-- PARENTS table (no dependencies)
CREATE TABLE Parents (
    parent_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    alternative_phone VARCHAR(20),
    email VARCHAR(100) UNIQUE NOT NULL,
    home_address VARCHAR(255),
    emergency_prio INT NOT NULL DEFAULT 1,
    authorized_pickup BOOLEAN NOT NULL DEFAULT TRUE
);

-- CLASSROOMS table (depends on Staff)
CREATE TABLE Classrooms (
    classroom_id SERIAL PRIMARY KEY,
    room_name VARCHAR(50) NOT NULL,
    room_number VARCHAR(10) NOT NULL,
    age_group VARCHAR(50) NOT NULL,
    max_capacity INT NOT NULL,
    lead_teach_id INT,
    co_teach_id INT,
    FOREIGN KEY (lead_teach_id) REFERENCES Staff(staff_id) ON DELETE SET NULL,
    FOREIGN KEY (co_teach_id) REFERENCES Staff(staff_id) ON DELETE SET NULL
);

-- KIDS table (depends on Classrooms)
CREATE TABLE Kids (
    kid_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender VARCHAR(10),
    enrollment_date DATE NOT NULL DEFAULT CURRENT_DATE,
    status VARCHAR(20) DEFAULT 'Active',
    allergies_med TEXT,
    potty_trained BOOLEAN DEFAULT FALSE,
    classroom_id INT,
    FOREIGN KEY (classroom_id) REFERENCES Classrooms(classroom_id) ON DELETE SET NULL
);

-- KIDS_PARENTS bridge table (depends on Kids and Parents)
CREATE TABLE Kids_Parents (
    parent_id INT,
    kid_id INT,
    relationship_kid VARCHAR(50) NOT NULL,
    is_primary_cont BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (parent_id, kid_id),
    FOREIGN KEY (parent_id) REFERENCES Parents(parent_id) ON DELETE CASCADE,
    FOREIGN KEY (kid_id) REFERENCES Kids(kid_id) ON DELETE CASCADE
);

-- KID_STAFF_ALLOCATIONS table (depends on Kids and Staff)
CREATE TABLE Kid_Staff_Allocations (
    allocation_id SERIAL PRIMARY KEY,
    kid_id INT NOT NULL,
    staff_id INT NOT NULL,
    service_type VARCHAR(100) NOT NULL,
    frequency VARCHAR(50),
    start_date DATE NOT NULL DEFAULT CURRENT_DATE,
    end_date DATE,
    FOREIGN KEY (kid_id) REFERENCES Kids(kid_id) ON DELETE CASCADE,
    FOREIGN KEY (staff_id) REFERENCES Staff(staff_id) ON DELETE CASCADE
);


