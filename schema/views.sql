
--  Description : Useful saved queries as reusable views


USE hospital;

-- ------------------------------------------------------------
-- 1. Patient appointment history (full details)
-- ------------------------------------------------------------
CREATE OR REPLACE VIEW vw_appointment_details AS
SELECT
    a.appointment_id,
    p.name                AS patient_name,
    p.phone               AS patient_phone,
    d.name                AS doctor_name,
    d.specialization,
    dp.dept_name,
    a.appointment_date,
    a.diagnosis,
    a.status
FROM Appointments a
JOIN Patients    p  ON a.patient_id = p.patient_id
JOIN Doctors     d  ON a.doctor_id  = d.doctor_id
JOIN Departments dp ON d.dept_id    = dp.dept_id;

-- ------------------------------------------------------------
-- 2. Unpaid bills with patient contact info
-- ------------------------------------------------------------
CREATE OR REPLACE VIEW vw_unpaid_bills AS
SELECT
    b.bill_id,
    p.name            AS patient_name,
    p.phone           AS patient_phone,
    b.bill_date,
    b.room_charges,
    b.medicine_charges,
    b.lab_charges,
    b.doctor_fees,
    b.total_amount,
    b.payment_mode
FROM Bills    b
JOIN Patients p ON b.patient_id = p.patient_id
WHERE b.payment_status IN ('Unpaid', 'Partial');

-- ------------------------------------------------------------
-- 3. Currently admitted patients
-- ------------------------------------------------------------
CREATE OR REPLACE VIEW vw_current_admissions AS
SELECT
    ad.admission_id,
    p.name            AS patient_name,
    p.blood_group,
    d.name            AS doctor_name,
    r.room_number,
    r.room_type,
    r.ward,
    ad.admission_date,
    ad.reason,
    DATEDIFF(CURRENT_DATE, ad.admission_date) AS days_admitted
FROM Admissions ad
JOIN Patients    p ON ad.patient_id = p.patient_id
JOIN Doctors     d ON ad.doctor_id  = d.doctor_id
JOIN Rooms       r ON ad.room_id    = r.room_id
WHERE ad.status = 'Admitted';

-- ------------------------------------------------------------
-- 4. Available rooms
-- ------------------------------------------------------------
CREATE OR REPLACE VIEW vw_available_rooms AS
SELECT
    r.room_id,
    r.room_number,
    r.room_type,
    r.ward,
    dp.dept_name,
    r.price_per_day
FROM Rooms       r
JOIN Departments dp ON r.dept_id = dp.dept_id
WHERE r.status = 'Available';

-- ------------------------------------------------------------
-- 5. Doctor schedule (today's appointments)
-- ------------------------------------------------------------
CREATE OR REPLACE VIEW vw_todays_schedule AS
SELECT
    d.name            AS doctor_name,
    d.specialization,
    p.name            AS patient_name,
    p.phone           AS patient_phone,
    a.appointment_date,
    a.diagnosis,
    a.status
FROM Appointments a
JOIN Doctors  d ON a.doctor_id  = d.doctor_id
JOIN Patients p ON a.patient_id = p.patient_id
WHERE DATE(a.appointment_date) = CURRENT_DATE
ORDER BY a.appointment_date;

-- ------------------------------------------------------------
-- 6. Low stock medicines (at or below reorder level)
-- ------------------------------------------------------------
CREATE OR REPLACE VIEW vw_low_stock AS
SELECT
    medicine_id,
    medicine_name,
    category,
    stock_quantity,
    reorder_level,
    expiry_date
FROM Pharmacy
WHERE stock_quantity <= reorder_level
ORDER BY stock_quantity ASC;

-- ------------------------------------------------------------
-- 7. Full patient profile (latest appointment + admission)
-- ------------------------------------------------------------
CREATE OR REPLACE VIEW vw_patient_summary AS
SELECT
    p.patient_id,
    p.name,
    p.age,
    p.gender,
    p.blood_group,
    p.phone,
    COUNT(DISTINCT a.appointment_id) AS total_appointments,
    COUNT(DISTINCT ad.admission_id)  AS total_admissions,
    MAX(a.appointment_date)          AS last_visit
FROM Patients    p
LEFT JOIN Appointments a  ON p.patient_id = a.patient_id
LEFT JOIN Admissions   ad ON p.patient_id = ad.patient_id
GROUP BY p.patient_id, p.name, p.age, p.gender, p.blood_group, p.phone;
