-- Task 3: Implement Indexes for Optimization
-- ALX Airbnb Database Project

-- Indexes for User Table
-- Index on email (frequently used in WHERE clauses for login/authentication)
CREATE INDEX idx_user_email ON User(email);

-- Index on created_at (useful for sorting and filtering by registration date)
CREATE INDEX idx_user_created_at ON User(created_at);

-- Indexes for Property Table
-- Index on location (frequently used in WHERE clauses for property searches)
CREATE INDEX idx_property_location ON Property(location);

-- Index on pricepernight (frequently used in WHERE and ORDER BY clauses for price filtering)
CREATE INDEX idx_property_price ON Property(pricepernight);

-- Composite index on location and pricepernight (optimizes location + price searches)
CREATE INDEX idx_property_location_price ON Property(location, pricepernight);

-- Index on host_id (foreign key, used in JOINs)
CREATE INDEX idx_property_host_id ON Property(host_id);

-- Indexes for Booking Table
-- Index on user_id (foreign key, frequently used in JOINs and WHERE clauses)
CREATE INDEX idx_booking_user_id ON Booking(user_id);

-- Index on property_id (foreign key, frequently used in JOINs and WHERE clauses)
CREATE INDEX idx_booking_property_id ON Booking(property_id);

-- Index on start_date (used in WHERE clauses for date range queries)
CREATE INDEX idx_booking_start_date ON Booking(start_date);

-- Index on end_date (used in WHERE clauses for date range queries)
CREATE INDEX idx_booking_end_date ON Booking(end_date);

-- Composite index on start_date and end_date (optimizes date range searches)
CREATE INDEX idx_booking_dates ON Booking(start_date, end_date);

-- Index on status (frequently used in WHERE clauses to filter bookings)
CREATE INDEX idx_booking_status ON Booking(status);

-- Composite index on property_id and start_date (optimizes availability checks)
CREATE INDEX idx_booking_property_date ON Booking(property_id, start_date, end_date);

-- Indexes for Review Table
-- Index on property_id (foreign key, used in JOINs and aggregations)
CREATE INDEX idx_review_property_id ON Review(property_id);

-- Index on user_id (foreign key, used in JOINs)
CREATE INDEX idx_review_user_id ON Review(user_id);

-- Index on rating (used in WHERE clauses and aggregations)
CREATE INDEX idx_review_rating ON Review(rating);

-- Composite index on property_id and rating (optimizes property rating queries)
CREATE INDEX idx_review_property_rating ON Review(property_id, rating);

-- Indexes for Payment Table
-- Index on booking_id (foreign key, used in JOINs)
CREATE INDEX idx_payment_booking_id ON Payment(booking_id);

-- Index on payment_date (used in WHERE and ORDER BY clauses)
CREATE INDEX idx_payment_date ON Payment(payment_date);

-- Index on payment_method (useful for payment analysis)
CREATE INDEX idx_payment_method ON Payment(payment_method);

-- Indexes for Message Table (if exists)
-- Index on sender_id (foreign key)
CREATE INDEX idx_message_sender_id ON Message(sender_id);

-- Index on recipient_id (foreign key)
CREATE INDEX idx_message_recipient_id ON Message(recipient_id);

-- Index on sent_at (used for sorting messages)
CREATE INDEX idx_message_sent_at ON Message(sent_at);
