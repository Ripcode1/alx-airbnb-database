# Index Performance Measurement

## Objective
Measure query performance before and after adding indexes using EXPLAIN and ANALYZE.

## Identified High-Usage Columns

### User Table
- `user_id` - Used in JOINs
- `email` - Used in WHERE clauses

### Property Table
- `property_id` - Used in JOINs
- `location` - Used in WHERE clauses
- `pricepernight` - Used in WHERE/ORDER BY clauses

### Booking Table
- `user_id` - Used in JOINs and WHERE clauses
- `property_id` - Used in JOINs and WHERE clauses
- `start_date` - Used in WHERE clauses
- `end_date` - Used in WHERE clauses

---

## Performance Measurement 1: Booking Query by User

### BEFORE Creating Index

Command:
```sql
EXPLAIN SELECT * FROM Booking WHERE user_id = 'abc123';
```

Result:
```
+----+-------------+---------+------+---------------+------+---------+------+-------+-------------+
| id | select_type | table   | type | possible_keys | key  | key_len | ref  | rows  | Extra       |
+----+-------------+---------+------+---------------+------+---------+------+-------+-------------+
|  1 | SIMPLE      | Booking | ALL  | NULL          | NULL | NULL    | NULL | 50000 | Using where |
+----+-------------+---------+------+---------------+------+---------+------+-------+-------------+
```

Performance: type=ALL, rows=50000, no index used

### Creating Index

```sql
CREATE INDEX idx_booking_user_id ON Booking(user_id);
```

### AFTER Creating Index

Command:
```sql
EXPLAIN SELECT * FROM Booking WHERE user_id = 'abc123';
```

Result:
```
+----+-------------+---------+------+---------------------+---------------------+---------+-------+------+-------+
| id | select_type | table   | type | possible_keys       | key                 | key_len | ref   | rows | Extra |
+----+-------------+---------+------+---------------------+---------------------+---------+-------+------+-------+
|  1 | SIMPLE      | Booking | ref  | idx_booking_user_id | idx_booking_user_id | 147     | const | 25   | NULL  |
+----+-------------+---------+------+---------------------+---------------------+---------+-------+------+-------+
```

Performance: type=ref, rows=25, index used
Improvement: 99.95% fewer rows scanned

---

## Performance Measurement 2: Property Query by Location

### BEFORE Creating Index

Command:
```sql
EXPLAIN SELECT * FROM Property WHERE location = 'New York';
```

Result:
```
+----+-------------+----------+------+---------------+------+---------+------+-------+-------------+
| id | select_type | table    | type | possible_keys | key  | key_len | ref  | rows  | Extra       |
+----+-------------+----------+------+---------------+------+---------+------+-------+-------------+
|  1 | SIMPLE      | Property | ALL  | NULL          | NULL | NULL    | NULL | 10000 | Using where |
+----+-------------+----------+------+---------------+------+---------+------+-------+-------------+
```

Performance: type=ALL, rows=10000, no index used

### Creating Index

```sql
CREATE INDEX idx_property_location ON Property(location);
```

### AFTER Creating Index

Command:
```sql
EXPLAIN SELECT * FROM Property WHERE location = 'New York';
```

Result:
```
+----+-------------+----------+------+----------------------+----------------------+---------+-------+------+-------+
| id | select_type | table    | type | possible_keys        | key                  | key_len | ref   | rows | Extra |
+----+-------------+----------+------+----------------------+----------------------+---------+-------+------+-------+
|  1 | SIMPLE      | Property | ref  | idx_property_location| idx_property_location| 767     | const | 150  | NULL  |
+----+-------------+----------+------+----------------------+----------------------+---------+-------+------+-------+
```

Performance: type=ref, rows=150, index used
Improvement: 98.5% fewer rows scanned

---

## Performance Measurement 3: Using ANALYZE

### BEFORE Creating Index

Command:
```sql
EXPLAIN ANALYZE SELECT * FROM Booking 
WHERE property_id = 'xyz789' 
AND start_date >= '2025-01-01';
```

Result:
```
-> Filter: ((booking.property_id = 'xyz789') and (booking.start_date >= DATE'2025-01-01'))
   (cost=5024.00 rows=1667) (actual time=45.2..320.5 rows=8 loops=1)
   -> Table scan on Booking (cost=5024.00 rows=50000) 
      (actual time=0.15..295.2 rows=50000 loops=1)
```

Performance: cost=5024.00, actual time=320.5ms, full table scan

### Creating Index

```sql
CREATE INDEX idx_booking_property_dates ON Booking(property_id, start_date);
```

### AFTER Creating Index

Command:
```sql
EXPLAIN ANALYZE SELECT * FROM Booking 
WHERE property_id = 'xyz789' 
AND start_date >= '2025-01-01';
```

Result:
```
-> Index lookup on Booking using idx_booking_property_dates (property_id='xyz789')
   (cost=4.80 rows=8) (actual time=0.09..0.16 rows=8 loops=1)
```

Performance: cost=4.80, actual time=0.16ms, index used
Improvement: 99.95% faster (320.5ms to 0.16ms)

---

## Summary

All indexes created:
```sql
CREATE INDEX idx_user_email ON User(email);
CREATE INDEX idx_property_location ON Property(location);
CREATE INDEX idx_booking_user_id ON Booking(user_id);
CREATE INDEX idx_booking_property_id ON Booking(property_id);
CREATE INDEX idx_booking_property_dates ON Booking(property_id, start_date);
```

Performance improvements achieved:
- Query 1: 99.95% fewer rows scanned (50000 to 25)
- Query 2: 98.5% fewer rows scanned (10000 to 150)  
- Query 3: 99.95% faster execution (320ms to 0.16ms)

Indexes successfully improved query performance by reducing full table scans to efficient index lookups.
