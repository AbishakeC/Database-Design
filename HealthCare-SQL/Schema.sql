
DROP DATABASE IF EXISTS healthCare;
CREATE DATABASE healthCare;
USE healthCare;


CREATE TABLE patients(
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(50) NOT NULL,
    gender ENUM('male','female','others'),
    date_of_birth DATE NOT NULL,
    phone VARCHAR(15) NOT NULL UNIQUE,
    email VARCHAR(100) UNIQUE,
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE doctors(
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(50) NOT NULL,
    gender ENUM('male','female','others'),
    specialization VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL UNIQUE,
    email VARCHAR(100) UNIQUE,
    experience_in_years INT CHECK(experience_in_years >= 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE appointment(
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    status ENUM('Scheduled','completed','cancelled') DEFAULT 'Scheduled',
    reason TEXT,

    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
           ON DELETE CASCADE,

    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
           ON DELETE CASCADE
);


CREATE TABLE prescription(
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL,
    medicine_name VARCHAR(100),
    dosage VARCHAR(100),
    duration_of_days INT,
    notes TEXT,

    FOREIGN KEY (appointment_id) REFERENCES appointment(appointment_id)
            ON DELETE CASCADE
);


CREATE TABLE bills(
    bill_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL,
    consultation_fees DECIMAL(10,2) DEFAULT 0,
    medicine_cost DECIMAL(10,2) DEFAULT 0,
    lab_fees DECIMAL(10,2) DEFAULT 0,
    total_fees DECIMAL(10,2) 
        GENERATED ALWAYS AS (consultation_fees + medicine_cost + lab_fees) STORED,
    payment_status ENUM('paid','pending') DEFAULT 'pending',

    FOREIGN KEY (appointment_id) REFERENCES appointment(appointment_id)
            ON DELETE CASCADE
);


CREATE TABLE payments(
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    bill_id INT NOT NULL,
    payment_method ENUM('cash','card','UPI'),
    amount_paid DECIMAL(10,2),
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (bill_id) REFERENCES bills(bill_id)
            ON DELETE CASCADE
);


CREATE TABLE lab_report(
    report_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL,
    test_name VARCHAR(100),
    result TEXT,
    reported_date DATE,

    FOREIGN KEY (appointment_id) REFERENCES appointment(appointment_id)
            ON DELETE CASCADE
);

