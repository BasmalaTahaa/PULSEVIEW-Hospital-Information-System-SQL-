
CREATE DATABASE HospitalDB_v2;
GO
USE HospitalDB_v2; 
GO
CREATE TABLE Physician (
    employee_id INTEGER PRIMARY KEY,
    physician_name TEXT NOT NULL,
    physician_position TEXT NOT NULL,
    ssn INTEGER UNIQUE NOT NULL
);

    CREATE TABLE Department (
        department_id INTEGER PRIMARY KEY,
        dep_name TEXT NOT NULL,
        head INTEGER NOT NULL,
        FOREIGN KEY (head) REFERENCES Physician(employee_id)
    );



CREATE TABLE Affiliated_with (
    physician INTEGER NOT NULL,
    department INTEGER NOT NULL,
    primary_affiliation BIT NOT NULL,
    PRIMARY KEY (physician, department),
    FOREIGN KEY (physician) REFERENCES Physician(employee_id),
    FOREIGN KEY (department) REFERENCES Department(department_id)
);



CREATE TABLE Procedure_Info (
    code INTEGER PRIMARY KEY,
    procedure_name TEXT NOT NULL,
    procedure_cost REAL NOT NULL
);

CREATE TABLE Trained_in (
    physician INTEGER NOT NULL,
    treatment INTEGER NOT NULL,
    certificationdate DATE NOT NULL,
    certificationexpires DATE NOT NULL,
    PRIMARY KEY (physician, treatment),
    FOREIGN KEY (physician) REFERENCES Physician(employee_id),
    FOREIGN KEY (treatment) REFERENCES Procedure_Info(code)
);


CREATE TABLE Patient (
    ssn INTEGER PRIMARY KEY,
    patient_name TEXT NOT NULL,
    address TEXT NOT NULL,
    phone TEXT NOT NULL,
    insurance_id INTEGER,
    pcp INTEGER NOT NULL,
    FOREIGN KEY (pcp) REFERENCES Physician(employee_id)
);
GO




CREATE TABLE Nurse (
    employee_id INTEGER PRIMARY KEY,
    nurse_name TEXT NOT NULL,
    nurse_position TEXT NOT NULL,
    registered BIT NOT NULL,
    ssn INTEGER UNIQUE NOT NULL
);


    CREATE TABLE Appointment (
        appointment_id INTEGER PRIMARY KEY,
        patient INTEGER NOT NULL,
        prep_nurse INTEGER,
        physician INTEGER NOT NULL,
        start_dt_time DATETIME2 NOT NULL,
        end_dt_time DATETIME2 NOT NULL,
        examination_room TEXT NOT NULL,
        FOREIGN KEY (patient) REFERENCES Patient(ssn),
        FOREIGN KEY (prep_nurse) REFERENCES Nurse(employee_id),
        FOREIGN KEY (physician) REFERENCES Physician(employee_id)
    );



CREATE TABLE Medication (
    code INTEGER PRIMARY KEY,
    med_name TEXT NOT NULL,
    brand TEXT NOT NULL,
    description TEXT
);
DROP TABLE Prescribes;
GO
CREATE TABLE Prescribes (
    physician INTEGER NOT NULL,
    patient INTEGER NOT NULL,
    medication INTEGER NOT NULL,
    date DATETIME2 NOT NULL,
    appointment INTEGER,
    dose TEXT NOT NULL,
    PRIMARY KEY (physician, patient, medication, date),
    FOREIGN KEY (physician) REFERENCES Physician(employee_id),
    FOREIGN KEY (patient) REFERENCES Patient(ssn),
    FOREIGN KEY (medication) REFERENCES Medication(code),
    FOREIGN KEY (appointment) REFERENCES Appointment(appointment_id)
);



SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Patient';
SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Patient';



CREATE TABLE Block (
    block_floor INTEGER NOT NULL,
    block_code INTEGER NOT NULL,
    PRIMARY KEY (block_floor, block_code)
);

CREATE TABLE Room (
    room_number INTEGER PRIMARY KEY,
    room_type TEXT NOT NULL,
    block_floor INTEGER NOT NULL,
    block_code INTEGER NOT NULL,
    unavailable BIT NOT NULL,
    FOREIGN KEY (block_floor, block_code) REFERENCES Block(block_floor, block_code)
);

CREATE TABLE On_Call (
    nurse INTEGER NOT NULL,
    block_floor INTEGER NOT NULL,
    block_code INTEGER NOT NULL,
    on_call_start DATETIME2 NOT NULL,
    on_call_end DATETIME2 NOT NULL,
    PRIMARY KEY (nurse, block_floor, block_code, on_call_start, on_call_end),
    FOREIGN KEY (nurse) REFERENCES Nurse(employee_id),
    FOREIGN KEY (block_floor, block_code) REFERENCES Block(block_floor, block_code)
);
GO

CREATE TABLE Stay (
    stay_id INTEGER PRIMARY KEY,
    patient INTEGER NOT NULL,
    room INTEGER NOT NULL,
    start_time DATETIME2 NOT NULL,
    end_time DATETIME2 NOT NULL,
    FOREIGN KEY (patient) REFERENCES Patient(ssn),
    FOREIGN KEY (room) REFERENCES Room(room_number)
);

CREATE TABLE Undergoes (
    patient INTEGER NOT NULL,
    patient_procedure INTEGER NOT NULL,
    stay INTEGER NOT NULL,
    date DATETIME2 NOT NULL,
    physician INTEGER NOT NULL,
    assisting_nurse INTEGER,
    PRIMARY KEY (patient, patient_procedure, stay, date),
    FOREIGN KEY (patient) REFERENCES Patient(ssn),
    FOREIGN KEY (patient_procedure) REFERENCES Procedure_Info(code),
    FOREIGN KEY (stay) REFERENCES Stay(stay_id),
    FOREIGN KEY (physician) REFERENCES Physician(employee_id),
    FOREIGN KEY (assisting_nurse) REFERENCES Nurse(employee_id)
);

