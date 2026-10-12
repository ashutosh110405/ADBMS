-- TCL CMDS 
Create DATABASE TCL;
use TCL; 

create table orders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    status VARCHAR(50)
);

desc orders; -- used to display the structure of the orders table, including column names, data types, and constraints. --

-- start the transaction --
set autocommit=0; -- autocommit is used to automatically commit each SQL statement as a transaction. Setting it to 0 disables this behavior, allowing you to manually control when transactions are committed.--

BEGIN; -- BEGIN is used to start a new transaction. It marks the beginning of a series of SQL statements that will be executed as a single unit of work. --

INSERT INTO orders (order_id, customer_name, status) VALUES (101, 'John Doe', 'Pending');
INSERT INTO orders (order_id, customer_name, status) VALUES (102, 'Jane Smith', 'Shipped');

select * from orders; -- select is used to retrieve data from the orders table. It displays all the rows and columns in the table. --

commit; -- commit is used to save the changes made in the current transaction to the database. It makes the changes permanent and visible to other users. --

--truncate the orders table to remove all data but keep the structure intact
TRUNCATE TABLE orders;

rollback; -- rollback is used to undo the changes made in the current transaction. It reverts the database to its previous state before the transaction began.(goes to the beginning of the transaction if not committed or else goes to the last committed state) --

Insert INTO orders (order_id, customer_name, status) VALUES (103, 'Alice Johnson', 'Processing');
INSERT INTO orders (order_id, customer_name, status) VALUES (104, 'Bob Brown', 'Pending');

desc orders; 

select * from orders;

rollback; -- rollback is used to undo the changes made in the current transaction. It reverts the database to its previous state before the transaction began.(goes to the beginning of the transaction if not committed or else goes to the last committed state) --

select * from orders;