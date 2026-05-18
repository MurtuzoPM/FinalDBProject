# Pharmacy Inventory & Prescription System (Naryn Central Pharmacy)

This project is a PostgreSQL-backed database system for managing a small pharmacy's inventory, prescriptions, and sales. It is designed to meet the requirements of the COMP 2082 Final Project.

## Features
- **Normalized Schema (3NF)**: 10 tables including hierarchical categories and employee management.
- **Realistic Kyrgyz Data**: 500+ records featuring local names, +996 phone numbers, and regional addresses.
- **Role-Based Security**: Defined roles for Admin, Pharmacist, and Inventory Manager.
- **Advanced SQL**: Includes views, non-trivial queries (CTEs, Joins), and transaction blocks.
- **Frontend**: A Python/Flask web application for interacting with the database.
- **Presentation**: A Reveal.js-based professional slide deck.

## Setup Instructions

### Prerequisites
- PostgreSQL 15 or later
- Python 3.12 or later
- `psycopg2-binary` and `Flask` Python packages

### Database Restore
1. Create a database named `pharmacy`:
   ```bash
   createdb pharmacy
   ```
2. Restore the dump:
   ```bash
   psql pharmacy < pharmacy_dump.sql
   ```
   *The dump includes the schema, all seed data, views, and role permissions.*

### Running the Frontend
1. Install dependencies:
   ```bash
   pip install Flask psycopg2-binary
   ```
2. Run the application:
   ```bash
   python app.py
   ```
3. Access the dashboard at `http://localhost:5000`

### Viewing the Presentation
Open `reports/defense_slides.html` in any modern web browser to view the project defense slides.

## Project Structure
- `sql/`:
    - `01_schema.sql`: Table definitions and constraints.
    - `02_seed_data.sql`: 500+ rows of realistic data.
    - `03_views.sql`: Inventory and sales views.
    - `04_queries.sql`: 10+ demonstration queries.
    - `05_roles.sql`: RBAC implementation.
    - `06_transactions.sql`: Atomic sale logic.
- `pharmacy_dump.sql`: Full database dump for one-command restore.
- `app.py`: Flask application.
- `templates/` & `static/`: Frontend assets.
- `reports/`:
    - `project_report.md`: Detailed technical report.
    - `defense_slides.html`: Reveal.js presentation.