INSERT INTO Physician VALUES (1, 'John Dorian', 'Intern', 111111111);
INSERT INTO Physician VALUES (2, 'Elliot Reid', 'Attending Physician', 222222222);
INSERT INTO Physician VALUES (3, 'Christopher Turk', 'Surgeon', 333333333);
INSERT INTO Physician VALUES (4, 'Percival Cox', 'Senior Attending Physician', 444444444);
INSERT INTO Physician VALUES (5, 'Bob Kelso', 'Chief of Medicine', 555555555);
INSERT INTO Physician VALUES (6, 'Molly Clock', 'Psychiatrist', 666666666);
INSERT INTO Physician VALUES (7, 'Lisa Cuddy', 'Endocrinologist', 777777777);
INSERT INTO Physician VALUES (8, 'James Wilson', 'Oncologist', 888888888);
INSERT INTO Physician VALUES (9, 'Gregory House', 'Diagnostic Medicine', 999999999);
INSERT INTO Physician VALUES (10, 'Robert Chase', 'Intensive Care Specialist', 101010101);
INSERT INTO Physician VALUES (11, 'Allison Cameron', 'Immunologist', 121212121);
INSERT INTO Physician VALUES (12, 'Eric Foreman', 'Neurologist', 131313131);
INSERT INTO Physician VALUES (13, 'Remy Hadley', 'Internist', 141414141);
INSERT INTO Physician VALUES (14, 'Lawrence Kutner', 'Sports Medicine', 151515151);
INSERT INTO Physician VALUES (15, 'Chi Park', 'Neurologist', 161616161);
INSERT INTO Physician VALUES (16, 'Chris Taub', 'Plastic Surgeon', 171717171);
INSERT INTO Physician VALUES (17, 'Jessica Adams', 'Internal Medicine', 181818181);
INSERT INTO Physician VALUES (18, 'Jeffrey Cole', 'Pathologist', 191919191);
INSERT INTO Physician VALUES (19, 'Samira Shah', 'Resident', 202020202);
INSERT INTO Physician VALUES (20, 'Noah Daniels', 'Cardiologist', 212121212);


INSERT INTO Department VALUES (1, 'General Medicine', 4);
INSERT INTO Department VALUES (2, 'Surgery', 3);
INSERT INTO Department VALUES (3, 'Psychiatry', 2);
INSERT INTO Department VALUES (4, 'Cardiology', 1);
INSERT INTO Department VALUES (5, 'Administration', 5);
INSERT INTO Department VALUES (6, 'Neurology', 12);
INSERT INTO Department VALUES (7, 'Oncology', 8);
INSERT INTO Department VALUES (8, 'Immunology', 11);
INSERT INTO Department VALUES (9, 'Pediatrics', 7);
INSERT INTO Department VALUES (10, 'Orthopedics', 14);
INSERT INTO Department VALUES (11, 'Dermatology', 17);
INSERT INTO Department VALUES (12, 'Urology', 13);
INSERT INTO Department VALUES (13, 'Radiology', 10);
INSERT INTO Department VALUES (14, 'Plastic Surgery', 16);
INSERT INTO Department VALUES (15, 'Internal Medicine', 18);
INSERT INTO Department VALUES (16, 'Pathology', 19);
INSERT INTO Department VALUES (17, 'Rehabilitation', 9);
INSERT INTO Department VALUES (18, 'Endocrinology', 6);
INSERT INTO Department VALUES (19, 'Emergency Medicine', 20);
INSERT INTO Department VALUES (20, 'Family Medicine', 15);


INSERT INTO Affiliated_with VALUES (1, 1, 1);
INSERT INTO Affiliated_with VALUES (1, 4, 0);
INSERT INTO Affiliated_with VALUES (2, 3, 1);
INSERT INTO Affiliated_with VALUES (2, 1, 0);
INSERT INTO Affiliated_with VALUES (3, 2, 1);
INSERT INTO Affiliated_with VALUES (3, 6, 0);
INSERT INTO Affiliated_with VALUES (4, 1, 1);
INSERT INTO Affiliated_with VALUES (4, 7, 0);
INSERT INTO Affiliated_with VALUES (5, 5, 1);
INSERT INTO Affiliated_with VALUES (6, 3, 1);
INSERT INTO Affiliated_with VALUES (7, 9, 1);
INSERT INTO Affiliated_with VALUES (8, 7, 1);
INSERT INTO Affiliated_with VALUES (8, 2, 0);
INSERT INTO Affiliated_with VALUES (9, 17, 1);
INSERT INTO Affiliated_with VALUES (10, 13, 1);
INSERT INTO Affiliated_with VALUES (10, 20, 0);
INSERT INTO Affiliated_with VALUES (11, 8, 1);
INSERT INTO Affiliated_with VALUES (12, 6, 1);
INSERT INTO Affiliated_with VALUES (13, 12, 1);
INSERT INTO Affiliated_with VALUES (13, 15, 0);


INSERT INTO Procedure_Info VALUES (1, 'Appendectomy', 5000);
INSERT INTO Procedure_Info VALUES (2, 'Colonoscopy', 1500);
INSERT INTO Procedure_Info VALUES (3, 'Angioplasty', 8000);
INSERT INTO Procedure_Info VALUES (4, 'MRI Scan', 2000);
INSERT INTO Procedure_Info VALUES (5, 'Psych Evaluation', 500);
INSERT INTO Procedure_Info VALUES (6, 'CT Scan', 1800);
INSERT INTO Procedure_Info VALUES (7, 'Blood Test', 200);
INSERT INTO Procedure_Info VALUES (8, 'X-Ray', 300);
INSERT INTO Procedure_Info VALUES (9, 'Ultrasound', 400);
INSERT INTO Procedure_Info VALUES (10, 'Cataract Surgery', 6000);
INSERT INTO Procedure_Info VALUES (11, 'Gastroscopy', 1600);
INSERT INTO Procedure_Info VALUES (12, 'ECG', 250);
INSERT INTO Procedure_Info VALUES (13, 'Dialysis', 3500);
INSERT INTO Procedure_Info VALUES (14, 'Chemotherapy Session', 7000);
INSERT INTO Procedure_Info VALUES (15, 'Vaccination', 150);
INSERT INTO Procedure_Info VALUES (16, 'Skin Biopsy', 1200);
INSERT INTO Procedure_Info VALUES (17, 'Laparoscopy', 5500);
INSERT INTO Procedure_Info VALUES (18, 'Brain MRI', 3000);
INSERT INTO Procedure_Info VALUES (19, 'Physical Therapy Session', 400);
INSERT INTO Procedure_Info VALUES (20, 'EEG', 1800);

