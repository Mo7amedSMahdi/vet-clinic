/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT,
    name VARCHAR(100),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL
);

--  Add species column to animal table 
ALTER TABLE public.animals ADD COLUMN species VARCHAR(100);

-- Create a table named owners with the following columns.

CREATE TABLE owners (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100),
    age INT
);

-- Create a table named species with the following columns
CREATE TABLE species (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100)
);

CREATE SEQUENCE animals_id_seq;

ALTER TABLE public.animals ALTER COLUMN id SET DEFAULT nextval('animals_id_seq');

ALTER SEQUENCE animals_id_seq OWNED BY public.animals.id;

ALTER TABLE "public"."animals" 
  DROP COLUMN "species",
  ADD COLUMN "species_id" int4,
  ADD COLUMN "owner_id" int4,
  ADD CONSTRAINT "species_id" FOREIGN KEY ("species_id") REFERENCES "public"."species" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT "owner_id" FOREIGN KEY ("owner_id") REFERENCES "public"."owners" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;


/* Create a table named vets with the following columns:*/
CREATE TABLE vets (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    date_of_graduation DATE
);

/* specializations TABLE */
CREATE TABLE specializations (
    id SERIAL PRIMARY KEY,
    species_id int4,
    vet_id int4,
    CONSTRAINT "species_id" FOREIGN KEY ("species_id") REFERENCES "public"."species" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT "vet_id" FOREIGN KEY ("vet_id") REFERENCES "public"."vets" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION
);

/* visits table */
CREATE TABLE visits (
    id SERIAL PRIMARY KEY,
    animal_id int4,
    vet_id int4,
    date_of_visit DATE,
    CONSTRAINT "animal_id" FOREIGN KEY ("animal_id") REFERENCES "public"."animals" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT "vet_id" FOREIGN KEY ("vet_id") REFERENCES "public"."vets" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- Add a new column for performance audit
ALTER TABLE owners
ADD COLUMN email VARCHAR(120);

/* visits table index */
CREATE INDEX ON visits(animal_id)
CREATE INDEX ON visits(vet_id DESC)