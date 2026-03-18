-- ============================================================
--  Hospital Management Database System
--  File        : 02_sample_data.sql
--  Description : Realistic sample data for all tables
--  Run after   : 01_schema.sql
--  Command     : mysql -u root -p hospital < 02_sample_data.sql
-- ============================================================

USE hospital;

-- ------------------------------------------------------------
-- DEPARTMENTS
-- ------------------------------------------------------------
INSERT INTO Departments (dept_name, hod_name, location, phone) VALUES
    ('Administration',  'Mr. Alan Mathews',   'Block A, Ground Floor', '040-11110001'),
    ('Surgery',         'Dr. Smith Rajan',    'Block B, 2nd Floor',    '040-11110002'),
    ('Cardiology',      'Dr. Mohit Verma',    'Block C, 1st Floor',    '040-11110003'),
    ('Pediatrics',      'Dr. Ritesh Pandey',  'Block A, 1st Floor',    '040-11110004'),
    ('Radiology',       'Dr. Sara Iyer',      'Block D, Ground Floor', '040-11110005'),
    ('Pharmacy',        'Mr. Aryan Mehta',    'Block A, Ground Floor', '040-11110006'),
    ('ENT',             'Dr. Meena Pillai',   'Block B, 1st Floor',    '040-11110007'),
    ('Nursing',         'Ms. Vartika Singh',  'Block C, Ground Floor', '040-11110008'),
    ('Emergency',       'Dr. Kavya Nair',     'Block E, Ground Floor', '040-11110009'),
    ('Gynecology',      'Dr. Priya Sharma',   'Block B, 3rd Floor',    '040-11110010');

-- ------------------------------------------------------------
-- DOCTORS
-- ------------------------------------------------------------
INSERT INTO Doctors (name, specialization, dept_id, phone, email, experience_years, status) VALUES
    ('Dr. Taarak Mehta',     'Cardiologist',       3,  '9876543210', 'taarak@hospital.com',   12, 'Active'),
    ('Dr. Priya Gupta',      'Orthopedic',         2,  '9876541111', 'priya.g@hospital.com',   8, 'Active'),
    ('Dr. Rohan Nair',       'Pediatrician',       4,  '9123456780', 'rohan.n@hospital.com',   5, 'Active'),
    ('Dr. Anjali Sharma',    'Surgeon',            2,  '9988776655', 'anjali.s@hospital.com',  10, 'Active'),
    ('Dr. Sara Khan',        'Radiologist',        5,  '9876512345', 'sara.k@hospital.com',     7, 'Active'),
    ('Dr. Meera Nair',       'Pediatrician',       4,  '9555443322', 'meera.n@hospital.com',   6, 'Active'),
    ('Dr. Arjun Kapoor',     'General Surgeon',    2,  '9444332211', 'arjun.k@hospital.com',  14, 'Active'),
    ('Dr. Sunita Deshmukh',  'Radiologist',        5,  '9333221100', 'sunita.d@hospital.com',  9, 'Active'),
    ('Dr. Vikram Seth',      'Emergency Medicine', 9,  '9222110099', 'vikram.s@hospital.com',  11, 'Active'),
    ('Dr. Pooja Bose',       'Gynecologist',       10, '9111009988', 'pooja.b@hospital.com',  13, 'Active'),
    ('Dr. Suresh Menon',     'Neurologist',        3,  '9000998877', 'suresh.m@hospital.com', 18, 'Active'),
    ('Dr. Deepa Joshi',      'Dermatologist',      10, '8999887766', 'deepa.j@hospital.com',   4, 'Active'),
    ('Dr. Sandeep Varma',    'Anesthesiologist',   2,  '8888776655', 'sandeep.v@hospital.com', 16, 'Active');

-- ------------------------------------------------------------
-- PATIENTS
-- ------------------------------------------------------------
INSERT INTO Patients (name, age, gender, phone, email, address, blood_group, date_of_registration, emergency_contact) VALUES
    ('Rahul Sharma',    22, 'Male',   '9876543210', 'rahul.s@email.com',   'Tirupati, AP',     'B+',  '2026-01-15', '9876543200'),
    ('Anjali Reddy',    19, 'Female', '9123456780', 'anjali.r@email.com',  'Chittoor, AP',     'O+',  '2026-02-02', '9123456700'),
    ('Vikram Singh',    35, 'Male',   '9988776655', 'vikram.si@email.com', 'Bengaluru, KA',    'A+',  '2026-01-20', '9988776600'),
    ('Sita Patel',      28, 'Female', '9876512345', 'sita.p@email.com',    'Hyderabad, TS',    'AB+', '2026-02-10', '9876512300'),
    ('Aryan Kumar',     40, 'Male',   '9123409876', 'aryan.k@email.com',   'Chennai, TN',      'O-',  '2026-02-12', '9123409800'),
    ('Saanvi Mishra',   45, 'Female', '9845012345', 'saanvi.m@email.com',  'Pune, MH',         'B-',  '2026-02-14', '9845012300'),
    ('Aryan Chopra',     5, 'Male',   '9632145870', 'parent@email.com',    'Ahmedabad, GJ',    'A-',  '2026-02-15', '9632145800'),
    ('Diya Verma',      51, 'Female', '9512348760', 'diya.v@email.com',    'Kolkata, WB',      'O+',  '2026-02-16', '9512348700'),
    ('Advait Kulkarni', 39, 'Male',   '9420123456', 'advait.k@email.com',  'Nagpur, MH',       'B+',  '2026-02-17', '9420123400'),
    ('Myra Saxena',     29, 'Female', '9301234567', 'myra.s@email.com',    'Lucknow, UP',      'A+',  '2026-02-18', '9301234500');

