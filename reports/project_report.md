# Project Report: Pharmacy Inventory & Prescription System

## 1. Problem Description and Scope
The Naryn Central Pharmacy Project aims to digitize the operations of a local pharmacy in Naryn, Kyrgyzstan. The system manages medicine inventory, tracks stock levels and expiry dates, handles prescriptions issued by healthcare providers, and processes sales transactions.

### Scope:
- **Inventory Management**: Track medicines, categories, and stock batches with expiry dates.
- **Supplier Relations**: Manage supplier contacts and procurement history.
- **Patient Records**: Maintain basic demographic information for patients.
- **Prescription Tracking**: Record and verify prescriptions for restricted medicines.
- **Sales Processing**: Handle sales transactions and maintain financial records.

## 2. ER Diagram and Relational Schema
The system is built on a relational model consisting of 10 tables:

1.  **Categories**: Hierarchical categorization of medicines (self-referencing).
2.  **Suppliers**: Entities providing medicine stock.
3.  **Medicines**: Master list of pharmaceutical products.
4.  **Employees**: Staff members including pharmacists and managers (self-referencing).
5.  **Patients**: Customers receiving healthcare services.
6.  **Stock Batches**: Specific batches of medicines received from suppliers.
7.  **Prescriptions**: Orders from doctors for specific patients.
8.  **Prescription Items**: Specific medicines and dosages in a prescription.
9.  **Sales**: Records of individual transactions.
10. **Sale Items**: Detailed breakdown of items sold in each transaction.

## 3. Normalization Analysis
The schema was designed with 3rd Normal Form (3NF) in mind:
- **1NF**: All tables have atomic values and unique primary keys.
- **2NF**: No partial dependencies; all non-key attributes are fully dependent on the primary key.
- **3NF**: No transitive dependencies; non-key attributes are only dependent on the primary key.

For example, in the `Medicines` table, all attributes (name, generic_name, manufacturer) depend solely on `medicine_id`. The relationship between sales and medicines is mediated by `sale_items` and `stock_batches` to maintain integrity and track specific batch movements.

## 4. Indexing Strategy
To optimize performance, we implemented several indexes:
- `idx_medicines_name`: Speeds up medicine lookups by name.
- `idx_stock_expiry`: Facilitates quick retrieval of expiring stock for alerts.
- `idx_sales_date`: Optimizes reporting on sales over specific time periods.
- `idx_prescriptions_patient`: Enables fast retrieval of a patient's prescription history.

## 5. Security and Roles
The system uses PostgreSQL's Role-Based Access Control (RBAC):
- **Admin**: Full control over all data and system configurations.
- **Pharmacist**: Permissions to view medicines, manage patients, and process sales/prescriptions. Restricted from supplier and inventory pricing data.
- **Inventory Manager**: Permissions to manage stock levels and supplier information. Restricted from viewing patient personal data.

## 6. Seed Data Audit
The database is seeded with 500+ records of realistic data reflecting the Kyrgyz context:
- **Names**: Kyrgyz and regional names (e.g., Aigerim Sultanova, Nurlan Bekov).
- **Phones**: +996 format with real operator prefixes (555, 700, 770).
- **Addresses**: Local cities and street names (Bishkek, Naryn, Osh).
- **Distribution**: Non-uniform distribution of sales and inventory to simulate real-world activity peaks.

## 7. Reflection
Designing the many-to-many relationship between Sales and Stock Batches was the most challenging aspect, as it required careful tracking of which specific batch was being sold to maintain accurate inventory levels. Future improvements could include a more robust prescription verification logic and integration with a barcode scanning system.

## 8. AI Usage Appendix
AI was used to:
1.  Generate realistic seed data patterns in the `generate_seed.py` script.
2.  Draft initial SQL table structures based on provided requirements.
3.  Design the basic Flask frontend layout and database connection logic.

*Declaration: All AI-generated content has been reviewed, edited, and verified for accuracy and compliance with project requirements.*
