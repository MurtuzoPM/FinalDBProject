-- 05_roles.sql - Role-Based Security

-- Drop roles if they exist
DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'pharmacy_admin') THEN
    DROP ROLE pharmacy_admin;
  END IF;
  IF EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'pharmacist') THEN
    DROP ROLE pharmacist;
  END IF;
  IF EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'inventory_manager') THEN
    DROP ROLE inventory_manager;
  END IF;
END $$;

-- 1. Pharmacy Admin: Full access
CREATE ROLE pharmacy_admin WITH LOGIN PASSWORD 'AdminPass123';
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO pharmacy_admin;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO pharmacy_admin;

-- 2. Pharmacist: Sales, Patients, Prescriptions
CREATE ROLE pharmacist WITH LOGIN PASSWORD 'PharmacistPass';
GRANT SELECT, INSERT, UPDATE ON sales, sale_items, patients, prescriptions, prescription_items TO pharmacist;
GRANT SELECT ON medicines, stock_batches, categories TO pharmacist;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO pharmacist;

-- 3. Inventory Manager: Stock, Suppliers, Medicines
CREATE ROLE inventory_manager WITH LOGIN PASSWORD 'ManagerPass';
GRANT SELECT, INSERT, UPDATE ON stock_batches, medicines, suppliers, categories TO inventory_manager;
GRANT SELECT ON sales, sale_items TO inventory_manager;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO inventory_manager;
