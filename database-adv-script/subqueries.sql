-- Task 1: Practice Subqueries
-- ALX Airbnb Database Project

-- Query 1: Non-correlated subquery - Find all properties where the average rating is greater than 4.0
SELECT 
    p.property_id,
    p.name,
    p.location,
    p.pricepernight,
    p.description
FROM 
    Property p
WHERE 
    p.property_id IN (
        SELECT 
            r.property_id
        FROM 
            Review r
        GROUP BY 
            r.property_id
        HAVING 
            AVG(r.rating) > 4.0
    )
ORDER BY 
    p.property_id;

-- Alternative using JOIN (more efficient in some cases)
SELECT 
    p.property_id,
    p.name,
    p.location,
    p.pricepernight,
    AVG(r.rating) AS average_rating
FROM 
    Property p
INNER JOIN 
    Review r ON p.property_id = r.property_id
GROUP BY 
    p.property_id, p.name, p.location, p.pricepernight
HAVING 
    AVG(r.rating) > 4.0
ORDER BY 
    average_rating DESC;

-- Query 2: Correlated subquery - Find users who have made more than 3 bookings
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.phone_number
FROM 
    User u
WHERE 
    (
        SELECT 
            COUNT(*)
        FROM 
            Booking b
        WHERE 
            b.user_id = u.user_id
    ) > 3
ORDER BY 
    u.user_id;

-- Alternative query with additional information showing booking count
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    (
        SELECT 
            COUNT(*)
        FROM 
            Booking b
        WHERE 
            b.user_id = u.user_id
    ) AS total_bookings
FROM 
    User u
WHERE 
    (
        SELECT 
            COUNT(*)
        FROM 
            Booking b
        WHERE 
            b.user_id = u.user_id
    ) > 3
ORDER BY 
    total_bookings DESC;
