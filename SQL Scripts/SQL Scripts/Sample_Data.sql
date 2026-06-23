USE BankingSystem;

-- Insert 3 Customers
INSERT INTO Customers (first_name, last_name, email, phone) VALUES
('Alice', 'Smith', 'alice@email.com', '555-0101'),
('Bob', 'Johnson', 'bob@email.com', '555-0102'),
('Charlie', 'Brown', 'charlie@email.com', '555-0103');

-- Insert Accounts for those customers
INSERT INTO Accounts (customer_id, account_type, balance) VALUES
(1, 'Checking', 5000.00), -- Alice (Account 1)
(1, 'Savings', 15000.00), -- Alice (Account 2)
(2, 'Checking', 2500.00),  -- Bob   (Account 3)
(3, 'Checking', 100.00);    -- Charlie (Account 4)

-- Insert Loans
INSERT INTO Loans (customer_id, loan_amount, interest_rate, duration_months, status) VALUES
(2, 5000.00, 5.50, 24, 'Approved'), 
(3, 20000.00, 7.25, 60, 'Approved');
