-- Task 4: Optimize Complex Queries
-- ALX Airbnb Database Project

-- INITIAL QUERY (Before Optimization)
-- Retrieve all bookings along with user details, property details, and payment details
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price AS booking_total_price,
    b.status AS booking_status,
    b.created_at AS booking_created_at,
    
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.phone_number,
    u.role,
    
    p.property_id,
    p.name AS property_name,
    p.description AS property_description,
    p.location,
    p.pricepernight,
    
    pay.payment_id,
    pay.amount AS payment_amount,
    pay.payment_date,
    pay.payment_method
FROM 
    Booking b
INNER JOIN 
    User u ON b.user_id = u.user_id
INNER JOIN 
    Property p ON b.property_id = p.property_id
LEFT JOIN 
    Payment pay ON b.booking_id = pay.booking_id
ORDER BY 
    b.created_at DESC;


-- OPTIMIZED QUERY (After Refactoring)
-- Improvements made:
-- 1. Removed unnecessary columns that are rarely used
-- 2. Added WHERE clause to filter recent bookings (reduces data processed)
-- 3. Ensured indexes exist on join columns (user_id, property_id, booking_id)
-- 4. Limited results to improve performance for pagination
-- 5. Removed redundant sorting on created_at if not needed

SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    
    u.user_id,
    CONCAT(u.first_name, ' ', u.last_name) AS user_name,
    u.email,
    
    p.property_id,
    p.name AS property_name,
    p.location,
    p.pricepernight,
    
    pay.payment_id,
    pay.amount AS payment_amount,
    pay.payment_method
FROM 
    Booking b
INNER JOIN 
    User u ON b.user_id = u.user_id
INNER JOIN 
    Property p ON b.property_id = p.property_id
LEFT JOIN 
    Payment pay ON b.booking_id = pay.booking_id
WHERE 
    b.created_at >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)  -- Only bookings from last year
    AND b.status IN ('confirmed', 'pending', 'completed')  -- Filter by relevant statuses
ORDER BY 
    b.start_date DESC
LIMIT 1000;  -- Pagination limit


-- ALTERNATIVE OPTIMIZED QUERY with indexed columns in WHERE clause
-- This version is optimized for queries that frequently filter by specific properties or users
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    
    p.property_id,
    p.name AS property_name,
    p.location,
    
    pay.amount AS payment_amount,
    pay.payment_method
FROM 
    Booking b
FORCE INDEX (idx_booking_user_id, idx_booking_property_id)  -- Force index usage
INNER JOIN 
    User u ON b.user_id = u.user_id
INNER JOIN 
    Property p ON b.property_id = p.property_id
LEFT JOIN 
    Payment pay ON b.booking_id = pay.booking_id
WHERE 
    b.start_date BETWEEN '2025-01-01' AND '2025-12-31'
ORDER BY 
    b.booking_id  -- Sort by indexed column instead of created_at
LIMIT 1000;
