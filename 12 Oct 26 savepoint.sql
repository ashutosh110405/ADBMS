-- ====================================================================
-- NEW TCL & SAVEPOINT DEMONSTRATION SCRIPT
-- ====================================================================

-- 1. Create a brand new database and switch to it
DROP DATABASE IF EXISTS tcl_demo_db;
CREATE DATABASE tcl_demo_db;
USE tcl_demo_db;

-- 2. Create the orders table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    status VARCHAR(50)
);

-- 3. Disable autocommit to manually control transaction boundaries
SET autocommit = 0;

-- 4. Start a new transaction
START TRANSACTION;

-- ==========================================
-- STEP 1: Insert values and create savepoint sp1
-- ==========================================
INSERT INTO orders (order_id, customer_name, status) VALUES (101, 'Alice Smith', 'Pending');
INSERT INTO orders (order_id, customer_name, status) VALUES (102, 'Bob Jones', 'Shipped');

SAVEPOINT sp1; -- Set savepoint 1

-- View records at Step 1 (Both orders exist with initial values)
SELECT '--- STATE AT STEP 1 (After Insert) ---' AS info;
SELECT * FROM orders;


-- ==========================================
-- STEP 2: Update an order and create savepoint sp2
-- ==========================================
UPDATE orders SET status = 'Delivered' WHERE order_id = 101;

SAVEPOINT sp2; -- Set savepoint 2

-- View records at Step 2 (Order 101 status is updated)
SELECT '--- STATE AT STEP 2 (After Update) ---' AS info;
SELECT * FROM orders;


-- ==========================================
-- STEP 3: Delete an order and create savepoint sp3
-- ==========================================
DELETE FROM orders WHERE order_id = 102;

SAVEPOINT sp3; -- Set savepoint 3

-- View records at Step 3 (Order 102 is removed)
SELECT '--- STATE AT STEP 3 (After Delete) ---' AS info;
SELECT * FROM orders;


-- ==========================================
-- STEP 4: Roll back to savepoint sp1
-- ==========================================
ROLLBACK TO sp1;

-- Final View: What survived the rollback?
-- (This undoes both the update in Step 2 and the delete in Step 3,
-- reverting orders back to their original state at sp1)
SELECT '--- STATE AT STEP 4 (After Rolling Back to sp1) ---' AS info;
SELECT * FROM orders;

-- Commit the final transaction state and reset autocommit
COMMIT;
SET autocommit = 1;