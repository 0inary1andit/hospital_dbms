# 🏥 Hospital Management Database System

> A production-style MySQL database for real-world hospital operations — built while learning DBMS.

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


---

## Getting Started

**Prerequisites:** MySQL 8.0+
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
