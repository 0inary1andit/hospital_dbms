# 🏥 Hospital Management Database System

> A production-style MySQL database for real-world hospital operations — built while learning DBMS.

![Status](https://img.shields.io/badge/Status-In%20Progress-yellow)
![Database](https://img.shields.io/badge/Database-MySQL-blue)
![Language](https://img.shields.io/badge/Language-SQL-orange)
![License](https://img.shields.io/badge/License-MIT-green)

---

## Overview

A relational database system designed to handle core hospital workflows — patient registration, doctor management, appointments, billing, and prescriptions. Built with a focus on data integrity, normalization (3NF), and real-world usability.

---

## Current Schema

| Table | Description |
|---|---|
| `Departments` | Hospital departments and heads |
| `Doctors` | Doctor details, specialization, department |
| `Patients` | Patient registration and personal info |
| `Appointments` | Patient-doctor visit scheduling |
| `Bills` | Invoice and payment records |
| `Prescriptions` | Medicines prescribed per appointment |
| `Staff` | Non-doctor hospital staff |

---

## ER Diagram

![ER Diagram](er_diagram.svg)

---

## Getting Started

**Prerequisites:** MySQL 8.0+

```bash
git clone https://github.com/0inary1andit/hospital_dbms.git
cd hospital_dbms
mysql -u root -p < schema/tables.sql
mysql -u root -p < schema/sample_data.sql
```

---

## Sample Queries

**All appointments for a doctor on a given day:**
```sql
SELECT p.name, a.appointment_date, a.diagnosis, a.status
FROM Appointments a
JOIN Patients p ON a.patient_id = p.patient_id
WHERE a.doctor_id = 101 AND DATE(a.appointment_date) = '2026-02-21';
```

**Unpaid bills summary:**
```sql
SELECT p.name, b.bill_id, b.total_amount, b.payment_mode
FROM Bills b
JOIN Patients p ON b.patient_id = p.patient_id
WHERE b.payment_status = 'Unpaid';
```

---

## Roadmap

- [x] Core schema — Departments, Doctors, Patients, Appointments, Bills, Prescriptions, Staff
- [x] Sample data for all tables
- [x] ER Diagram
- [ ] Rooms and bed management table
- [ ] Lab tests and results table
- [ ] Pharmacy and inventory table
- [ ] Stored procedures (admit, discharge, generate bill)
- [ ] Views and triggers
- [ ] Python backend (Flask/FastAPI)
- [ ] Web frontend (HTML/CSS/JS)

---

## Tech Stack

| | |
|---|---|
| Database | MySQL 8.0 |
| Design | draw.io |
| Planned backend | Python (Flask) |
| Planned frontend | HTML, CSS, JS |

---

## Author

**Mohit Satyal** — B.Tech CSE Student

---

## License

MIT — see [LICENSE](LICENSE)
