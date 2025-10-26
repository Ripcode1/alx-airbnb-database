-- ============================================================================
-- Airbnb Database - Sample Data (DML)
-- Author: Jason Rippon
-- Date: October 26, 2025
-- Description: Realistic sample data for testing and development
-- ============================================================================

-- ============================================================================
-- INSERT: Users (Guests, Hosts, and Admins)
-- ============================================================================

INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at) VALUES
-- Admin
('550e8400-e29b-41d4-a716-446655440000', 'Admin', 'User', 'admin@airbnb.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5NU7BZ68GwK', '+27123456789', 'admin', '2024-01-15 08:00:00'),

-- Hosts
('550e8400-e29b-41d4-a716-446655440001', 'Sarah', 'Johnson', 'sarah.johnson@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5NU7BZ68GwK', '+27214567890', 'host', '2024-02-10 09:30:00'),
('550e8400-e29b-41d4-a716-446655440002', 'Michael', 'Chen', 'michael.chen@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5NU7BZ68GwK', '+27315678901', 'host', '2024-02-15 14:20:00'),
('550e8400-e29b-41d4-a716-446655440003', 'Emma', 'Williams', 'emma.williams@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5NU7BZ68GwK', '+27416789012', 'host', '2024-03-01 11:15:00'),
('550e8400-e29b-41d4-a716-446655440004', 'David', 'Mbeki', 'david.mbeki@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5NU7BZ68GwK', '+27117890123', 'host', '2024-03-10 16:45:00'),

-- Guests
('550e8400-e29b-41d4-a716-446655440010', 'John', 'Smith', 'john.smith@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5NU7BZ68GwK', '+27219012345', 'guest', '2024-04-01 08:30:00'),
('550e8400-e29b-41d4-a716-446655440011', 'Maria', 'Garcia', 'maria.garcia@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5NU7BZ68GwK', '+27320123456', 'guest', '2024-04-05 12:00:00'),
('550e8400-e29b-41d4-a716-446655440012', 'James', 'Taylor', 'james.taylor@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5NU7BZ68GwK', '+27421234567', 'guest', '2024-04-10 15:20:00'),
('550e8400-e29b-41d4-a716-446655440013', 'Olivia', 'Brown', 'olivia.brown@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5NU7BZ68GwK', '+27112345678', 'guest', '2024-04-15 09:45:00'),
('550e8400-e29b-41d4-a716-446655440014', 'Liam', 'Anderson', 'liam.anderson@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5NU7BZ68GwK', '+27323456789', 'guest', '2024-04-20 13:10:00'),
('550e8400-e29b-41d4-a716-446655440015', 'Sophia', 'Martinez', 'sophia.martinez@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5NU7BZ68GwK', '+27424567890', 'guest', '2024-04-25 11:30:00'),
('550e8400-e29b-41d4-a716-446655440016', 'Noah', 'Wilson', 'noah.wilson@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5NU7BZ68GwK', NULL, 'guest', '2024-05-01 14:00:00');

-- ============================================================================
-- INSERT: Properties
-- ============================================================================

INSERT INTO Property (property_id, host_id, name, description, location, pricepernight, created_at, updated_at) VALUES
-- Properties by Sarah Johnson
('650e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440001', 'Seaside Villa in Cape Town', 'Stunning 3-bedroom villa with ocean views, private pool, and direct beach access. Perfect for families.', 'Camps Bay, Cape Town, Western Cape', 3500.00, '2024-02-12 10:00:00', '2024-02-12 10:00:00'),
('650e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440001', 'Modern Apartment in Waterfront', 'Stylish 2-bedroom apartment in the heart of V&A Waterfront. Walking distance to attractions.', 'V&A Waterfront, Cape Town, Western Cape', 1800.00, '2024-03-01 14:30:00', '2024-03-01 14:30:00'),

