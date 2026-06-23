IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'BankingSystem')
    CREATE DATABASE BankingSystem;
GO
USE BankingSystem;

-- 1. CUSTOMERS TABLE
CREATE TABLE Customers (
    customer_id   INT AUTO_INCREMENT PRIMARY KEY,
    first_name    VARCHAR(50) NOT NULL,
    last_name     VARCHAR(50) NOT NULL,
    email         VARCHAR(100) UNIQUE NOT NULL,
    phone         VARCHAR(15),
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. ACCOUNTS TABLE
CREATE TABLE Accounts (
    account_id    INT AUTO_INCREMENT PRIMARY KEY,
    customer_id   INT NOT NULL,
    account_type  ENUM('Checking', 'Savings') NOT NULL,
    balance       DECIMAL(15, 2) DEFAULT 0.00,
    status        ENUM('Active', 'Suspended', 'Closed') DEFAULT 'Active',
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE CASCADE
);

-- 3. TRANSACTIONS TABLE
CREATE TABLE Transactions (
    transaction_id   INT AUTO_INCREMENT PRIMARY KEY,
    account_id       INT NOT NULL,
    transaction_type ENUM('Deposit', 'Withdrawal', 'Transfer') NOT NULL,
    amount           DECIMAL(15, 2) NOT NULL,
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    description      VARCHAR(255),
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id)
);

-- 4. LOANS TABLE
CREATE TABLE Loans (
    loan_id         INT AUTO_INCREMENT PRIMARY KEY,
    customer_id     INT NOT NULL,
    loan_amount     DECIMAL(15, 2) NOT NULL,
    interest_rate   DECIMAL(5, 2) NOT NULL,
    duration_months INT NOT NULL,
    status          ENUM('Applied', 'Approved', 'Paid', 'Defaulted') DEFAULT 'Applied',
    start_date      DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
