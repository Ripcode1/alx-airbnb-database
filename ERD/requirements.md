Airbnb Database - Entity-Relationship Diagram Requirements
Project Overview
This document outlines the entities, attributes, and relationships for an Airbnb-like database system. The design supports core functionalities including user management, property listings, bookings, payments, reviews, and messaging.

Entities and Attributes
1. User
Represents all users in the system (guests, hosts, and admins).
Attributes:

user_id (UUID, Primary Key)
first_name (VARCHAR, NOT NULL)
last_name (VARCHAR, NOT NULL)
email (VARCHAR, UNIQUE, NOT NULL)
password_hash (VARCHAR, NOT NULL)
phone_number (VARCHAR, NULL)
role (ENUM: guest, host, admin, NOT NULL)
created_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

Business Rules:

Email must be unique across the system
Users can have multiple roles (a guest can also be a host)
Phone number is optional but recommended


2. Property
Represents properties listed by hosts for rental.
Attributes:

property_id (UUID, Primary Key)
host_id (UUID, Foreign Key → User)
name (VARCHAR, NOT NULL)
description (TEXT, NOT NULL)
location (VARCHAR, NOT NULL)
price_per_night (DECIMAL, NOT NULL)
created_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)
updated_at (TIMESTAMP, ON UPDATE CURRENT_TIMESTAMP)

Business Rules:

Each property must have exactly one host
Price must be greater than 0
A host can list multiple properties


3. Booking
Represents reservations made by guests for properties.
Attributes:

booking_id (UUID, Primary Key)
property_id (UUID, Foreign Key → Property)
user_id (UUID, Foreign Key → User)
start_date (DATE, NOT NULL)
end_date (DATE, NOT NULL)
total_price (DECIMAL, NOT NULL)
status (ENUM: pending, confirmed, canceled, NOT NULL)
created_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

Business Rules:

End date must be after start date
A property cannot have overlapping bookings with "confirmed" status
Total price is calculated based on price_per_night × number of nights
Users cannot book their own properties


4. Payment
Represents payment transactions for bookings.
Attributes:

payment_id (UUID, Primary Key)
booking_id (UUID, Foreign Key → Booking)
amount (DECIMAL, NOT NULL)
payment_date (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)
payment_method (ENUM: credit_card, paypal, stripe, NOT NULL)

Business Rules:

Each booking can have one or more payments (e.g., deposit + final payment)
Payment amount must match or be less than booking total_price
Payment is processed when booking status changes to "confirmed"


5. Review
Represents reviews left by guests for properties they've stayed at.
Attributes:

review_id (UUID, Primary Key)
property_id (UUID, Foreign Key → Property)
user_id (UUID, Foreign Key → User)
rating (INTEGER, CHECK: 1-5, NOT NULL)
comment (TEXT, NOT NULL)
created_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

Business Rules:

Users can only review properties they have booked and stayed at
Rating must be between 1 and 5
Each user can leave only one review per property
Reviews can only be created after the booking end_date has passed


6. Message
Represents messages exchanged between users (guest-host communication).
Attributes:

message_id (UUID, Primary Key)
sender_id (UUID, Foreign Key → User)
recipient_id (UUID, Foreign Key → User)
message_body (TEXT, NOT NULL)
sent_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

Business Rules:

Sender and recipient must be different users
Messages are stored in chronological order
Both users must exist in the system


Relationships
User ↔ Property (One-to-Many)

Relationship Type: One-to-Many
Description: One user (host) can list multiple properties
Cardinality: 1:N
Foreign Key: Property.host_id references User.user_id
Business Rule: A property must have exactly one host

User ↔ Booking (One-to-Many)

Relationship Type: One-to-Many
Description: One user (guest) can make multiple bookings
Cardinality: 1:N
Foreign Key: Booking.user_id references User.user_id
Business Rule: A booking must be made by exactly one user

Property ↔ Booking (One-to-Many)

Relationship Type: One-to-Many
Description: One property can have multiple bookings over time
Cardinality: 1:N
Foreign Key: Booking.property_id references Property.property_id
Business Rule: Each booking is for exactly one property

Booking ↔ Payment (One-to-Many)

Relationship Type: One-to-Many
Description: One booking can have multiple payments (installments, deposits)
Cardinality: 1:N
Foreign Key: Payment.booking_id references Booking.booking_id
Business Rule: Each payment is associated with exactly one booking

Property ↔ Review (One-to-Many)

Relationship Type: One-to-Many
Description: One property can have multiple reviews from different guests
Cardinality: 1:N
Foreign Key: Review.property_id references Property.property_id
Business Rule: Each review is for exactly one property

User ↔ Review (One-to-Many)

Relationship Type: One-to-Many
Description: One user can write multiple reviews for different properties
Cardinality: 1:N
Foreign Key: Review.user_id references User.user_id
Business Rule: Each review is written by exactly one user

User ↔ Message (Sender) (One-to-Many)

Relationship Type: One-to-Many
Description: One user can send multiple messages
Cardinality: 1:N
Foreign Key: Message.sender_id references User.user_id
Business Rule: Each message has exactly one sender

User ↔ Message (Recipient) (One-to-Many)

Relationship Type: One-to-Many
Description: One user can receive multiple messages
Cardinality: 1:N
Foreign Key: Message.recipient_id references User.user_id
Business Rule: Each message has exactly one recipient


ER Diagram Summary
User (1) ────────< (N) Property
User (1) ────────< (N) Booking
Property (1) ────< (N) Booking
Booking (1) ─────< (N) Payment
Property (1) ────< (N) Review
User (1) ────────< (N) Review
User (1) ────────< (N) Message (as sender)
User (1) ────────< (N) Message (as recipient)

Indexes for Performance
To optimize query performance, the following indexes should be created:

User Table:

Index on email (for login lookups)
Index on role (for filtering by user type)


Property Table:

Index on host_id (for finding all properties by a host)
Index on location (for location-based searches)
Index on price_per_night (for price filtering)


Booking Table:

Index on property_id (for finding bookings for a property)
Index on user_id (for finding user's bookings)
Index on start_date and end_date (for availability queries)
Index on status (for filtering by booking status)


Payment Table:

Index on booking_id (for finding payments for a booking)


Review Table:

Index on property_id (for finding reviews for a property)
Index on user_id (for finding reviews by a user)


Message Table:

Index on sender_id (for finding sent messages)
Index on recipient_id (for finding received messages)




Constraints Summary

Primary Keys: All tables have UUID primary keys for unique identification
Foreign Keys: Enforce referential integrity between related tables
NOT NULL: Critical fields cannot be empty
UNIQUE: Email addresses must be unique
CHECK: Rating must be between 1-5
ENUM: Constrain values for role, status, and payment_method
DEFAULT: Timestamps default to current time


Notes for ERD Creation
When creating the visual ERD in Draw.io:

Use rectangles for entities
Use diamonds or lines for relationships
Label relationship cardinality (1:1, 1:N, N:M)
Include primary keys (underlined) and foreign keys
Show all attributes within each entity
Use different colors for better visual organization:

Blue for core entities (User, Property, Booking)
Green for transaction entities (Payment)
Yellow for interaction entities (Review, Message)




Author: Jason Rippon
Date: October 26, 2025
Project: ALX Airbnb Database Design
