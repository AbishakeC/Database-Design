
USE healthCare;

-- Patients
INSERT INTO patients (full_name, gender, date_of_birth, phone, email, address)
VALUES
('Divya R','female','2000-03-22','9876543211','divya@gmail.com','Chennai'),
('Rahul S','male','1995-11-01','9876543212','rahul@gmail.com','Coimbatore'),
('Meena K','female','1992-07-18','9876543213','meena@gmail.com','Salem'),
('Karthik V','male','1999-09-09','9876543214','karthik@gmail.com','Trichy'),
('Anitha P','female','1997-01-15','9876543215','anitha@gmail.com','Erode');

-- Doctors
INSERT INTO doctors (full_name, gender, specialization, phone, email, experience_in_years)
VALUES
('Dr. Ramesh','male','Cardiologist','9000000001','ramesh@gmail.com',10),
('Dr. Sneha','female','Dermatologist','9000000002','sneha@gmail.com',7),
('Dr. Prakash','male','Orthopedic','9000000003','prakash@gmail.com',12);

-- Appointments
INSERT INTO appointment (patient_id, doctor_id, appointment_date, status, reason)
VALUES
(1,1,'2026-02-25 10:00:00','completed','Chest pain'),
(2,2,'2026-02-26 11:00:00','completed','Skin allergy'),
(3,3,'2026-02-27 09:30:00','Scheduled','Fever');

-- Prescriptions
INSERT INTO prescription (appointment_id, medicine_name, dosage, duration_of_days, notes)
VALUES
(1,'Aspirin','1 tablet twice daily',5,'After food'),
(2,'Cetirizine','1 tablet daily',3,'Before sleep');

-- Bills
INSERT INTO bills (appointment_id, consultation_fees, medicine_cost, lab_fees, payment_status)
VALUES
(1,500,200,300,'paid'),
(2,400,150,0,'paid'),
(3,600,250,500,'pending');

-- Payments
INSERT INTO payments (bill_id, payment_method, amount_paid)
VALUES
(1,'UPI',1000),
(2,'card',550);

-- Lab Reports
INSERT INTO lab_report (appointment_id, test_name, result, reported_date)
VALUES
(1,'ECG','Normal','2026-02-25'),
(3,'Blood Test','Mild infection','2026-02-27');


SELECT * FROM patients;