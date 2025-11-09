-- Task 5: Partitioning Large Tables
-- ALX Airbnb Database Project

-- Step 1: Check if the Booking table exists and view its structure
DESCRIBE Booking;

-- Step 2: Create a new partitioned Booking table
-- Note: If the table already exists, you may need to rename it first or drop it
-- For safety, we'll create a backup first

-- Backup existing Booking table (optional but recommended)
CREATE TABLE Booking_backup AS SELECT * FROM Booking;

-- Drop existing Booking table (be cautious in production!)
-- DROP TABLE IF EXISTS Booking;

-- Step 3: Create the Booking table with RANGE partitioning based on start_date
-- Partitioning by YEAR for better performance on date range queries

CREATE TABLE Booking_partitioned (
    booking_id CHAR(36) PRIMARY KEY,
    property_id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status ENUM('pending', 'confirmed', 'canceled', 'completed') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_property_id (property_id),
    INDEX idx_user_id (user_id),
    INDEX idx_start_date (start_date),
    INDEX idx_status (status)
) PARTITION BY RANGE (YEAR(start_date)) (
    PARTITION p_before_2020 VALUES LESS THAN (2020),
    PARTITION p_2020 VALUES LESS THAN (2021),
    PARTITION p_2021 VALUES LESS THAN (2022),
    PARTITION p_2022 VALUES LESS THAN (2023),
    PARTITION p_2023 VALUES LESS THAN (2024),
    PARTITION p_2024 VALUES LESS THAN (2025),
    PARTITION p_2025 VALUES LESS THAN (2026),
    PARTITION p_2026 VALUES LESS THAN (2027),
    PARTITION p_future VALUES LESS THAN MAXVALUE
);

-- Step 4: Copy data from backup to partitioned table
INSERT INTO Booking_partitioned 
SELECT * FROM Booking_backup;

-- Alternative: If you want to rename the tables instead
-- RENAME TABLE Booking TO Booking_old, Booking_partitioned TO Booking;

-- Step 5: Verify partitioning
SELECT 
    TABLE_NAME,
    PARTITION_NAME,
    TABLE_ROWS,
    AVG_ROW_LENGTH,
    DATA_LENGTH
FROM 
    INFORMATION_SCHEMA.PARTITIONS
WHERE 
    TABLE_NAME = 'Booking_partitioned'
    AND TABLE_SCHEMA = DATABASE();

-- Step 6: Test query performance on partitioned table

-- Query 1: Fetch bookings for a specific date range (should only scan relevant partitions)
EXPLAIN PARTITIONS
SELECT * FROM Booking_partitioned
WHERE start_date BETWEEN '2025-01-01' AND '2025-12-31';

-- Query 2: Fetch bookings for a specific property in a date range
EXPLAIN PARTITIONS
SELECT * FROM Booking_partitioned
WHERE property_id = 'some-property-id'
  AND start_date BETWEEN '2025-06-01' AND '2025-08-31';

-- Query 3: Count bookings by year
SELECT 
    YEAR(start_date) AS booking_year,
    COUNT(*) AS total_bookings
FROM 
    Booking_partitioned
GROUP BY 
    YEAR(start_date)
ORDER BY 
    booking_year;

-- Step 7: Add new partitions for future years (maintenance task)
ALTER TABLE Booking_partitioned 
ADD PARTITION (
    PARTITION p_2028 VALUES LESS THAN (2029),
    PARTITION p_2029 VALUES LESS THAN (2030)
);

-- Step 8: Drop old partitions (to archive data older than certain years)
-- Example: Remove bookings before 2020
-- ALTER TABLE Booking_partitioned DROP PARTITION p_before_2020;

-- Alternative Partitioning Strategy: HASH Partitioning (for even data distribution)
/*
CREATE TABLE Booking_hash_partitioned (
    booking_id CHAR(36) PRIMARY KEY,
    property_id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status ENUM('pending', 'confirmed', 'canceled', 'completed') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_property_id (property_id),
    INDEX idx_user_id (user_id),
    INDEX idx_start_date (start_date)
) PARTITION BY HASH(YEAR(start_date))
PARTITIONS 10;
*/

-- Alternative Partitioning Strategy: LIST Partitioning (by status)
/*
CREATE TABLE Booking_list_partitioned (
    booking_id CHAR(36) PRIMARY KEY,
    property_id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status ENUM('pending', 'confirmed', 'canceled', 'completed') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) PARTITION BY LIST COLUMNS(status) (
    PARTITION p_pending VALUES IN ('pending'),
    PARTITION p_confirmed VALUES IN ('confirmed'),
    PARTITION p_canceled VALUES IN ('canceled'),
    PARTITION p_completed VALUES IN ('completed')
);
*/
