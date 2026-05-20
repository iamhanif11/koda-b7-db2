CREATE TABLE events(
    event_id SERIAL PRIMARY KEY,
    event_name VARCHAR,
    start_date TIMESTAMP
);

INSERT INTO events(event_name, start_date) VALUES
('Event A', '2024-01-01'),('Event B', '2024-01-05'),('Event C', '2024-01-10');

SELECT * FROM events;

SELECT 
    e1.event_name,  
    COALESCE(string_agg(e2.event_name, ', '), 'No Next Event') AS "Next Event"
FROM events e1
LEFT JOIN events e2 ON e2.start_date > e1.start_date
GROUP BY e1.event_name, e1.start_date
ORDER BY e1.start_date;


CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    referred_by INT
);

INSERT INTO customers (name, referred_by) VALUES
('Alice', NULL),
('Bob',1),('Charlie',1),('David',2),('Eva',2),('Frank', 3);

--1.
SELECT c.name, r.name
FROM customers c 
LEFT JOIN customers r ON c.referred_by = r.id;

--2
SELECT name FROM customers
WHERE referred_by IS NULL;

--3
SELECT r.name, COUNT (c.id)
FROM customers r
LEFT JOIN customers c ON r.id = c.referred_by
GROUP BY r.name
ORDER BY COUNT (c.id) DESC;

--4
SELECT r.name, COUNT (c.id)
FROM customers r
JOIN customers c ON r.id = c.referred_by
GROUP BY r.name
ORDER BY COUNT (c.id) DESC;