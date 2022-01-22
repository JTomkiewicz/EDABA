-------------------------------------------
-- Task #2 Table filling
--
-- Jakub Tomkiewicz
-- Index: 300183
-------------------------------------------

-- Start transaction
SET TRANSACTION NAME 'table_filling';

-------------------------------------------
-- Insert data into languages_dictionary

-- Save point
SAVEPOINT after_lang_dict;

-------------------------------------------
-- Insert data into reviewers_dictionary

-- Save point
SAVEPOINT after_review_dict;

-------------------------------------------
-- Insert data into equipment

-- Save point
SAVEPOINT after_equip;

-------------------------------------------
-- Insert data into employees

-- Save point
SAVEPOINT after_emplo;

-------------------------------------------
-- Insert data into clients

-- Save point
SAVEPOINT after_clients;

-------------------------------------------
-- Insert data into lease_contracts

-- Save point
SAVEPOINT after_lease_contr;

-------------------------------------------
-- Insert data into equipment_rental

-- Save point
SAVEPOINT after_equip_rental;

-------------------------------------------
-- Insert data into contract_opinions

-------------------------------------------
-- Commit transaction
COMMIT;