-- ------------------------------------------------------------
-- STAFF
-- ------------------------------------------------------------
INSERT INTO Staff (name, role, dept_id, phone, salary, join_date) VALUES
    ('Sunil Kumar',   'Nurse',          8,  '9811223344', 32000.00, '2023-06-01'),
    ('Rekha Singh',   'Receptionist',   1,  '9822334455', 28000.00, '2022-03-15'),
    ('Manish Paul',   'Lab Technician', 7,  '9833445566', 35000.00, '2021-09-10'),
    ('Divya Rao',     'Nurse',          4,  '9844556677', 32000.00, '2023-01-20'),
    ('Ramesh Tiwari', 'Pharmacist',     6,  '9855667788', 40000.00, '2020-07-05'),
    ('Leela Nair',    'Nurse',          3,  '9866778899', 32000.00, '2024-02-01');

-- ------------------------------------------------------------
-- ROOMS
-- ------------------------------------------------------------
INSERT INTO Rooms (room_number, room_type, ward, dept_id, price_per_day, status) VALUES
    ('101', 'General',  'General Ward',   8,  800.00,  'Occupied'),
    ('102', 'General',  'General Ward',   8,  800.00,  'Available'),
    ('201', 'Private',  'Surgical Ward',  2,  3000.00, 'Occupied'),
    ('202', 'Private',  'Surgical Ward',  2,  3000.00, 'Available'),
    ('301', 'ICU',      'ICU',            9,  8000.00, 'Occupied'),
    ('302', 'ICU',      'ICU',            9,  8000.00, 'Available'),
    ('401', 'General',  'Pediatric Ward', 4,  1000.00, 'Available'),
    ('501', 'Private',  'Cardiology',     3,  4000.00, 'Occupied');

-- ------------------------------------------------------------
-- APPOINTMENTS
-- ------------------------------------------------------------
INSERT INTO Appointments (patient_id, doctor_id, appointment_date, diagnosis, notes, status) VALUES
    (1,  1,  '2026-02-21 10:00:00', 'Chest Pain',        'Patient reports tightness since 2 days', 'Completed'),
    (2,  3,  '2026-02-21 11:00:00', 'Fever',             'High grade fever, 103F',                 'Completed'),
    (3,  4,  '2026-02-22 09:30:00', 'Knee Pain',         'Possible ligament tear, MRI advised',    'Completed'),
    (4,  2,  '2026-02-22 14:00:00', 'Fracture',          'Right wrist fracture confirmed on X-ray', 'Completed'),
    (5,  5,  '2026-02-23 13:00:00', 'Chest X-ray',       'Routine screening',                      'Completed'),
    (6,  11, '2026-02-24 10:30:00', 'Migraine',          'Recurring headaches, MRI recommended',   'Completed'),
    (7,  3,  '2026-02-24 11:00:00', 'Viral Infection',   'Common cold with fever',                 'Completed'),
    (8,  10, '2026-02-25 09:00:00', 'Routine Checkup',   'Annual gynecology checkup',              'Completed'),
    (9,  1,  '2026-02-25 15:00:00', 'Hypertension',      'BP 160/100, medication adjusted',        'Completed'),
    (10, 4,  '2026-03-01 10:00:00', 'Back Pain',         'Lower back pain, physiotherapy advised', 'Pending');

-- ------------------------------------------------------------
-- ADMISSIONS
-- ------------------------------------------------------------
INSERT INTO Admissions (patient_id, doctor_id, room_id, admission_date, discharge_date, reason, status) VALUES
    (1, 1,  8, '2026-02-21', '2026-02-25', 'Cardiac observation',      'Discharged'),
    (3, 4,  3, '2026-02-22', '2026-02-28', 'Post-surgery recovery',    'Discharged'),
    (5, 9,  5, '2026-02-23', NULL,         'Emergency — chest pain',   'Admitted'),
    (6, 11, 1, '2026-02-24', '2026-02-27', 'Neurological observation', 'Discharged'),
    (9, 1,  8, '2026-02-25', NULL,         'Hypertension management',  'Admitted');