-- Properties by Michael Chen
('650e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440002', 'Luxury Penthouse Sandton', 'Spectacular 4-bedroom penthouse with panoramic city views and rooftop terrace.', 'Sandton, Johannesburg, Gauteng', 4200.00, '2024-02-18 11:20:00', '2024-02-18 11:20:00'),
('650e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440002', 'Cozy Studio in Melville', 'Charming studio apartment in trendy Melville. Close to cafes and nightlife.', 'Melville, Johannesburg, Gauteng', 850.00, '2024-03-05 09:45:00', '2024-03-05 09:45:00'),

-- Properties by Emma Williams
('650e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440003', 'Beachfront Cottage Durban', 'Beautiful 2-bedroom cottage right on the beach. Wake up to ocean sounds.', 'Umhlanga, Durban, KwaZulu-Natal', 2100.00, '2024-03-03 13:00:00', '2024-03-03 13:00:00'),
('650e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440003', 'Garden Suite Morningside', 'Peaceful 1-bedroom garden suite with private entrance. Perfect for business travelers.', 'Morningside, Durban, KwaZulu-Natal', 950.00, '2024-03-15 16:20:00', '2024-03-15 16:20:00'),

-- Properties by David Mbeki
('650e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440004', 'Safari Lodge near Kruger', 'Authentic 3-bedroom safari lodge with game viewing deck. Experience the wild.', 'Hazyview, Mpumalanga', 2800.00, '2024-03-12 08:30:00', '2024-03-12 08:30:00'),
('650e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440004', 'Mountain Cabin Drakensberg', 'Rustic 2-bedroom cabin in the mountains. Hiking trails and stunning views.', 'Drakensberg, KwaZulu-Natal', 1600.00, '2024-03-25 12:00:00', '2024-03-25 12:00:00');

-- ============================================================================
-- INSERT: Bookings
-- ============================================================================

INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at) VALUES
-- Confirmed bookings
('750e8400-e29b-41d4-a716-446655440001', '650e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440010', '2025-11-05', '2025-11-10', 17500.00, 'confirmed', '2025-10-15 09:30:00'),
('750e8400-e29b-41d4-a716-446655440002', '650e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440011', '2025-11-12', '2025-11-15', 12600.00, 'confirmed', '2025-10-18 14:20:00'),
('750e8400-e29b-41d4-a716-446655440003', '650e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440012', '2025-12-20', '2025-12-27', 14700.00, 'confirmed', '2025-10-20 11:45:00'),
('750e8400-e29b-41d4-a716-446655440004', '650e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440013', '2025-11-15', '2025-11-20', 14000.00, 'confirmed', '2025-10-22 16:10:00'),
('750e8400-e29b-41d4-a716-446655440005', '650e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440014', '2025-12-01', '2025-12-05', 6400.00, 'confirmed', '2025-10-25 10:00:00'),

-- Pending bookings
('750e8400-e29b-41d4-a716-446655440006', '650e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440015', '2025-11-25', '2025-11-28', 5400.00, 'pending', '2025-10-26 08:30:00'),
('750e8400-e29b-41d4-a716-446655440007', '650e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440016', '2025-12-10', '2025-12-13', 2550.00, 'pending', '2025-10-26 12:15:00'),

-- Canceled bookings
('750e8400-e29b-41d4-a716-446655440008', '650e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440010', '2025-11-01', '2025-11-05', 3800.00, 'canceled', '2025-10-10 13:20:00');

-- ============================================================================
-- INSERT: Payments
-- ============================================================================

