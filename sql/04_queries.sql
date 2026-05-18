-- 04_queries.sql - Demonstration Queries

-- 1. Get total sales amount by employee (Join + Aggregation)
SELECT e.full_name, e.role, SUM(s.total_amount) as revenue
FROM employees e
JOIN sales s ON e.employee_id = s.employee_id
GROUP BY e.full_name, e.role
ORDER BY revenue DESC;

-- 2. List all medicines in 'Antibiotics' category (Join)
SELECT m.name, m.generic_name, c.name as category
FROM medicines m
JOIN categories c ON m.category_id = c.category_id
WHERE c.name = 'Antibiotics' OR c.parent_category_id = (SELECT category_id FROM categories WHERE name = 'Antibiotics');

-- 3. Find patients who have had more than 3 prescriptions (Aggregation + Having)
SELECT p.full_name, COUNT(pr.prescription_id) as prescription_count
FROM patients p
JOIN prescriptions pr ON p.patient_id = pr.patient_id
GROUP BY p.full_name
HAVING COUNT(pr.prescription_id) > 2
ORDER BY prescription_count DESC;

-- 4. Get stock value per supplier (Join + Aggregation)
SELECT s.name, SUM(sb.quantity * sb.unit_price) as total_stock_value
FROM suppliers s
JOIN stock_batches sb ON s.supplier_id = sb.supplier_id
GROUP BY s.name
ORDER BY total_stock_value DESC;

-- 5. Find medicines that have never been sold (Subquery with NOT IN)
SELECT name, generic_name
FROM medicines
WHERE medicine_id NOT IN (
    SELECT DISTINCT m.medicine_id
    FROM medicines m
    JOIN stock_batches sb ON m.medicine_id = sb.medicine_id
    JOIN sale_items si ON sb.batch_id = si.batch_id
);

-- 6. List employees and their managers (Self-join)
SELECT e.full_name as employee, m.full_name as manager, m.role as manager_role
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.employee_id;

-- 7. Average sale amount per payment method (Aggregation)
SELECT payment_method, ROUND(AVG(total_amount), 2) as avg_sale
FROM sales
GROUP BY payment_method;

-- 8. Top 5 most sold medicines (Join + Aggregation)
SELECT m.name, SUM(si.quantity) as units_sold
FROM medicines m
JOIN stock_batches sb ON m.medicine_id = sb.medicine_id
JOIN sale_items si ON sb.batch_id = si.batch_id
GROUP BY m.name
ORDER BY units_sold DESC
LIMIT 5;

-- 9. Using a Common Table Expression (CTE) to find high-value customers
WITH PatientSpending AS (
    SELECT p.patient_id, p.full_name, SUM(s.total_amount) as total_spent
    FROM patients p
    JOIN sales s ON p.patient_id = s.patient_id
    GROUP BY p.patient_id, p.full_name
)
SELECT * FROM PatientSpending WHERE total_spent > 5000 ORDER BY total_spent DESC;

-- 10. Find prescription items for a specific patient (Triple Join)
SELECT pat.full_name as patient, m.name as medicine, pi.dosage, pi.quantity
FROM patients pat
JOIN prescriptions pr ON pat.patient_id = pr.patient_id
JOIN prescription_items pi ON pr.prescription_id = pi.prescription_id
JOIN medicines m ON pi.medicine_id = m.medicine_id
WHERE pat.patient_id = 2;
