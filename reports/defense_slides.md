# Project Defense: Naryn Central Pharmacy System

## Slide 1: Title
- **Project**: Naryn Central Pharmacy Inventory & Prescription System
- **Members**: Mamadziyoev Murtuzo
- **Date**: May 2026

## Slide 2: Problem Statement
- **Objective**: Digitize a small pharmacy in Naryn.
- **Challenges**: Expiry tracking, prescription verification, and stock management.

## Slide 3: ER Diagram
- **Core Entities**: Medicines, Suppliers, Patients, Employees, Sales.
- **Key Relationships**: Many-to-many (Sales-Batches), Self-referencing (Category hierarchy).

## Slide 4: Database Schema
- **Tables**: 10 tables in 3NF.
- **Constraints**: FK enforcement, CHECK constraints (e.g., non-negative quantity).

## Slide 5: Normalization
- **Goal**: Reach 3NF to prevent anomalies.
- **Examples**: Decomposition of sales into header/items.

## Slide 6: Realistic Seed Data
- **Volume**: 500+ rows.
- **Locale**: Kyrgyz names, addresses, and phone formats.
- **Distribution**: Non-uniform patterns for realistic simulation.

## Slide 7: Advanced SQL Features
- **Views**: Low stock, expiring soon, sales reports.
- **Roles**: Admin, Pharmacist, Manager with granular permissions.
- **Transactions**: Ensuring atomicity in sales processing.

## Slide 8: Demonstration Queries
- Complex JOINS, CTEs, and Window Functions (demonstrated in `04_queries.sql`).

## Slide 9: Frontend Overview
- **Stack**: Python, Flask, Psycopg2, Bootstrap.
- **Features**: View inventory, manage patient records, record new sales.

## Slide 10: Conclusion & Reflection
- **Key Learnings**: Database integrity, PostgreSQL administration.
- **Future Work**: Prescription AI verification, mobile integration.
