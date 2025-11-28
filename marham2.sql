CREATE DATABASE marham2;
USE marham2;

-- ============================================
-- ADMIN TABLE
-- ============================================
CREATE TABLE admin (
    admin_id INT IDENTITY(1,1) PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT GETDATE()
);

INSERT INTO admin (username, password) 
VALUES ('wajahat', '1234');

-- ============================================
-- SPECIALIZATIONS
-- ============================================
CREATE TABLE specializations (
    specialization_id INT IDENTITY(1,1) PRIMARY KEY,
    specialization_name VARCHAR(100) NOT NULL UNIQUE,
    description VARCHAR(255)
);

INSERT INTO specializations (specialization_name, description) VALUES
('Cardiology', 'Heart and cardiovascular system'),
('Pediatrics', 'Children and adolescents'),
('Orthopedics', 'Bones, joints, and muscles'),
('Dermatology', 'Skin conditions'),
('Neurology', 'Nervous system and brain'),
('General Physician', 'General medical care'),
('Emergency Medicine', 'Emergency care specialist');

-- ============================================
-- UNIFIED DOCTORS TABLE
-- ============================================
CREATE TABLE doctors (
    doctor_id INT IDENTITY(100,1) PRIMARY KEY,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    doctor_type VARCHAR(20) NOT NULL CHECK (doctor_type IN ('Regular', 'Emergency')),
    specialization_id INT NOT NULL,
    consultation_fee DECIMAL(10,2) NOT NULL DEFAULT 0,
    experience_years INT NOT NULL,
    registration_number VARCHAR(50) UNIQUE,
    created_at DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_doctors_specializations FOREIGN KEY (specialization_id) 
        REFERENCES specializations(specialization_id)
);

-- ============================================
-- PATIENTS
-- ============================================
CREATE TABLE patients (
    patient_id INT IDENTITY(1000,1) PRIMARY KEY,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    gender VARCHAR(10),
    blood_group VARCHAR(10), -- A+, A-, B+, B-, AB+, AB-, O+, O-
    created_at DATETIME DEFAULT GETDATE()
);

-- ============================================
-- RECEPTIONISTS
-- ============================================
CREATE TABLE receptionists (
    receptionist_id INT IDENTITY(1,1) PRIMARY KEY,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(100) NOT NULL,
    created_at DATETIME DEFAULT GETDATE()
);

-- ============================================
-- AUTHENTICATION LOGS
-- ============================================
CREATE TABLE signin_logs (
    log_id INT IDENTITY(1,1) PRIMARY KEY,
    user_type VARCHAR(20) NOT NULL CHECK (user_type IN ('Admin', 'Doctor', 'Patient', 'Receptionist')),
    user_id INT NOT NULL,
    signin_datetime DATETIME DEFAULT GETDATE(),
    signin_status VARCHAR(20) DEFAULT 'Success' CHECK (signin_status IN ('Success', 'Failed'))
);

CREATE TABLE signup_logs (
    signup_log_id INT IDENTITY(1,1) PRIMARY KEY,
    patient_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    signup_datetime DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_signup_patient FOREIGN KEY (patient_id) 
        REFERENCES patients(patient_id)
);

-- ============================================
-- TIME SLOTS (30-minute slots for Regular doctors)
-- ============================================
CREATE TABLE time_slots (
    slot_id INT IDENTITY(1,1) PRIMARY KEY,
    slot_number INT NOT NULL UNIQUE,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL
);

INSERT INTO time_slots (slot_number, start_time, end_time) VALUES
(1, '06:00', '06:30'), (2, '06:30', '07:00'),
(3, '07:00', '07:30'), (4, '07:30', '08:00'),
(5, '08:00', '08:30'), (6, '08:30', '09:00'),
(7, '09:00', '09:30'), (8, '09:30', '10:00'),
(9, '10:00', '10:30'), (10, '10:30', '11:00'),
(11, '11:00', '11:30'), (12, '11:30', '12:00'),
(13, '12:00', '12:30'), (14, '12:30', '13:00'),
(15, '13:00', '13:30'), (16, '13:30', '14:00'),
(17, '14:00', '14:30'), (18, '14:30', '15:00'),
(19, '15:00', '15:30'), (20, '15:30', '16:00'),
(21, '16:00', '16:30'), (22, '16:30', '17:00'),
(23, '17:00', '17:30'), (24, '17:30', '18:00');

