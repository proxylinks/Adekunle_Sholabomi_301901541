# Gym and Fitness Centre Management System — SQL queries

## 1. Show related booking, member, fitness_class records (up to 20).

```sql
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
```

| booking_booking_id | booking_booked_at | member_member_id | member_full_name | fitness_class_class_id | fitness_class_title |
| --- | --- | --- | --- | --- | --- |
| 5 | 2026-10-20T14:15:00+00:00 | 1 | Alex Morgan | 3 | Morning Yoga |
| 6 | 2026-10-21T08:40:00+00:00 | 2 | Jamie Lee | 4 | Strength Basics |

## 2. Find booking records where member_id matches 1 (up to 20).

```sql
SELECT * FROM portfolio."booking"
WHERE "member_id" IS NOT DISTINCT FROM 1
ORDER BY "booking_id"
LIMIT 20;
```

| booking_id | member_id | class_id | booked_at | status |
| --- | --- | --- | --- | --- |
| 5 | 1 | 3 | 2026-10-20T14:15:00+00:00 | booked |

## 3. Count booking records for each member_id (up to 20 groups).

```sql
SELECT "member_id", count(*) AS record_count
FROM portfolio."booking"
GROUP BY "member_id"
ORDER BY record_count DESC, "member_id" NULLS LAST
LIMIT 20;
```

| member_id | record_count |
| --- | --- |
| 1 | 1 |
| 2 | 1 |

## 4. Find fitness_class records where starts_at matches "2026-11-02T09:00:00Z" (up to 20).

```sql
SELECT * FROM portfolio."fitness_class"
WHERE "starts_at" IS NOT DISTINCT FROM '2026-11-02T09:00:00Z'
ORDER BY "class_id"
LIMIT 20;
```

| class_id | title | starts_at | room | capacity | seats_remaining |
| --- | --- | --- | --- | --- | --- |
| 3 | Morning Yoga | 2026-11-02T09:00:00+00:00 | Studio A | 12 | 10 |


## Index comparison

| Phase | Median (ms) | Three runs (ms) | Plan nodes | Buffer hits |
| --- | --- | --- | --- | --- |
| Before index | 0.917 | 0.917, 0.91, 0.921 | Sort → Seq Scan | 112 |
| After index | 0.171 | 0.144, 0.193, 0.171 | Sort → Bitmap Heap Scan → Bitmap Index Scan | 25 |

The median execution time changed from 0.917 ms to 0.171 ms. The measured plan used p2_filter_idx. The results matched in both phases. An index adds storage and write-maintenance costs; timings depend on the selected lookup and environment.

## Execution plans

### Before index, run 1

```text
Sort (actual time=0.898..0.899 rows=20 loops=1)
  Seq Scan on fitness_class (actual time=0.012..0.869 rows=20 loops=1)
Planning Time: 0.251 ms
Execution Time: 0.917 ms
```

### Before index, run 2

```text
Sort (actual time=0.89..0.891 rows=20 loops=1)
  Seq Scan on fitness_class (actual time=0.011..0.863 rows=20 loops=1)
Planning Time: 0.245 ms
Execution Time: 0.91 ms
```

### Before index, run 3

```text
Sort (actual time=0.902..0.903 rows=20 loops=1)
  Seq Scan on fitness_class (actual time=0.012..0.873 rows=20 loops=1)
Planning Time: 0.271 ms
Execution Time: 0.921 ms
```

### After index, run 1

```text
Sort (actual time=0.101..0.102 rows=20 loops=1)
  Bitmap Heap Scan on fitness_class (actual time=0.023..0.073 rows=20 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.013..0.013 rows=20 loops=1)
Planning Time: 0.443 ms
Execution Time: 0.144 ms
```

### After index, run 2

```text
Sort (actual time=0.146..0.148 rows=20 loops=1)
  Bitmap Heap Scan on fitness_class (actual time=0.027..0.084 rows=20 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.014..0.015 rows=20 loops=1)
Planning Time: 0.448 ms
Execution Time: 0.193 ms
```

### After index, run 3

```text
Sort (actual time=0.108..0.109 rows=20 loops=1)
  Bitmap Heap Scan on fitness_class (actual time=0.025..0.074 rows=20 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.014..0.014 rows=20 loops=1)
Planning Time: 0.428 ms
Execution Time: 0.171 ms
```

## Reproduce

Use a fresh database with the Portfolio 1 schema and sample data. Run Adekunle_Sholabomi_301901541_P2_Queries.sql, then Adekunle_Sholabomi_301901541_Portfolio2_Optimisation.sql. The optimisation script creates a separate performance table and runs EXPLAIN (ANALYZE, BUFFERS).

[Query screenshot](screenshots/Adekunle_Sholabomi_301901541_Portfolio2_Query_Results.png) · [Index comparison](screenshots/Adekunle_Sholabomi_301901541_Portfolio2_Index_Comparison.png)

## References

- [PostgreSQL — EXPLAIN](https://www.postgresql.org/docs/17/using-explain.html)