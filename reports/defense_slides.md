# Naryn Central Pharmacy System
## COMP 2082 Final Project Defense

**Student:** Mamadziyoev Murtuzo
**Date:** May 2026

---

## Slide 1: Problem Description
- **The Context**: Mid-sized pharmacies in Naryn, Kyrgyzstan.
- **The Problem**: Manual tracking leads to expired medicine sales and stockouts.
- **The Solution**: A PostgreSQL-backed inventory and prescription management system.
- **Scope**: Cataloging, stock tracking, patient history, and sales auditing.

---

## Slide 2: ER Diagram
- **Entities**: 10 tables representing the full pharmacy lifecycle.
- **Key Relationships**:
  - **Many-to-Many**: Sales to Stock Batches (via Sale Items).
  - **Recursive**: Category hierarchy (Sub-categories) and Employee reporting lines.
  - **Constraints**: Mandatory prescriptions for specific medicine types.

---

## Slide 3: Relational Schema & Constraints
- **Tables**: Categories, Suppliers, Medicines, Patients, Employees, Stock Batches, Prescriptions, Sales.
- **Integrity**:
  - `CHECK` constraints on quantities (no negative stock).
  - `FOREIGN KEY` enforcement on all relationships.
  - `UNIQUE` constraints on phone numbers and emails.

---

## Slide 4: Normalization (3NF)
- **1NF**: Atomic values (e.g., separate Sale Items).
- **2NF**: Fully functional dependencies on Primary Keys.
- **3NF**: Removed transitive dependencies.
  - *Example*: Category names are not in the Medicines table.
  - *Example*: Manager names are not in the Employee table.

---

## Slide 5: Seed Data Audit
- **Volume**: 500+ records across 10 tables.
- **Realism**:
  - Kyrgyz names (*Sultanova*, *Bekov*).
  - `+996` phone formats.
  - Real Naryn street names (*ul. Lenina*).
- **Distribution**: Non-uniform patterns (Pareto distribution on patient activity).

---

## Slide 6: Advanced SQL & Transactions
- **Complex Queries**: Joins across 5 tables, CTEs for best-sellers, and Window Functions.
- **Transactions**: Atomic sale processing.
  - `BEGIN;`
  - Record Sale -> Record Items -> Deduct Stock.
  - `COMMIT;` (or `ROLLBACK` if stock is insufficient).

---

## Slide 7: Security & Indexing
- **Indexing**:
  - B-Tree on Medicine Names (Search).
  - B-Tree on Expiry Dates (Alerts).
- **Security**:
  - `pharmacist_role`: Sales & Inventory view.
  - `manager_role`: Price updates & Supplier management.
  - `admin_role`: User & Role management.

---

## Slide 8: Implementation & Demo
- **Backend**: Python 3.12 + Psycopg2.
- **Frontend**: Flask + Bootstrap 5.
- **Key Features**:
  - Real-time inventory dashboard.
  - Low-stock and Expiry alerts via Views.
  - Patient purchase history tracking.

---

## Slide 9: Reflection & Limitations
- **What was hard**: Managing batch-specific sales to ensure FEFO (First-Expiry-First-Out).
- **What I'd do differently**: Implement a trigger-based audit log for every price change.
- **Limitations**: No barcode hardware integration or PDF invoice generation.

---

## Slide 10: AI Disclosure & Final Defense
- **AI Use**: Prompted for localized seed data and initial UI layout.
- **Verification**: All SQL queries and Python routes were manually tested and optimized.
- **Conclusion**: The system provides a defensible, production-ready foundation for pharmacy management.
