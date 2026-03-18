

USE hospital;



-- A1. All registered patients
SELECT patient_id, name, age, gender, blood_group, phone, date_of_registration
FROM   Patients
ORDER  BY date_of_registration DESC;

-- A2. Search patient by name
SELECT * FROM Patients
WHERE  name LIKE '%Rahul%';

-- A3. Full history of a specific patient (uses stored procedure)
CALL sp_patient_history(1);

-- A4. Patients by blood group
SELECT name, age, phone, blood_group
FROM   Patients
WHERE  blood_group = 'B+'
ORDER  BY name;



-- B1. All appointments for a doctor on a given date
SELECT p.name AS patient, a.appointment_date, a.diagnosis, a.status
FROM   Appointments a
JOIN   Patients p ON a.patient_id = p.patient_id
WHERE  a.doctor_id = 1
  AND  DATE(a.appointment_date) = '2026-02-21'
ORDER  BY a.appointment_date;

-- B2. All pending appointments
SELECT * FROM vw_appointment_details
WHERE  status = 'Pending'
ORDER  BY appointment_date;

-- B3. Today's full schedule (uses view)
SELECT * FROM vw_todays_schedule;

-- B4. Appointment count per doctor
SELECT d.name AS doctor, d.specialization,
       COUNT(a.appointment_id) AS total_appointments
FROM   Doctors d
LEFT JOIN Appointments a ON d.doctor_id = a.doctor_id
GROUP  BY d.doctor_id, d.name, d.specialization
ORDER  BY total_appointments DESC;



-- C1. All currently admitted patients (uses view)
SELECT * FROM vw_current_admissions;

-- C2. Available rooms (uses view)
SELECT * FROM vw_available_rooms;

-- C3. Room occupancy summary
SELECT room_type,
       COUNT(*)                                  AS total_rooms,
       SUM(status = 'Available')                 AS available,
       SUM(status = 'Occupied')                  AS occupied,
       SUM(status = 'Under Maintenance')         AS under_maintenance
FROM   Rooms
GROUP  BY room_type;

-- C4. Average length of stay per department
SELECT dp.dept_name,
       ROUND(AVG(DATEDIFF(IFNULL(ad.discharge_date, CURRENT_DATE), ad.admission_date)), 1)
           AS avg_days_stay
FROM   Admissions   ad
JOIN   Doctors       d  ON ad.doctor_id = d.doctor_id
JOIN   Departments   dp ON d.dept_id    = dp.dept_id
GROUP  BY dp.dept_name
ORDER  BY avg_days_stay DESC;



-- D1. All unpaid bills (uses view)
SELECT * FROM vw_unpaid_bills;

-- D2. Total revenue collected (paid bills only)
SELECT SUM(total_amount) AS total_revenue_collected
FROM   Bills
WHERE  payment_status = 'Paid';

-- D3. Revenue breakdown by payment mode
SELECT payment_mode,
       COUNT(*)           AS num_transactions,
       SUM(total_amount)  AS total_amount
FROM   Bills
WHERE  payment_status = 'Paid'
GROUP  BY payment_mode
ORDER  BY total_amount DESC;

-- D4. Monthly billing summary
SELECT DATE_FORMAT(bill_date, '%Y-%m') AS month,
       COUNT(*)                        AS bills_generated,
       SUM(total_amount)               AS total_billed,
       SUM(CASE WHEN payment_status = 'Paid' THEN total_amount ELSE 0 END) AS collected
FROM   Bills
GROUP  BY DATE_FORMAT(bill_date, '%Y-%m')
ORDER  BY month DESC;



-- E1. Low stock medicines (uses view)
SELECT * FROM vw_low_stock;

-- E2. Medicines expiring within 3 months
SELECT medicine_name, category, stock_quantity, expiry_date
FROM   Pharmacy
WHERE  expiry_date <= DATE_ADD(CURRENT_DATE, INTERVAL 3 MONTH)
ORDER  BY expiry_date;

-- E3. Pending lab tests
SELECT lt.test_id, p.name AS patient, d.name AS ordered_by,
       lt.test_name, lt.test_date
FROM   Lab_Tests lt
JOIN   Patients  p ON lt.patient_id = p.patient_id
LEFT JOIN Doctors d ON lt.doctor_id  = d.doctor_id
WHERE  lt.status = 'Ordered'
ORDER  BY lt.test_date;


-- F1. All staff with their departments
SELECT s.name, s.role, dp.dept_name, s.phone, s.join_date
FROM   Staff       s
JOIN   Departments dp ON s.dept_id = dp.dept_id
ORDER  BY dp.dept_name, s.role;

-- F2. Headcount per department (doctors + staff)
SELECT dp.dept_name,
       COUNT(DISTINCT d.doctor_id)  AS doctors,
       COUNT(DISTINCT s.staff_id)   AS support_staff
FROM   Departments dp
LEFT JOIN Doctors d ON dp.dept_id = d.dept_id
LEFT JOIN Staff   s ON dp.dept_id = s.dept_id
GROUP  BY dp.dept_name
ORDER  BY (doctors + support_staff) DESC;



-- G1. Recent audit log entries
SELECT log_id, table_name, action, record_id, performed_at
FROM   Audit_Log
ORDER  BY performed_at DESC
LIMIT  50;

-- G2. All INSERT actions today
SELECT * FROM Audit_Log
WHERE  action = 'INSERT'
  AND  DATE(performed_at) = CURRENT_DATE;
