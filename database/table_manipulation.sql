/*
 * This document provides the standard layout for inserting new data.
 * Updates and deletes take a similar form and are left to the implementer.
 *
 * As a reference, this is for viewing only. The web service utilizes
 * a technology known as ActiveRecord, which handles common tasks such as this.
 */

-- Add a student.

INSERT INTO swe.student
    VALUES ('{pawprint}', '{first_name}', '{last_name}');

-- Add a TA.

INSERT INTO swe.ta
    VALUES ('{pawprint}');

-- Add an instructor.

INSERT INTO swe.instructor
    VALUES ('{title}', '{first_name}', '{last_name}');

-- Add a course.

INSERT INTO swe.course
    VALUES ('{name}', {instructor_id});

-- Add a section.

INSERT INTO swe.section
    VALUES ('{name}', {course_id});

-- Add an assignment.

INSERT INTO swe.assignment
    VALUES ('{name}', {course_id});

-- Add a submission.

INSERT INTO swe.submission
    VALUES ('{receipt}', {assignment_id}, {section_id}, '{pawprint}',
            '{filename}', file_contents, '{submission_date}', '{ip}');

-- Enroll a student in a course and then a section.

INSERT INTO swe.student_course
    VALUES ('{pawprint}', {course_id});

INSERT INTO swe.student_section
    VALUES ('{pawprint}', {section_id});

-- Assign a TA to a course and then a section.

INSERT INTO swe.ta_course
    VALUES ('{pawprint}', {course_id});

INSERT INTO swe.ta_section
    VALUES ('{pawprint}', {section_id});
