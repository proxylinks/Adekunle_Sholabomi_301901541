# Gym and Fitness Centre Management System — Entity Relationship diagram

```mermaid
erDiagram
    direction LR
    member {
        bigint member_id PK
        text full_name
        text email UK
        date joined_on
    }
    fitness_class {
        bigint class_id PK
        text title
        timestamptz starts_at
        text room
        integer capacity
        integer seats_remaining
    }
    booking {
        bigint booking_id PK
        bigint member_id FK
        bigint class_id FK
        timestamptz booked_at
        text status
    }
    member ||--o{ booking : "member_id"
    fitness_class ||--o{ booking : "class_id"
```

PK(Primary Key) uniquely identifies a record; FK(Foreign Key) links to another table; UK(Unique Key) marks a single-field unique value. The relationship ends show exactly one, zero or one, or zero or many records. Composite unique keys and conditional rules are listed in the schema and design.

[Diagram image](../images/Adekunle_Sholabomi_301901541_ER_Diagram.png)
