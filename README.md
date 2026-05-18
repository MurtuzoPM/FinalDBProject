# Pharmacy Inventory & Prescription System (Naryn Central Pharmacy)

This project is a PostgreSQL-backed database system for managing a small pharmacy's inventory, prescriptions, and sales.

## Features
- Normalized schema (3NF) with 10 related tables.
- Realistic Kyrgyz-context seed data (500+ records).
- Role-based security (Admin, Pharmacist, Inventory Manager).
- Demonstration queries covering joins, aggregations, and CTEs.
- Simple Python/Flask frontend for data visualization and recording sales.

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
   *Note: If using the provided scripts directly:*
   - `psql -f sql/01_schema.sql`
   - `psql -f sql/02_seed_data.sql`
   - `psql -f sql/03_views.sql`
   - `psql -f sql/05_roles.sql`

### Running the Frontend
1. Install dependencies:
   ```bash
   pip install Flask psycopg2-binary
   ```
2. Update the database connection in `app.py` if necessary.
3. Run the application:
   ```bash
   python app.py
   ```
4. Access at `http://localhost:5000`

## Project Structure
- `/sql`: SQL scripts for schema, seeding, views, queries, roles, and transactions.
- `pharmacy_dump.sql`: Full database dump.
- `app.py`: Flask application.
- `/templates`: HTML templates for the frontend.
- `reports/`: Documentation and project report (Draft).
