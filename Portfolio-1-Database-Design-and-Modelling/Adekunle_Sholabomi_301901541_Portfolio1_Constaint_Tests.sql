-- Run these deliberately invalid statements one at a time, outside a transaction.
-- Each should fail at the named constraint; the sample rows should remain unchanged.

-- 1. member primary key duplicate. Expected: pk_member, SQLSTATE 23505.
INSERT INTO portfolio."member" ("member_id", "full_name", "email", "joined_on")
VALUES (1, 'Alex Johnson', 'alex_johnson@example.test', '2026-03-01');

-- 2. member email duplicate. Expected: uq_member_0, SQLSTATE 23505.
INSERT INTO portfolio."member" ("member_id", "full_name", "email", "joined_on")
VALUES (101, 'Alex Johnson', 'alex_johnson@example.test', '2026-03-01');

-- 3. member member id null. Expected: member_id, SQLSTATE 23502.
INSERT INTO portfolio."member" ("member_id", "full_name", "email", "joined_on")
VALUES (NULL, 'Alex Johnson', 'alex_johnson@example.test', '2026-03-01');

-- 4. member full name null. Expected: full_name, SQLSTATE 23502.
INSERT INTO portfolio."member" ("member_id", "full_name", "email", "joined_on")
VALUES (102, NULL, 'alex_johnson@example.test', '2026-03-01');

-- 5. member email null. Expected: email, SQLSTATE 23502.
INSERT INTO portfolio."member" ("member_id", "full_name", "email", "joined_on")
VALUES (103, 'Alex Johnson', NULL, '2026-03-01');

-- 6. member joined on null. Expected: joined_on, SQLSTATE 23502.
INSERT INTO portfolio."member" ("member_id", "full_name", "email", "joined_on")
VALUES (104, 'Alex Johnson', 'alex_johnson@example.test', NULL);

-- 7. class pk duplicate. Expected: pk_fitness_class, SQLSTATE 23505.
INSERT INTO portfolio."fitness_class" ("class_id", "title", "starts_at", "room", "capacity", "seats_remaining")
VALUES (3, 'Evening Pilates', '2026-11-03T18:00:00Z', 'Studio C', 10, 8);

-- 8. class room time duplicate. Expected: uq_fitness_class_0, SQLSTATE 23505.
INSERT INTO portfolio."fitness_class" ("class_id", "title", "starts_at", "room", "capacity", "seats_remaining")
VALUES (105, 'Another Yoga', '2026-11-02T09:00:00Z', 'Studio A', 10, 8);

-- 9. class class id null. Expected: class_id, SQLSTATE 23502.
INSERT INTO portfolio."fitness_class" ("class_id", "title", "starts_at", "room", "capacity", "seats_remaining")
VALUES (NULL, 'Evening Pilates', '2026-11-03T18:00:00Z', 'Studio C', 10, 8);

-- 10. class title null. Expected: title, SQLSTATE 23502.
INSERT INTO portfolio."fitness_class" ("class_id", "title", "starts_at", "room", "capacity", "seats_remaining")
VALUES (106, NULL, '2026-11-03T18:00:00Z', 'Studio C', 10, 8);

-- 11. class starts at null. Expected: starts_at, SQLSTATE 23502.
INSERT INTO portfolio."fitness_class" ("class_id", "title", "starts_at", "room", "capacity", "seats_remaining")
VALUES (107, 'Evening Pilates', NULL, 'Studio C', 10, 8);

-- 12. class room null. Expected: room, SQLSTATE 23502.
INSERT INTO portfolio."fitness_class" ("class_id", "title", "starts_at", "room", "capacity", "seats_remaining")
VALUES (108, 'Evening Pilates', '2026-11-03T18:00:00Z', NULL, 10, 8);

-- 13. class capacity null. Expected: capacity, SQLSTATE 23502.
INSERT INTO portfolio."fitness_class" ("class_id", "title", "starts_at", "room", "capacity", "seats_remaining")
VALUES (109, 'Evening Pilates', '2026-11-03T18:00:00Z', 'Studio C', NULL, 8);

-- 14. class seats remaining null. Expected: seats_remaining, SQLSTATE 23502.
INSERT INTO portfolio."fitness_class" ("class_id", "title", "starts_at", "room", "capacity", "seats_remaining")
VALUES (110, 'Evening Pilates', '2026-11-03T18:00:00Z', 'Studio C', 10, NULL);

-- 15. booking pk duplicate. Expected: pk_booking, SQLSTATE 23505.
INSERT INTO portfolio."booking" ("booking_id", "member_id", "class_id", "booked_at", "status")
VALUES (5, 1, 4, '2026-10-22T12:00:00Z', 'booked');

-- 16. booking member fk invalid. Expected: fk_booking_0, SQLSTATE 23503.
INSERT INTO portfolio."booking" ("booking_id", "member_id", "class_id", "booked_at", "status")
VALUES (111, 7001, 3, '2026-10-22T12:00:00Z', 'booked');

-- 17. booking class fk invalid. Expected: fk_booking_1, SQLSTATE 23503.
INSERT INTO portfolio."booking" ("booking_id", "member_id", "class_id", "booked_at", "status")
VALUES (112, 1, 7002, '2026-10-22T12:00:00Z', 'booked');

-- 18. booking booking id null. Expected: booking_id, SQLSTATE 23502.
INSERT INTO portfolio."booking" ("booking_id", "member_id", "class_id", "booked_at", "status")
VALUES (NULL, 1, 4, '2026-10-22T12:00:00Z', 'booked');

-- 19. booking member id null. Expected: member_id, SQLSTATE 23502.
INSERT INTO portfolio."booking" ("booking_id", "member_id", "class_id", "booked_at", "status")
VALUES (113, NULL, 3, '2026-10-22T12:00:00Z', 'booked');

-- 20. booking class id null. Expected: class_id, SQLSTATE 23502.
INSERT INTO portfolio."booking" ("booking_id", "member_id", "class_id", "booked_at", "status")
VALUES (114, 1, NULL, '2026-10-22T12:00:00Z', 'booked');

-- 21. booking booked at null. Expected: booked_at, SQLSTATE 23502.
INSERT INTO portfolio."booking" ("booking_id", "member_id", "class_id", "booked_at", "status")
VALUES (115, 1, 4, NULL, 'booked');

-- 22. booking status null. Expected: status, SQLSTATE 23502.
INSERT INTO portfolio."booking" ("booking_id", "member_id", "class_id", "booked_at", "status")
VALUES (116, 1, 4, '2026-10-22T12:00:00Z', NULL);

-- 23. class seat bounds invalid. Expected: class_seat_bounds, SQLSTATE 23514.
INSERT INTO portfolio."fitness_class" ("class_id", "title", "starts_at", "room", "capacity", "seats_remaining")
VALUES (117, 'Invalid Capacity', '2026-11-04T18:00:00Z', 'Studio D', 0, 0);

-- 24. booking status invalid. Expected: booking_status_check, SQLSTATE 23514.
INSERT INTO portfolio."booking" ("booking_id", "member_id", "class_id", "booked_at", "status")
VALUES (118, 1, 4, '2026-10-22T12:00:00Z', 'pending');

-- 25. active booking duplicate. Expected: active_booking_unique, SQLSTATE 23505.
INSERT INTO portfolio."booking" ("booking_id", "member_id", "class_id", "booked_at", "status")
VALUES (119, 1, 3, '2026-10-23T09:00:00Z', 'booked');