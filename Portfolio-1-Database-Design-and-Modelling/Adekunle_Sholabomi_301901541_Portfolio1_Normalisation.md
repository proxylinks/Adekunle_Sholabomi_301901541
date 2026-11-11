# Gym and Fitness Centre Management System — normalisation

The example uses the saved sample records. The full set of fields is in the design and schema.

## Starting grouped records

| member_id | booking records (list) |
| --- | --- |
| 1 | [5] |
| 2 | [6] |


The record IDs are grouped in a list. In 1NF, each record has its own row and each cell holds one value.

## 1NF: one value per cell

| booking.booking_id | booking.member_id | booking.class_id | booking.status | member.member_id | member.full_name | fitness_class.class_id | fitness_class.title |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 5 | 1 | 3 | booked | 1 | Alex Morgan | 3 | Morning Yoga |
| 6 | 2 | 4 | booked | 2 | Jamie Lee | 4 | Strength Basics |

Key: booking_id.

## 2NF: depend on the whole key

The declared candidate keys do not introduce a partial dependency here, so the 1NF rows stay unchanged at this step.

## booking_example

| booking.booking_id | booking.member_id | booking.class_id | booking.status | member.member_id | member.full_name | fitness_class.class_id | fitness_class.title |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 5 | 1 | 3 | booked | 1 | Alex Morgan | 3 | Morning Yoga |
| 6 | 2 | 4 | booked | 2 | Jamie Lee | 4 | Strength Basics |

## 3NF: store each entity’s details once

The entity keys determine their own descriptions. Related records keep foreign keys rather than repeating those descriptions.

## member

| member_id | full_name | email | joined_on |
| --- | --- | --- | --- |
| 1 | Alex Morgan | alex.morgan@example.test | 2026-01-12 |
| 2 | Jamie Lee | jamie.lee@example.test | 2026-02-03 |

## fitness_class

| class_id | title | starts_at | room | capacity | seats_remaining |
| --- | --- | --- | --- | --- | --- |
| 3 | Morning Yoga | 2026-11-02T09:00:00+00:00 | Studio A | 12 | 10 |
| 4 | Strength Basics | 2026-11-02T10:30:00+00:00 | Studio B | 8 | 7 |

## booking

| booking_id | member_id | class_id | booked_at | status |
| --- | --- | --- | --- | --- |
| 5 | 1 | 3 | 2026-10-20T14:15:00+00:00 | booked |
| 6 | 2 | 4 | 2026-10-21T08:40:00+00:00 | booked |

## Dependencies

- member: (member_id) → full_name, email, joined_on
- fitness_class: (class_id) → title, starts_at, room, capacity, seats_remaining
- booking: (booking_id) → member_id, class_id, booked_at, status

Joining the decomposed sample tables reproduces the original 2 example rows. The design assumes the declared keys describe the relevant business dependencies.
