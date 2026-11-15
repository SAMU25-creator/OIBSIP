# Task 3: SQL Injection on DVWA

## Overview
This project demonstrates a SQL Injection vulnerability using the Damn Vulnerable Web Application (DVWA) at Low security level.

The objective was to understand how malicious SQL input can manipulate database queries and expose information.

All testing was performed locally using XAMPP and DVWA.

## Tools Used
- XAMPP
- Damn Vulnerable Web Application (DVWA)
- MySQL
- Web browser

## Environment Setup
1. Installed XAMPP.
2. Started Apache and MySQL.
3. Installed DVWA in the XAMPP `htdocs` directory.
4. Configured the DVWA database.
5. Logged into DVWA using the default local credentials.
6. Changed the DVWA security level to Low.
7. Opened the SQL Injection module.

## Testing and Results

### Baseline Test
**Input:** `1`

The application returned one record:

| ID | First Name | Surname |
|---|---|---|
| 1 | admin | admin |

### SQL Injection Test 1

**Payload:**
```sql id="v0d6g5"
1' OR '1'='1
```

**Result:** Five records were returned:
- admin admin
- Gordon Brown
- Hack Me
- Pablo Picasso
- Bob Smith

### SQL Injection Test 2

**Payload:**
```sql id="0n7z7p"
1' OR 1=1 #
```

**Result:** The same five records were returned.

## Why the Vulnerability Exists
SQL Injection occurs when an application places user input directly into an SQL query without safely separating data from SQL instructions.

In this test, the injected conditions were always true. This caused the database query to return multiple records rather than only the requested user.

## Security Risks
SQL Injection can allow attackers to:
- View unauthorised database records.
- Access sensitive information.
- Bypass application restrictions.
- Modify or delete database information in more severe cases.

## Prevention
Developers should:
1. Use prepared statements and parameterised queries.
2. Validate user input.
3. Avoid constructing SQL queries through direct string concatenation.
4. Apply least-privilege database permissions.
5. Handle database errors securely.

## Screenshots
The `screenshots` folder contains evidence of:
- Baseline SQL query.
- First SQL injection attempt.
- Second SQL injection attempt.

## Conclusion
Both injection payloads successfully returned five user records, demonstrating that the DVWA SQL Injection module was vulnerable at Low security.

This exercise highlights the importance of secure database query handling and parameterised SQL statements.

## Ethical Considerations
Testing was performed only on a locally installed DVWA application. No external websites or systems were targeted.