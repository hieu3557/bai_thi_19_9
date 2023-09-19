  CREATE DATABASE AZBank;


CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(50),
    Address VARCHAR(100)
);


CREATE TABLE CustomerAccount (
    AccountNumber INT PRIMARY KEY,
    CustomerID INT,
    Phone VARCHAR(15),
    Email VARCHAR(50),
    Balance DECIMAL(18, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);


CREATE TABLE CustomerTransaction (
    TransactionID INT PRIMARY KEY,
    AccountNumber INT,
    TransactionDate DATE,
    Amount DECIMAL(18, 2),
    DepositorWithdraw VARCHAR(10),
    FOREIGN KEY (AccountNumber) REFERENCES CustomerAccount(AccountNumber),
    CHECK (Amount > 0 AND Amount <= 1000000)
);


INSERT INTO Customer (CustomerID, Name, Address)
VALUES (1, 'Phan Ngoc Hieu', 'Hanoi'),
       (2, 'Phan Trong Nghia', 'Hanoi'),
       (3, 'BBD', 'Ho Chi Minh City');


INSERT INTO CustomerAccount (AccountNumber, CustomerID, Phone, Email, Balance)
VALUES (1001, 1, '1234567890', 'hieucutokhonglo@example.com', 5000.00),
       (1002, 2, '9876543210', 'nghia123@example.com', 10000.00),
       (1003, 3, '5555555555', 'thanrung@example.com', 8000.00);


INSERT INTO CustomerTransaction (TransactionID, AccountNumber, TransactionDate, Amount, DepositorWithdraw)
VALUES (101, 1001, '2023-09-18', 1000.00, 'Deposit'),
       (102, 1002, '2023-09-19', 500.00, 'Withdraw'),
       (103, 1003, '2023-09-20', 2000.00, 'Deposit');

SELECT *
FROM Customer
WHERE Address = 'Hanoi';

SELECT C.Name, CA.Phone, CA.Email, CA.AccountNumber, CA.Balance
FROM CustomerAccount CA
JOIN Customer C ON CA.CustomerID = C.CustomerID;

CREATE VIEW CustomerTransactions AS
SELECT C.Name, CT.AccountNumber, CT.TransactionDate, CT.Amount, CT.DepositorWithdraw
FROM CustomerTransaction CT
JOIN CustomerAccount CA ON CT.AccountNumber = CA.AccountNumber
JOIN Customer C ON CA.CustomerID = C.CustomerID;
