DROP TABLE merchants CASCADE;
DROP TABLE tags CASCADE;
DROP TABLE transactions CASCADE;

CREATE TABLE merchants (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  total_spend FLOAT
);

CREATE TABLE tags (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  total_spend FLOAT
);

CREATE TABLE transactions (
  id SERIAL PRIMARY KEY,
  description VARCHAR(255) NOT NULL,
  value FLOAT NOT NULL,
  spend_date DATE NOT NULL,
  merchant_id INT REFERENCES merchants(id) ON DELETE CASCADE,
  tag_id INT REFERENCES tags(id) ON DELETE CASCADE
);
