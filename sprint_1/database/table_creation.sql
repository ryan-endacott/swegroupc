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

-- Create the TA table.

DROP TABLE IF EXISTS swe.ta;
CREATE TABLE swe.ta
(
  pawprint character varying(10) NOT NULL
);

ALTER TABLE swe.ta
  ADD CONSTRAINT pawprint_foreign_key
        FOREIGN KEY (pawprint) REFERENCES swe.student(pawprint);