INSERT INTO Trained_in VALUES (3, 1, '2020-01-01', '2025-01-01');
INSERT INTO Trained_in VALUES (3, 2, '2019-06-15', '2024-06-15');
INSERT INTO Trained_in VALUES (1, 3, '2021-03-10', '2026-03-10');
INSERT INTO Trained_in VALUES (4, 4, '2018-11-20', '2023-11-20');
INSERT INTO Trained_in VALUES (2, 5, '2020-09-05', '2025-09-05');
INSERT INTO Trained_in VALUES (5, 6, '2019-01-10', '2024-01-10');
INSERT INTO Trained_in VALUES (6, 7, '2022-04-05', '2027-04-05');
INSERT INTO Trained_in VALUES (7, 8, '2020-09-12', '2025-09-12');
INSERT INTO Trained_in VALUES (8, 9, '2021-02-18', '2026-02-18');
INSERT INTO Trained_in VALUES (9, 10, '2018-06-30', '2023-06-30');
INSERT INTO Trained_in VALUES (10, 11, '2023-01-01', '2028-01-01');
INSERT INTO Trained_in VALUES (11, 12, '2017-07-15', '2022-07-15');
INSERT INTO Trained_in VALUES (12, 13, '2019-10-25', '2024-10-25');
INSERT INTO Trained_in VALUES (13, 14, '2021-05-20', '2026-05-20');
INSERT INTO Trained_in VALUES (14, 15, '2020-03-01', '2025-03-01');
INSERT INTO Trained_in VALUES (15, 16, '2022-12-11', '2027-12-11');
INSERT INTO Trained_in VALUES (16, 17, '2021-08-08', '2026-08-08');
INSERT INTO Trained_in VALUES (17, 18, '2019-04-14', '2024-04-14');
INSERT INTO Trained_in VALUES (18, 19, '2020-06-06', '2025-06-06');
INSERT INTO Trained_in VALUES (19, 20, '2023-09-09', '2028-09-09');


INSERT INTO Patient VALUES (1001, 'John Smith', '123 Main St', '555-0101', 7001, 1);
INSERT INTO Patient VALUES (1002, 'Jane Doe', '456 Oak Ave', '555-0102', 7002, 2);
INSERT INTO Patient VALUES (1003, 'Robert Johnson', '789 Pine Rd', '555-0103', 7003, 3);
INSERT INTO Patient VALUES (1004, 'Sarah Williams', '321 Elm Blvd', '555-0104', 7004, 4);
INSERT INTO Patient VALUES (1005, 'Michael Brown', '654 Maple Ln', '555-0105', 7005, 1);
INSERT INTO Patient VALUES (1006, 'Lisa Ray', '987 Cedar Dr', '555-0106', 7006, 2);
INSERT INTO Patient VALUES (1007, 'David Miller', '159 Birch St', '555-0107', 7007, 5);
INSERT INTO Patient VALUES (1008, 'Emily Davis', '753 Walnut Rd', '555-0108', 7008, 6);
INSERT INTO Patient VALUES (1009, 'James Wilson', '852 Aspen Ct', '555-0109', 7009, 7);
INSERT INTO Patient VALUES (1010, 'Mary Taylor', '951 Chestnut Blvd', '555-0110', 7010, 8);
INSERT INTO Patient VALUES (1011, 'William Moore', '357 Spruce Ln', '555-0111', 7011, 9);
INSERT INTO Patient VALUES (1012, 'Patricia Anderson', '258 Redwood Dr', '555-0112', 7012, 10);
INSERT INTO Patient VALUES (1013, 'Charles Thomas', '147 Magnolia Ave', '555-0113', 7013, 11);
INSERT INTO Patient VALUES (1014, 'Linda Jackson', '369 Willow St', '555-0114', 7014, 12);
INSERT INTO Patient VALUES (1015, 'Christopher White', '741 Poplar Way', '555-0115', 7015, 13);
INSERT INTO Patient VALUES (1016, 'Barbara Harris', '963 Beech Ct', '555-0116', 7016, 14);
INSERT INTO Patient VALUES (1017, 'Daniel Martin', '684 Sequoia Blvd', '555-0117', 7017, 15);
INSERT INTO Patient VALUES (1018, 'Elizabeth Thompson', '276 Fir Ln', '555-0118', 7018, 16);
INSERT INTO Patient VALUES (1019, 'Matthew Garcia', '183 Hickory Dr', '555-0119', 7019, 17);
INSERT INTO Patient VALUES (1020, 'Susan Martinez', '492 Maple St', '555-0120', 7020, 18);


INSERT INTO Nurse VALUES (101, 'Carla Espinosa', 'Head Nurse', 1, 666666666);
INSERT INTO Nurse VALUES (102, 'Laverne Roberts', 'Nurse', 1, 777777777);
INSERT INTO Nurse VALUES (103, 'Paul Flowers', 'Nurse', 0, 888888888);
INSERT INTO Nurse VALUES (104, 'Shirley', 'Senior Nurse', 1, 999999999);
INSERT INTO Nurse VALUES (105, 'Todd Quinlan', 'Junior Nurse', 0, 101010101);
INSERT INTO Nurse VALUES (106, 'The Todd', 'Department Head', 1, 121212121);
INSERT INTO Nurse VALUES (107, 'Nancy Hall', 'Staff Nurse', 1, 131313131);
INSERT INTO Nurse VALUES (108, 'Tim Blake', 'Junior Nurse', 0, 141414141);
INSERT INTO Nurse VALUES (109, 'Angela Reed', 'Nurse', 1, 151515151);
INSERT INTO Nurse VALUES (110, 'Victor Scott', 'Senior Nurse', 1, 161616161);
INSERT INTO Nurse VALUES (111, 'Rachel Green', 'Pediatric Nurse', 0, 171717171);
INSERT INTO Nurse VALUES (112, 'Monica Geller', 'OR Nurse', 1, 181818181);
INSERT INTO Nurse VALUES (113, 'Phoebe Buffay', 'Night Shift Nurse', 0, 191919191);
INSERT INTO Nurse VALUES (114, 'Ross Geller', 'Trauma Nurse', 1, 202020202);
INSERT INTO Nurse VALUES (115, 'Joey Tribbiani', 'Recovery Nurse', 0, 212121212);
INSERT INTO Nurse VALUES (116, 'Chandler Bing', 'ICU Nurse', 1, 222222222);
INSERT INTO Nurse VALUES (117, 'Janice Hosenstein', 'ER Nurse', 1, 232323232);
INSERT INTO Nurse VALUES (118, 'Mike Hannigan', 'Triage Nurse', 0, 242424242);
INSERT INTO Nurse VALUES (119, 'Gunther', 'Ward Nurse', 1, 252525252);
INSERT INTO Nurse VALUES (120, 'Ben Wyatt', 'Surgical Nurse', 0, 262626262);


