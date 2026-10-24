CREATE TABLE appointments (
  app_id INTEGER PRIMARY KEY AUTOINCREMENT CHECK (app_id > 0),
  app_date TEXT NOT NULL,
  app_status TEXT NOT NULL, 
  app_message TEXT NOT NULL,
  patient_id INTEGER NOT NULL,
  FOREIGN KEY (patient_id) REFERENCES patients(p_id)
);

CREATE TABLE beds (
  bed_id INTEGER PRIMARY KEY AUTOINCREMENT CHECK (bed_id > 0),
  bed_name TEXT NOT NULL,
  bed_status TEXT NOT NULL
);

CREATE TABLE departments (
  dept_id INTEGER PRIMARY KEY AUTOINCREMENT CHECK (dept_id > 0),
  dept_name TEXT NOT NULL,
  dept_details TEXT NOT NULL
);

CREATE TABLE doctors (
  doc_id INTEGER PRIMARY KEY AUTOINCREMENT CHECK (doc_id > 0),
  doc_name TEXT NOT NULL,
  doc_phone TEXT NOT NULL,
  doc_address TEXT NOT NULL,
  doc_email TEXT NOT NULL,
  doc_dept_id INTEGER NOT NULL CHECK (doc_dept_id > 0),
  FOREIGN KEY (doc_dept_id) REFERENCES departments(dept_id)
);

CREATE TABLE patients (
  p_id INTEGER PRIMARY KEY AUTOINCREMENT CHECK (p_id > 0),
  p_name TEXT NOT NULL,
  p_gender TEXT NOT NULL,
  p_age INTEGER NOT NULL,
  p_phone TEXT NOT NULL,
  p_height TEXT NOT NULL,
  p_weight TEXT NOT NULL,
  p_symptoms TEXT NOT NULL,
  p_address TEXT NOT NULL,
  p_doc_id INTEGER NOT NULL CHECK (p_doc_id > 0),
  p_bed_id INTEGER NOT NULL CHECK (p_bed_id > 0),
  FOREIGN KEY (p_doc_id) REFERENCES doctors(doc_id),
  FOREIGN KEY (p_bed_id) REFERENCES beds(bed_id)
);

CREATE TABLE medicines (
  med_id INTEGER PRIMARY KEY AUTOINCREMENT CHECK (med_id > 0),
  med_name TEXT NOT NULL,
  med_purchase_price INTEGER NOT NULL,
  med_sales_price INTEGER NOT NULL,
  med_quantity INTEGER NOT NULL
);

CREATE TABLE patient_expenses (
  p_exp_id INTEGER PRIMARY KEY AUTOINCREMENT CHECK (p_exp_id > 0),
  p_service_id INTEGER NOT NULL CHECK (p_service_id > 0),
  patient_id INTEGER NOT NULL,
  FOREIGN KEY (p_service_id) REFERENCES services(service_id),
  FOREIGN KEY (patient_id) REFERENCES patients(p_id)
);

CREATE TABLE prescriptions (
  prescription_id INTEGER PRIMARY KEY AUTOINCREMENT CHECK (prescription_id > 0),
  prescription_code TEXT NOT NULL,
  prescription_p_id INTEGER NOT NULL CHECK (prescription_p_id > 0),
  prescription_history TEXT NOT NULL,
  prescription_note TEXT NOT NULL,
  prescription_date TEXT NOT NULL,
  FOREIGN KEY (prescription_p_id) REFERENCES patients(p_id)
);

CREATE TABLE prescription_medicines (
  prescription_id INTEGER NOT NULL CHECK (prescription_id > 0),
  prescription_medicine_id INTEGER NOT NULL CHECK (prescription_medicine_id > 0),
  prescription_med_dosage TEXT NOT NULL,
  prescription_med_frequency TEXT NOT NULL,
  prescription_med_days TEXT NOT NULL,
  PRIMARY KEY (prescription_id, prescription_medicine_id),
  FOREIGN KEY (prescription_id) REFERENCES prescriptions(prescription_id),
  FOREIGN KEY (prescription_medicine_id) REFERENCES medicines(med_id)
);

CREATE TABLE services (
  service_id INTEGER PRIMARY KEY AUTOINCREMENT CHECK (service_id > 0),
  service_name TEXT NOT NULL,
  service_price INTEGER NOT NULL,
  service_description TEXT NOT NULL,
  service_commission_rate INTEGER NOT NULL
);