-- ============================================
-- TIME BLOCKS (3-hour blocks for Emergency doctors)
-- ============================================
CREATE TABLE time_blocks (
    block_id INT IDENTITY(1,1) PRIMARY KEY,
    block_name VARCHAR(50) NOT NULL UNIQUE,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL
);

INSERT INTO time_blocks (block_name, start_time, end_time) VALUES
('Morning Block 1', '06:00', '09:00'),
('Morning Block 2', '09:00', '12:00'),
('Afternoon Block 1', '12:00', '15:00'),
('Afternoon Block 2', '15:00', '18:00'),
('Evening Block', '18:00', '21:00'),
('Night Block', '21:00', '00:00');

-- ============================================
-- DOCTOR SCHEDULES (Unified)
-- ============================================
CREATE TABLE doctor_schedules (
    schedule_id INT IDENTITY(1,1) PRIMARY KEY,
    doctor_id INT NOT NULL,
    day_of_week TINYINT NOT NULL, -- 0=Sunday, 1=Monday, etc.
    slot_id INT NULL, -- For Regular doctors
    block_id INT NULL, -- For Emergency doctors
    CONSTRAINT FK_schedule_doctor FOREIGN KEY (doctor_id) 
        REFERENCES doctors(doctor_id),
    CONSTRAINT FK_schedule_slot FOREIGN KEY (slot_id) 
        REFERENCES time_slots(slot_id),
    CONSTRAINT FK_schedule_block FOREIGN KEY (block_id) 
        REFERENCES time_blocks(block_id),
    CONSTRAINT CHK_slot_or_block CHECK (
        (slot_id IS NOT NULL AND block_id IS NULL) OR 
        (slot_id IS NULL AND block_id IS NOT NULL)
    ),
    CONSTRAINT UQ_doctor_day_slot UNIQUE (doctor_id, day_of_week, slot_id),
    CONSTRAINT UQ_doctor_day_block UNIQUE (doctor_id, day_of_week, block_id)
);

-- ============================================
-- ROOMS & FACILITIES
-- ============================================
CREATE TABLE room_types (
    room_type_id INT IDENTITY(1,1) PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(255)
);

INSERT INTO room_types (type_name, description) VALUES
('General', 'General admission room'),
('Emergency', 'Emergency room'),
('ICU', 'Intensive Care Unit'),
('Private', 'Private room');

CREATE TABLE rooms (
    room_id INT IDENTITY(1,1) PRIMARY KEY,
    room_number VARCHAR(20) NOT NULL UNIQUE,
    room_type_id INT NOT NULL,
    floor_number INT DEFAULT 1,
    total_beds INT DEFAULT 1,
    available_beds INT DEFAULT 1,
    CONSTRAINT FK_room_type FOREIGN KEY (room_type_id) 
        REFERENCES room_types(room_type_id),
    CONSTRAINT CHK_beds CHECK (available_beds <= total_beds AND available_beds >= 0)
);

-- ============================================
-- APPOINTMENT STATUSES
-- ============================================
CREATE TABLE appointment_statuses (
    status_id INT IDENTITY(1,1) PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL UNIQUE
);

INSERT INTO appointment_statuses (status_name) VALUES
('Scheduled'), ('Completed'), ('Cancelled');

