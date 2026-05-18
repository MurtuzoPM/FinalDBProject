-- 03_views.sql - Pharmacy Inventory & Prescription System Views

-- 1. Expiring Soon View: Stock batches expiring in the next 90 days
CREATE OR REPLACE VIEW view_expiring_soon AS
SELECT
    sb.batch_id,
    m.name AS medicine_name,
    sb.batch_number,
    sb.expiry_date,
    sb.quantity,
    s.name AS supplier_name
FROM stock_batches sb
JOIN medicines m ON sb.medicine_id = m.medicine_id
JOIN suppliers s ON sb.supplier_id = s.supplier_id
WHERE sb.expiry_date BETWEEN CURRENT_DATE AND (CURRENT_DATE + INTERVAL '90 days')
ORDER BY sb.expiry_date;

-- 2. Low Stock View: Medicines with total quantity less than 50
CREATE OR REPLACE VIEW view_low_stock AS
SELECT
    m.medicine_id,
    m.name,
    SUM(sb.quantity) AS total_quantity
FROM medicines m
LEFT JOIN stock_batches sb ON m.medicine_id = sb.medicine_id
GROUP BY m.medicine_id, m.name
HAVING SUM(sb.quantity) < 50 OR SUM(sb.quantity) IS NULL
ORDER BY total_quantity;

-- 3. Monthly Sales Report View
CREATE OR REPLACE VIEW view_monthly_sales AS
SELECT
    DATE_TRUNC('month', sale_date) AS month,
    COUNT(sale_id) AS total_transactions,
    SUM(total_amount) AS total_revenue
FROM sales
GROUP BY 1
ORDER BY 1 DESC;

-- 4. Active Prescriptions View
CREATE OR REPLACE VIEW view_active_prescriptions AS
SELECT
    p.prescription_id,
    pat.full_name AS patient_name,
    emp.full_name AS issued_by,
    p.issued_date,
    p.expiry_date
FROM prescriptions p
JOIN patients pat ON p.patient_id = pat.patient_id
JOIN employees emp ON p.employee_id = emp.employee_id
WHERE p.status = 'Active' AND p.expiry_date >= CURRENT_DATE;
