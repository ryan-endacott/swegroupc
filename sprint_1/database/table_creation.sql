CREATE SCHEMA IF NOT EXISTS swe;

-- Create the Student table.

DROP TABLE IF EXISTS swe.student CASCADE;
CREATE TABLE swe.student
(
  pawprint character varying(10) PRIMARY KEY,
  first_name character varying(50) NOT NULL,
  last_name character varying(50) NOT NULL
);

-- Create the TA table.

DROP TABLE IF EXISTS swe.ta;
CREATE TABLE swe.ta
(
  pawprint character varying(10) NOT NULL REFERENCES swe.student(pawprint)
);

-- Create the Professor table.

DROP TABLE IF EXISTS swe.professor;
CREATE table swe.professor
(
  id serial PRIMARY KEY
);

