-- schema.sql
-- Simple campus tracking schema: students, courses, enrollments

BEGIN;

CREATE TABLE IF NOT EXISTS students (
  student_id   BIGSERIAL PRIMARY KEY,
  nau_id       TEXT UNIQUE NOT NULL,
  first_name   TEXT NOT NULL,
  last_name    TEXT NOT NULL,
  email        TEXT UNIQUE NOT NULL,
  created_at   TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS courses (
  course_id    BIGSERIAL PRIMARY KEY,
  course_code  TEXT NOT NULL,              -- e.g., "CS-249"
  title        TEXT NOT NULL,              -- e.g., "Data Structures"
  term         TEXT NOT NULL,              -- e.g., "Spring"
  year         INT  NOT NULL CHECK (year >= 2000),
  UNIQUE (course_code, term, year)
);

CREATE TABLE IF NOT EXISTS enrollments (
  enrollment_id BIGSERIAL PRIMARY KEY,
  student_id    BIGINT NOT NULL REFERENCES students(student_id) ON DELETE CASCADE,
  course_id     BIGINT NOT NULL REFERENCES courses(course_id)   ON DELETE CASCADE,
  enrolled_at   TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE (student_id, course_id)
);

-- Helpful indexes (optional but nice)
CREATE INDEX IF NOT EXISTS idx_enrollments_student_id ON enrollments(student_id);
CREATE INDEX IF NOT EXISTS idx_enrollments_course_id  ON enrollments(course_id);

COMMIT;
