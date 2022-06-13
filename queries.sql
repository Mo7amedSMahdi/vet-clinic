/*Queries that provide answers to the questions from all projects.*/

-- Find all animals whose name ends in "mon".
SELECT * from animals WHERE name LIKE '%mon%';

-- List the name of all animals born between 2016 and 2019.
SELECT name from animals WHERE date_of_birth BETWEEN '2016-1-1' AND '2019-12-31';

-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT name from animals WHERE neutered is true and escape_attempts < 3;

-- List date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth from animals WHERE name LIKE 'Agumon' OR name LIKE 'Pikachu';

-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts from animals WHERE weight_kg > 10.5;

-- Find all animals that are neutered.
SELECT * from animals WHERE neutered is true;

-- Find all animals not named Gabumon.
SELECT * from animals WHERE name NOT LIKE 'Gabumon';

-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * from animals WHERE weight_kg >= 10.5 AND weight_kg <= 17.3;

-- Inside a transaction update the animals table by setting the species column to unspecified. Verify that change was made. Then roll back the change and verify that species columns went back to the state before transaction.
BEGIN;
UPDATE animals SET species = 'unspecified';
ROLLBACK;
-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon%';
UPDATE animals SET species = 'pokemon' WHERE species is null;
COMMIT;

-- delete all records in the animals table, then roll back the transaction.
BEGIN;
DELETE FROM animals;
ROLLBACK;

-- Delete all animals born after Jan 1st, 2022.
-- Create a savepoint for the transaction.
-- Update all animals' weight to be their weight multiplied by -1.
-- Rollback to the savepoint
-- Update all animals' weights that are negative to be their weight multiplied by -1.
-- Commit transaction
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-1-1';
SAVEPOINT animals_deleted;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO animals_deleted;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

-- How many animals are there?
SELECT COUNT(*) FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, MAX(escape_attempts) FROM animals GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-1-1' AND '2000-12-31' GROUP BY species;

-- Insert the following data into the owners table
BEGIN;
INSERT INTO "owners" ("id", "full_name", "age") VALUES (1, 'Sam Smith', 34);
INSERT INTO "owners" ("id", "full_name", "age") VALUES (2, 'Jennifer Orwell', 19);
INSERT INTO "owners" ("id", "full_name", "age") VALUES (3, 'Bob', 45);
INSERT INTO "owners" ("id", "full_name", "age") VALUES (5, 'Dean Winchester', 14);
INSERT INTO "owners" ("id", "full_name", "age") VALUES (4, 'Melody Pond', 77);
INSERT INTO "owners" ("id", "full_name", "age") VALUES (6, 'Jodie Whittaker ', 38);
COMMIT;

-- Modify your inserted animals so it includes the species_id value:
-- If the name ends in "mon" it will be Digimon
-- All other animals are Pokemon
BEGIN;
UPDATE animals SET species_id = 2 WHERE name LIKE '%mon%';
UPDATE animals SET species_id = 1 WHERE species_id is null;
COMMIT;

-- Modify your inserted animals to include owner information (owner_id):
-- Sam Smith owns Agumon.
-- Jennifer Orwell owns Gabumon and Pikachu.
-- Bob owns Devimon and Plantmon.
-- Melody Pond owns Charmander, Squirtle, and Blossom.
-- Dean Winchester owns Angemon and Boarmon.
BEGIN;
UPDATE animals SET owner_id = 1 WHERE name LIKE 'Agumon';
UPDATE animals SET owner_id = 2 WHERE name LIKE 'Gabumon' OR name LIKE 'Pikachu';
UPDATE animals SET owner_id = 3 WHERE name LIKE 'Devimon' OR name LIKE 'Plantmon';
UPDATE animals SET owner_id = 4 WHERE name LIKE 'Charmander' OR name LIKE 'Squirtle' OR name LIKE 'Blossom';
UPDATE animals SET owner_id = 5 WHERE name LIKE 'Angemon' OR name LIKE 'Boarmon';
COMMIT;

