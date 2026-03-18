

USE hospital;

DELIMITER $$


CREATE PROCEDURE sp_admit_patient(
    IN  p_patient_id  INT,
    IN  p_doctor_id   INT,
    IN  p_room_id     INT,
    IN  p_reason      VARCHAR(100)
)
BEGIN
    DECLARE room_available VARCHAR(20);

    -- Check room availability
    SELECT status INTO room_available
    FROM Rooms WHERE room_id = p_room_id;

    IF room_available != 'Available' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Room is not available for admission.';
    ELSE
        INSERT INTO Admissions (patient_id, doctor_id, room_id, admission_date, reason, status)
        VALUES (p_patient_id, p_doctor_id, p_room_id, CURRENT_DATE, p_reason, 'Admitted');

        UPDATE Rooms SET status = 'Occupied' WHERE room_id = p_room_id;

        SELECT 'Patient admitted successfully.' AS message,
               LAST_INSERT_ID()                AS admission_id;
    END IF;
END$$


CREATE PROCEDURE sp_discharge_patient(
    IN p_admission_id INT
)
BEGIN
    DECLARE v_room_id INT;
    DECLARE v_status  VARCHAR(20);

    SELECT room_id, status INTO v_room_id, v_status
    FROM Admissions WHERE admission_id = p_admission_id;

    IF v_status = 'Discharged' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Patient is already discharged.';
    ELSE
        UPDATE Admissions
        SET    status         = 'Discharged',
               discharge_date = CURRENT_DATE
        WHERE  admission_id   = p_admission_id;

        UPDATE Rooms
        SET    status = 'Available'
        WHERE  room_id = v_room_id;

        SELECT 'Patient discharged successfully.' AS message;
    END IF;
END$$

-- ------------------------------------------------------------

CREATE PROCEDURE sp_generate_bill(
    IN p_admission_id      INT,
    IN p_room_charges      DECIMAL(10,2),
    IN p_medicine_charges  DECIMAL(10,2),
    IN p_lab_charges       DECIMAL(10,2),
    IN p_doctor_fees       DECIMAL(10,2),
    IN p_payment_mode      VARCHAR(20)
)
BEGIN
    DECLARE v_patient_id INT;

    SELECT patient_id INTO v_patient_id
    FROM Admissions WHERE admission_id = p_admission_id;

    INSERT INTO Bills
        (patient_id, admission_id, bill_date, room_charges,
         medicine_charges, lab_charges, doctor_fees, payment_status, payment_mode)
    VALUES
        (v_patient_id, p_admission_id, CURRENT_DATE, p_room_charges,
         p_medicine_charges, p_lab_charges, p_doctor_fees, 'Unpaid', p_payment_mode);

    SELECT 'Bill generated successfully.' AS message,
           LAST_INSERT_ID()              AS bill_id,
           (p_room_charges + p_medicine_charges + p_lab_charges + p_doctor_fees) AS total_amount;
END$$


CREATE PROCEDURE sp_book_appointment(
    IN p_patient_id       INT,
    IN p_doctor_id        INT,
    IN p_appointment_date DATETIME,
    IN p_diagnosis        VARCHAR(100)
)
BEGIN
    DECLARE conflict_count INT;

    -- Check doctor is not already booked at that exact time
    SELECT COUNT(*) INTO conflict_count
    FROM Appointments
    WHERE doctor_id        = p_doctor_id
      AND appointment_date = p_appointment_date
      AND status          != 'Cancelled';

    IF conflict_count > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Doctor already has an appointment at this time.';
    ELSE
        INSERT INTO Appointments (patient_id, doctor_id, appointment_date, diagnosis, status)
        VALUES (p_patient_id, p_doctor_id, p_appointment_date, p_diagnosis, 'Pending');

        SELECT 'Appointment booked successfully.' AS message,
               LAST_INSERT_ID()                   AS appointment_id;
    END IF;
END$$


CREATE PROCEDURE sp_patient_history(
    IN p_patient_id INT
)
BEGIN
    -- Basic info
    SELECT name, age, gender, blood_group, phone, date_of_registration
    FROM   Patients
    WHERE  patient_id = p_patient_id;

    -- Appointments
    SELECT a.appointment_date, d.name AS doctor, a.diagnosis, a.status
    FROM   Appointments a
    JOIN   Doctors d ON a.doctor_id = d.doctor_id
    WHERE  a.patient_id = p_patient_id
    ORDER  BY a.appointment_date DESC;

    -- Prescriptions
    SELECT pr.medicine_name, pr.dosage, pr.frequency, pr.duration_days
    FROM   Prescriptions pr
    JOIN   Appointments  a  ON pr.appointment_id = a.appointment_id
    WHERE  a.patient_id = p_patient_id;

    -- Admissions
    SELECT ad.admission_date, ad.discharge_date, ad.reason, ad.status,
           r.room_number, r.room_type
    FROM   Admissions ad
    LEFT JOIN Rooms r ON ad.room_id = r.room_id
    WHERE  ad.patient_id = p_patient_id
    ORDER  BY ad.admission_date DESC;

    -- Bills
    SELECT bill_date, total_amount, payment_status, payment_mode
    FROM   Bills
    WHERE  patient_id = p_patient_id
    ORDER  BY bill_date DESC;
END$$

DELIMITER ;
