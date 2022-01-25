-- Task #3 Triggers
-- Jakub Tomkiewicz
-- Index: 300183

------------------------------------------
-- Trigger #1 UPDATE
-- After employee is being marked as archived, their phone number is set to null

-- create trigger
CREATE OR REPLACE TRIGGER telephone_null_after_archive
AFTER UPDATE OF is_archival ON employees
FOR EACH ROW
BEGIN
  IF OLD:is_archival = FALSE AND NEW:is_archival = TRUE THEN
  UPDATE employees SET telephone = NULL WHERE id = NEW:id;
  END IF;
END;

-- telephone number of first 3 employees before update
SELECT id, name, surname, telephone, is_archival FROM employees WHERE id IN (1, 2, 3);

-- move these 3 employees to archival
UPDATE employees SET is_archival = TRUE WHERE id IN (1, 2, 3);

-- telephone number of first 3 employees after update
SELECT id, name, surname, telephone, is_archival FROM employees WHERE id IN (1, 2, 3);

------------------------------------------
-- Trigger #2 INSERT

------------------------------------------
-- Trigger #3 DELETE