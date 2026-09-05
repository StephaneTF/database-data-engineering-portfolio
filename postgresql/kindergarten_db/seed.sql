-- ==========================================================================================
-- KINDERGARTEN DATABASE MOCK DATA (SEED SCRIPT)                                            |
-- Description: Test datasets to populate teachers, classrooms, families, and allocations.  |
-- Platform:    PostgreSQL                                                                  |
-- ==========================================================================================

-- SEED STAFF (Teachers, Admin, and Specialists)
INSERT INTO Staff (first_name, last_name, role_type, job_title, email, phone_number, cert_expiry)
VALUES ('Sarah', 'Jenkins', 'Instructional', 'Lead Teacher', 's.jenkins@kinder.com', '555-0101', '2028-06-01'),
       ('Michael', 'Alvarez', 'Instructional', 'Co-Teacher', 'm.alvarez@kinder.com', '555-0102', '2027-12-15'),
       ('Emily', 'Taylor', 'Instructional', 'Lead Teacher', 'e.taylor@kinder.com', '555-0103', '2028-09-20'),
       ('David', 'Kim', 'Support', 'Speech-Language Pathologist', 'd.kim@kinder.com', '555-0104', '2027-04-11'),
       ('Jessica', 'Blair', 'Support', 'Paraeducator / 1:1 Aide', 'j.blair@kinder.com', '555-0105', '2029-01-10');

-- SEED CLASSROOMS (Uses staff_id 1, 2, and 3 from above)
INSERT INTO Classrooms (room_name, room_number, age_group, max_capacity, lead_teach_id, co_teach_id)
VALUES ('The Sunshine Room', '101', 'Pre-K', 15, 1, 2),
       ('The Rainbow Room', '102', 'Junior K', 18, 3, NULL);

-- SEED KIDS (Assigned to classrooms 1 and 2)
INSERT INTO kids (first_name, last_name, date_of_birth, gender, allergies_med, potty_trained, classroom_id)
VALUES ('Liam', 'Smith', '2022-03-14', 'Male', 'Peanut Allergy', TRUE, 1),
       ('Emma', 'Smith', '2023-07-22', 'Female', NULL, FALSE, 1), -- Sibling to Liam
       ('Noah', 'Davis', '2021-11-05', 'Male', 'Asthma - Inhaler in office', TRUE, 2);

-- SEED PARENTS
INSERT INTO parents (first_name, last_name, phone_number, email, home_address, emergency_prio)
VALUES ('John', 'Smith', '555-1234', 'j.smith@email.com', '123 Maple St', 1),
       ('Mary', 'Smith', '555-5678', 'm.smith@email.com', '123 Maple St', 2),
       ('Robert', 'Davis', '555-9876', 'r.davis@email.com', '789 Oak Ave', 1);

-- SEED KIDS_PARENTS BRIDGE (Links parents and kids together)
INSERT INTO kids_parents (parent_id, kid_id, relationship_kid, is_primary_cont)
VALUES (1, 1, 'Father', TRUE),   -- John is Liam's Dad
       (2, 1, 'Mother', FALSE),  -- Mary is Liam's Mom
       (1, 2, 'Father', TRUE),   -- John is Emma's Dad (Sibling logic)
       (2, 2, 'Mother', FALSE),  -- Mary is Emma's Mom
       (3, 3, 'Father', TRUE);   -- Robert is Noah's Dad

-- SEED KID_STAFF_ALLOCATIONS (Specialist and Support mappings)
INSERT INTO kid_staff_allocations (kid_id, staff_id, service_type, frequency, end_date)
VALUES (2, 5, '1:1 Aide Support', 'Daily', NULL),                        -- Emma gets a daily 1:1 aide
       (3, 4, 'Speech Therapy', '2x per Week', '2027-06-18');             -- Noah sees the Speech Therapist