INSERT INTO Appointment VALUES (2001, 1001, 101, 1, '2023-04-25 10:00:00', '2023-04-25 10:30:00', 'A101');
INSERT INTO Appointment VALUES (2002, 1002, 102, 2, '2023-04-25 11:00:00', '2023-04-25 11:45:00', 'B202');
INSERT INTO Appointment VALUES (2003, 1003, NULL, 3, '2023-04-26 09:00:00', '2023-04-26 10:00:00', 'C303');
INSERT INTO Appointment VALUES (2004, 1004, 104, 4, '2023-04-27 14:00:00', '2023-04-27 14:30:00', 'A101');
INSERT INTO Appointment VALUES (2005, 1005, NULL, 1, '2023-04-28 15:00:00', '2023-04-28 16:00:00', 'B202');
INSERT INTO Appointment VALUES (2006, 1006, 105, 5, '2023-05-01 09:30:00', '2023-05-01 10:00:00', 'C101');
INSERT INTO Appointment VALUES (2007, 1007, 106, 6, '2023-05-02 11:00:00', '2023-05-02 11:30:00', 'B101');
INSERT INTO Appointment VALUES (2008, 1008, NULL, 7, '2023-05-02 13:00:00', '2023-05-02 13:45:00', 'A201');
INSERT INTO Appointment VALUES (2009, 1009, 108, 8, '2023-05-03 10:15:00', '2023-05-03 10:45:00', 'C102');
INSERT INTO Appointment VALUES (2010, 1010, 109, 9, '2023-05-03 12:00:00', '2023-05-03 12:30:00', 'B202');
INSERT INTO Appointment VALUES (2011, 1011, NULL, 10, '2023-05-04 09:00:00', '2023-05-04 09:30:00', 'A103');
INSERT INTO Appointment VALUES (2012, 1012, 110, 11, '2023-05-04 11:00:00', '2023-05-04 11:30:00', 'C101');
INSERT INTO Appointment VALUES (2013, 1013, 111, 12, '2023-05-05 14:00:00', '2023-05-05 14:45:00', 'A202');
INSERT INTO Appointment VALUES (2014, 1014, NULL, 13, '2023-05-05 15:30:00', '2023-05-05 16:15:00', 'B303');
INSERT INTO Appointment VALUES (2015, 1015, 112, 14, '2023-05-06 10:00:00', '2023-05-06 10:30:00', 'C203');
INSERT INTO Appointment VALUES (2016, 1016, 113, 15, '2023-05-06 11:30:00', '2023-05-06 12:00:00', 'A101');
INSERT INTO Appointment VALUES (2017, 1017, 114, 16, '2023-05-07 09:45:00', '2023-05-07 10:15:00', 'B101');
INSERT INTO Appointment VALUES (2018, 1018, NULL, 17, '2023-05-07 12:00:00', '2023-05-07 12:30:00', 'C101');
INSERT INTO Appointment VALUES (2019, 1019, 115, 18, '2023-05-08 08:00:00', '2023-05-08 08:30:00', 'A301');
INSERT INTO Appointment VALUES (2020, 1020, 116, 19, '2023-05-08 13:00:00', '2023-05-08 13:45:00', 'B202');


INSERT INTO Medication VALUES (1, 'Paracetamol', 'Tylenol', 'Pain reliever and fever reducer');
INSERT INTO Medication VALUES (2, 'Ibuprofen', 'Advil', 'NSAID for pain and inflammation');
INSERT INTO Medication VALUES (3, 'Lisinopril', 'Zestril', 'ACE inhibitor for blood pressure');
INSERT INTO Medication VALUES (4, 'Metformin', 'Glucophage', 'Diabetes medication');
INSERT INTO Medication VALUES (5, 'Sertraline', 'Zoloft', 'SSRI antidepressant');
INSERT INTO Medication VALUES (6, 'Amoxicillin', 'Amoxil', 'Antibiotic for bacterial infections');
INSERT INTO Medication VALUES (7, 'Atorvastatin', 'Lipitor', 'Statin for cholesterol');
INSERT INTO Medication VALUES (8, 'Omeprazole', 'Prilosec', 'Proton pump inhibitor for acid reflux');
INSERT INTO Medication VALUES (9, 'Amlodipine', 'Norvasc', 'Calcium channel blocker for hypertension');
INSERT INTO Medication VALUES (10, 'Albuterol', 'Ventolin', 'Bronchodilator for asthma');
INSERT INTO Medication VALUES (11, 'Levothyroxine', 'Synthroid', 'Thyroid hormone replacement');
INSERT INTO Medication VALUES (12, 'Clonazepam', 'Klonopin', 'Benzodiazepine for seizures and anxiety');
INSERT INTO Medication VALUES (13, 'Hydrochlorothiazide', 'Microzide', 'Diuretic for high blood pressure');
INSERT INTO Medication VALUES (14, 'Ciprofloxacin', 'Cipro', 'Fluoroquinolone antibiotic');
INSERT INTO Medication VALUES (15, 'Simvastatin', 'Zocor', 'Cholesterol-lowering statin');
INSERT INTO Medication VALUES (16, 'Metoprolol', 'Lopressor', 'Beta blocker for heart conditions');
INSERT INTO Medication VALUES (17, 'Gabapentin', 'Neurontin', 'Nerve pain and seizure medication');
INSERT INTO Medication VALUES (18, 'Escitalopram', 'Lexapro', 'SSRI for anxiety and depression');
INSERT INTO Medication VALUES (19, 'Furosemide', 'Lasix', 'Loop diuretic for fluid retention');
INSERT INTO Medication VALUES (20, 'Prednisone', 'Deltasone', 'Corticosteroid for inflammation');


INSERT INTO Prescribes VALUES (1, 1001, 1, '2023-04-25 10:15:00', 2001, '500mg every 6 hours');
INSERT INTO Prescribes VALUES (2, 1002, 2, '2023-04-25 11:20:00', 2002, '200mg every 8 hours');
INSERT INTO Prescribes VALUES (3, 1003, 3, '2023-04-26 09:30:00', 2003, '10mg daily');
INSERT INTO Prescribes VALUES (4, 1004, 4, '2023-04-27 14:10:00', 2004, '500mg twice daily');
INSERT INTO Prescribes VALUES (2, 1006, 5, '2023-04-29 09:00:00', NULL, '50mg daily');
INSERT INTO Prescribes VALUES (5, 1005, 6, '2023-04-28 15:30:00', 2005, '250mg once daily');
INSERT INTO Prescribes VALUES (6, 1007, 7, '2023-05-01 09:45:00', 2006, '20mg at bedtime');
INSERT INTO Prescribes VALUES (7, 1008, 8, '2023-05-02 11:15:00', 2007, '40mg before meals');
INSERT INTO Prescribes VALUES (8, 1009, 9, '2023-05-03 10:30:00', 2009, '5mg daily');
INSERT INTO Prescribes VALUES (9, 1010, 10, '2023-05-03 12:15:00', 2010, '2 puffs every 4 hours');
INSERT INTO Prescribes VALUES (10, 1011, 11, '2023-05-04 09:15:00', 2011, '100mcg daily');
INSERT INTO Prescribes VALUES (11, 1012, 12, '2023-05-04 11:15:00', 2012, '0.5mg twice daily');
INSERT INTO Prescribes VALUES (12, 1013, 13, '2023-05-05 14:30:00', 2013, '25mg daily');
INSERT INTO Prescribes VALUES (13, 1014, 14, '2023-05-05 15:45:00', 2014, '500mg every 12 hours');
INSERT INTO Prescribes VALUES (14, 1015, 15, '2023-05-06 10:15:00', 2015, '20mg at night');
INSERT INTO Prescribes VALUES (15, 1016, 16, '2023-05-06 11:45:00', 2016, '50mg in morning');
INSERT INTO Prescribes VALUES (16, 1017, 17, '2023-05-07 10:00:00', 2017, '300mg three times daily');
INSERT INTO Prescribes VALUES (17, 1018, 18, '2023-05-07 12:15:00', 2018, '10mg once daily');
INSERT INTO Prescribes VALUES (18, 1019, 19, '2023-05-08 08:15:00', 2019, '40mg twice daily');
INSERT INTO Prescribes VALUES (19, 1020, 20, '2023-05-08 13:30:00', 2020, '10mg tapered over 5 days');

