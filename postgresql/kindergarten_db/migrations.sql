-- =================================================================================
-- SECTION 3: SCHEMA SCHEMA EVOLUTION & MODIFICATIONS                              |
-- Description: Tracking structural changes, alterations, and table adaptations.   |
-- Platform:    PostgreSQL                                                         |
-- =================================================================================

-- Level: Basic Editing
-- ==========================
-- Add two new columns to Staff table
ALTER TABLE Staff ADD COLUMN middle_name VARCHAR(50);
ALTER TABLE Staff ADD COLUMN date_of_birth VARCHAR(50);

-- Permanently deletes an entire column from Staff table (date_of_birth)
ALTER TABLE Staff DROP COLUMN date_of_birth;

-- Rename allergies_med to medical_notes on Kids table
ALTER TABLE Kids RENAME COLUMN allergies_med TO medical_notes;

-- Rename Staff table to School_Employees
ALTER TABLE Staff RENAME TO School_Employees;

-- Verification
-- =====================================================================
-- Note: 'Staff' no longer exists, so we verify using 'School_Employees'
SELECT * FROM School_Employees;
SELECT middle_name FROM School_Employees;
SELECT * FROM Kids;
SELECT medical_notes FROM Kids;

-- Level: Intermediate Editing
-- ===========================
-- Change the phone_number data type of Parents table
ALTER TABLE Parents ALTER COLUMN phone_number TYPE VARCHAR(50);

-- Update an automatic default shortcut rule to potty_trained column on Kids table
ALTER TABLE Kids ALTER COLUMN potty_trained SET DEFAULT TRUE;

-- Removes an automatic default shortcut from potty_trained completely
ALTER TABLE Kids ALTER COLUMN potty_trained DROP DEFAULT;

-- Verification
-- ============
-- Verify Parents phone_number length increased to 50 characters
SELECT column_name, data_type, character_maximum_length
FROM information_schema.columns
WHERE table_name = 'parents' AND column_name = 'phone_number';

-- Verify Kids potty_trained column no longer has a default expression
SELECT column_name, column_default
FROM information_schema.columns
WHERE table_name = 'kids' AND column_name = 'potty_trained';

-- Level: Advanced Editing
-- =======================
-- Adds a rule ensuring max capacity can never be a negative number
ALTER TABLE Classrooms ADD CONSTRAINT check_capacity CHECK ( max_capacity > 0);

-- Wipes out a structural constraint or foreign key link by using its unique constraint name
ALTER TABLE Classrooms DROP CONSTRAINT classrooms_lead_teach_id_fkey;

-- Safely converts a simple text column into a true, True/False Boolean column
ALTER TABLE Kids ALTER COLUMN potty_trained TYPE BOOLEAN USING (potty_trained::BOOLEAN);

-- Verification
-- ============
-- Verify that 'check_capacity' exists and see what type of constraint it is
SELECT constraint_name, constraint_type
FROM information_schema.table_constraints
WHERE table_name = 'classrooms';

-- Verify that 'check_capacity' exists and see what type of constraint it is
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'kids' AND column_name = 'potty_trained';
