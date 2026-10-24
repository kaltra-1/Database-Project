-- QUERY 1: List all patients
SELECT * FROM patients;

-- QUERY 2: List all departments
SELECT * FROM departments;

-- QUERY 3: Patients older than 30
SELECT p_name, p_age FROM patients WHERE p_age > 30;

-- QUERY 4: Medicines with low stock
SELECT med_name, med_quantity FROM medicines WHERE med_quantity < 100;

-- QUERY 5: Planned appointments for pacients
SELECT * 
FROM appointments, patients 
WHERE patient_id=p_id and app_status = 'Planned';

-- QUERY 6: Prescriptions for a specific patient
SELECT p.* 
FROM prescriptions p
JOIN patients pt ON p.prescription_p_id = pt.p_id
WHERE pt.p_name LIKE 'Ana%';

-- QUERY 7: Doctors in a specific department
SELECT doc_name FROM doctors WHERE doc_dept_id = (SELECT dept_id FROM departments WHERE dept_name = 'Neurology');

-- QUERY 8: Services priced above 1000
SELECT service_name, service_price FROM services WHERE service_price > 1000;

-- QUERY 9: Medicines with high profit margin
SELECT med_name, med_sales_price - med_purchase_price AS profit FROM medicines WHERE (med_sales_price - med_purchase_price) > 5;

-- QUERY 10: Patients and their respective doctors
SELECT p.p_name, d.doc_name FROM patients p
JOIN doctors d ON p.p_doc_id = d.doc_id;

-- QUERY 11: Prescriptions with medicine and patient names
SELECT pr.prescription_code, m.med_name, pa.p_name FROM prescriptions pr
JOIN prescription_medicines pm ON pr.prescription_id = pm.prescription_id
JOIN medicines m ON pm.prescription_medicine_id = m.med_id
JOIN patients pa ON pr.prescription_p_id = pa.p_id;

-- QUERY 12: Patients with more one registered service
SELECT p.p_name, COUNT(*) AS total_services FROM patient_expenses pe
JOIN patients p ON pe.patient_id = p.p_id
GROUP BY p.p_name HAVING COUNT(*) = 1;

-- QUERY 13: Number of patients per doctor
SELECT d.doc_name, COUNT(p.p_id) AS num_patients FROM doctors d
JOIN patients p ON p.p_doc_id = d.doc_id
GROUP BY d.doc_name;

-- QUERY 14: Prescriptions issued in April 2025
SELECT * FROM prescriptions WHERE prescription_date LIKE '2025-04%';

-- QUERY 15: Change the status of a bed
UPDATE beds SET bed_status = 'Occupied' WHERE bed_name = 'Bed C1';

-- QUERY 16: Update the price of a service
UPDATE services SET service_price = 1800 WHERE service_name = 'Chest X-ray';

-- QUERY 17: Delete a specific appointment
DELETE FROM appointments WHERE app_message = 'Periodic check-up visit';

-- QUERY 18: Patients treated by a doctor his surname finished with kola
SELECT p.p_name, d.doc_name FROM patients p
JOIN doctors d ON p.p_doc_id = d.doc_id
WHERE d.doc_name LIKE '%Kola';

-- QUERY 19: Beds assigned to female patients
SELECT b.bed_name, p.p_name FROM beds b
JOIN patients p ON b.bed_id = p.p_bed_id
WHERE p.p_gender = 'F';

-- QUERY 20: Appointments for patients with symptom 'Cough'
SELECT a.app_date, a.app_status, p.p_name FROM appointments a
JOIN patients p ON a.patient_id = p.p_id
WHERE p.p_symptoms = 'Cough';