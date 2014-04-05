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

-- Create the Instructor table.

DROP TABLE IF EXISTS swe.instructor;
CREATE table swe.instructor
(
  id serial PRIMARY KEY,
  title character varying(20),
  first_name character varying(50) NOT NULL,
  last_name character varying(50) NOT NULL
);

-- Create the Course table.

DROP TABLE IF EXISTS swe.course;
CREATE table swe.course
(
  id serial PRIMARY KEY,
  name character varying(255) NOT NULL,
  instructor_id serial REFERENCES swe.instructor(id)
);

-- Create the Section table.

DROP TABLE IF EXISTS swe.section;
CREATE table swe.section
(
  id serial PRIMARY KEY,
  name character varying (255) NOT NULL,
  course_id serial REFERENCES swe.course(id)
);