-- ============================================
-- APPOINTMENTS (Unified for both doctor types)
-- ============================================
CREATE TABLE appointments (
    appointment_id INT IDENTITY(1,1) PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATE NOT NULL,
    slot_id INT NULL, -- For Regular doctor appointments
    appointment_datetime DATETIME NULL, -- For Emergency doctor walk-ins
    status_id INT DEFAULT 1,
    booked_by_type VARCHAR(20) NOT NULL CHECK (booked_by_type IN ('Patient', 'Receptionist')),
    booked_by_id INT NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_appt_patient FOREIGN KEY (patient_id) 
        REFERENCES patients(patient_id),
    CONSTRAINT FK_appt_doctor FOREIGN KEY (doctor_id) 
        REFERENCES doctors(doctor_id),
    CONSTRAINT FK_appt_slot FOREIGN KEY (slot_id) 
        REFERENCES time_slots(slot_id),
    CONSTRAINT FK_appt_status FOREIGN KEY (status_id) 
        REFERENCES appointment_statuses(status_id),
    CONSTRAINT CHK_slot_or_datetime CHECK (
        (slot_id IS NOT NULL AND appointment_datetime IS NULL) OR 
        (slot_id IS NULL AND appointment_datetime IS NOT NULL)
    ),
    CONSTRAINT UQ_doctor_date_slot UNIQUE (doctor_id, appointment_date, slot_id)
);

-- ============================================
-- APPOINTMENT FORMS (Pre-consultation details)
-- ============================================
CREATE TABLE appointment_forms (
    form_id INT IDENTITY(1,1) PRIMARY KEY,
    appointment_id INT NOT NULL,
    patient_name VARCHAR(100) NOT NULL,
    patient_age INT NOT NULL,
    patient_gender VARCHAR(10) NOT NULL,
    chief_complaint VARCHAR(500) NOT NULL,
    symptoms VARCHAR(1000),
    medical_history VARCHAR(1000),
    allergies VARCHAR(500),
    current_medications VARCHAR(500),
    created_at DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_form_appointment FOREIGN KEY (appointment_id) 
        REFERENCES appointments(appointment_id)
);

-- ============================================
-- CONSULTATIONS
-- ============================================
CREATE TABLE consultations (
    consultation_id INT IDENTITY(1,1) PRIMARY KEY,
    appointment_id INT NOT NULL,
    doctor_id INT NOT NULL,
    patient_id INT NOT NULL,
    examination_notes VARCHAR(1000),
    diagnosis VARCHAR(500),
    treatment_plan VARCHAR(1000),
    consultation_date DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_cons_appointment FOREIGN KEY (appointment_id) 
        REFERENCES appointments(appointment_id),
    CONSTRAINT FK_cons_doctor FOREIGN KEY (doctor_id) 
        REFERENCES doctors(doctor_id),
    CONSTRAINT FK_cons_patient FOREIGN KEY (patient_id) 
        REFERENCES patients(patient_id)
);

-- ============================================
-- VITALS (Recorded during consultation)
-- ============================================
CREATE TABLE vitals (
    vital_id INT IDENTITY(1,1) PRIMARY KEY,
    consultation_id INT NOT NULL,
    blood_pressure VARCHAR(20), -- e.g., "120/80"
    pulse_rate INT, -- beats per minute
    temperature DECIMAL(4,2), -- in Fahrenheit or Celsius
    respiratory_rate INT, -- breaths per minute
    oxygen_saturation INT, -- percentage
    weight DECIMAL(5,2), -- in kg
    height DECIMAL(5,2), -- in cm
    recorded_at DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_vitals_consultation FOREIGN KEY (consultation_id) 
        REFERENCES consultations(consultation_id)
);

-- ============================================
-- PRESCRIPTIONS
-- ============================================
CREATE TABLE prescriptions (
    prescription_id INT IDENTITY(1,1) PRIMARY KEY,
    consultation_id INT NOT NULL,
    medicine_name VARCHAR(200) NOT NULL,
    dosage VARCHAR(100),
    frequency VARCHAR(100),
    duration VARCHAR(100),
    instructions VARCHAR(500),
    CONSTRAINT FK_presc_cons FOREIGN KEY (consultation_id) 
        REFERENCES consultations(consultation_id)
);