-- ------------------------------------------------------------
-- BILLS
-- ------------------------------------------------------------
INSERT INTO Bills (patient_id, admission_id, bill_date, room_charges, medicine_charges, lab_charges, doctor_fees, payment_status, payment_mode) VALUES
    (1, 1, '2026-02-25', 3200.00, 850.00,  500.00, 1000.00, 'Paid',   'Card'),
    (3, 2, '2026-02-28', 3600.00, 1200.00, 700.00, 1500.00, 'Paid',   'UPI'),
    (6, 4, '2026-02-27', 2400.00, 600.00,  800.00, 1000.00, 'Unpaid', 'Cash'),
    (2, NULL, '2026-02-21', 0.00, 250.00,   0.00,   500.00, 'Paid',   'Cash'),
    (4, NULL, '2026-02-22', 0.00, 400.00, 700.00,   800.00, 'Unpaid', 'UPI');

-- ------------------------------------------------------------
-- PRESCRIPTIONS
-- ------------------------------------------------------------
INSERT INTO Prescriptions (appointment_id, medicine_name, dosage, frequency, duration_days, notes) VALUES
    (1, 'Aspirin',       '75mg',    'Once daily',   30, 'Take after food'),
    (1, 'Atorvastatin',  '10mg',    'Once at night', 30, 'Lipid management'),
    (2, 'Paracetamol',   '500mg',   'Thrice daily',   5, 'For fever'),
    (2, 'Amoxicillin',   '250mg',   'Twice daily',    7, 'Complete the course'),
    (3, 'Ibuprofen',     '400mg',   'Twice daily',    5, 'With meals'),
    (4, 'Cefixime',      '200mg',   'Twice daily',   10, 'Post fracture antibiotic'),
    (5, 'Vitamin D',     '1000 IU', 'Once daily',    30, 'Supplement'),
    (6, 'Sumatriptan',   '50mg',    'As needed',      0, 'Only during migraine attack'),
    (7, 'Cetirizine',    '10mg',    'Once at night',  5, 'For cold symptoms'),
    (9, 'Amlodipine',    '5mg',     'Once daily',    30, 'BP medication, monitor weekly');

-- ------------------------------------------------------------
-- LAB_TESTS
-- ------------------------------------------------------------
INSERT INTO Lab_Tests (patient_id, doctor_id, test_name, test_date, result, normal_range, status) VALUES
    (1, 1,  'ECG',              '2026-02-21', 'Mild ST depression noted',  'Normal sinus rhythm', 'Completed'),
    (1, 1,  'Lipid Profile',    '2026-02-21', 'LDL: 145 mg/dL',           'LDL < 100 mg/dL',     'Completed'),
    (2, 3,  'CBC',              '2026-02-21', 'WBC: 11,000 cells/mcL',    '4000-11000 cells/mcL','Completed'),
    (3, 5,  'X-Ray Knee',       '2026-02-22', 'No fracture, soft tissue swelling', 'Normal',      'Completed'),
    (4, 5,  'X-Ray Wrist',      '2026-02-22', 'Colles fracture confirmed', 'Normal',              'Completed'),
    (5, 5,  'Chest X-Ray',      '2026-02-23', 'Clear lung fields',        'Normal',              'Completed'),
    (6, 11, 'MRI Brain',        '2026-02-24', 'No structural abnormality','Normal',              'Completed'),
    (9, 1,  'Blood Pressure',   '2026-02-25', '160/100 mmHg',             '120/80 mmHg',         'Completed'),
    (10, 4, 'X-Ray Lumbar',     '2026-03-01', NULL,                       'Normal',              'Ordered');

-- ------------------------------------------------------------
-- PHARMACY
-- ------------------------------------------------------------
INSERT INTO Pharmacy (medicine_name, category, manufacturer, stock_quantity, price_per_unit, expiry_date, reorder_level) VALUES
    ('Paracetamol 500mg',   'Analgesic',      'Sun Pharma',       500, 2.50,  '2027-12-31', 50),
    ('Amoxicillin 250mg',   'Antibiotic',     'Cipla',            300, 8.00,  '2027-06-30', 30),
    ('Ibuprofen 400mg',     'Anti-inflammatory','Dr. Reddys',     400, 4.50,  '2027-09-30', 40),
    ('Aspirin 75mg',        'Antiplatelet',   'Bayer',            600, 1.80,  '2028-03-31', 60),
    ('Atorvastatin 10mg',   'Statin',         'Pfizer',           250, 12.00, '2027-08-31', 25),
    ('Amlodipine 5mg',      'Antihypertensive','Lupin',           350, 6.50,  '2028-01-31', 35),
    ('Cetirizine 10mg',     'Antihistamine',  'Mankind Pharma',   450, 3.00,  '2027-11-30', 45),
    ('Vitamin D 1000IU',    'Supplement',     'Abbott',           200, 15.00, '2028-06-30', 20),
    ('Sumatriptan 50mg',    'Antimigraine',   'GSK',              100, 45.00, '2027-05-31', 10),
    ('Cefixime 200mg',      'Antibiotic',     'Alkem',            280, 18.00, '2027-10-31', 30);
