# Database Seed Data - DML Scripts

## Overview
This directory contains SQL Data Manipulation Language (DML) scripts to populate the Airbnb database with realistic sample data for testing and development purposes.

## File: seed.sql

The `seed.sql` file contains INSERT statements that add sample data to all tables in the Airbnb database.

### Sample Data Included:

#### 1. Users (13 users total)
- **1 Admin**: System administrator
- **4 Hosts**: Users who list properties
- **8 Guests**: Users who book properties

All users have:
- Unique email addresses
- Hashed passwords (bcrypt format)
- South African phone numbers (some optional)
- Realistic names and creation timestamps

#### 2. Properties (8 properties)
Properties across various South African locations:
- **Cape Town**: Seaside villa, waterfront apartment
- **Johannesburg**: Luxury penthouse, studio in Melville
- **Durban**: Beachfront cottage, garden suite
- **Other**: Safari lodge (Mpumalanga), mountain cabin (Drakensberg)

Price range: R850 - R4,200 per night

#### 3. Bookings (8 bookings)
- **5 Confirmed bookings**: With payments processed
- **2 Pending bookings**: Awaiting confirmation
- **1 Canceled booking**: Demonstrates cancellation workflow

All bookings have realistic date ranges and calculated total prices.

#### 4. Payments (7 payments)
- Linked to confirmed bookings only
- Multiple payment methods: credit_card, paypal, stripe
- Some bookings have split payments (deposit + final payment)
- Amounts match booking total prices

#### 5. Reviews (5 reviews)
- Only from guests who have completed bookings
- Ratings range from 4 to 5 stars
- Detailed comments about the stay
- Realistic feedback on properties and hosts

#### 6. Messages (8 messages)
- Communication between guests and hosts
- Inquiries about bookings
- Special requests (parking, amenities, celebrations)
- Follow-up messages after stays
- Demonstrates typical guest-host interactions

### Data Relationships:

The sample data maintains proper referential integrity:
- All properties belong to valid hosts
- All bookings reference existing properties and guests
- All payments are linked to valid bookings
- Reviews are only from guests who booked the properties
- Messages are between registered users

### Real-World Scenarios Covered:

1. **User Management**
   - Different user roles (admin, host, guest)
   - Users with and without phone numbers

2. **Property Listings**
   - Hosts with single and multiple properties
   - Various property types and price points
   - Different locations across South Africa

3. **Booking Workflow**
   - Confirmed bookings with full payment
   - Pending bookings awaiting confirmation
   - Canceled bookings showing lifecycle

4. **Payment Processing**
   - Single full payments
   - Split payments (installments)
   - Different payment methods

5. **Guest Reviews**
   - Various rating levels
   - Positive and constructive feedback
   - Detailed comments

6. **Communication**
   - Pre-booking inquiries
   - Special requests
   - Post-stay follow-ups

### How to Execute:

```bash
# Using MySQL
mysql -u username -p database_name < seed.sql

# Using PostgreSQL
psql -U username -d database_name -f seed.sql
```

### Prerequisites:

Before running this script:
1. The database must exist
2. All tables must be created (run schema.sql first)
3. Tables should be empty or you should clear existing data

### Data Volume:

- 13 Users
- 8 Properties
- 8 Bookings
- 7 Payments
- 5 Reviews
- 8 Messages

**Total: 49 records** across all tables

### Testing Use Cases:

This sample data allows you to test:
- User authentication with different roles
- Property search and filtering
- Booking creation and status management
- Payment processing workflows
- Review submission and display
- Messaging between users
- Admin management functions
- Host property management
- Guest booking history

### Data Quality:

- ✅ All foreign keys reference valid records
- ✅ Email addresses are unique
- ✅ Dates are logical (bookings in future, reviews after stays)
- ✅ Prices are realistic for South African market
- ✅ UUIDs follow proper format
- ✅ ENUM values match defined constraints
- ✅ Review ratings within 1-5 range

### Notes:

- Passwords are hashed (bcrypt format) - not plain text
- UUIDs are pre-generated for consistency
- Timestamps reflect realistic booking patterns
- South African context (locations, phone numbers, currency)
- Data supports both current and future date scenarios

---

**Author:** Jason Rippon  
**Project:** ALX Airbnb Database Design  
**Date:** October 26, 2025
