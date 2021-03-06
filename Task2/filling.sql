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
  FOR i IN 1..45 LOOP
    INSERT INTO employees VALUES (
      i,
      DBMS_RANDOM.string('A', DBMS_RANDOM.value(3, 7)),
      DBMS_RANDOM.string('A', DBMS_RANDOM.value(5, 15)),
      FLOOR(DBMS_RANDOM.value(100000, 999999)),
      FLOOR(DBMS_RANDOM.value(100000, 999999)),
      TO_CHAR(DBMS_RANDOM.string('A', DBMS_RANDOM.value(3, 10)) || '@' || DBMS_RANDOM.string('A', DBMS_RANDOM.value(2, 5)) || '.com'),
      FLOOR(DBMS_RANDOM.value(100000, 999999)),
      DBMS_RANDOM.string('A', DBMS_RANDOM.value(5, 30)),
      FLOOR(DBMS_RANDOM.value(1, 100)),
      DBMS_RANDOM.string('A', DBMS_RANDOM.value(5, 15)),
      DBMS_RANDOM.string('A', DBMS_RANDOM.value(5, 15)),
      TO_CHAR(FLOOR(DBMS_RANDOM.value(10,99)) || '-' || FLOOR(DBMS_RANDOM.value(10,99))),
      FLOOR(DBMS_RANDOM.value(10, 200)),
      FLOOR(DBMS_RANDOM.value(1, 15)),
      TO_DATE(TRUNC(DBMS_RANDOM.value(TO_CHAR(DATE '2010-01-01', 'J'), TO_CHAR(DATE '2021-12-31', 'J'))), 'J'),
      (CASE WHEN DBMS_RANDOM.value(0, 1) > 0.5 THEN 1 ELSE 0 END)
    );
  END LOOP;

  -- Insert data into clients
  FOR i IN 1..20 LOOP
    INSERT INTO clients VALUES (
      i,
      DBMS_RANDOM.string('A', DBMS_RANDOM.value(3, 15)),
      FLOOR(DBMS_RANDOM.value(100, 100000)),
      DBMS_RANDOM.string('A', DBMS_RANDOM.value(5, 30)),
      FLOOR(DBMS_RANDOM.value(1, 100)),
      DBMS_RANDOM.string('A', DBMS_RANDOM.value(5, 15)),
      DBMS_RANDOM.string('A', DBMS_RANDOM.value(5, 15)),
      TO_CHAR(FLOOR(DBMS_RANDOM.value(10,99)) || '-' || FLOOR(DBMS_RANDOM.value(100,999)))
    );
  END LOOP;
END;

-- Commit transaction
COMMIT;

-------------------------------------------
-- Start transaction #3
SET TRANSACTION NAME 'equipment_filling';

BEGIN
  -- Insert data into equipment
  FOR i IN 1..60 LOOP
    INSERT INTO equipment VALUES (
      i,
      DBMS_RANDOM.string('A', DBMS_RANDOM.value(3, 15)),
      DBMS_RANDOM.string('A', DBMS_RANDOM.value(3, 20)),
      DBMS_RANDOM.string('A', DBMS_RANDOM.value(3, 20))
    );
  END LOOP;

  -- Insert data into equipment_rental
  FOR i IN 1..50 LOOP
    INSERT INTO equipment_rental VALUES (
      i,
      TO_DATE(TRUNC(DBMS_RANDOM.value(TO_CHAR(DATE '2010-01-01', 'J'), TO_CHAR(DATE '2015-12-31', 'J'))), 'J'),
      TO_DATE(TRUNC(DBMS_RANDOM.value(TO_CHAR(DATE '2016-01-01', 'J'), TO_CHAR(DATE '2021-12-31', 'J'))), 'J'),
      TO_DATE(TRUNC(DBMS_RANDOM.value(TO_CHAR(DATE '2013-01-01', 'J'), TO_CHAR(DATE '2021-12-31', 'J'))), 'J'),
      FLOOR(DBMS_RANDOM.value(1, 60)),
      FLOOR(DBMS_RANDOM.value(1, 45))
    );
  END LOOP;
END;

-- Commit transaction
COMMIT;

-------------------------------------------
-- Start transaction #4
SET TRANSACTION NAME 'contracts_filling';

BEGIN
  -- Insert data into lease_contracts
  FOR i IN 1..60 LOOP
    INSERT INTO lease_contracts VALUES (
      i,
      FLOOR(DBMS_RANDOM.value(100, 1000000)),
      TO_DATE(TRUNC(DBMS_RANDOM.value(TO_CHAR(DATE '2010-01-01', 'J'), TO_CHAR(DATE '2015-12-31', 'J'))), 'J'),
      TO_DATE(TRUNC(DBMS_RANDOM.value(TO_CHAR(DATE '2016-01-01', 'J'), TO_CHAR(DATE '2021-12-31', 'J'))), 'J'),
      FLOOR(DBMS_RANDOM.value(1, 45)),
      FLOOR(DBMS_RANDOM.value(1, 20))
    );
  END LOOP;

  -- Insert data into contract_opinions
  FOR i IN 1..15 LOOP
    INSERT INTO contract_opinions VALUES (
      FLOOR(DBMS_RANDOM.value(1, 10)),
      DBMS_RANDOM.string('A', DBMS_RANDOM.value(3, 40)),
      FLOOR(DBMS_RANDOM.value(1, 60)),
      FLOOR(DBMS_RANDOM.value(1, 3))
    );
  END LOOP;
END;

-- Commit transaction
COMMIT;