-- Task #3 Triggers
-- Jakub Tomkiewicz
-- Index: 300183

------------------------------------------
-- Trigger #1 UPDATE
-- When lease contract price increases by more than 1000, earnings of employee (that take part is this contract) are increased by trigger by 20

-- create trigger
CREATE OR REPLACE TRIGGER higher_earnings_after_contract_price_increase
AFTER UPDATE ON lease_contracts
FOR EACH ROW
WHEN (NEW.price >= OLD.price + 1000)
BEGIN
  UPDATE employees 
  SET earnings_per_hour =  (SELECT earnings_per_hour + 20 FROM employees WHERE id = :NEW.employee)
  WHERE id = :NEW.employee;
END;

-- price of the contract with id = 1 and earnings_per_hour of employee that take part in it BEFORE update
SELECT lc.id, lc.price, lc.employee, e.earnings_per_hour
FROM lease_contracts lc
INNER JOIN employees e ON e.id = lc.employee
WHERE lc.id = 1;

-- increase the price of the contract by 9999
UPDATE lease_contracts
SET price = (SELECT price + 9999 FROM lease_contracts WHERE id = 1)
WHERE id = 1;

-- price of the contract with id = 1 and earnings_per_hour of employee that take part in it AFTER update
SELECT lc.id, lc.price, lc.employee, e.earnings_per_hour
FROM lease_contracts lc
INNER JOIN employees e ON e.id = lc.employee
WHERE lc.id = 1;

------------------------------------------
-- Trigger #2 DELETE
-- When lease contract is going to be deleted, all associated with it opinions are deleted too

-- create trigger
CREATE OR REPLACE TRIGGER delete_contract_opinions
BEFORE DELETE ON lease_contracts
FOR EACH ROW
BEGIN
  DELETE FROM contract_opinions WHERE contract = :OLD.id;
END;

-- show opionions for contract with id = 4 before delete
SELECT contract, mark, reviewer, comments
FROM contract_opinions
WHERE contract = 4;

-- delete contract with id = 4
DELETE FROM lease_contracts
WHERE id = 4;

-- show opionions for contract with id = 4 after delete
SELECT contract, mark, reviewer, comments
FROM contract_opinions
WHERE contract = 4;

------------------------------------------
-- Trigger #3 INSERT
-- When new employee is added, equipment (if there is piece not used at the moment) is being rented for him automatically 

-- create trigger
CREATE OR REPLACE TRIGGER give_new_employee_equipment
AFTER INSERT ON employees
FOR EACH ROW
DECLARE
free_equip_id number;
BEGIN
  free_equip_id := 
  SELECT id 
  FROM equipment 
  WHERE id NOT IN (
    SELECT UNIQUE equipment 
    FROM equipment_rental 
    WHERE date_of_actual_return IS NOT NULL 
    AND date_of_actual_return < :NEW.date_begin;) 
  ORDER BY id DESC 
  FETCH FIRST 1 ROWS ONLY;

  INSERT INTO equipment_rental VALUES(
    51,
    :NEW.date_begin,
    :NEW.date_begin + 365,
    NULL,
    free_equip_id,
    :NEW.id
  );
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
  TO_DATE('2021-11-11'),
  0
);

-- newest equipment rentals (id DESC)
SELECT id, equipment, employee, date_begin, date_end, date_of_actual_return
FROM equipment_rental
ORDER BY id DESC;

