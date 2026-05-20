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
