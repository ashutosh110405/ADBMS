-- Ensure we are using the TCL database and start clean
USE TCL;

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    status VARCHAR(50)
);

-- Disable autocommit to manually manage the transaction and savepoints
SET autocommit = 0;

-- Start the transaction block
START TRANSACTION;

-- STEP 1: Insert values and create savepoint sp1
INSERT INTO orders (order_id, customer_name, status) VALUES (101, 'John Doe', 'Pending');
INSERT INTO orders (order_id, customer_name, status) VALUES (102, 'Jane Smith', 'Shipped');

SAVEPOINT sp1; -- Marks savepoint 1

-- View current records (Both orders 101 and 102 exist)
SELECT * FROM orders;


-- STEP 2: Update an order and create savepoint sp2
UPDATE orders SET status = 'Delivered' WHERE order_id = 101;

SAVEPOINT sp2; -- Marks savepoint 2

-- View current records (Order 101 status is now 'Delivered')
SELECT * FROM orders;


-- STEP 3: Delete an order and create savepoint sp3
DELETE FROM orders WHERE order_id = 102;

SAVEPOINT sp3; -- Marks savepoint 3

-- View current records (Order 102 is now deleted, only order 101 remains)
SELECT * FROM orders;


-- STEP 4: Roll back to savepoint sp1
ROLLBACK TO sp1;

-- Final View: What do you see?
-- Explanation: Rolling back to 'sp1' undoes both the update (Step 2) 
-- and the deletion (Step 3). You are left with just the original 
-- inserts from Step 1, with their initial unupdated statuses!
SELECT * FROM orders;

-- Finalize or clean up the transaction
COMMIT;