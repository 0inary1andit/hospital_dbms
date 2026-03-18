

DROP DATABASE IF EXISTS hospital;
CREATE DATABASE hospital
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE hospital;


CREATE TABLE Departments (
    dept_id     INT           PRIMARY KEY AUTO_INCREMENT,
    dept_name   VARCHAR(50)   NOT NULL,
    hod_name    VARCHAR(50),
    location    VARCHAR(50),
    phone       VARCHAR(15)
);


CREATE TABLE Doctors (
    doctor_id        INT          PRIMARY KEY AUTO_INCREMENT,
    name             VARCHAR(50)  NOT NULL,
    specialization   VARCHAR(50),
    dept_id          INT,
    phone            VARCHAR(15),
    email            VARCHAR(50),
    experience_years INT          DEFAULT 0,
    status           ENUM('Active', 'Inactive') DEFAULT 'Active',
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
        ON DELETE SET NULL ON UPDATE CASCADE
);


CREATE TABLE Patients (
    patient_id           INT          PRIMARY KEY AUTO_INCREMENT,
    name                 VARCHAR(50)  NOT NULL,
    age                  INT,
    gender               ENUM('Male', 'Female', 'Other'),
    phone                VARCHAR(15),
    email                VARCHAR(50),
    address              VARCHAR(100),
    blood_group          VARCHAR(5),
    date_of_registration DATE         DEFAULT (CURRENT_DATE),
    emergency_contact    VARCHAR(15)
);


CREATE TABLE Staff (
    staff_id  INT          PRIMARY KEY AUTO_INCREMENT,
    name      VARCHAR(50)  NOT NULL,
    role      VARCHAR(30),
    dept_id   INT,
    phone     VARCHAR(15),
    salary    DECIMAL(10,2),
    join_date DATE,
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
        ON DELETE SET NULL ON UPDATE CASCADE
);


CREATE TABLE Rooms (
    room_id       INT          PRIMARY KEY AUTO_INCREMENT,
    room_number   VARCHAR(10)  NOT NULL UNIQUE,
    room_type     VARCHAR(20),                          -- General / ICU / Private
    ward          VARCHAR(30),
    dept_id       INT,
    price_per_day DECIMAL(10,2) DEFAULT 0.00,
    status        ENUM('Available', 'Occupied', 'Under Maintenance') DEFAULT 'Available',
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
        ON DELETE SET NULL ON UPDATE CASCADE
);


CREATE TABLE Appointments (
    appointment_id   INT           PRIMARY KEY AUTO_INCREMENT,
    patient_id       INT           NOT NULL,
    doctor_id        INT           NOT NULL,
    appointment_date DATETIME      NOT NULL,
    diagnosis        VARCHAR(100),
    notes            TEXT,
    status           ENUM('Pending', 'Completed', 'Cancelled') DEFAULT 'Pending',
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (doctor_id)  REFERENCES Doctors(doctor_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
);


CREATE TABLE Admissions (
    admission_id    INT  PRIMARY KEY AUTO_INCREMENT,
    patient_id      INT  NOT NULL,
    doctor_id       INT,
    room_id         INT,
    admission_date  DATE NOT NULL DEFAULT (CURRENT_DATE),
    discharge_date  DATE,
    reason          VARCHAR(100),
    status          ENUM('Admitted', 'Discharged') DEFAULT 'Admitted',
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
        ON DELETE CASCADE  ON UPDATE CASCADE,
    FOREIGN KEY (doctor_id)  REFERENCES Doctors(doctor_id)
        ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (room_id)    REFERENCES Rooms(room_id)
        ON DELETE SET NULL ON UPDATE CASCADE
);


CREATE TABLE Bills (
    bill_id           INT            PRIMARY KEY AUTO_INCREMENT,
    patient_id        INT            NOT NULL,
    admission_id      INT,
    bill_date         DATE           DEFAULT (CURRENT_DATE),
    room_charges      DECIMAL(10,2)  DEFAULT 0.00,
    medicine_charges  DECIMAL(10,2)  DEFAULT 0.00,
    lab_charges       DECIMAL(10,2)  DEFAULT 0.00,
    doctor_fees       DECIMAL(10,2)  DEFAULT 0.00,
    total_amount      DECIMAL(10,2)  GENERATED ALWAYS AS
                        (room_charges + medicine_charges + lab_charges + doctor_fees) STORED,
    payment_status    ENUM('Paid', 'Unpaid', 'Partial') DEFAULT 'Unpaid',
    payment_mode      ENUM('Cash', 'Card', 'UPI', 'Insurance') DEFAULT 'Cash',
    FOREIGN KEY (patient_id)   REFERENCES Patients(patient_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (admission_id) REFERENCES Admissions(admission_id)
        ON DELETE SET NULL ON UPDATE CASCADE
);


CREATE TABLE Prescriptions (
    prescription_id  INT          PRIMARY KEY AUTO_INCREMENT,
    appointment_id   INT          NOT NULL,
    medicine_name    VARCHAR(50)  NOT NULL,
    dosage           VARCHAR(20),
    frequency        VARCHAR(30),                       -- e.g. "Twice daily"
    duration_days    INT,
    notes            TEXT,
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Lab_Tests (
    test_id       INT          PRIMARY KEY AUTO_INCREMENT,
    patient_id    INT          NOT NULL,
    doctor_id     INT,
    test_name     VARCHAR(50)  NOT NULL,
    test_date     DATE         DEFAULT (CURRENT_DATE),
    result        TEXT,
    normal_range  VARCHAR(50),
    status        ENUM('Ordered', 'In Progress', 'Completed') DEFAULT 'Ordered',
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
        ON DELETE CASCADE  ON UPDATE CASCADE,
    FOREIGN KEY (doctor_id)  REFERENCES Doctors(doctor_id)
        ON DELETE SET NULL ON UPDATE CASCADE
);


CREATE TABLE Pharmacy (
    medicine_id     INT           PRIMARY KEY AUTO_INCREMENT,
    medicine_name   VARCHAR(50)   NOT NULL,
    category        VARCHAR(30),
    manufacturer    VARCHAR(50),
    stock_quantity  INT           DEFAULT 0,
    price_per_unit  DECIMAL(10,2) DEFAULT 0.00,
    expiry_date     DATE,
    reorder_level   INT           DEFAULT 10
);


CREATE TABLE Audit_Log (
    log_id        INT          PRIMARY KEY AUTO_INCREMENT,
    table_name    VARCHAR(30)  NOT NULL,
    action        ENUM('INSERT', 'UPDATE', 'DELETE') NOT NULL,
    record_id     INT,
    performed_by  INT,                                 -- staff_id (nullable)
    performed_at  DATETIME     DEFAULT CURRENT_TIMESTAMP,
    old_value     TEXT,
    new_value     TEXT,
    FOREIGN KEY (performed_by) REFERENCES Staff(staff_id)
        ON DELETE SET NULL ON UPDATE CASCADE
);
