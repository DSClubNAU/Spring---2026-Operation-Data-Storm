-- seed.sql
-- Sample data for students/courses/enrollments

BEGIN;

-- Students
INSERT INTO students (nau_id, first_name, last_name, email) VALUES
  ('N00123456', 'Sam',   'Utzinger', 'sam.utzinger@nau.edu'),
  ('N00987654', 'Ava',   'Nguyen',   'ava.nguyen@nau.edu'),
  ('N00445566', 'Noah',  'Patel',    'noah.patel@nau.edu'),
  ('N00778899', 'Maya',  'Garcia',   'maya.garcia@nau.edu')
ON CONFLICT (nau_id) DO NOTHING;

-- Courses
INSERT INTO courses (course_code, title, term, year) VALUES
  ('CS-249',  'Data Structures',                  'Spring', 2026),
  ('STA-371', 'Applied Regression and ANOVA',     'Spring', 2026),
  ('CS-136',  'Programming Fundamentals',         'Fall',   2025)
ON CONFLICT (course_code, term, year) DO NOTHING;

-- Enrollments (using subqueries so IDs don’t matter)
INSERT INTO enrollments (student_id, course_id)
SELECT s.student_id, c.course_id
FROM students s
JOIN courses c ON c.course_code = 'CS-249' AND c.term='Spring' AND c.year=2026
WHERE s.nau_id IN ('N00123456','N00987654')
ON CONFLICT (student_id, course_id) DO NOTHING;

INSERT INTO enrollments (student_id, course_id)
SELECT s.student_id, c.course_id
FROM students s
JOIN courses c ON c.course_code = 'STA-371' AND c.term='Spring' AND c.year=2026
WHERE s.nau_id IN ('N00123456','N00445566','N00778899')
ON CONFLICT (student_id, course_id) DO NOTHING;

INSERT INTO enrollments (student_id, course_id)
SELECT s.student_id, c.course_id
FROM students s
JOIN courses c ON c.course_code = 'CS-136' AND c.term='Fall' AND c.year=2025
WHERE s.nau_id IN ('N00987654','N00445566')
ON CONFLICT (student_id, course_id) DO NOTHING;

COMMIT;