-- ============================================
-- CONSULTATION ACTIONS (Checkboxes)
-- ============================================
CREATE TABLE action_types (
    action_type_id INT IDENTITY(1,1) PRIMARY KEY,
    action_name VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(255)
);

INSERT INTO action_types (action_name, description) VALUES
('X-Ray', 'X-Ray imaging required'),
('Blood Test', 'Blood test required'),
('Ultrasound', 'Ultrasound imaging required'),
('CT Scan', 'CT scan required'),
('MRI', 'MRI scan required'),
('Observation', 'Patient needs observation'),
('Admission', 'Patient needs admission');

CREATE TABLE consultation_actions (
    action_id INT IDENTITY(1,1) PRIMARY KEY,
    consultation_id INT NOT NULL,
    action_type_id INT NOT NULL,
    status VARCHAR(20) DEFAULT 'Pending' CHECK (status IN ('Pending', 'Completed', 'Cancelled')),
    assigned_by_receptionist_id INT NULL, -- Receptionist who handled it
    room_id INT NULL, -- If action requires room (observation/admission)
    notes VARCHAR(500),
    created_at DATETIME DEFAULT GETDATE(),
    completed_at DATETIME NULL,
    CONSTRAINT FK_ca_consultation FOREIGN KEY (consultation_id) 
        REFERENCES consultations(consultation_id),
    CONSTRAINT FK_ca_action_type FOREIGN KEY (action_type_id) 
        REFERENCES action_types(action_type_id),
    CONSTRAINT FK_ca_receptionist FOREIGN KEY (assigned_by_receptionist_id) 
        REFERENCES receptionists(receptionist_id),
    CONSTRAINT FK_ca_room FOREIGN KEY (room_id) 
        REFERENCES rooms(room_id)
);

-- ============================================
-- ADMISSIONS (Triggered only when "Admission" action is checked)
-- ============================================
CREATE TABLE admissions (
    admission_id INT IDENTITY(1,1) PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    consultation_id INT NOT NULL,
    action_id INT NOT NULL, -- Links to the admission action
    room_id INT NOT NULL,
    admission_date DATETIME DEFAULT GETDATE(),
    discharge_date DATETIME NULL,
    status VARCHAR(20) DEFAULT 'Admitted' CHECK (status IN ('Admitted', 'Discharged')),
    discharge_notes VARCHAR(500),
    assigned_by_receptionist_id INT NOT NULL,
    CONSTRAINT FK_adm_patient FOREIGN KEY (patient_id) 
        REFERENCES patients(patient_id),
    CONSTRAINT FK_adm_doctor FOREIGN KEY (doctor_id) 
        REFERENCES doctors(doctor_id),
    CONSTRAINT FK_adm_consultation FOREIGN KEY (consultation_id) 
        REFERENCES consultations(consultation_id),
    CONSTRAINT FK_adm_action FOREIGN KEY (action_id) 
        REFERENCES consultation_actions(action_id),
    CONSTRAINT FK_adm_room FOREIGN KEY (room_id) 
        REFERENCES rooms(room_id),
    CONSTRAINT FK_adm_receptionist FOREIGN KEY (assigned_by_receptionist_id) 
        REFERENCES receptionists(receptionist_id)
);

-- ============================================
-- DATABASE VIEWS
-- ============================================

-- View 1: Available Doctors with Schedule (For Patient Booking)
GO
CREATE VIEW vw_available_doctors AS
SELECT 
    d.doctor_id,
    d.name AS doctor_name,
    d.doctor_type,
    d.consultation_fee,
    d.experience_years,
    s.specialization_name,
    ds.day_of_week,
    CASE 
        WHEN d.doctor_type = 'Regular' THEN CONCAT(ts.start_time, ' - ', ts.end_time)
        WHEN d.doctor_type = 'Emergency' THEN tb.block_name
    END AS available_time,
    CASE 
        WHEN d.doctor_type = 'Regular' THEN ts.slot_id
        ELSE NULL
    END AS slot_id,
    CASE 
        WHEN d.doctor_type = 'Emergency' THEN tb.block_id
        ELSE NULL
    END AS block_id
