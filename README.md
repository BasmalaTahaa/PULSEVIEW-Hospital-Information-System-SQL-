# PULSEVIEW: Hospital Information System (SQL + Power BI)

A relational database for a hospital, with 39 analytical SQL queries and an interactive Power BI dashboard on top. It models staff, patients, appointments, prescriptions, rooms, hospital stays and medical procedures. The goal is to replace manual recordkeeping with a structured, normalized database that supports questions about patient care, staff assignments, room availability and procedure certification.

This was my first full SQL project.

## Contents

| File | Description |
|------|-------------|
| `PULSEVIEW.sql` | Schema (15 tables), sample data, and queries (T-SQL) |
| `HIS_Final_Project.pdf` | Project report: ERD, table creation, and all 39 queries with code, results and explanations |
| `HIS_Presentation_final_project.pptx` | Project presentation |
| `HIS.pbix` | Power BI dashboard (Pulse View) |

## Database schema

Database name: `HospitalDB_v2`. 15 tables, with primary keys, composite keys and foreign keys throughout. The full ERD is in the report.

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
- Department heads must be physicians. The schema does not allow a nurse to head a department, which is why Query 2 returns an empty result by design.

## What the queries cover

The 39 queries are grouped by theme:

- **Basic filtering and counting:** unregistered nurses, department heads, patients with at least one appointment, available and unavailable rooms.
- **Joins:** physicians with their departments, patients with their primary care physician, patients with the rooms and nurses assigned to them.
- **Anti-joins and null handling:** patients with no appointment, appointments with no nurse, physicians not yet affiliated with a department or not trained in any procedure.
- **Aggregation:** available rooms per block, per floor, and per block and floor; floors with the most and fewest available rooms (using a CTE and `TOP`).
- **Compliance checks:** procedures performed by uncertified physicians, and procedures performed after a certification expired.
- **Multi-table analysis:** patients with procedures costing over 5000 and their primary care physician, patients with at least two appointments with a registered nurse, patients whose primary care physician does not head a department.

## SQL concepts used

`INNER JOIN` and `LEFT JOIN`, `GROUP BY` and `HAVING`, subqueries, CTEs, `NOT IN` and `NOT EXISTS`, `TOP`, `COUNT(DISTINCT ...)`, `GROUP_CONCAT`, `LIKE`, aggregate functions, date and time filtering, composite keys, and referential integrity.

## Power BI dashboard

`HIS.pbix` contains the **Pulse View: Real-Time Hospital Dashboard**, built on the same 15 tables. It has three pages with a navigation menu:

| Page | Contents |
|------|----------|
| **Home** | Landing page with navigation buttons |
| **Overview** | KPI cards (patients, physicians, department heads, nurses), room availability by floor, patient count by floor (treemap), top 10 performed procedures, top 10 prescribed medications |
| **Distributions** | Top performing physicians, appointments per physician, average procedure cost by department, patient count by department and insurance, with room status cards |

Slicers filter the pages by floor, department, medication brand, physician and procedure date.

To open it, use Power BI Desktop and open `HIS.pbix`.

## How to run

1. Open SQL Server Management Studio (or Azure Data Studio) on a SQL Server instance.
2. Open `PULSEVIEW.sql` and run it. It creates `HospitalDB_v2`, the 15 tables, and inserts the sample data.
3. Run the queries one at a time. They are listed in the same order as the report.

The script uses T-SQL syntax (`GO`, `DATETIME2`, `BIT`, `TOP`). While developing the queries I also ran them on PostgreSQL and MySQL, so a few queries in the report use syntax from those systems (for example `= false` and `GROUP_CONCAT`). When running on SQL Server, replace those with `= 0` and `STRING_AGG`.

## Note on the data

All records are synthetic sample data created for this project. No real patient information is used.

## Author

Basmala Taha, Bioinformatics, Faculty of Computer Science, Egypt-Japan University of Science and Technology (E-JUST)
