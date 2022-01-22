-- Task #2 Table filling
-- Jakub Tomkiewicz
-- Index: 300183

-------------------------------------------
-- Start transaction #1
SET TRANSACTION NAME 'dictionary_filling';

BEGIN
  -- Insert data into languages_dictionary
  FOR i IN 1..15 LOOP
    INSERT INTO languages_dictionary VALUES (
      i,
      DBMS_RANDOM.string('A', DBMS_RANDOM.value(5, 10))
    );
  END LOOP;

  -- Insert data into reviewers_dictionary
  INSERT INTO reviewers_dictionary VALUES (1, 'Admin');
  INSERT INTO reviewers_dictionary VALUES (2, 'Client');
  INSERT INTO reviewers_dictionary VALUES (3, 'Employee');
END;

-- Commit transaction
COMMIT;

-------------------------------------------
-- Start transaction #2
SET TRANSACTION NAME 'client_employees_filling';

BEGIN
  -- Insert data into employees

  -- Insert data into clients
END;

-- Commit transaction
COMMIT;

-------------------------------------------
-- Start transaction #3
SET TRANSACTION NAME 'equipment_filling';

BEGIN
  -- Insert data into equipment

  -- Insert data into equipment_rental
END;

-------------------------------------------
-- Start transaction #4
SET TRANSACTION NAME 'contracts_filling';

BEGIN
-- Insert data into lease_contracts

-- Insert data into contract_opinions
END;

-- Commit transaction
COMMIT;