INSERT INTO Payment (payment_id, booking_id, amount, payment_date, payment_method) VALUES
-- Payments for confirmed bookings
('850e8400-e29b-41d4-a716-446655440001', '750e8400-e29b-41d4-a716-446655440001', 17500.00, '2025-10-15 09:35:00', 'credit_card'),
('850e8400-e29b-41d4-a716-446655440002', '750e8400-e29b-41d4-a716-446655440002', 6300.00, '2025-10-18 14:25:00', 'paypal'),
('850e8400-e29b-41d4-a716-446655440003', '750e8400-e29b-41d4-a716-446655440002', 6300.00, '2025-11-10 10:00:00', 'paypal'),
('850e8400-e29b-41d4-a716-446655440004', '750e8400-e29b-41d4-a716-446655440003', 14700.00, '2025-10-20 11:50:00', 'stripe'),
('850e8400-e29b-41d4-a716-446655440005', '750e8400-e29b-41d4-a716-446655440004', 7000.00, '2025-10-22 16:15:00', 'credit_card'),
('850e8400-e29b-41d4-a716-446655440006', '750e8400-e29b-41d4-a716-446655440004', 7000.00, '2025-11-13 12:00:00', 'credit_card'),
('850e8400-e29b-41d4-a716-446655440007', '750e8400-e29b-41d4-a716-446655440005', 6400.00, '2025-10-25 10:05:00', 'stripe');

-- ============================================================================
-- INSERT: Reviews
-- ============================================================================

INSERT INTO Review (review_id, property_id, user_id, rating, comment, created_at) VALUES
('950e8400-e29b-41d4-a716-446655440001', '650e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440010', 5, 'Absolutely stunning property! The ocean views were breathtaking and the villa had everything we needed. Sarah was a wonderful host. Would definitely stay here again!', '2025-10-16 14:30:00'),
('950e8400-e29b-41d4-a716-446655440002', '650e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440011', 5, 'The penthouse exceeded all expectations! Modern, clean, and the rooftop terrace was perfect. Michael was very accommodating. Highly recommended!', '2025-10-19 11:20:00'),
('950e8400-e29b-41d4-a716-446655440003', '650e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440012', 4, 'Great beachfront location! The cottage was cozy and well-equipped. Wi-Fi was a bit slow, but the beach made up for it. Emma was a gracious host.', '2025-10-21 09:45:00'),
('950e8400-e29b-41d4-a716-446655440004', '650e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440013', 5, 'Once-in-a-lifetime safari experience! Saw elephants from the deck every morning. The lodge was comfortable and authentic. David provided excellent tips!', '2025-10-23 16:00:00'),
('950e8400-e29b-41d4-a716-446655440005', '650e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440014', 4, 'Beautiful mountain retreat. The cabin was rustic but had all amenities. Hiking trails were amazing. Would recommend for nature lovers!', '2025-10-26 12:30:00');

-- ============================================================================
-- INSERT: Messages
-- ============================================================================

INSERT INTO Message (message_id, sender_id, recipient_id, message_body, sent_at) VALUES
-- Guest to Host inquiries
('a50e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440001', 'Hi Sarah! I am interested in booking your Seaside Villa for November 5-10. Is it available? Also, does it have parking for 2 cars?', '2025-10-14 14:30:00'),
('a50e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440010', 'Hello John! Yes, the villa is available for those dates. We have a double garage plus street parking. Would you like to proceed with booking?', '2025-10-14 15:45:00'),
('a50e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440001', 'Perfect! Yes, I would like to book it. We are a family of 5. What is the check-in process?', '2025-10-14 16:20:00'),
('a50e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440010', 'Great! Check-in is after 3 PM on November 5th. I will send you access codes and a welcome guide. Looking forward to hosting you!', '2025-10-14 17:00:00'),
('a50e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440011', '550e8400-e29b-41d4-a716-446655440002', 'Hi Michael, I am traveling to Johannesburg for a conference. Is your penthouse suitable for business travelers? Reliable internet?', '2025-10-17 09:15:00'),
('a50e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440011', 'Absolutely! The penthouse has a dedicated office with desk. We have fiber internet (200 Mbps). Many business travelers choose this property.', '2025-10-17 10:30:00'),
('a50e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440012', '550e8400-e29b-41d4-a716-446655440003', 'Hi Emma! Your beachfront cottage looks amazing. We are celebrating our anniversary - any chance you could arrange something special?', '2025-10-19 13:45:00'),
('a50e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440012', 'Congratulations! I would be happy to arrange champagne and flowers for your arrival. I can also recommend a wonderful restaurant for dinner.', '2025-10-19 14:30:00');

-- ============================================================================
-- END OF SEED DATA
-- ============================================================================
