-------------------------------------------
-- Task #2 Queries
--
-- Jakub Tomkiewicz
-- Index: 300183

-------------------------------------------
-- Query #1: id and name of equipment that has never been rented to employees
SELECT e.id, e.name 
FROM equipment e
LEFT JOIN equipment_rental er
  ON e.id = er.equipment
WHERE er.equipment IS NULL
ORDER BY e.id ASC;

-------------------------------------------
-- Query #2: employees that have the biggest earnings per hour
SELECT name || ' ' || surname AS employee, earnings_per_hour 
FROM employees
WHERE earnings_per_hour = (SELECT MAX(earnings_per_hour) FROM employees);

-------------------------------------------
-- Query #3: employees with numbers of contracts that they took place in
SELECT e.name , e.surname, COUNT(lc.employee) AS nr_of_contracts
FROM employees e
INNER JOIN lease_contracts lc
  ON e.id = lc.employee 
GROUP BY e.name, e.surname
ORDER BY nr_of_contracts DESC;

-------------------------------------------
-- Query #4: rounded to 2 decimal places average price of lease contracts
SELECT ROUND(AVG(price), 2) AS avg_price FROM lease_contracts;

-------------------------------------------
-- Query #5: lease contracts with opinions and name of the reviewer
SELECT lc.id, lc.price, lc.date_begin, lc.date_end, co.mark, rd.name
FROM lease_contracts lc
INNER JOIN contract_opinions co
  ON lc.id = co.contract
INNER JOIN reviewers_dictionary rd
  ON co.reviewer = rd.id
ORDER BY lc.id ASC;

-------------------------------------------
-- Query #6: nr of archival and non-archival employees
SELECT is_archival, COUNT(is_archival)
FROM employees
GROUP BY is_archival

-------------------------------------------
-- Query #7: 