FROM doctors d
INNER JOIN specializations s ON d.specialization_id = s.specialization_id
INNER JOIN doctor_schedules ds ON d.doctor_id = ds.doctor_id
LEFT JOIN time_slots ts ON ds.slot_id = ts.slot_id
LEFT JOIN time_blocks tb ON ds.block_id = tb.block_id;
GO

-- View 2: Patient Appointment History
GO
CREATE VIEW vw_patient_appointments AS
SELECT 
    p.patient_id,
    p.name AS patient_name,
    a.appointment_id,
    a.appointment_date,
    CASE 
        WHEN a.slot_id IS NOT NULL THEN CONCAT(ts.start_time, ' - ', ts.end_time)
        ELSE CONVERT(VARCHAR, a.appointment_datetime, 120)
    END AS appointment_time,
    d.name AS doctor_name,
    d.doctor_type,
    s.specialization_name,
    ast.status_name,
    af.chief_complaint,
    af.symptoms
FROM patients p
INNER JOIN appointments a ON p.patient_id = a.patient_id
INNER JOIN doctors d ON a.doctor_id = d.doctor_id
INNER JOIN specializations s ON d.specialization_id = s.specialization_id
INNER JOIN appointment_statuses ast ON a.status_id = ast.status_id
LEFT JOIN time_slots ts ON a.slot_id = ts.slot_id
LEFT JOIN appointment_forms af ON a.appointment_id = af.appointment_id;
GO

-- View 3: Doctor's Today Appointments (For Doctor Dashboard)
GO
CREATE VIEW vw_doctor_today_appointments AS
SELECT 
    d.doctor_id,
    d.name AS doctor_name,
    a.appointment_id,
    p.patient_id,
    p.name AS patient_name,
    p.age AS patient_age,
    p.gender AS patient_gender,
    p.blood_group,
    a.appointment_date,
    CASE 
        WHEN a.slot_id IS NOT NULL THEN CONCAT(ts.start_time, ' - ', ts.end_time)
        ELSE CONVERT(VARCHAR, a.appointment_datetime, 120)
    END AS appointment_time,
    ast.status_name,
    af.chief_complaint,
    af.symptoms,
    af.medical_history,
    af.allergies,
    af.current_medications
FROM doctors d
INNER JOIN appointments a ON d.doctor_id = a.doctor_id
INNER JOIN patients p ON a.patient_id = p.patient_id
INNER JOIN appointment_statuses ast ON a.status_id = ast.status_id
LEFT JOIN time_slots ts ON a.slot_id = ts.slot_id
LEFT JOIN appointment_forms af ON a.appointment_id = af.appointment_id
WHERE a.appointment_date = CAST(GETDATE() AS DATE);
GO

-- View 4: Complete Consultation Report (For Doctor/Records)
GO
CREATE VIEW vw_consultation_reports AS
SELECT 
    c.consultation_id,
    c.consultation_date,
    p.patient_id,
    p.name AS patient_name,
    p.age AS patient_age,
    p.gender AS patient_gender,
    d.doctor_id,
    d.name AS doctor_name,
    s.specialization_name,
    af.chief_complaint,
    af.symptoms AS initial_symptoms,
    v.blood_pressure,
    v.pulse_rate,
    v.temperature,
    v.respiratory_rate,
    v.oxygen_saturation,
    v.weight,
    v.height,
    c.examination_notes,
    c.diagnosis,
    c.treatment_plan
FROM consultations c
INNER JOIN patients p ON c.patient_id = p.patient_id
INNER JOIN doctors d ON c.doctor_id = d.doctor_id
INNER JOIN specializations s ON d.specialization_id = s.specialization_id
INNER JOIN appointments a ON c.appointment_id = a.appointment_id
LEFT JOIN appointment_forms af ON a.appointment_id = af.appointment_id
LEFT JOIN vitals v ON c.consultation_id = v.consultation_id;
GO

