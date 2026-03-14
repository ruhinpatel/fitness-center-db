# Fitness-center-db

A relational database management system for fitness center operations, built with SQL, Flask, and SQLAlchemy. Includes a normalized 8-table schema, 10 analytical SQL queries, and a web-based GUI for data management and query execution.

---

## Overview

Fitness centers generate daily operational data across locations, rooms, sessions, trainers, and participants. This project models that domain as a normalized relational database with enforced referential integrity, and exposes it through a Flask web application that allows non-technical users to manage records and run predefined analytical queries without writing SQL.

---

## Schema

8 tables with foreign key constraints, cascade rules, and check constraints:

| Table | Description |
|---|---|
| Center | Fitness center locations |
| Room | Rooms within each center, with capacity constraints |
| Session | Base table for all session types (date, time, type, room, center) |
| GroupSession | Subtype of Session, linked to a Trainer |
| IndividualSession | Subtype of Session |
| Person | All individuals in the system |
| Trainer | Subtype of Person, with diploma attribute |
| Participation | Many-to-many join between Person and Session |

**Key design decisions:**
- Session uses a table inheritance pattern: GroupSession and IndividualSession both reference Session via foreign key, separating shared attributes from subtype-specific ones
- Cascade deletes propagate from Center down through Room and Session
- Room capacity enforced at the schema level via CHECK constraint

---

## Analytical Queries

10 complex SQL queries covering:

1. Most popular sessions by participant count
2. Average room capacity per center
3. Trainers leading the most sessions
4. Distribution of session types across all centers
5. Sessions conducted per day per center
6. Busiest hours of the day per center
7. Most frequently used rooms
8. Ratio of group to individual sessions per center
9. Most active participants by session attendance
10. Average age of participants by session type

Queries use multi-table JOINs, GROUP BY aggregations, AVG, COUNT, CASE expressions, NULLIF, and date functions.

---

## Stack

- **Database:** SQLite via SQLAlchemy ORM
- **Backend:** Python, Flask
- **Frontend:** HTML, CSS, Bootstrap
- **Schema:** SQL (CREATE, INSERT, constraints, foreign keys)

---

## Project Structure
```
fitness-center-db/
├── app.py                          # Flask application, routes, ORM models
├── CreateDB-FinalGroupProject.sql  # Schema creation and seed data
├── QueryDB-FinalGroupProject.sql   # 10 analytical queries
├── initialize_db.py                # Database initialization script
├── templates/
│   ├── base.html
│   ├── home.html
│   ├── centers.html
│   ├── rooms.html
│   ├── sessions.html
│   ├── persons.html
│   ├── trainers.html
│   ├── participations.html
│   └── interesting_questions.html
└── static/
    └── styles.css
```

---

## Setup and Running
```bash
# Clone the repo
git clone https://github.com/ruhinpatel/fitness-center-db.git
cd fitness-center-db

# Install dependencies
pip install flask flask-sqlalchemy

# Run the application
python app.py
```

Open http://localhost:5000 in your browser.

The database initializes automatically on first run, creates all tables, and loads seed data from the SQL file.

---

## Features

- **Centers:** View and add fitness center locations
- **Rooms:** View and add rooms with capacity constraints per center
- **Sessions:** View and add sessions with date, time, type, room, and center
- **Trainers:** View and add trainers with diploma details
- **Participants:** View and add participant records
- **Analytical Queries:** Select from 10 predefined business queries, results rendered as dynamic tables
