-- ============================================================
--  Hospital Management Database System
--  File        : 05_triggers.sql
--  Description : Triggers for automation and audit logging
--  Run after   : 04_procedures.sql
-- ============================================================

USE hospital;

DELIMITER $$

-- ------------------------------------------------------------
-- 1. Auto-update Room status when Admission is inserted
-- ------------------------------------------------------------
CREATE TRIGGER trg_room_on_admit
AFTER INSERT ON Admissions
FOR EACH ROW
BEGIN
    IF NEW.room_id IS NOT NULL THEN
        UPDATE Rooms SET status = 'Occupied'
        WHERE room_id = NEW.room_id;
    END IF;
END$$

-- ------------------------------------------------------------
-- 2. Free up Room when patient is discharged
-- ------------------------------------------------------------
CREATE TRIGGER trg_room_on_discharge
AFTER UPDATE ON Admissions
FOR EACH ROW
BEGIN
    IF NEW.status = 'Discharged' AND OLD.status = 'Admitted' THEN
        UPDATE Rooms SET status = 'Available'
        WHERE room_id = NEW.room_id;
    END IF;
END$$

-- ------------------------------------------------------------
-- 3. Audit log — track every new patient registration
-- ------------------------------------------------------------
CREATE TRIGGER trg_audit_patient_insert
AFTER INSERT ON Patients
FOR EACH ROW
BEGIN
    INSERT INTO Audit_Log (table_name, action, record_id, new_value, performed_at)
    VALUES (
        'Patients',
        'INSERT',
        NEW.patient_id,
        CONCAT('name=', NEW.name, ', phone=', NEW.phone, ', blood_group=', NEW.blood_group),
        NOW()
    );
END$$

-- ------------------------------------------------------------
-- 4. Audit log — track patient record updates
-- ------------------------------------------------------------
CREATE TRIGGER trg_audit_patient_update
AFTER UPDATE ON Patients
FOR EACH ROW
BEGIN
    INSERT INTO Audit_Log (table_name, action, record_id, old_value, new_value, performed_at)
    VALUES (
        'Patients',
        'UPDATE',
        NEW.patient_id,
        CONCAT('name=', OLD.name, ', phone=', OLD.phone),
        CONCAT('name=', NEW.name, ', phone=', NEW.phone),
        NOW()
    );
END$$

-- ------------------------------------------------------------
-- 5. Audit log — track every new appointment
-- ------------------------------------------------------------
CREATE TRIGGER trg_audit_appointment_insert
AFTER INSERT ON Appointments
FOR EACH ROW
BEGIN
    INSERT INTO Audit_Log (table_name, action, record_id, new_value, performed_at)
    VALUES (
        'Appointments',
        'INSERT',
        NEW.appointment_id,
        CONCAT('patient_id=', NEW.patient_id, ', doctor_id=', NEW.doctor_id,
               ', date=', NEW.appointment_date),
        NOW()
    );
END$$

-- ------------------------------------------------------------
-- 6. Prevent deleting a doctor who has active admissions
-- ------------------------------------------------------------
CREATE TRIGGER trg_protect_doctor_delete
BEFORE DELETE ON Doctors
FOR EACH ROW
BEGIN
    DECLARE active_count INT;
    SELECT COUNT(*) INTO active_count
    FROM Admissions
    WHERE doctor_id = OLD.doctor_id AND status = 'Admitted';

    IF active_count > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Cannot delete doctor with active patient admissions.';
    END IF;
END$$

-- ------------------------------------------------------------
-- 7. Prevent double-booking a room
-- ------------------------------------------------------------
CREATE TRIGGER trg_prevent_room_double_book
BEFORE INSERT ON Admissions
FOR EACH ROW
BEGIN
    DECLARE room_status VARCHAR(20);
    IF NEW.room_id IS NOT NULL THEN
        SELECT status INTO room_status FROM Rooms WHERE room_id = NEW.room_id;
        IF room_status = 'Occupied' THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'This room is already occupied.';
        END IF;
    END IF;
END$$

DELIMITER ;
