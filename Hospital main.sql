CREATE database hospital;
USE hospital;
CREATE TABLE Departments(dept_id INT PRIMARY KEY, dept_name VARCHAR(20),HOD VARCHAR(30));
INSERT INTO departments values(001,'Administration', 'Mr.Alan');
INSERT INTO departments values(002,'surgery','Mr.Smith');
INSERT INTO departments values(003,'cardiology','Mr.Mohit');
INSERT INTO departments values(004,'pediatrics','Mr.Ritesh');
INSERT INTO departments values(005,'Radiology','Ms.Sara');
INSERT INTO departments values(006,'Pharmacy','Mr.Aryan');
INSERT INTO departments values(007,'ENT','Ms.Meena');
INSERT INTO departments values(008,'Nursing','Ms.Vartika');

CREATE TABLE Doctors(
    doctor_id INT PRIMARY KEY,
    name VARCHAR(30),
    specialization VARCHAR(30),
    dept_id INT,
    phone VARCHAR(15),
    experience_years INT,
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);

INSERT INTO Doctors VALUES (101, 'Dr. Mehta', 'Cardiologist', 3, '9876543210', 12);
INSERT INTO Doctors VALUES (102, 'Dr. Priya', 'Orthopedic', 2, '9876541111', 8);
INSERT INTO Doctors VALUES (103, 'Dr. Rohan', 'Pediatrician', 4, '9123456780', 5);
INSERT INTO Doctors VALUES (104, 'Dr. Anjali', 'Surgeon', 2, '9988776655', 10);
INSERT INTO Doctors VALUES (105, 'Dr. Sara', 'Radiologist', 5, '9876512345', 7);

CREATE TABLE Patients(
    patient_id INT PRIMARY KEY,
    name VARCHAR(30),
    age INT,
    gender VARCHAR(10),
    phone VARCHAR(15),
    address VARCHAR(50),
    blood_group VARCHAR(5),
    date_of_registration DATE
);

INSERT INTO Patients VALUES (201, 'Rahul Sharma', 22, 'Male', '9876543210', 'Tirupati', 'B+', '2026-01-15');
INSERT INTO Patients VALUES (202, 'Anjali Reddy', 19, 'Female', '9123456780', 'Chittoor', 'O+', '2026-02-02');
INSERT INTO Patients VALUES (203, 'Vikram Singh', 35, 'Male', '9988776655', 'Bengaluru', 'A+', '2026-01-20');
INSERT INTO Patients VALUES (204, 'Sita Patel', 28, 'Female', '9876512345', 'Hyderabad', 'AB+', '2026-02-10');
INSERT INTO Patients VALUES (205, 'Aryan Kumar', 40, 'Male', '9123409876', 'Chennai', 'O-', '2026-02-12');

CREATE TABLE Appointments(
    appointment_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATETIME,
    diagnosis VARCHAR(50),
    status VARCHAR(15),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

INSERT INTO Appointments VALUES (301, 201, 101, '2026-02-21 10:00:00', 'Chest Pain', 'Pending');
INSERT INTO Appointments VALUES (302, 202, 103, '2026-02-21 11:00:00', 'Fever', 'Completed');
INSERT INTO Appointments VALUES (303, 203, 104, '2026-02-22 09:30:00', 'Knee Pain', 'Pending');
INSERT INTO Appointments VALUES (304, 204, 102, '2026-02-22 14:00:00', 'Fracture', 'Completed');
INSERT INTO Appointments VALUES (305, 205, 105, '2026-02-23 13:00:00', 'X-ray', 'Pending');

CREATE TABLE Bills(
    bill_id INT PRIMARY KEY,
    patient_id INT,
    total_amount DECIMAL(10,2),
    payment_status VARCHAR(10),
    payment_mode VARCHAR(10),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);

INSERT INTO Bills VALUES (401, 201, 5000.00, 'Paid', 'Cash');
INSERT INTO Bills VALUES (402, 202, 2500.00, 'Unpaid', 'UPI');
INSERT INTO Bills VALUES (403, 203, 7000.00, 'Paid', 'Card');
INSERT INTO Bills VALUES (404, 204, 4500.00, 'Unpaid', 'UPI');
INSERT INTO Bills VALUES (405, 205, 3000.00, 'Paid', 'Cash');

CREATE TABLE Prescriptions(
    prescription_id INT PRIMARY KEY,
    appointment_id INT,
    medicine_name VARCHAR(30),
    dosage VARCHAR(20),
    duration_days INT,
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
);

INSERT INTO Prescriptions VALUES (501, 301, 'Paracetamol', '500mg', 5);
INSERT INTO Prescriptions VALUES (502, 302, 'Amoxicillin', '250mg', 7);
INSERT INTO Prescriptions VALUES (503, 303, 'Ibuprofen', '400mg', 5);
INSERT INTO Prescriptions VALUES (504, 304, 'Cefixime', '200mg', 10);
INSERT INTO Prescriptions VALUES (505, 305, 'Vitamin D', '1000 IU', 30);