-- View 5: Pending Actions for Receptionist
GO
CREATE VIEW vw_pending_actions AS
SELECT 
    ca.action_id,
    ca.created_at,
    p.patient_id,
    p.name AS patient_name,
    d.name AS doctor_name,
    at.action_name,
    at.description AS action_description,
    ca.status,
    ca.notes,
    c.consultation_id,
    CASE 
        WHEN at.action_name IN ('Observation', 'Admission') THEN 'Room Required'
        ELSE 'No Room Needed'
    END AS room_requirement
FROM consultation_actions ca
INNER JOIN action_types at ON ca.action_type_id = at.action_type_id
INNER JOIN consultations c ON ca.consultation_id = c.consultation_id
INNER JOIN patients p ON c.patient_id = p.patient_id
INNER JOIN doctors d ON c.doctor_id = d.doctor_id
WHERE ca.status = 'Pending';
GO

-- View 6: Room Occupancy Status
GO
CREATE VIEW vw_room_status AS
SELECT 
    r.room_id,
    r.room_number,
    rt.type_name AS room_type,
    r.floor_number,
    r.total_beds,
    r.available_beds,
    (r.total_beds - r.available_beds) AS occupied_beds,
    CASE 
        WHEN r.available_beds = 0 THEN 'Full'
        WHEN r.available_beds = r.total_beds THEN 'Empty'
        ELSE 'Partially Occupied'
    END AS occupancy_status
FROM rooms r
INNER JOIN room_types rt ON r.room_type_id = rt.room_type_id;
GO

-- View 7: Current Admissions
GO
CREATE VIEW vw_current_admissions AS
SELECT 
    adm.admission_id,
    adm.admission_date,
    p.patient_id,
    p.name AS patient_name,
    p.age AS patient_age,
    p.gender,
    d.name AS doctor_name,
    s.specialization_name,
    r.room_number,
    rt.type_name AS room_type,
    rec.name AS assigned_by_receptionist,
    adm.status,
    DATEDIFF(DAY, adm.admission_date, GETDATE()) AS days_admitted
FROM admissions adm
INNER JOIN patients p ON adm.patient_id = p.patient_id
INNER JOIN doctors d ON adm.doctor_id = d.doctor_id
INNER JOIN specializations s ON d.specialization_id = s.specialization_id
INNER JOIN rooms r ON adm.room_id = r.room_id
INNER JOIN room_types rt ON r.room_type_id = rt.room_type_id
INNER JOIN receptionists rec ON adm.assigned_by_receptionist_id = rec.receptionist_id
WHERE adm.status = 'Admitted';
GO

-- View 8: Doctor Statistics
GO
CREATE VIEW vw_doctor_statistics AS
SELECT 
    d.doctor_id,
    d.name AS doctor_name,
    d.doctor_type,
    s.specialization_name,
    COUNT(DISTINCT a.appointment_id) AS total_appointments,
    COUNT(DISTINCT CASE WHEN ast.status_name = 'Completed' THEN a.appointment_id END) AS completed_appointments,
    COUNT(DISTINCT CASE WHEN ast.status_name = 'Cancelled' THEN a.appointment_id END) AS cancelled_appointments,
    COUNT(DISTINCT c.consultation_id) AS total_consultations,
    SUM(d.consultation_fee) AS total_revenue
FROM doctors d
INNER JOIN specializations s ON d.specialization_id = s.specialization_id
LEFT JOIN appointments a ON d.doctor_id = a.doctor_id
LEFT JOIN appointment_statuses ast ON a.status_id = ast.status_id
LEFT JOIN consultations c ON d.doctor_id = c.doctor_id
GROUP BY d.doctor_id, d.name, d.doctor_type, s.specialization_name;
GO