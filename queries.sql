/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals;
SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-01-01';
SELECT name FROM animals WHERE neutered = TRUE AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = TRUE;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;
BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;
BEGIN;
DELETE FROM animals;
SELECT COUNT(*) FROM animals;
ROLLBACK;
SELECT COUNT(*) FROM animals;
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT delete_young_dog;
UPDATE animals SET weight_kg = weight_kg * -1;
SELECT * FROM animals;
ROLLBACK TO SAVEPOINT delete_young_dog;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;
SELECT * FROM animals;
SELECT COUNT(*) FROM animals;
SELECT COUNT(escape_attempts) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, MAX(escape_attempts) AS max_escape_attempts FROM animals GROUP BY neutered;
SELECT species, MIN(weight_kg) AS minimum_weight, MAX(weight_kg) AS maximum_weight FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) AS average_escape_attempts FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

SELECT
  name AS animal_name,
  full_name AS owner_name
FROM animals
INNER JOIN owners
ON owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';
SELECT
  species.name AS species,
  animals.name AS animal_name
FROM species
INNER JOIN animals
ON species.id = animals.species_id
WHERE species.name = 'Pokemon';
SELECT
  full_name AS owners_name,
  animals.name AS ainmals_name
FROM owners
LEFT JOIN animals
ON owners.id = animals.owner_id;
SELECT
  species.name AS species_name,
  COUNT(animals.name) AS number_of_animals
FROM species
INNER JOIN animals
ON species.id = animals.species_id
GROUP BY species.name;
SELECT
  animals.name AS ainmal_name,
  species.name AS species_name,
  owners.full_name
FROM animals
INNER JOIN owners
ON owner_id = owners.id
INNER JOIN species
ON species_id = species.id
GROUP BY
  species.name,
  animals.name,
  owners.full_name
HAVING
  species.name = 'Digimon'
  AND
  owners.full_name = 'Jennifer Orwell';
SELECT
  animals.name AS ainmal_name,
  escape_attempts,
  owners.full_name
FROM animals
INNER JOIN owners
ON owner_id = owners.id
GROUP BY
  animals.name,
  escape_attempts,
  owners.full_name
HAVING
  escape_attempts = 0
  AND
  owners.full_name = 'Dean Winchester';
SELECT
  full_name ,
  COUNT(name) AS animal_count
FROM owners
INNER JOIN animals
ON owners.id = owner_id
GROUP BY full_name
ORDER BY animal_count DESC;
SELECT
  vets.name AS vets_name,
  animals.name AS animal_name,
  visit_date
FROM visits
INNER JOIN vets
ON vets_id = vets.id
INNER JOIN animals
ON animal_id = animals.id
WHERE vets.name = 'William Tatcher'
ORDER BY visit_date DESC;
SELECT
  vets.name AS vets_name,
  COUNT(animals.name) AS animal_number
FROM visits
INNER JOIN vets
ON vets_id = vets.id
INNER JOIN animals
ON animal_id = animals.id
GROUP BY vets.name
HAVING vets.name = 'Stephanie Mendez';
SELECT
  vets.name AS vets_name,
  species.name AS specialties
FROM vets
LEFT JOIN specializations
ON vets.id = vets_id
LEFT JOIN species
ON species.id = species_id;
SELECT
  vets.name AS vets_name,
  animals.name AS animal_name,
  visit_date
FROM visits
INNER JOIN vets
ON vets_id = vets.id
INNER JOIN animals
ON animal_id = animals.id
WHERE vets.name = 'Stephanie Mendez'
AND visit_date
BETWEEN '2020-04-01' AND '2020-08-30';
SELECT
  animals.name,
  COUNT(visit_date)
FROM visits
INNER JOIN animals
ON animal_id = animals.id
GROUP BY animals.name
ORDER BY COUNT(visit_date) DESC
FETCH FIRST 1 ROW ONLY;
SELECT
  vets.name AS vets_name,
  animals.name AS animal_name,
  visit_date
FROM visits
INNER JOIN animals
ON animal_id = animals.id
INNER JOIN vets
ON vets_id = vets.id
WHERE vets.name = 'Maisy Smith'
ORDER BY visit_date
FETCH FIRST 1 ROW ONLY;
SELECT
  animals.name AS animal_name,
  species.name AS species_name,
  vets.name AS vets_name,
  vets.age AS vets_age,
  vets.date_of_graduation AS vet_date_of_graduation,
  visit_date
FROM visits
INNER JOIN vets
ON visits.vets_id = vets.id
INNER JOIN animals
ON visits.animal_id = animals.id
INNER JOIN species
ON species.id = animals.species_id
ORDER BY visit_date DESC
FETCH FIRST 1 ROW ONLY;
SELECT COUNT(*)
FROM visits
JOIN vets
ON visits.vets_id = vets.id
JOIN animals
ON visits.animal_id = animals.id
LEFT JOIN specializations
ON vets.id = specializations.vets_id
AND animals.species_id = specializations.species_id
WHERE specializations.vets_id IS NULL;
SELECT
  COUNT(*) AS visit_count,
  species.name AS recommended_speciality
FROM visits
JOIN vets
ON visits.vets_id = vets.id
JOIN animals
ON visits.animal_id = animals.id
JOIN species
ON animals.species_id = species.id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name
ORDER BY visit_count DESC
FETCH FIRST 1 ROW ONLY;