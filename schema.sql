/* Database schema to keep the structure of entire database. */

CREATE DATABASE vet_clinic;

\c vet_clinic;

CREATE TABLE animals (
    id INT,
    name VARCHAR,
    date_of_birth DATE,
    escape_attempts INT, 
    neutered BOOLEAN,
    weight_kg FLOAT
);

ALTER TABLE animals ADD COLUMN species VARCHAR;

CREATE TABLE owners (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name VARCHAR(255),
    age INT
);

CREATE TABLE species (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(255)
);

ALTER TABLE animals
ALTER COLUMN id SET NOT NULL;

ALTER TABLE animals
ALTER COLUMN id
ADD GENERATED ALWAYS AS IDENTITY
(START WITH 11 INCREMENT 1);

ALTER TABLE animals ADD PRIMARY KEY (id);

ALTER TABLE animals
DROP COLUMN species;

ALTER TABLE animals
ADD COLUMN species_id INT,
ADD CONSTRAINT fk_species
FOREIGN KEY (species_id)
REFERENCES species(id);

ALTER TABLE animals
ADD COLUMN owner_id INT,
ADD CONSTRAINT fk_owner
FOREIGN KEY (owner_id)
REFERENCES owners(id);

CREATE TABLE vets (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(255),
    age INT,
    date_of_graduation DATE
);

CREATE TABLE specializations (
    species_id INT,
    vets_id INT,
    PRIMARY KEY(species_id, vets_id),
    CONSTRAINT fk_species_id FOREIGN KEY (species_id) REFERENCES species(id),
    CONSTRAINT fk_vets01_id FOREIGN KEY (vets_id) REFERENCES vets(id)
);

CREATE TABLE visits (
    animal_id INT,
    vets_id INT,
    visit_date DATE,
    PRIMARY KEY(animal_id, vets_id),
    CONSTRAINT fk_animals FOREIGN KEY (animal_id) REFERENCES animals(id),
    CONSTRAINT fk_vets02_id FOREIGN KEY (vets_id) REFERENCES vets(id)
);
