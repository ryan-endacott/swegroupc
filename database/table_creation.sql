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

DROP TABLE IF EXISTS swe.ta CASCADE;
CREATE TABLE swe.ta
(
    pawprint character varying(10) REFERENCES swe.student(pawprint),
    PRIMARY KEY (pawprint)
);

-- Create the Instructor table.

DROP TABLE IF EXISTS swe.instructor CASCADE;
CREATE TABLE swe.instructor
(
    id serial PRIMARY KEY,
    title character varying(20),
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL
);

-- Create the Course table.

DROP TABLE IF EXISTS swe.course CASCADE;
CREATE TABLE swe.course
(
    id serial PRIMARY KEY,
    name character varying(255) NOT NULL,
    instructor_id serial REFERENCES swe.instructor(id)
);

-- Create the Section table.

DROP TABLE IF EXISTS swe.section CASCADE;
CREATE TABLE swe.section
(
    id serial PRIMARY KEY,
    name character varying(255) NOT NULL,
    course_id serial REFERENCES swe.course(id)
);

-- Create the Student Course table.

DROP TABLE IF EXISTS swe.student_course;
CREATE TABLE swe.student_course
(
    pawprint character varying(10) REFERENCES swe.student(pawprint),
    course_id serial REFERENCES swe.course(id),
    PRIMARY KEY (pawprint, course_id)
);

-- Create the Student Section table

DROP TABLE IF EXISTS swe.student_section;
CREATE TABLE swe.student_section
(
    pawprint character varying(10) REFERENCES swe.student(pawprint),
    section_id serial REFERENCES swe.section(id),
    PRIMARY KEY (pawprint, section_id)
);

-- Create the TA Course table.

DROP TABLE IF EXISTS swe.ta_course;
CREATE TABLE swe.ta_course
(
    pawprint character varying(10) REFERENCES swe.ta(pawprint),
    course_id serial REFERENCES swe.course(id),
    PRIMARY KEY (pawprint, course_id)
);

-- Create the TA Section table.

DROP TABLE IF EXISTS swe.ta_section;
CREATE TABLE swe.ta_section
(
    pawprint character varying(10) REFERENCES swe.ta(pawprint),
    section_id serial REFERENCES swe.section(id),
    PRIMARY KEY (pawprint, section_id)
);

-- Create the Assignment table.
DROP TABLE IF EXISTS swe.assignment;
CREATE TABLE swe.assignment
(
    id serial PRIMARY KEY,
    course_id serial REFERENCES swe.course(id)
)

-- Create the Submission table.

DROP TABLE IF EXISTS swe.submission;
CREATE TABLE swe.submission
(
    receipt character varying(255) PRIMARY KEY,
    assignment_id serial REFERENCES swe.assignment(id),
    section_id serial REFERENCES swe.section(id),
    pawprint character varying(10) REFERENCES swe.student(pawprint),
    filename character varying(255) NOT NULL,
    file_contents bytea NOT NULL,
    submission_date timestamp NOT NULL,
    ip timestamp NOT NULL
);
