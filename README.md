# PULSEVIEW: Hospital Information System (SQL)

A relational database for a hospital, designed and queried in **Microsoft SQL Server (T-SQL)**. It models staff, patients, appointments, prescriptions, rooms, hospital stays and medical procedures, and answers 39 analytical questions about them. A Power BI dashboard sits on top of the data.

This was my first full SQL project.

## Contents

| File | Description |
|------|-------------|
| `PULSEVIEW.sql` | Schema (15 tables), sample data, and queries |
| `HIS_Presentation_final_project.pptx` | Project presentation: table creation, all 39 queries with results, Power BI dashboard |

## Database schema

Database name: `HospitalDB_v2`. 15 tables, with primary keys, composite keys and foreign keys throughout.

| Area | Tables |
|------|--------|
| Staff | `Physician`, `Nurse`, `Department`, `Affiliated_with`, `On_Call` |
| Patients and care | `Patient`, `Appointment`, `Prescribes`, `Medication` |
| Procedures | `Procedure_Info`, `Trained_in`, `Undergoes` |
| Facilities | `Block`, `Room`, `Stay` |

Design notes:
- Many-to-many relationships (physician to department, physician to procedure training) use junction tables with composite primary keys.
- `Room` references `Block` through a composite foreign key (`block_floor`, `block_code`).
- `Trained_in` stores certification and expiry dates, so the data can show whether a physician was certified when a procedure was performed.
- Optional links (for example `prep_nurse` on `Appointment`) are nullable.

## What the queries cover

The 39 queries are grouped by theme:

- **Basic filtering and counting:** unregistered nurses, department heads, patients with at least one appointment, available and unavailable rooms.
- **Joins:** physicians with their departments, patients with their primary care physician, patients with the rooms and nurses assigned to them.
- **Anti-joins and null handling:** patients with no appointment, appointments with no nurse, physicians not yet affiliated with a department.
- **Aggregation:** available rooms per block, per floor, and per block and floor; floors with the most and fewest available rooms.
- **Compliance checks:** procedures performed by uncertified physicians, and procedures performed after a certification expired.
- **Multi-table analysis:** patients with procedures costing over 5000 and their primary care physician, patients with at least two appointments with a registered nurse, patients whose primary care physician does not head a department.

## SQL concepts used

`INNER JOIN` and `LEFT JOIN`, `GROUP BY` and `HAVING`, subqueries, `NOT IN` and `NOT EXISTS`, `TOP`, `COUNT(DISTINCT ...)`, aggregate functions, date and time filtering, composite keys, and referential integrity.

## Power BI dashboard

A dashboard built on the database visualizes the results (see the last slides of the presentation).

## How to run

1. Open SQL Server Management Studio (or Azure Data Studio) on a SQL Server instance.
2. Open `PULSEVIEW.sql` and run it. It creates `HospitalDB_v2`, the 15 tables, and inserts the sample data.
3. Run the queries one at a time. They are listed in the same order as the presentation.

The script uses T-SQL syntax (`GO`, `DATETIME2`, `BIT`, `TOP`), so it targets SQL Server. Running it on MySQL or PostgreSQL needs small syntax changes.

## Note on the data

All records are synthetic sample data created for this project. No real patient information is used.

## Author

Basmala Taha, Bioinformatics, Faculty of Computer Science, Egypt-Japan University of Science and Technology (E-JUST)
