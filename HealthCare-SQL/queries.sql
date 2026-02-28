--Total Revenue + Paid vs Pending Summary
SELECT 
    COUNT(*) AS total_bills,
    SUM(total_fees) AS total_revenue,
    SUM(CASE WHEN payment_status='paid' THEN total_fees ELSE 0 END) AS paid_amount,
    SUM(CASE WHEN payment_status='pending' THEN total_fees ELSE 0 END) AS pending_amount
FROM bills;




--Doctor Performance Report (Revenue Generated Per Doctor
SELECT 
    d.full_name AS doctor,
    d.specialization,
    COUNT(a.appointment_id) AS total_appointments,
    SUM(b.total_fees) AS total_generated_revenue
FROM doctors d
LEFT JOIN appointment a ON d.doctor_id = a.doctor_id
LEFT JOIN bills b ON a.appointment_id = b.appointment_id
GROUP BY d.doctor_id
ORDER BY total_generated_revenue DESC;


--Patients With Most Visits (Top 5 Frequent Patients)
SELECT 
    p.full_name,
    COUNT(a.appointment_id) AS visit_count
FROM patients p
JOIN appointment a ON p.patient_id = a.patient_id
GROUP BY p.patient_id
ORDER BY visit_count DESC
LIMIT 5;

--Find Patients With Pending Bills
SELECT DISTINCT
    p.full_name,
    b.total_fees,
    b.payment_status
FROM patients p
JOIN appointment a ON p.patient_id = a.patient_id
JOIN bills b ON a.appointment_id = b.appointment_id
WHERE b.payment_status = 'pending';

--Monthly Revenue Report
SELECT 
    MONTH(a.appointment_date) AS month,
    SUM(b.total_fees) AS monthly_revenue
FROM appointment a
JOIN bills b ON a.appointment_id = b.appointment_id
GROUP BY MONTH(a.appointment_date)
ORDER BY month;

--Find Doctors Who Have No Appointments
SELECT d.full_name
FROM doctors d
LEFT JOIN appointment a ON d.doctor_id = a.doctor_id
WHERE a.appointment_id IS NULL;

--Find Highest Paying Patient
SELECT 
    p.full_name,
    SUM(b.total_fees) AS total_paid
FROM patients p
JOIN appointment a ON p.patient_id = a.patient_id
JOIN bills b ON a.appointment_id = b.appointment_id
WHERE b.payment_status = 'paid'
GROUP BY p.patient_id
ORDER BY total_paid DESC
LIMIT 1;


--Find Highest Paying Patient
SELECT 
    p.full_name,
    SUM(b.total_fees) AS total_paid
FROM patients p
JOIN appointment a ON p.patient_id = a.patient_id
JOIN bills b ON a.appointment_id = b.appointment_id
WHERE b.payment_status = 'paid'
GROUP BY p.patient_id
ORDER BY total_paid DESC
LIMIT 1;



--Complete Medical History of a Patient
SELECT 
    p.full_name,
    d.full_name AS doctor,
    a.appointment_date,
    a.reason,
    pr.medicine_name,
    pr.dosage,
    l.test_name,
    l.result
FROM patients p
JOIN appointment a ON p.patient_id = a.patient_id
LEFT JOIN doctors d ON a.doctor_id = d.doctor_id
LEFT JOIN prescription pr ON a.appointment_id = pr.appointment_id
LEFT JOIN lab_report l ON a.appointment_id = l.appointment_id
WHERE p.full_name = 'Divya R';

--Find Average Consultation Fee Per Doctor
SELECT 
    d.full_name,
    AVG(b.consultation_fees) AS avg_fee
FROM doctors d
JOIN appointment a ON d.doctor_id = a.doctor_id
JOIN bills b ON a.appointment_id = b.appointment_id
GROUP BY d.doctor_id;


--Detect Partial Payments (Business Logic)
SELECT 
    b.bill_id,
    b.total_fees,
    IFNULL(SUM(p.amount_paid),0) AS paid_amount,
    (b.total_fees - IFNULL(SUM(p.amount_paid),0)) AS remaining_amount
FROM bills b
LEFT JOIN payments p ON b.bill_id = p.bill_id
GROUP BY b.bill_id;
