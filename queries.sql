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
-- Query #7: employees that started working in 2016 or 2017
SELECT name, surname, date_begin
FROM employees
WHERE EXTRACT(year FROM date_begin) = 2016
  OR EXTRACT(year FROM date_begin) = 2017;

-- the same query written in another way 
SELECT name, surname, date_begin
FROM employees
WHERE EXTRACT(year FROM date_begin) IN (2016, 2017);

-------------------------------------------
-- Query #8: contracts that length is smaller than 1000 days
SELECT id, date_begin, date_end, date_end - date_begin AS length 
FROM lease_contracts
GROUP BY id, date_begin, date_end
HAVING date_end - date_begin < 1000;

-------------------------------------------
-- Query #9: clients that do not take part in any leasing contracts
SELECT c.id, c.name 
FROM lease_contracts lc
RIGHT JOIN clients c
  ON lc.client = c.id
WHERE lc.client IS NULL

-------------------------------------------
-- Query #10: the post popular programming langauges used by employees
SELECT ld.name, COUNT(e.programming_language)
FROM languages_dictionary ld
INNER JOIN employees e
  ON ld.id = e.programming_language
GROUP BY ld.name
ORDER BY COUNT(e.programming_language) DESC