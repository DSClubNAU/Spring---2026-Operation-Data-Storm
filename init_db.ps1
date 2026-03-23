# init_db.ps1
# Runs schema.sql, seed.sql, then runs a quick test query.
# Requires: PostgreSQL installed and psql available.

$ErrorActionPreference = "Stop"

# --- Config: edit if your psql path differs ---
$Psql = "C:\Program Files\PostgreSQL\18\bin\psql.exe"
$Createdb = "C:\Program Files\PostgreSQL\18\bin\createdb.exe"

# Use DATABASE_URL if set; otherwise fall back to a local default.
if (-not $env:DATABASE_URL -or $env:DATABASE_URL.Trim() -eq "") {
  $env:DATABASE_URL = "postgresql://postgres:0309143015@localhost:5432/your_database"
}

Write-Host "==> Using DATABASE_URL=$($env:DATABASE_URL)"
Write-Host "==> Using psql at: $Psql"

# Ensure files exist
if (-not (Test-Path ".\schema.sql")) { throw "schema.sql not found in current directory." }
if (-not (Test-Path ".\seed.sql"))   { throw "seed.sql not found in current directory." }

# Apply schema + seed
& $Psql $env:DATABASE_URL -v ON_ERROR_STOP=1 -f ".\schema.sql"
Write-Host "==> schema.sql applied."

& $Psql $env:DATABASE_URL -v ON_ERROR_STOP=1 -f ".\seed.sql"
Write-Host "==> seed.sql applied."

# Test query: counts + a sample join
Write-Host "==> Running test query..."

$testSql = @"
SELECT 'students'    AS table, COUNT(*) AS rows FROM students
UNION ALL
SELECT 'courses'     AS table, COUNT(*) AS rows FROM courses
UNION ALL
SELECT 'enrollments' AS table, COUNT(*) AS rows FROM enrollments;

SELECT
  s.nau_id,
  s.first_name,
  s.last_name,
  c.course_code,
  c.term,
  c.year
FROM enrollments e
JOIN students s ON s.student_id = e.student_id
JOIN courses  c ON c.course_id  = e.course_id
ORDER BY s.nau_id, c.year, c.term, c.course_code
LIMIT 25;
"@

& $Psql $env:DATABASE_URL -v ON_ERROR_STOP=1 -c $testSql

Write-Host "==> Done."









01101001        F1 8A 5C                day              int main     int coun
0101010A3       9E 26 B3               08:01             t = 0;i<     0; while
01001101F9      7E B4 A1              8:03:14            (x>0) if     (value);
1010110100N     C8 6D 10             2008-08-3           else 1==     N_value;
10110100101C    5A 09 3C            2024-09-12:           SELECT:     usersid
101001104F A2   E3 17 8D           status=active          if not      result: 
10100110100 9D  4F A2 9C          2026/09/1208:03         def run     _cmd(); 
10101011 A3 9C  A3 F9 0C         2026/11   11:20:4        print("     Hello W
10101001 6C D8 B7F 04 A9        alpha Be    ta gamm       orld");     print()
01001010  9F 9D E2 61 D7       ID Category Score Day      if(flag     )while( 
01001011   1 07 09 D5 F2      1021 active   87   TRUE     j<maxup     date(); 
01001010     3A 7E 4B D1     1022  inactive 91    TRUE    j++;}++i   return 0 
01001011     F0 88 2A C4    TRUE FA             LSE TRU   if(success==1){retu 
10101001      B 9F 5E 01   120 121               123 124   rn 0;}code = 404;
11010101       NB7 A0 6D  125 126                 127 128    with get_db()    
10101001        4F A2 9C FALSE T                   RUE FAL    as db: #l     