INSERT INTO Block VALUES (1, 101);
INSERT INTO Block VALUES (1, 102);
INSERT INTO Block VALUES (2, 201);
INSERT INTO Block VALUES (2, 202);
INSERT INTO Block VALUES (2, 203);
INSERT INTO Block VALUES (3, 301);
INSERT INTO Block VALUES (3, 302);
INSERT INTO Block VALUES (3, 303);
INSERT INTO Block VALUES (4, 401);
INSERT INTO Block VALUES (4, 402);
INSERT INTO Block VALUES (4, 403);
INSERT INTO Block VALUES (4, 404);
INSERT INTO Block VALUES (5, 501);
INSERT INTO Block VALUES (5, 502);
INSERT INTO Block VALUES (5, 503);
INSERT INTO Block VALUES (5, 504);
INSERT INTO Block VALUES (5, 505);
INSERT INTO Block VALUES (1, 103);
INSERT INTO Block VALUES (2, 204);
INSERT INTO Block VALUES (3, 304);


INSERT INTO Room VALUES (212, 'OBYGN', 2, 202, 1);
INSERT INTO Room VALUES (301, 'ICU', 1, 101, 0);
INSERT INTO Room VALUES (302, 'General', 1, 101, 1);
INSERT INTO Room VALUES (303, 'Surgery', 1, 102, 0);
INSERT INTO Room VALUES (304, 'Psychiatry', 2, 201, 0);
INSERT INTO Room VALUES (305, 'Cardiology', 2, 202, 0);
INSERT INTO Room VALUES (306, 'Neurology', 2, 203, 1);
INSERT INTO Room VALUES (401, 'Orthopedics', 3, 301, 0);
INSERT INTO Room VALUES (402, 'Pediatrics', 3, 302, 1);
INSERT INTO Room VALUES (403, 'Dermatology', 3, 303, 0);
INSERT INTO Room VALUES (404, 'Radiology', 4, 401, 0);
INSERT INTO Room VALUES (405, 'Plastic Surgery', 4, 402, 1);
INSERT INTO Room VALUES (406, 'Internal Medicine', 4, 403, 0);
INSERT INTO Room VALUES (407, 'Rehabilitation', 4, 404, 1);
INSERT INTO Room VALUES (408, 'Urology', 5, 501, 0);
INSERT INTO Room VALUES (409, 'ENT', 5, 502, 1);
INSERT INTO Room VALUES (410, 'Emergency', 5, 503, 0);
INSERT INTO Room VALUES (411, 'Observation', 5, 504, 1);
INSERT INTO Room VALUES (412, 'Isolation', 5, 505, 0);
INSERT INTO Room VALUES (413, 'Maternity', 3, 304, 0);


INSERT INTO On_Call VALUES (101, 1, 101, '2023-04-25 08:00:00', '2023-04-25 16:00:00');
INSERT INTO On_Call VALUES (102, 1, 102, '2023-04-25 16:00:00', '2023-04-26 00:00:00');
INSERT INTO On_Call VALUES (104, 2, 201, '2023-04-26 08:00:00', '2023-04-26 16:00:00');
INSERT INTO On_Call VALUES (105, 2, 202, '2023-04-26 16:00:00', '2023-04-27 00:00:00');
INSERT INTO On_Call VALUES (106, 2, 203, '2023-04-27 08:00:00', '2023-04-27 16:00:00');
INSERT INTO On_Call VALUES (107, 3, 301, '2023-04-27 16:00:00', '2023-04-28 00:00:00');
INSERT INTO On_Call VALUES (108, 3, 302, '2023-04-28 08:00:00', '2023-04-28 16:00:00');
INSERT INTO On_Call VALUES (109, 3, 303, '2023-04-28 16:00:00', '2023-04-29 00:00:00');
INSERT INTO On_Call VALUES (110, 4, 401, '2023-04-29 08:00:00', '2023-04-29 16:00:00');
INSERT INTO On_Call VALUES (111, 4, 402, '2023-04-29 16:00:00', '2023-04-30 00:00:00');
INSERT INTO On_Call VALUES (112, 4, 403, '2023-04-30 08:00:00', '2023-04-30 16:00:00');
INSERT INTO On_Call VALUES (113, 4, 404, '2023-04-30 16:00:00', '2023-05-01 00:00:00');
INSERT INTO On_Call VALUES (114, 5, 501, '2023-05-01 08:00:00', '2023-05-01 16:00:00');
INSERT INTO On_Call VALUES (115, 5, 502, '2023-05-01 16:00:00', '2023-05-02 00:00:00');
INSERT INTO On_Call VALUES (116, 5, 503, '2023-05-02 08:00:00', '2023-05-02 16:00:00');
INSERT INTO On_Call VALUES (117, 5, 504, '2023-05-02 16:00:00', '2023-05-03 00:00:00');
INSERT INTO On_Call VALUES (118, 5, 505, '2023-05-03 08:00:00', '2023-05-03 16:00:00');
INSERT INTO On_Call VALUES (119, 3, 304, '2023-05-03 16:00:00', '2023-05-04 00:00:00');
INSERT INTO On_Call VALUES (120, 1, 103, '2023-05-04 08:00:00', '2023-05-04 16:00:00');
INSERT INTO On_Call VALUES (103, 1, 101, '2023-05-04 16:00:00', '2023-05-05 00:00:00');