-- What animals belong to Melody Pond using join?
SELECT animals.name FROM animals JOIN owners ON owners.id = animals.owner_id WHERE owners."id" = 4;

-- List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name FROM animals JOIN species ON species.id = animals.species_id WHERE species.id = 1;

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT name, full_name FROM animals FULL JOIN owners ON animals.owner_id = owners."id";

-- How many animals are there per species?
SELECT species.name,count(animals."name") FROM animals JOIN species
ON animals.species_id = species."id"
GROUP BY species."id";

-- List all Digimon owned by Jennifer Orwell.
SELECT species."name", animals.name, owners.full_name from animals JOIN species
ON species."id" = animals.species_id
JOIN owners
ON owners."id" = animals.owner_id
WHERE ( animals.owner_id = 2 AND animals.species_id = 2 );

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animals.name from animals
JOIN owners ON owners.id = animals.owner_id
WHERE escape_attempts = 0 AND animals.owner_id = 5;

-- Who owns the most animals?
SELECT owners.full_name, COUNT(animals.name) FROM animals 
JOIN owners ON owners.id = animals.owner_id
GROUP BY owners."id"
ORDER BY count DESC
LIMIT 1;


-- Who was the last animal seen by William Tatcher?
SELECT animals.name,visits.date_of_visit,vets.name FROM animals 
JOIN visits ON visits.animal_id = animals.id 
JOIN vets ON visits.vet_id = vets.id
WHERE vets.id = 1
ORDER BY visits.date_of_visit DESC
LIMIT 1

-- How many different animals did Stephanie Mendez see?
SELECT COUNT(DISTINCT animals.name),vets.name FROM animals
JOIN visits ON visits.animal_id = animals.id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.id = 3
GROUP BY vets.name

-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name AS "Vet Name", species.name AS "Species Name" FROM vets
FULL JOIN specializations ON specializations.vet_id = vets.id
FULL JOIN species ON species."id" = specializations.species_id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name, visits.date_of_visit FROM animals
JOIN visits ON visits.animal_id =animals.id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.id = 3 AND visits.date_of_visit BETWEEN '2020-4-1' AND '2020-8-30';

-- What animal has the most visits to vets?
SELECT COUNT(animals.name), animals.name FROM animals
JOIN visits ON visits.animal_id = animals.id
GROUP BY animals.name
ORDER BY "count" DESC
LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT animals.name AS "Animal Name", visits.date_of_visit FROM animals
JOIN visits ON visits.animal_id = animals.id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.id = 2
ORDER BY visits.date_of_visit ASC
LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT DISTINCT ON(visits.date_of_visit)
 animals.name AS "Animal Name",
animals.weight_kg AS "Animal weight",
animals.escape_attempts AS "Escape Attempts",
vets.name AS "Vet Name",
species.name AS "Vet Specialty",
visits.date_of_visit AS "Date of Visit" FROM visits
 JOIN animals ON animals.id = visits.animal_id
 JOIN vets ON vets.id = visits.vet_id
 JOIN specializations ON specializations.vet_id = vets.id
 JOIN species ON species.id = specializations.species_id
 ORDER BY visits.date_of_visit DESC;

--  How many visits were with a vet that did not specialize in that animal's species?
SELECT vets.name, COUNT(*) FROM visits
JOIN vets ON visits.vet_id = vets.id
LEFT JOIN specializations s ON s.vet_id = visits.vet_id
WHERE s.id IS NULL
GROUP BY vets.name;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT vets.name AS "Vets Name",
  species.name AS "Species name",
  COUNT(species.name)
FROM visits
  JOIN animals ON animals.id = visits.animal_id
  JOIN vets ON vets.id = visits.vet_id
  JOIN species ON species.id = animals.species_id
WHERE vets.name = 'Maisy Smith'
GROUP BY vets.name,
  species.name
ORDER BY COUNT DESC
LIMIT 1;

-- The following queries are taking too much time 
-- (1 sec = 1000ms can be considered as too much time for database query). Try them on your machine to confirm it:
explain analyze SELECT COUNT(*) FROM visits where animal_id = 4