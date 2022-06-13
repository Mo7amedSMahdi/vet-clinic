/* Populate database with sample data. */

INSERT INTO "public"."animals" ("id", "name", "date_of_birth", "escape_attempts", "neutered", "weight_kg") VALUES (1, 'Agumon', '2020-3-2', 0, 't', 10.23);
INSERT INTO "public"."animals" ("id", "name", "date_of_birth", "escape_attempts", "neutered", "weight_kg") VALUES (2, 'Gabumon', '2018-11-15', 2, 't', 8);
INSERT INTO "public"."animals" ("id", "name", "date_of_birth", "escape_attempts", "neutered", "weight_kg") VALUES (3, 'Pikachu', '2021-7-1', 1, 'f', 15.04);
INSERT INTO "public"."animals" ("id", "name", "date_of_birth", "escape_attempts", "neutered", "weight_kg") VALUES (4, 'Devimon', '2017-12-5', 5, 't', 11);


INSERT INTO "public"."animals" ("id", "name", "date_of_birth", "escape_attempts", "neutered", "weight_kg") VALUES (5, 'Charmander', '2020-2-8', 0, FALSE, -11.00);
INSERT INTO "public"."animals" ("id", "name", "date_of_birth", "escape_attempts", "neutered", "weight_kg") VALUES (6, 'Plantmon', '2021-11-15', 2, TRUE, -5.70);
INSERT INTO "public"."animals" ("id", "name", "date_of_birth", "escape_attempts", "neutered", "weight_kg") VALUES (7, 'Squirtle', '1993-4-2', 3, FALSE, -12.13);
INSERT INTO "public"."animals" ("id", "name", "date_of_birth", "escape_attempts", "neutered", "weight_kg") VALUES (8, 'Angemon', '2005-6-12', 1, TRUE, -45);
INSERT INTO "public"."animals" ("id", "name", "date_of_birth", "escape_attempts", "neutered", "weight_kg") VALUES (9, 'Boarmon', '2005-6-7', 7, TRUE, 20.40);
INSERT INTO "public"."animals" ("id", "name", "date_of_birth", "escape_attempts", "neutered", "weight_kg") VALUES (10, 'Blossom', '1998-10-13', 3, TRUE, 17.00);
INSERT INTO "public"."animals" ("id", "name", "date_of_birth", "escape_attempts", "neutered", "weight_kg") VALUES (11, 'Ditto', '2022-5-14', 4, TRUE, 22.00);

-- Insert the following data into the species table
INSERT INTO "public"."species" ("id", "name") VALUES (1, 'Pokemon');
INSERT INTO "public"."species" ("id", "name") VALUES (2, 'Digimon');

/* Insert the following data into vets table */
INSERT INTO vets ("id", "name", "age", "date_of_graduation") VALUES (1, 'William Tatcher', 45, '2000-04-23');
INSERT INTO vets ("id", "name", "age", "date_of_graduation") VALUES (2, 'Maisy Smith', 26, '2019-01-17');
INSERT INTO vets ("id", "name", "age", "date_of_graduation") VALUES (3, 'Stephanie Mendez', 64, '1981-05-04');
INSERT INTO vets ("id", "name", "age", "date_of_graduation") VALUES (4, 'Jack Harkness', 38, '2008-06-08');

/* Insert the following data into specializations table */
INSERT INTO specializations ("id", "species_id", "vet_id") VALUES (1, 1, 1);
INSERT INTO specializations ("id", "species_id", "vet_id") VALUES (2, 2, 3);
INSERT INTO specializations ("id", "species_id", "vet_id") VALUES (3, 2, 4);

/* Insert the following data into visits */
INSERT INTO visits ("id", "animal_id", "vet_id","date_of_visit") VALUES (1, 1,1, '2020-5-24');
INSERT INTO visits ("id", "animal_id", "vet_id","date_of_visit") VALUES (2, 1,3, '2020-7-22');
INSERT INTO visits ("id", "animal_id", "vet_id","date_of_visit") VALUES (3, 2,4, '2021-2-2');
INSERT INTO visits ("id", "animal_id", "vet_id","date_of_visit") VALUES (4, 3,2, '2020-1-5');
INSERT INTO visits ("id", "animal_id", "vet_id","date_of_visit") VALUES (5, 3,2, '2020-3-8');
INSERT INTO visits ("id", "animal_id", "vet_id","date_of_visit") VALUES (6, 3,2, '2020-5-14');
INSERT INTO visits ("id", "animal_id", "vet_id","date_of_visit") VALUES (7, 4,3, '2021-5-4');
INSERT INTO visits ("id", "animal_id", "vet_id","date_of_visit") VALUES (8, 5,4, '2021-2-24');
INSERT INTO visits ("id", "animal_id", "vet_id","date_of_visit") VALUES (9, 6,2, '2019-12-21');
INSERT INTO visits ("id", "animal_id", "vet_id","date_of_visit") VALUES (10, 6,1, '2020-8-10');
INSERT INTO visits ("id", "animal_id", "vet_id","date_of_visit") VALUES (11, 6,2, '2021-4-7');
INSERT INTO visits ("id", "animal_id", "vet_id","date_of_visit") VALUES (12, 7,3, '2019-9-29');
INSERT INTO visits ("id", "animal_id", "vet_id","date_of_visit") VALUES (13, 8,4, '2020-10-3');
INSERT INTO visits ("id", "animal_id", "vet_id","date_of_visit") VALUES (14, 8,4, '2020-11-4');
INSERT INTO visits ("id", "animal_id", "vet_id","date_of_visit") VALUES (15, 9,2, '2019-1-24');
INSERT INTO visits ("id", "animal_id", "vet_id","date_of_visit") VALUES (16, 9,2, '2019-5-15');
INSERT INTO visits ("id", "animal_id", "vet_id","date_of_visit") VALUES (17, 9,2, '2020-2-27');
INSERT INTO visits ("id", "animal_id", "vet_id","date_of_visit") VALUES (18, 9,2, '2020-8-3');
INSERT INTO visits ("id", "animal_id", "vet_id","date_of_visit") VALUES (19, 10,3, '2020-5-24');
INSERT INTO visits ("id", "animal_id", "vet_id","date_of_visit") VALUES (20, 10,1, '2021-1-11');

-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animal_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';
