CREATE TABLE temperature (
  id          INTEGER PRIMARY KEY,
  temperature DECIMAL(4,2),
  timestamp   DATETIME DEFAULT CURRENT_TIMESTAMP
);