INSERT INTO Stay VALUES (5001, 1001, 301, '2023-04-20 10:00:00', '2023-04-22 15:00:00');
INSERT INTO Stay VALUES (5002, 1002, 303, '2023-04-21 08:00:00', '2023-04-23 12:00:00');
INSERT INTO Stay VALUES (5003, 1003, 304, '2023-04-22 09:00:00', '2023-04-25 18:00:00');
INSERT INTO Stay VALUES (5004, 1004, 305, '2023-04-23 07:00:00', '2023-04-24 19:00:00');
INSERT INTO Stay VALUES (5005, 1005, 306, '2023-04-24 10:00:00', '2023-04-26 14:00:00');
INSERT INTO Stay VALUES (5006, 1006, 401, '2023-04-25 08:00:00', '2023-04-27 12:00:00');
INSERT INTO Stay VALUES (5007, 1007, 402, '2023-04-25 09:00:00', '2023-04-26 09:00:00');
INSERT INTO Stay VALUES (5008, 1008, 403, '2023-04-26 13:00:00', '2023-04-27 17:00:00');
INSERT INTO Stay VALUES (5009, 1009, 404, '2023-04-27 10:00:00', '2023-04-28 15:00:00');
INSERT INTO Stay VALUES (5010, 1010, 405, '2023-04-28 07:00:00', '2023-04-29 18:00:00');
INSERT INTO Stay VALUES (5011, 1011, 406, '2023-04-29 09:00:00', '2023-05-01 10:00:00');
INSERT INTO Stay VALUES (5012, 1012, 407, '2023-04-30 08:00:00', '2023-05-02 11:00:00');
INSERT INTO Stay VALUES (5013, 1013, 408, '2023-05-01 07:00:00', '2023-05-03 08:00:00');
INSERT INTO Stay VALUES (5014, 1014, 409, '2023-05-02 12:00:00', '2023-05-04 14:00:00');
INSERT INTO Stay VALUES (5015, 1015, 410, '2023-05-03 09:00:00', '2023-05-05 16:00:00');
INSERT INTO Stay VALUES (5016, 1016, 411, '2023-05-04 10:00:00', '2023-05-06 15:00:00');
INSERT INTO Stay VALUES (5017, 1017, 412, '2023-05-05 08:00:00', '2023-05-07 12:00:00');
INSERT INTO Stay VALUES (5018, 1018, 413, '2023-05-06 07:00:00', '2023-05-08 18:00:00');
INSERT INTO Stay VALUES (5019, 1019, 212, '2023-05-07 06:00:00', '2023-05-09 13:00:00');
INSERT INTO Stay VALUES (5020, 1020, 302, '2023-05-08 11:00:00', '2023-05-10 15:00:00');


INSERT INTO Undergoes VALUES (1002, 1, 5002, '2023-04-21 09:00:00', 3, 102);
INSERT INTO Undergoes VALUES (1003, 5, 5003, '2023-04-23 10:00:00', 2, 104);
INSERT INTO Undergoes VALUES (1001, 3, 5001, '2023-04-21 11:00:00', 1, 103);
INSERT INTO Undergoes VALUES (1004, 4, 5004, '2023-04-23 14:00:00', 4, 104);
INSERT INTO Undergoes VALUES (1005, 6, 5005, '2023-04-25 09:00:00', 5, NULL);
INSERT INTO Undergoes VALUES (1006, 7, 5006, '2023-04-26 10:00:00', 6, 105);
INSERT INTO Undergoes VALUES (1007, 8, 5007, '2023-04-25 10:30:00', 7, 106);
INSERT INTO Undergoes VALUES (1008, 9, 5008, '2023-04-26 14:00:00', 8, NULL);
INSERT INTO Undergoes VALUES (1009, 10, 5009, '2023-04-27 11:30:00', 9, 107);
INSERT INTO Undergoes VALUES (1010, 11, 5010, '2023-04-28 08:30:00', 10, 108);
INSERT INTO Undergoes VALUES (1011, 12, 5011, '2023-04-30 09:15:00', 11, NULL);
INSERT INTO Undergoes VALUES (1012, 13, 5012, '2023-05-01 10:45:00', 12, 109);
INSERT INTO Undergoes VALUES (1013, 14, 5013, '2023-05-02 11:00:00', 13, NULL);
INSERT INTO Undergoes VALUES (1014, 15, 5014, '2023-05-03 10:15:00', 14, 110);
INSERT INTO Undergoes VALUES (1015, 16, 5015, '2023-05-04 12:00:00', 15, NULL);
INSERT INTO Undergoes VALUES (1016, 17, 5016, '2023-05-05 13:30:00', 16, 111);
INSERT INTO Undergoes VALUES (1017, 18, 5017, '2023-05-06 09:45:00', 17, NULL);
INSERT INTO Undergoes VALUES (1018, 19, 5018, '2023-05-07 11:20:00', 18, 112);
INSERT INTO Undergoes VALUES (1019, 20, 5019, '2023-05-08 07:50:00', 19, NULL);
INSERT INTO Undergoes VALUES (1020, 2, 5020, '2023-05-09 14:10:00', 20, 113);



-- Displaying all tables above 
SELECT * FROM Physician;
SELECT * FROM Department;
SELECT * FROM Affiliated_with;
SELECT * FROM Procedure_Info;  
SELECT * FROM Trained_in;
SELECT * FROM Patient;
SELECT * FROM Nurse;
SELECT * FROM Appointment;
SELECT * FROM Medication;
SELECT * FROM Prescribes;
SELECT * FROM Block;
SELECT * FROM Room;
SELECT * FROM On_Call;  
SELECT * FROM Stay;
SELECT * FROM Undergoes;

-- 1) Find all information of nurses who are yet to be registered

--all nurses
SELECT * FROM Nurse;

--non registered nurses
SELECT *
FROM Nurse
WHERE registered = 0;


-- ####################
-- 2) Find names of nurses who are department heads
--all nurses and department info
SELECT * FROM Nurse;
SELECT * FROM Department;

-- Now the actual query to find nurses who are department heads
SELECT n.nurse_name, d.dep_name AS department
FROM Nurse n
JOIN Department d ON n.employee_id = d.head;




-- ####################
-- 3)Find names of physicians who are department heads
SELECT p.physician_name, d.dep_name AS department
FROM Physician p
JOIN Department d ON p.employee_id = d.head;

--all physicians and department info
SELECT * FROM Department;
SELECT * FROM Physician;

--heads of departments
SELECT p.physician_name, d.dep_name AS department_name
FROM Physician p
JOIN Department d ON p.employee_id = d.head;


-- ####################
-- 4) Find floor and block for room number 212
--all rooms info
SELECT * FROM Room;

