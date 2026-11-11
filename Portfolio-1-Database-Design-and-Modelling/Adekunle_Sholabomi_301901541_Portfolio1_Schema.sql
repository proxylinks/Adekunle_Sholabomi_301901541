-- Gym and Fitness Centre Management System: tables, keys and business constraints.
-- Run once in a fresh PostgreSQL database.
BEGIN;
SET LOCAL standard_conforming_strings = on;
CREATE SCHEMA portfolio;
CREATE TABLE portfolio."member" (
  "member_id" bigint NOT NULL,
  "full_name" text NOT NULL,
  "email" text NOT NULL,
  "joined_on" date NOT NULL,
  CONSTRAINT "pk_member" PRIMARY KEY ("member_id"),
  CONSTRAINT "uq_member_0" UNIQUE ("email")
);
CREATE TABLE portfolio."fitness_class" (
  "class_id" bigint NOT NULL,
  "title" text NOT NULL,
  "starts_at" timestamptz NOT NULL,
  "room" text NOT NULL,
  "capacity" bigint NOT NULL,
  "seats_remaining" bigint NOT NULL,
  CONSTRAINT "pk_fitness_class" PRIMARY KEY ("class_id"),
  CONSTRAINT "uq_fitness_class_0" UNIQUE ("room", "starts_at")
);
CREATE TABLE portfolio."booking" (
  "booking_id" bigint NOT NULL,
  "member_id" bigint NOT NULL,
  "class_id" bigint NOT NULL,
  "booked_at" timestamptz NOT NULL,
  "status" text NOT NULL,
  CONSTRAINT "pk_booking" PRIMARY KEY ("booking_id")
);
ALTER TABLE portfolio."booking" ADD CONSTRAINT "fk_booking_0" FOREIGN KEY ("member_id") REFERENCES portfolio."member" ("member_id");
ALTER TABLE portfolio."booking" ADD CONSTRAINT "fk_booking_1" FOREIGN KEY ("class_id") REFERENCES portfolio."fitness_class" ("class_id");
ALTER TABLE portfolio."fitness_class" ADD CONSTRAINT "class_seat_bounds" CHECK (("capacity" > 0) AND ("seats_remaining" >= 0) AND ("capacity" > "seats_remaining"));
ALTER TABLE portfolio."booking" ADD CONSTRAINT "booking_status_check" CHECK (("status" = 'booked') OR ("status" = 'cancelled') OR ("status" = 'attended'));
CREATE UNIQUE INDEX "active_booking_unique" ON portfolio."booking" ("member_id", "class_id") WHERE ("status" = 'booked');
COMMIT;