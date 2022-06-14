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
    status varchar(100),
    CONSTRAINT "medical_history_id" FOREIGN KEY ("medical_history_id") REFERENCES "public"."medical_history" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION
);