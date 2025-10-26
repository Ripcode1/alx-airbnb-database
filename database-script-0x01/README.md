# Database Schema - DDL Scripts

## Overview
This directory contains the SQL Data Definition Language (DDL) scripts for creating the Airbnb database schema.

## File: schema.sql

The `schema.sql` file contains CREATE TABLE statements for all entities in the Airbnb database system.

### Tables Created:

1. **User** - Stores all user accounts (guests, hosts, and admins)
2. **Property** - Stores property listings created by hosts
3. **Booking** - Stores booking/reservation information
4. **Payment** - Stores payment transaction records
5. **Review** - Stores property reviews from guests
6. **Message** - Stores messages between users (guest-host communication)

### Key Features:

#### Primary Keys
- All tables use UUID as primary keys
- Automatically indexed for optimal lookup performance

#### Foreign Keys
- **Property.host_id** → References User(user_id)
- **Booking.property_id** → References Property(property_id)
- **Booking.user_id** → References User(user_id)
- **Payment.booking_id** → References Booking(booking_id)
- **Review.property_id** → References Property(property_id)
- **Review.user_id** → References User(user_id)
- **Message.sender_id** → References User(user_id)
- **Message.recipient_id** → References User(user_id)

#### Constraints
- **NOT NULL**: Required fields cannot be empty
- **UNIQUE**: Email addresses must be unique in User table
- **CHECK**: Rating values constrained between 1 and 5
- **ENUM**: Restricted values for role, status, and payment_method
- **CASCADE**: Foreign key actions for maintaining referential integrity

#### Indexes
The following indexes are created for query optimization:
- `idx_user_email` - Fast user lookup by email (login)
- `idx_property_id` - Property lookups
- `idx_booking_property_id` - Find bookings for a property
- `idx_booking_booking_id` - Booking lookups
- `idx_payment_booking_id` - Find payments for a booking

### Data Types Used:

- **UUID**: Unique identifiers for all primary keys
- **VARCHAR**: Text fields with specified maximum length
- **TEXT**: Large text fields (descriptions, comments, messages)
- **DECIMAL(10,2)**: Monetary values (prices, amounts)
- **DATE**: Calendar dates (start_date, end_date)
- **TIMESTAMP**: Date and time values with automatic defaults
- **INTEGER**: Whole numbers (ratings)
- **ENUM**: Predefined set of values (role, status, payment_method)

### Relationships:

```
User (1) ─────── (Many) Property
User (1) ─────── (Many) Booking
Property (1) ─── (Many) Booking
Booking (1) ──── (Many) Payment
Property (1) ─── (Many) Review
User (1) ─────── (Many) Review
User (1) ─────── (Many) Message (as sender)
User (1) ─────── (Many) Message (as recipient)
```

### How to Execute:

```bash
# Using MySQL
mysql -u username -p database_name < schema.sql

# Using PostgreSQL
psql -U username -d database_name -f schema.sql
```

### Design Principles:

1. **Normalization**: Database design follows Third Normal Form (3NF)
2. **Referential Integrity**: Foreign keys ensure data consistency
3. **Performance**: Strategic indexes on frequently queried columns
4. **Scalability**: UUID primary keys support distributed systems
5. **Data Integrity**: Constraints prevent invalid data entry

### Notes:

- All foreign keys use CASCADE actions for automatic cleanup
- Timestamps use DEFAULT CURRENT_TIMESTAMP for automatic tracking
- Property table includes ON UPDATE CURRENT_TIMESTAMP for updated_at field
- ENUM types ensure data consistency for categorical fields

---

**Author:** Jason Rippon  
**Project:** ALX Airbnb Database Design  
**Date:** October 26, 2025
