# Project Report: Naryn Central Pharmacy Inventory & Prescription System

**Date**: May 18, 2026
**Team**: Mamadziyoev Murtuzo (Individual Project)
**Course**: COMP 2082 - Database Management Systems

---

## 1. Problem Description and Scope
The **Naryn Central Pharmacy System** is designed to address the operational challenges of a mid-sized pharmacy in the Naryn region of Kyrgyzstan. Currently, many local pharmacies rely on manual ledger entries or simple spreadsheets, leading to errors in expiry tracking, stockouts of critical medicine, and difficulty in auditing prescription-only drug sales.

### Objectives:
- **Inventory Control**: Real-time tracking of medicine quantities across different batches.
- **Expiry Management**: Proactive alerts for medicines approaching their expiration date.
- **Regulatory Compliance**: Maintaining a rigorous link between prescriptions and sales of restricted substances.
- **Financial Reporting**: Tracking revenue and employee performance.

---

## 2. ER Diagram and Relational Schema
The database is modeled to capture the complex relationships between healthcare providers, inventory, and retail transactions.

### Entities:
- **Categories**: Supports a hierarchical structure (e.g., "Antibiotics" -> "Beta-lactams").
- **Suppliers**: Local and regional distributors like "Neman-Pharm" or "Amanat Pharm".
- **Medicines**: The master catalog of products, including generic and brand names.
- **Employees**: Staff management including a reporting hierarchy (Pharmacists report to Managers).
- **Patients**: Local residents, identified by contact details.
- **Stock Batches**: The most granular level of inventory, tracking individual shipments and expiry.
- **Prescriptions & Prescription Items**: Documentation of doctor-ordered medications.
- **Sales & Sale Items**: Transactional records capturing the point-of-sale data.

---

## 3. Normalization Analysis
Each table has been analyzed to ensure it meets **3rd Normal Form (3NF)** to prevent update, insertion, and deletion anomalies.

### Functional Dependencies (FDs):
1. **Medicines**: `medicine_id -> name, generic_name, manufacturer, category_id`.
   - *Justification*: There are no transitive dependencies. Category info is in its own table.
2. **Employees**: `employee_id -> full_name, email, phone, role, manager_id`.
   - *Justification*: All attributes depend solely on the employee ID.
3. **Stock Batches**: `batch_id -> medicine_id, supplier_id, quantity, unit_price, expiry_date`.
   - *Justification*: The unit price is specific to the batch (inflation/supplier changes).

### Normal Form Justification:
- **1NF**: Every column contains atomic values; no repeating groups.
- **2NF**: Every non-key attribute is fully functionally dependent on the primary key.
- **3NF**: No non-key attribute is transitively dependent on the primary key. For example, we do not store "Category Name" in the `Medicines` table; we store `category_id` which references the `Categories` table.

---

## 4. SQL Implementation & Sample Queries
The implementation uses PostgreSQL 16. The schema is enforced with foreign keys, `NOT NULL` constraints, and `CHECK` constraints (e.g., `quantity >= 0`).

### Sample Queries (Demonstrating Complexity):
1. **Revenue by Employee**: Uses `JOIN` and `GROUP BY` to audit performance.
2. **Category Hierarchy Search**: Uses a subquery to find all medicines in a parent category.
3. **Frequent Patients**: Uses `HAVING` to identify customers with high medical needs.
4. **Stock Valuation**: Calculates financial asset value per supplier.
5. **Dead Stock Analysis**: Uses `NOT IN` with a subquery to find products that haven't sold.
6. **Management Hierarchy**: Uses a `LEFT JOIN` on the same table (Self-join) to show the org chart.
7. **Payment Trends**: Analyzes preferred local payment methods (M-Bank vs Cash).
8. **Top Sellers**: Identifies high-demand inventory.
9. **High-Value Customer CTE**: Uses a Common Table Expression to segment customers.
10. **Prescription Audit**: Triple-join to link patients to specific medicines prescribed.

---

## 5. Seed Data Audit
The database is populated with **500+ rows** of realistic data generated to reflect the Naryn context.

- **Primary Entities**: 100 Medicines, 50 Employees, 100 Patients.
- **Transactions**: 251 Sales, 200 Prescriptions.
- **Distribution Patterns**:
    - **Pareto Principle**: A small group of "top" patients account for a significant portion of prescriptions.
    - **Temporal Clustering**: Sales timestamps reflect peaks during morning and early evening business hours.
    - **Regional Grounding**: Addresses utilize real Naryn street names (ul. Lenina) and Bishkek districts.
- **Data Sources**: Combination of hand-written reference data (categories) and Python-scripted generation (Faker-style) for names and numbers.

---

## 6. Advanced Features
- **Indexing Strategy**: B-Tree indexes created on `medicines.name` for search, `stock_batches.expiry_date` for inventory management, and `sales.sale_date` for reporting.
- **Views**:
    - `expiring_soon`: Lists stock expiring within 90 days.
    - `low_stock_alerts`: Identifies items below 20 units.
    - `monthly_sales_summary`: Aggregates revenue for business intelligence.
- **Transactions**: The `06_transactions.sql` script demonstrates an atomic sale where the stock quantity is decremented only if the sale record is successfully created, ensuring data consistency.
- **Security**: Defined `admin`, `pharmacist`, and `manager` roles with specific `GRANT`/`REVOKE` permissions.

---

## 7. Reflection
The project successfully bridges the gap between theoretical relational algebra and practical implementation. The most significant challenge was maintaining referential integrity during the automated seeding process—ensuring that sale items correctly referenced existing batches that had sufficient quantity. If I were to extend this, I would implement a trigger-based audit log to track every manual change to medicine prices.

---

## 8. AI Usage Appendix
AI (Claude 3.5 Sonnet) was utilized as an "Integral" part of the development process:
- **Schema Design**: AI assisted in identifying optimal relationships for the self-referencing employee table.
- **Data Generation**: AI provided the logic for generating Kyrgyz-specific names and phone formats in the seeding script.
- **Frontend**: The Flask application structure and Bootstrap integration were drafted with AI assistance.

### Signed Declaration
I, **Mamadziyoev Murtuzo**, hereby declare that the AI usage disclosed above is a complete and honest record of the assistance received during this project. I have reviewed, tested, and am responsible for every line of SQL and Python code included in this submission.

**Signed**: *Mamadziyoev Murtuzo*
