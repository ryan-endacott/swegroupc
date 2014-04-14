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
    VALUES ('{name}', '{instructor_id}');