--intended query
SELECT r.room_number, r.block_floor AS floor, r.block_code AS block
FROM Room r
WHERE r.room_number = 212;



-- ####################
-- 5) Find floor and block for room number 212
--all rooms infor
SELECT * FROM Room;

-- Actual query
SELECT r.room_number, r.block_floor AS floor, r.block_code AS block
FROM Room r
WHERE r.room_number = 212;

-- ####################
-- 6) Count the number of available rooms
-- Show room availability status
SELECT room_number, room_type, unavailable FROM Room;

-- Count available rooms
SELECT COUNT(*) AS available_rooms
FROM Room
WHERE unavailable = 0;

-- ####################
-- 7) Count the number of unavailable rooms
-- Show room availability status again
SELECT room_number, room_type, unavailable FROM Room;

-- Count unavailable rooms
SELECT COUNT(*) AS unavailable_rooms
FROM Room
WHERE unavailable = 1;

-- ####################
-- 8) Get physician names and their affiliated departments
-- Show relevant tables first
SELECT * FROM Physician;
SELECT * FROM Department;
SELECT * FROM Affiliated_with;

-- Actual query
SELECT p.physician_name, d.dep_name AS department
FROM Physician p
JOIN Affiliated_with a ON p.employee_id = a.physician
JOIN Department d ON a.department = d.department_id
WHERE a.primary_affiliation = 1;

-- ####################
-- 9) Get physicians trained for special treatments
-- Show training info
SELECT * FROM Trained_in;
SELECT * FROM Procedure_Info;

ALTER TABLE Procedure_Info
ALTER COLUMN procedure_name VARCHAR(255);


-- Actual query
SELECT p.physician_name, pi.procedure_name AS special_treatment
FROM Physician p
JOIN Trained_in t ON p.employee_id = t.physician
JOIN Procedure_Info pi ON t.treatment = pi.code;




-- ####################
-- 10) Get physicians with department who are yet to be affiliated
-- Show all physicians and affiliations
SELECT * FROM Physician;
SELECT * FROM Affiliated_with;

-- Actual query (physicians with no affiliations)
SELECT p.physician_name
FROM Physician p
LEFT JOIN Affiliated_with a ON p.employee_id = a.physician
WHERE a.physician IS NULL;

-- ####################
-- 11) Get physicians who are not specialized
-- Show physicians and their training
SELECT * FROM Physician;
SELECT * FROM Trained_in;

-- Actual query
SELECT p.physician_name
FROM Physician p
LEFT JOIN Trained_in t ON p.employee_id = t.physician
WHERE t.physician IS NULL;

-- ####################
-- 12) Get patients with their primary care physicians
-- Show patients and physicians
SELECT * FROM Patient;
SELECT * FROM Physician;

-- Actual query
SELECT pt.patient_name AS patient, p.physician_name AS primary_physician
FROM Patient pt
JOIN Physician p ON pt.pcp = p.employee_id;


-- 26) Find out the floor where the maximum no of rooms are available.
SELECT TOP 1 block_floor, COUNT(*) AS available_rooms
FROM Room
WHERE unavailable = 0
GROUP BY block_floor
ORDER BY available_rooms DESC;

-- 27) Find out the floor where the minimum no of rooms are available.
SELECT TOP 1 block_floor, COUNT(*) AS available_rooms
FROM Room
WHERE unavailable = 0
GROUP BY block_floor
ORDER BY available_rooms ASC;

-- 28) Obtain patient names with their block, floor, and room number.
SELECT p.patient_name, r.block_floor, r.block_code, r.room_number
FROM Stay s
JOIN Patient p ON s.patient = p.ssn
JOIN Room r ON s.room = r.room_number;

-- 29) Obtain nurses and the block where they are booked for on call.
SELECT n.nurse_name, oc.block_floor, oc.block_code
FROM On_Call oc
JOIN Nurse n ON oc.nurse = n.employee_id;

-- 30) Patient name, physician, nurse, treatment, release date, room, floor, block.
SELECT 
    p.patient_name,
    ph.physician_name,
    n.nurse_name,
    pi.procedure_name,
    s.end_time AS release_date,
    r.room_number,
    r.block_floor,
    r.block_code
FROM Undergoes u
JOIN Patient p ON u.patient = p.ssn
JOIN Physician ph ON u.physician = ph.employee_id
LEFT JOIN Nurse n ON u.assisting_nurse = n.employee_id
JOIN Procedure_Info pi ON u.patient_procedure = pi.code
JOIN Stay s ON u.stay = s.stay_id
JOIN Room r ON s.room = r.room_number;


ALTER TABLE Physician
ALTER COLUMN physician_name VARCHAR(100);

-- 31) Physicians who performed procedures without being certified.
SELECT DISTINCT ph.physician_name
FROM Undergoes u
JOIN Physician ph ON u.physician = ph.employee_id
WHERE NOT EXISTS (
    SELECT 1 FROM Trained_in t
    WHERE t.physician = u.physician AND t.treatment = u.patient_procedure
);

-- 32) Name, procedure, date, patient - for uncertified physician procedures.
SELECT ph.physician_name, pi.procedure_name, u.date, p.patient_name
FROM Undergoes u
JOIN Physician ph ON u.physician = ph.employee_id
JOIN Procedure_Info pi ON u.patient_procedure = pi.code
JOIN Patient p ON u.patient = p.ssn
WHERE NOT EXISTS (
    SELECT 1 FROM Trained_in t
    WHERE t.physician = u.physician AND t.treatment = u.patient_procedure
);


ALTER TABLE Physician
ALTER COLUMN physician_name VARCHAR(100);

ALTER TABLE Physician
ALTER COLUMN physician_position VARCHAR(100);

-- 33) Physicians who performed procedures after certification expiry.
SELECT DISTINCT ph.physician_name, ph.physician_position
FROM Undergoes u
JOIN Trained_in t ON u.physician = t.physician AND u.patient_procedure = t.treatment
JOIN Physician ph ON u.physician = ph.employee_id
WHERE u.date > t.certificationexpires;

-- 34) Physician, procedure, patient, date when certification expired.
SELECT 
    ph.physician_name,
    ph.physician_position,
    pi.procedure_name,
    u.date,
    pt.patient_name,
    t.certificationexpires
FROM Undergoes u
JOIN Trained_in t ON u.physician = t.physician AND u.patient_procedure = t.treatment
JOIN Physician ph ON u.physician = ph.employee_id
JOIN Patient pt ON u.patient = pt.ssn
JOIN Procedure_Info pi ON u.patient_procedure = pi.code
WHERE u.date > t.certificationexpires;


