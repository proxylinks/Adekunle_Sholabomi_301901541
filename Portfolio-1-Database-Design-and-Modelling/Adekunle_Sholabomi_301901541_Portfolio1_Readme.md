# Portfolio 1 — Database Design and Modelling

I organised the data into member, fitness_class, booking. The design document explains the fields, keys, relationships and business rules. The normalisation document shows the sample tables at 1NF, 2NF and 3NF.

## Database checks

| Table         | Rows |
| ------------- | ---- |
| member        | 2    |
| fitness_class | 2    |
| booking       | 2    |

The 25 invalid inserts were rejected at their expected constraints, and the valid sample rows remained unchanged.

## Files

- [Design](Adekunle_Sholabomi_301901541_Portfolio1_Design.md)
- [ER diagram](Adekunle_Sholabomi_301901541_Portfolio1_ER_Diagram.md)
- [Normalisation](Adekunle_Sholabomi_301901541_Porfolio1_Normalisation.md)
- [Schema](Adekunle_Sholabomi_301901541_Portfolio1_Schema.sql)
- [Sample data](Adekunle_Sholabomi_301901541_Portfolio1_Sample_Data.sql)
- [Constraint tests](Adekunle_Sholabomi_301901541_Porfolio1_Constraint_Tests.sql)
- [Table and constraint evidence](screenshots/Adekunle_Sholabomi_301901541_Portfolio1_Database_Results.png)

## Run the SQL

Create a fresh PostgreSQL database. Run the schema first, then the sample data. Run the deliberately invalid statements in Constraint_Tests.sql individually outside a transaction; each is expected to produce an error.

## References

- [PostgreSQL — constraints](https://www.postgresql.org/docs/17/ddl-constraints.html)
