-- Create the Student table.

CREATE TABLE sprint_1.student
(
  pawprint character varying(10) NOT NULL,
  "firstName" character varying(50) NOT NULL,
  "lastName" character varying(50) NOT NULL,
  CONSTRAINT pawprint_primary_key PRIMARY KEY (pawprint)
);

ALTER TABLE sprint_1.student
  ADD CONSTRAINT pawprint_unique UNIQUE (pawprint);

-- Create the TA table.