ALTER TABLE Nurse
ALTER COLUMN nurse_name VARCHAR(100);

-- 35) Nurses who have ever been on call in the block of room 122.
SELECT DISTINCT n.nurse_name
FROM On_Call oc
JOIN Nurse n ON oc.nurse = n.employee_id
JOIN Room r ON oc.block_floor = r.block_floor AND oc.block_code = r.block_code
WHERE r.room_number = 122;
SELECT * FROM Room WHERE room_number = 122;
INSERT INTO Room VALUES (122, 'General', 3, 302, 0);

SELECT DISTINCT n.nurse_name, r.room_number, r.block_floor, r.block_code
FROM On_Call oc
JOIN Nurse n ON oc.nurse = n.employee_id
JOIN Room r ON oc.block_floor = r.block_floor AND oc.block_code = r.block_code
WHERE r.room_number = 122;

-- 36) Patients who were prescribed medication by their PCP.
SELECT p.patient_name, ph.physician_name
FROM Prescribes pr
JOIN Patient p ON pr.patient = p.ssn
JOIN Physician ph ON pr.physician = ph.employee_id
WHERE p.pcp = pr.physician;


ALTER TABLE Patient
ALTER COLUMN patient_name VARCHAR(100);

ALTER TABLE Physician
ALTER COLUMN physician_name VARCHAR(100);

-- 37) Patients who underwent procedures > 5000 and their PCP.
SELECT DISTINCT p.patient_name, ph.physician_name
FROM Undergoes u
JOIN Patient p ON u.patient = p.ssn
JOIN Procedure_Info pi ON u.patient_procedure = pi.code
JOIN Physician ph ON p.pcp = ph.employee_id
WHERE pi.procedure_cost > 5000;

-- 38) Patients with at least two appointments with a registered nurse.
SELECT p.patient_name, ph.physician_name
FROM Appointment a
JOIN Nurse n ON a.prep_nurse = n.employee_id
JOIN Patient p ON a.patient = p.ssn
JOIN Physician ph ON p.pcp = ph.employee_id
WHERE n.registered = 1
GROUP BY p.patient_name, ph.physician_name
HAVING COUNT(a.appointment_id) >= 2;

SELECT a.appointment_id, p.patient_name, n.nurse_name
FROM Appointment a
JOIN Nurse n ON a.prep_nurse = n.employee_id
JOIN Patient p ON a.patient = p.ssn
WHERE n.registered = 1;

INSERT INTO Appointment VALUES 
(2021, 1001, 101, 1, '2023-05-10 14:00:00', '2023-05-10 14:30:00', 'A103');

SELECT p.patient_name, COUNT(*) AS reg_nurse_appointments
FROM Appointment a
JOIN Nurse n ON a.prep_nurse = n.employee_id
JOIN Patient p ON a.patient = p.ssn
WHERE n.registered = 1
GROUP BY p.patient_name;



-- 39) Patients whose PCP is not the head of any department.
SELECT p.patient_name, ph.physician_name
FROM Patient p
JOIN Physician ph ON p.pcp = ph.employee_id
WHERE ph.employee_id NOT IN (
    SELECT head FROM Department
);

INSERT INTO Physician VALUES (389, 'Nawal Saeed', 'Resident', 999888777);
INSERT INTO Patient VALUES (1101, 'Lina Hossam', '35 Lotus St', '555-0123', 8001, 389);

SELECT employee_id, physician_name
FROM Physician
WHERE employee_id NOT IN (
    SELECT head FROM Department
);

SELECT COUNT(DISTINCT head) AS number_of_heads
FROM Department;


SELECT DISTINCT ph.employee_id, ph.physician_name
FROM Patient p
JOIN Physician ph ON p.pcp = ph.employee_id
WHERE ph.employee_id IN (SELECT head FROM Department);



-- Procedure 1 repeated 5 times
INSERT INTO Undergoes VALUES (1001, 1, 5001, '2023-05-01 09:00:00', 2, 102);
INSERT INTO Undergoes VALUES (1002, 1, 5002, '2023-05-02 10:00:00', 3, 103);
INSERT INTO Undergoes VALUES (1003, 1, 5003, '2023-05-03 11:00:00', 2, 102);
INSERT INTO Undergoes VALUES (1004, 1, 5001, '2023-05-04 12:00:00', 1, 101);
INSERT INTO Undergoes VALUES (1005, 1, 5002, '2023-05-05 13:00:00', 4, 104);

-- Procedure 2 repeated 3 times
INSERT INTO Undergoes VALUES (1001, 2, 5001, '2023-05-06 10:30:00', 3, 102);
INSERT INTO Undergoes VALUES (1002, 2, 5003, '2023-05-07 10:45:00', 4, 104);
INSERT INTO Undergoes VALUES (1003, 2, 5001, '2023-05-08 11:00:00', 5, NULL);

-- Procedure 3 repeated 2 times
INSERT INTO Undergoes VALUES (1006, 3, 5003, '2023-05-09 09:00:00', 1, 101);
INSERT INTO Undergoes VALUES (1007, 3, 5002, '2023-05-10 14:00:00', 2, NULL);

-- Procedure 4 once
INSERT INTO Undergoes VALUES (1008, 4, 5001, '2023-05-11 08:30:00', 3, 103);

-- Procedure 5 once
INSERT INTO Undergoes VALUES (1001, 5, 5003, '2023-05-12 15:30:00', 4, NULL);



INSERT INTO Prescribes VALUES (1, 1001, 1, '2023-05-01 10:00:00', 2001, '500mg');
INSERT INTO Prescribes VALUES (2, 1002, 1, '2023-05-02 10:00:00', 2002, '500mg');
INSERT INTO Prescribes VALUES (3, 1003, 1, '2023-05-03 10:00:00', 2003, '500mg');
INSERT INTO Prescribes VALUES (1, 1004, 1, '2023-05-04 10:00:00', 2004, '500mg');
INSERT INTO Prescribes VALUES (2, 1005, 1, '2023-05-05 10:00:00', NULL, '500mg');

INSERT INTO Prescribes VALUES (3, 1001, 2, '2023-05-06 10:00:00', 2001, '200mg');
INSERT INTO Prescribes VALUES (4, 1002, 2, '2023-05-07 10:00:00', NULL, '200mg');
INSERT INTO Prescribes VALUES (5, 1003, 2, '2023-05-08 10:00:00', 2002, '200mg');

INSERT INTO Prescribes VALUES (1, 1006, 5, '2023-05-09 10:00:00', 2003, '50mg');
INSERT INTO Prescribes VALUES (2, 1001, 5, '2023-05-10 10:00:00', NULL, '50mg');

SELECT* FROM Prescribes;
