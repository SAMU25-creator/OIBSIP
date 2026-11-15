# SQL Injection Test Notes

## 1. Environment
- Application: Damn Vulnerable Web Application (DVWA)
- Platform: XAMPP on Windows
- Target: Localhost
- Module: SQL Injection
- Security Level: Low
- Database: MySQL

## 2. Baseline Test

**Input:** `1`

**Result:**
- ID: 1
- First name: admin
- Surname: admin

**Observation:** The application returned one user record for the supplied ID.

## 3. SQL Injection Test 1

**Payload:**
```sql
1' OR '1'='1
```

**Result:** The application returned five user records:
- admin admin
- Gordon Brown
- Hack Me
- Pablo Picasso
- Bob Smith

**Analysis:** The condition `'1'='1'` is always true. This changed the intended query condition and caused multiple records to be returned.

**Evidence:** `02-sql-injection-test1.png`

## 4. SQL Injection Test 2

**Payload:**
```sql
1' OR 1=1 #
```

**Result:** The application returned the same five user records:
- admin admin
- Gordon Brown
- Hack Me
- Pablo Picasso
- Bob Smith

**Analysis:** The condition `1=1` is always true. The `#` character comments out the remaining part of the SQL statement in MySQL.

**Evidence:** `03-sql-injection-test2.png`

## 5. Conclusion

Both payloads successfully demonstrated SQL injection in DVWA at Low security.

The application returned multiple user records instead of restricting the result to the requested User ID. This demonstrates how unsafe handling of user input can expose database information.

## 6. Recommended Prevention

Developers should:
- Use prepared statements and parameterised queries.
- Avoid directly inserting user input into SQL statements.
- Validate input according to the expected data type.
- Apply least-privilege database permissions.
- Avoid displaying detailed database errors to users.

**Ethical note:** All testing was performed on a locally installed DVWA environment for educational purposes.