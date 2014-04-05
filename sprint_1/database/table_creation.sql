CREATE SCHEMA IF NOT EXISTS swe;

-- Create the Student table.

DROP TABLE IF EXISTS swe.student;
CREATE TABLE swe.student
(
  pawprint character varying(10) NOT NULL,
  first_name character varying(50) NOT NULL,
  last_name character varying(50) NOT NULL
);

ALTER TABLE swe.student
  ADD CONSTRAINT pawprint_primary_key PRIMARY KEY (pawprint);

