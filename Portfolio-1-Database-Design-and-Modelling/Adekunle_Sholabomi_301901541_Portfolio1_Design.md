# Gym and Fitness Centre Management System — database design

My case study records member, fitness_class, booking.

## Users

- Gym members
- Gym staff
- Fitness class coaches

## Main operations

- Register members
- Schedule fitness classes
- Book or cancel a class
- Review class schedules and booking totals

## Entities

| Entity | Information stored |
| --- | --- |
| member | A person eligible to book gym fitness classes. |
| fitness_class | A scheduled, capacity-limited fitness class at the gym. |
| booking | A member's reservation or attendance record for one scheduled class. |

## member

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| member_id | BIGINT | PK | Yes |
| full_name | TEXT |  | Yes |
| email | TEXT | Unique | Yes |
| joined_on | DATE |  | Yes |
- Unique key: (email).

## fitness_class

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| class_id | BIGINT | PK | Yes |
| title | TEXT |  | Yes |
| starts_at | TIMESTAMPTZ |  | Yes |
| room | TEXT |  | Yes |
| capacity | INTEGER |  | Yes |
| seats_remaining | INTEGER |  | Yes |
- Unique key: (room, starts_at).

## booking

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| booking_id | BIGINT | PK | Yes |
| member_id | BIGINT | FK | Yes |
| class_id | BIGINT | FK | Yes |
| booked_at | TIMESTAMPTZ |  | Yes |
| status | TEXT |  | Yes |
- member_id → member.member_id
- class_id → fitness_class.class_id

## Relationships and business rules

- Each member's email address is required and unique.
- A class must have positive capacity, and seats_remaining must be between zero and capacity inclusive.
- Every booking member_id must reference an existing member.member_id.
- Every booking class_id must reference an existing fitness_class.class_id.
- Booking status is limited to booked, cancelled, or attended.
- A partial unique constraint on member_id and class_id, applying only where status is booked, prevents duplicate active reservations by the same member for the same class.

## Assumptions

- Each booking refers to one member and one scheduled class.
- Class start times are stored in UTC; each class has a fixed room and capacity.
- A booking status is booked, cancelled, or attended. Only booked reservations consume a seat.
- Booking transactions lock the fitness_class row before changing seats_remaining; a partial unique constraint prevents duplicate active bookings.
- Normalization example: booking is the root relation, with member_id and class_id as separate foreign keys. Member details belong in member and scheduled-class details belong in fitness_class, avoiding repeated ancestor roles in booking.
- All example names, contact details, schedules, and records are synthetic; IDs are globally unique across these entities.