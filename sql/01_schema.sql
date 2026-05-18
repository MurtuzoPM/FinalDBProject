-- 01_schema.sql - Pharmacy Inventory & Prescription System Schema

-- Enable necessary extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Drop existing tables if they exist (for clean runs)
DROP TABLE IF EXISTS sale_items CASCADE;
DROP TABLE IF EXISTS sales CASCADE;
DROP TABLE IF EXISTS prescription_items CASCADE;
DROP TABLE IF EXISTS prescriptions CASCADE;
DROP TABLE IF EXISTS patients CASCADE;
DROP TABLE IF EXISTS stock_batches CASCADE;
DROP TABLE IF EXISTS medicines CASCADE;
DROP TABLE IF EXISTS categories CASCADE;
DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS suppliers CASCADE;

-- 1. Categories (Self-referencing relationship)
CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    parent_category_id INTEGER REFERENCES categories(category_id),
    description TEXT
);

-- 2. Suppliers
CREATE TABLE suppliers (
    supplier_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    contact_person VARCHAR(255),
    phone VARCHAR(50) NOT NULL,
    email VARCHAR(255),
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Medicines
CREATE TABLE medicines (
    medicine_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    generic_name VARCHAR(255),
    category_id INTEGER REFERENCES categories(category_id),
    manufacturer VARCHAR(255),
    description TEXT,
    requires_prescription BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. Employees (Self-referencing relationship)
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    role VARCHAR(100) NOT NULL,
    phone VARCHAR(50) NOT NULL,
    email VARCHAR(255) UNIQUE,
    manager_id INTEGER REFERENCES employees(employee_id),
    hire_date DATE NOT NULL,
    is_active BOOLEAN DEFAULT TRUE
);

-- 5. Patients
CREATE TABLE patients (
    patient_id SERIAL PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    date_of_birth DATE NOT NULL,
    phone VARCHAR(50) NOT NULL,
    email VARCHAR(255),
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_dob CHECK (date_of_birth <= CURRENT_DATE)
);

-- 6. Stock Batches
CREATE TABLE stock_batches (
    batch_id SERIAL PRIMARY KEY,
    medicine_id INTEGER NOT NULL REFERENCES medicines(medicine_id),
    supplier_id INTEGER NOT NULL REFERENCES suppliers(supplier_id),
    batch_number VARCHAR(100) NOT NULL,
    quantity INTEGER NOT NULL DEFAULT 0,
    unit_price NUMERIC(12, 2) NOT NULL,
    expiry_date DATE NOT NULL,
    received_date DATE NOT NULL DEFAULT CURRENT_DATE,
    CONSTRAINT chk_quantity CHECK (quantity >= 0),
    CONSTRAINT chk_unit_price CHECK (unit_price >= 0),
    CONSTRAINT chk_expiry CHECK (expiry_date > received_date)
);

-- 7. Prescriptions
CREATE TABLE prescriptions (
    prescription_id SERIAL PRIMARY KEY,
    patient_id INTEGER NOT NULL REFERENCES patients(patient_id),
    employee_id INTEGER NOT NULL REFERENCES employees(employee_id),
    issued_date DATE NOT NULL DEFAULT CURRENT_DATE,
    expiry_date DATE NOT NULL,
    status VARCHAR(50) DEFAULT 'Active',
    notes TEXT,
    CONSTRAINT chk_presc_expiry CHECK (expiry_date >= issued_date)
);

-- 8. Prescription Items (Many-to-many relationship)
CREATE TABLE prescription_items (
    prescription_id INTEGER NOT NULL REFERENCES prescriptions(prescription_id),
    medicine_id INTEGER NOT NULL REFERENCES medicines(medicine_id),
    dosage VARCHAR(255),
    quantity INTEGER NOT NULL,
    PRIMARY KEY (prescription_id, medicine_id),
    CONSTRAINT chk_presc_item_qty CHECK (quantity > 0)
);

-- 9. Sales
CREATE TABLE sales (
    sale_id SERIAL PRIMARY KEY,
    patient_id INTEGER REFERENCES patients(patient_id),
    employee_id INTEGER NOT NULL REFERENCES employees(employee_id),
    sale_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    total_amount NUMERIC(12, 2) DEFAULT 0,
    payment_method VARCHAR(50)
);

-- 10. Sale Items (Junction table)
CREATE TABLE sale_items (
    sale_item_id SERIAL PRIMARY KEY,
    sale_id INTEGER NOT NULL REFERENCES sales(sale_id),
    batch_id INTEGER NOT NULL REFERENCES stock_batches(batch_id),
    quantity INTEGER NOT NULL,
    price_at_sale NUMERIC(12, 2) NOT NULL,
    CONSTRAINT chk_sale_qty CHECK (quantity > 0),
    CONSTRAINT chk_sale_price CHECK (price_at_sale >= 0)
);

-- Indexes for performance
CREATE INDEX idx_medicines_name ON medicines(name);
CREATE INDEX idx_stock_expiry ON stock_batches(expiry_date);
CREATE INDEX idx_prescriptions_patient ON prescriptions(patient_id);
CREATE INDEX idx_sales_date ON sales(sale_date);
CREATE INDEX idx_stock_medicine ON stock_batches(medicine_id);
