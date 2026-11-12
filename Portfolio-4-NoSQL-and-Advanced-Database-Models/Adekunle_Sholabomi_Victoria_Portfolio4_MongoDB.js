// Run once in mongosh against a fresh exercise database.
// These records are based on fictional events for the case study.
(async function () {
  db = db.getSiblingDB("portfolio_nosql");
  if ((await db.getCollectionNames()).includes("booking_events")) {
    throw new Error(
      "The exercise collection already exists. Use a fresh database.",
    );
  }

  // The validator checks the stable event fields while details can vary.
  await db.createCollection("booking_events", {
    validator: {
      $jsonSchema: {
        bsonType: "object",
        required: [
          "_id",
          "schemaVersion",
          "simulation",
          "eventType",
          "occurredAt",
          "source",
          "embedded",
          "references",
          "details",
        ],
        properties: {
          _id: {
            bsonType: "string",
            minLength: 1,
          },
          schemaVersion: {
            enum: [1],
          },
          simulation: {
            enum: [true],
          },
          eventType: {
            bsonType: "string",
            enum: ["booking_created", "booking_cancelled"],
          },
          occurredAt: {
            bsonType: "date",
          },
          source: {
            bsonType: "object",
            required: ["entity", "key", "snapshot"],
            properties: {
              entity: {
                enum: ["booking"],
              },
              key: {
                bsonType: "object",
                required: ["booking_id"],
              },
              snapshot: {
                bsonType: "object",
              },
            },
          },
          embedded: {
            bsonType: "object",
          },
          references: {
            bsonType: "object",
          },
          details: {
            bsonType: "object",
          },
        },
      },
    },
    validationLevel: "strict",
    validationAction: "error",
  });

  // Insert the four example events and show their IDs.
  printjson(
    await db.getCollection("booking_events").insertMany([
      {
        _id: "event_000001",
        schemaVersion: 1,
        simulation: true,
        eventType: "booking_created",
        occurredAt: ISODate("2030-01-01T10:00:00Z"),
        source: {
          entity: "booking",
          key: {
            booking_id: 5,
          },
          snapshot: {
            booking_id: 5,
            member_id: 1,
            class_id: 3,
            booked_at: "2026-10-20T14:15:00Z",
            status: "booked",
          },
        },
        embedded: {
          member: [
            {
              key: {
                member_id: 1,
              },
              snapshot: {
                member_id: 1,
                full_name: "Alex Johnson",
                email: "alex.johnson@example.test",
                joined_on: "2026-01-12",
              },
              via: ["booking.member_id → member"],
            },
          ],
          fitness_class: [
            {
              key: {
                class_id: 3,
              },
              snapshot: {
                class_id: 3,
                title: "Morning Yoga",
                starts_at: "2026-11-02T09:00:00Z",
                room: "Studio A",
                capacity: 12,
                seats_remaining: 10,
              },
              via: ["booking.class_id → fitness_class"],
            },
          ],
        },
        references: {},
        details: {
          channel: "web",
        },
      },
      {
        _id: "event_000002",
        schemaVersion: 1,
        simulation: true,
        eventType: "booking_cancelled",
        occurredAt: ISODate("2030-01-01T10:01:00Z"),
        source: {
          entity: "booking",
          key: {
            booking_id: 5,
          },
          snapshot: {
            booking_id: 5,
            member_id: 1,
            class_id: 3,
            booked_at: "2026-10-20T14:15:00Z",
            status: "booked",
          },
        },
        embedded: {
          member: [
            {
              key: {
                member_id: 1,
              },
              snapshot: {
                member_id: 1,
                full_name: "Alex Johnson",
                email: "alex.morgan@example.test",
                joined_on: "2026-01-12",
              },
              via: ["booking.member_id → member"],
            },
          ],
          fitness_class: [
            {
              key: {
                class_id: 3,
              },
              snapshot: {
                class_id: 3,
                title: "Morning Yoga",
                starts_at: "2026-11-02T09:00:00Z",
                room: "Studio A",
                capacity: 12,
                seats_remaining: 10,
              },
              via: ["booking.class_id → fitness_class"],
            },
          ],
        },
        references: {},
        details: {
          channel: "mobile",
          note: "Illustrative event-specific metadata",
          examples: {
            cancellation_reason: "illustrative cancellation_reason",
            check_in_method: "illustrative check_in_method",
            staff_note: "illustrative staff_note",
          },
        },
      },
      {
        _id: "event_000003",
        schemaVersion: 1,
        simulation: true,
        eventType: "booking_created",
        occurredAt: ISODate("2030-01-01T10:02:00Z"),
        source: {
          entity: "booking",
          key: {
            booking_id: 6,
          },
          snapshot: {
            booking_id: 6,
            member_id: 2,
            class_id: 4,
            booked_at: "2026-10-21T08:40:00Z",
            status: "booked",
          },
        },
        embedded: {
          member: [
            {
              key: {
                member_id: 2,
              },
              snapshot: {
                member_id: 2,
                full_name: "Jamie Lee",
                email: "jamie.lee@example.test",
                joined_on: "2026-02-03",
              },
              via: ["booking.member_id → member"],
            },
          ],
          fitness_class: [
            {
              key: {
                class_id: 4,
              },
              snapshot: {
                class_id: 4,
                title: "Strength Basics",
                starts_at: "2026-11-02T10:30:00Z",
                room: "Studio B",
                capacity: 8,
                seats_remaining: 7,
              },
              via: ["booking.class_id → fitness_class"],
            },
          ],
        },
        references: {},
        details: {
          channel: "web",
        },
      },
      {
        _id: "event_000004",
        schemaVersion: 1,
        simulation: true,
        eventType: "booking_cancelled",
        occurredAt: ISODate("2030-01-01T10:03:00Z"),
        source: {
          entity: "booking",
          key: {
            booking_id: 6,
          },
          snapshot: {
            booking_id: 6,
            member_id: 2,
            class_id: 4,
            booked_at: "2026-10-21T08:40:00Z",
            status: "booked",
          },
        },
        embedded: {
          member: [
            {
              key: {
                member_id: 2,
              },
              snapshot: {
                member_id: 2,
                full_name: "Jamie Lee",
                email: "jamie.lee@example.test",
                joined_on: "2026-02-03",
              },
              via: ["booking.member_id → member"],
            },
          ],
          fitness_class: [
            {
              key: {
                class_id: 4,
              },
              snapshot: {
                class_id: 4,
                title: "Strength Basics",
                starts_at: "2026-11-02T10:30:00Z",
                room: "Studio B",
                capacity: 8,
                seats_remaining: 7,
              },
              via: ["booking.class_id → fitness_class"],
            },
          ],
        },
        references: {},
        details: {
          channel: "mobile",
          note: "Illustrative event-specific metadata",
          examples: {
            cancellation_reason: "illustrative cancellation_reason",
            check_in_method: "illustrative check_in_method",
            staff_note: "illustrative staff_note",
          },
        },
      },
    ]),
  );
  await db
    .getCollection("booking_events")
    .createIndex({ eventType: 1, occurredAt: -1 }, { name: "event_type_time" });

  // 1. Find the first sample event type (up to five documents).
  printjson(
    await db
      .getCollection("booking_events")
      .find({ eventType: "booking_created" })
      .sort({ _id: 1 })
      .limit(5)
      .toArray(),
  );

  // 2. Find events for the first source record using nested key fields (up to five).
  printjson(
    await db
      .getCollection("booking_events")
      .find({ "source.key.booking_id": 5 })
      .sort({ _id: 1 })
      .limit(5)
      .toArray(),
  );

  // 3. Find events in the sample time range using a MongoDB Date filter (up to five).
  printjson(
    await db
      .getCollection("booking_events")
      .find({
        occurredAt: {
          $gte: ISODate("2030-01-01T10:00:00Z"),
          $lt: ISODate("2030-01-01T11:00:00Z"),
        },
      })
      .sort({ _id: 1 })
      .limit(5)
      .toArray(),
  );

  // 4. Count documents for each event type.
  printjson(
    await db
      .getCollection("booking_events")
      .aggregate([
        { $group: { _id: "$eventType", documentCount: { $sum: 1 } } },
        { $sort: { _id: 1 } },
      ])
      .toArray(),
  );

  // A date stored as text should be rejected by the validator.
  try {
    await db.getCollection("booking_events").insertOne({
      ...{
        _id: "event_000001",
        schemaVersion: 1,
        simulation: true,
        eventType: "booking_created",
        occurredAt: ISODate("2030-01-01T10:00:00Z"),
        source: {
          entity: "booking",
          key: {
            booking_id: 5,
          },
          snapshot: {
            booking_id: 5,
            member_id: 1,
            class_id: 3,
            booked_at: "2026-10-20T14:15:00Z",
            status: "booked",
          },
        },
        embedded: {
          member: [
            {
              key: {
                member_id: 1,
              },
              snapshot: {
                member_id: 1,
                full_name: "Alex Johnson",
                email: "alex.johnson@example.test",
                joined_on: "2026-01-12",
              },
              via: ["booking.member_id → member"],
            },
          ],
          fitness_class: [
            {
              key: {
                class_id: 3,
              },
              snapshot: {
                class_id: 3,
                title: "Morning Yoga",
                starts_at: "2026-11-02T09:00:00Z",
                room: "Studio A",
                capacity: 12,
                seats_remaining: 10,
              },
              via: ["booking.class_id → fitness_class"],
            },
          ],
        },
        references: {},
        details: {
          channel: "web",
        },
      },
      _id: "invalid_date_example",
      occurredAt: "not-a-date",
    });
  } catch (error) {
    print("Invalid date error: " + error.code);
  }

  // Reusing an event ID should be rejected by the unique _id index.
  try {
    await db.getCollection("booking_events").insertOne({
      _id: "event_000001",
      schemaVersion: 1,
      simulation: true,
      eventType: "booking_created",
      occurredAt: ISODate("2030-01-01T10:00:00Z"),
      source: {
        entity: "booking",
        key: {
          booking_id: 5,
        },
        snapshot: {
          booking_id: 5,
          member_id: 1,
          class_id: 3,
          booked_at: "2026-10-20T14:15:00Z",
          status: "booked",
        },
      },
      embedded: {
        member: [
          {
            key: {
              member_id: 1,
            },
            snapshot: {
              member_id: 1,
              full_name: "Alex Johnson",
              email: "alex.johnson@example.test",
              joined_on: "2026-01-12",
            },
            via: ["booking.member_id → member"],
          },
        ],
        fitness_class: [
          {
            key: {
              class_id: 3,
            },
            snapshot: {
              class_id: 3,
              title: "Morning Yoga",
              starts_at: "2026-11-02T09:00:00Z",
              room: "Studio A",
              capacity: 12,
              seats_remaining: 10,
            },
            via: ["booking.class_id → fitness_class"],
          },
        ],
      },
      references: {},
      details: {
        channel: "web",
      },
    });
  } catch (error) {
    print("Duplicate ID error: " + error.code);
  }

  print(
    "Document count: " +
      (await db.getCollection("booking_events").countDocuments()),
  );
})().catch((error) => {
  print(error.stack || String(error));
  quit(1);
});
