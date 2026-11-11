-- Sample records for Gym and Fitness Centre Management System.
BEGIN;
SET LOCAL standard_conforming_strings = on;
INSERT INTO portfolio."member" ("member_id", "full_name", "email", "joined_on") VALUES (1, 'Alex Morgan', 'alex.morgan@example.test', '2026-01-12');
INSERT INTO portfolio."member" ("member_id", "full_name", "email", "joined_on") VALUES (2, 'Jamie Lee', 'jamie.lee@example.test', '2026-02-03');
INSERT INTO portfolio."fitness_class" ("class_id", "title", "starts_at", "room", "capacity", "seats_remaining") VALUES (3, 'Morning Yoga', '2026-11-02T09:00:00Z', 'Studio A', 12, 10);
INSERT INTO portfolio."fitness_class" ("class_id", "title", "starts_at", "room", "capacity", "seats_remaining") VALUES (4, 'Strength Basics', '2026-11-02T10:30:00Z', 'Studio B', 8, 7);
INSERT INTO portfolio."booking" ("booking_id", "member_id", "class_id", "booked_at", "status") VALUES (5, 1, 3, '2026-10-20T14:15:00Z', 'booked');
INSERT INTO portfolio."booking" ("booking_id", "member_id", "class_id", "booked_at", "status") VALUES (6, 2, 4, '2026-10-21T08:40:00Z', 'booked');
COMMIT;
