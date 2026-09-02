CREATE TABLE IF NOT EXISTS tasks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    description VARCHAR(255) NOT NULL,
    completed BOOLEAN NOT NULL DEFAULT FALSE
);

INSERT INTO tasks (description, completed) VALUES
('Buy groceries', FALSE),
('Book dentist appointment', FALSE),
('Submit library books', TRUE);