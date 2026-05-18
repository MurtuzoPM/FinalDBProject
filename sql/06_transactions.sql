-- 06_transactions.sql - Transaction Demonstration

-- Scenario: Processing a sale while updating inventory stock.
-- This transaction ensures that a sale is recorded AND the medicine quantity is decremented.
-- If stock is insufficient, the transaction should be rolled back (handled by application logic usually, but shown here as a block).

BEGIN;

-- 1. Create a new sale record
INSERT INTO sales (patient_id, employee_id, sale_date, total_amount, payment_method)
VALUES (1, 1, CURRENT_TIMESTAMP, 500.00, 'Cash');

-- Save the sale_id (assuming it's the latest)
-- In a script, we use a variable or subquery.

-- 2. Add an item to the sale
-- Let's say we sell 2 units of medicine from batch 1
INSERT INTO sale_items (sale_id, batch_id, quantity, price_at_sale)
VALUES (currval('sales_sale_id_seq'), 1, 2, 250.00);

-- 3. Update the stock quantity
UPDATE stock_batches
SET quantity = quantity - 2
WHERE batch_id = 1;

-- 4. Check if quantity became negative (Simulating a constraint check)
-- In real SQL, a CHECK constraint would fail here if quantity < 0.
-- We'll just commit.

COMMIT;

-- Demonstration of ROLLBACK (Failed sale due to error)
BEGIN;

INSERT INTO sales (patient_id, employee_id, sale_date, total_amount, payment_method)
VALUES (2, 2, CURRENT_TIMESTAMP, 1000.00, 'Card');

-- Intentional error: medicine_id doesn't exist in prescription_items for this PK if we had one,
-- but here we'll just show a manual rollback for demo.
ROLLBACK;
