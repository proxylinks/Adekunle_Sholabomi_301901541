-- Show related booking, member, fitness_class records (up to 20).
SELECT t0."booking_id" AS "booking_booking_id",
       t0."booked_at" AS "booking_booked_at",
       t1."member_id" AS "member_member_id",
       t1."full_name" AS "member_full_name",
       t2."class_id" AS "fitness_class_class_id",
       t2."title" AS "fitness_class_title"
FROM portfolio."booking" t0
JOIN portfolio."member" t1 ON t0."member_id" = t1."member_id"
JOIN portfolio."fitness_class" t2 ON t0."class_id" = t2."class_id"
ORDER BY t0."booking_id", t1."member_id", t2."class_id"
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT t0."booking_id" AS "booking_booking_id",
       t0."booked_at" AS "booking_booked_at",
       t1."member_id" AS "member_member_id",
       t1."full_name" AS "member_full_name",
       t2."class_id" AS "fitness_class_class_id",
       t2."title" AS "fitness_class_title"
FROM portfolio."booking" t0
JOIN portfolio."member" t1 ON t0."member_id" = t1."member_id"
JOIN portfolio."fitness_class" t2 ON t0."class_id" = t2."class_id"
ORDER BY t0."booking_id", t1."member_id", t2."class_id"
LIMIT 20;

-- Find booking records where member_id matches 1 (up to 20).
SELECT * FROM portfolio."booking"
WHERE "member_id" IS NOT DISTINCT FROM 1
ORDER BY "booking_id"
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT * FROM portfolio."booking"
WHERE "member_id" IS NOT DISTINCT FROM 1
ORDER BY "booking_id"
LIMIT 20;

-- Count booking records for each member_id (up to 20 groups).
SELECT "member_id", count(*) AS record_count
FROM portfolio."booking"
GROUP BY "member_id"
ORDER BY record_count DESC, "member_id" NULLS LAST
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT "member_id", count(*) AS record_count
FROM portfolio."booking"
GROUP BY "member_id"
ORDER BY record_count DESC, "member_id" NULLS LAST
LIMIT 20;

-- Find fitness_class records where starts_at matches "2026-11-02T09:00:00Z" (up to 20).
SELECT * FROM portfolio."fitness_class"
WHERE "starts_at" IS NOT DISTINCT FROM '2026-11-02T09:00:00Z'
ORDER BY "class_id"
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT * FROM portfolio."fitness_class"
WHERE "starts_at" IS NOT DISTINCT FROM '2026-11-02T09:00:00Z'
ORDER BY "class_id"
LIMIT 20;
