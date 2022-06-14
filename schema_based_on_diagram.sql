CREATE TABLE patients (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    date_of_birth DATE
);

CREATE TABLE medical_history (
    id SERIAL PRIMARY KEY,
    admitted_date timestamp(6),
    patient_id int4,
    status varchar(100),
    CONSTRAINT "patient_id" FOREIGN KEY ("patient_id") REFERENCES "public"."patients" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE invoices (
    id SERIAL PRIMARY KEY,
    total_amount decimal(10,2),
    generated_at timestamp(6),
    payed_at timestamp(6),
    medical_history_id int4,
    CONSTRAINT "medical_history_id" FOREIGN KEY ("medical_history_id") REFERENCES "public"."medical_history" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE treatments (
    id SERIAL PRIMARY KEY,
    type varchar(100),
    name varchar(100)
);

CREATE TABLE invoice_items (
    id SERIAL PRIMARY KEY,
    unit_price decimal(10,2),
    quantity int4,
    total_price decimal(10,2),
    invoice_id int4,
    treatment_id int4,
    CONSTRAINT invoice_id FOREIGN KEY ("invoice_id") REFERENCES "public"."invoices" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT treatment_id FOREIGN KEY ("treatment_id") REFERENCES "public"."treatments" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE medical_treatment (
    id SERIAL PRIMARY KEY,
    medical_id INT,
    treatment_id INT,
    CONSTRAINT fk_medical_history FOREIGN KEY("medical_id") REFERENCES "public"."medical_histories"("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT fk_medical_treatment FOREIGN KEY("treatment_id") REFERENCES "public"."treatments"("id") ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- Optimized Execution analysis by creating Indexes
CREATE INDEX treatment_id_asc ON invoice_items (treatment_id ASC);
CREATE INDEX invoices_asc ON invoice_items (invoice_id ASC);
CREATE INDEX patients_asc ON medical_histories (patient_id ASC);
CREATE INDEX medical_histories_id_asc ON invoices (medical_histories_id ASC);