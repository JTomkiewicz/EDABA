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
    UPDATE employees 
    SET telephone = NULL 
    WHERE id = NEW:id;
  END IF;
END;

-- telephone number of first 3 employees before update
SELECT id, name, surname, telephone, is_archival 
FROM employees 
WHERE id IN (1, 2, 3);

-- move these 3 employees to archival
UPDATE employees 
SET is_archival = TRUE 
WHERE id IN (1, 2, 3);

-- telephone number of first 3 employees after update
SELECT id, name, surname, telephone, is_archival 
FROM employees 
WHERE id IN (1, 2, 3);

------------------------------------------
-- Trigger #2 INSERT
-- When new employee is added, equipment (if there is piece not used at the moment) is being rented for him automaticaly 

-- create trigger
CREATE OR REPLACE TRIGGER give_new_employee_equipment
AFTER INSERT ON employees
FOR EACH ROW
BEGIN
END;

-- newest equipment rentals (id DESC)
SELECT id, equipment, employee, date_begin, date_end, date_of_actual_return
FROM equipment_rental
ORDER BY id DESC;

-- insert new employee into employees
INSERT INTO employees VALUES (
  46,
  'Jakub',
  'Tomkiewicz',
  123456,
  654321,
  'testemail@email.com',
  098765,
  'Street',
  150,
  'Warsaw',
  'Poland',
  '01-234',
  1,
  10,
  TO_DATE('2022-01-25'),
  0
);

-- newest equipment rentals (id DESC)
SELECT id, equipment, employee, date_begin, date_end, date_of_actual_return
FROM equipment_rental
ORDER BY id DESC;

------------------------------------------
-- Trigger #3 DELETE