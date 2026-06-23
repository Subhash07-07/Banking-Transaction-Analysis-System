USE BankingSystem;

/*
Purpose:
Safely transfer funds between two accounts using
database transactions and error handling.

Procedure Name:
TransferFunds
*/

DELIMITER //

CREATE PROCEDURE TransferFunds(
    IN p_sender_id INT,
    IN p_receiver_id INT,
    IN p_amount DECIMAL(15,2)
)
BEGIN
    DECLARE v_sender_balance DECIMAL(15,2);

    START TRANSACTION;

    -- Lock sender account and get current balance
    SELECT balance
    INTO v_sender_balance
    FROM Accounts
    WHERE account_id = p_sender_id
    FOR UPDATE;

    -- Check if sufficient funds exist
    IF v_sender_balance < p_amount THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insufficient funds for transfer.';

        ROLLBACK;

    ELSE

        -- Deduct from sender
        UPDATE Accounts
        SET balance = balance - p_amount
        WHERE account_id = p_sender_id;

        -- Add to receiver
        UPDATE Accounts
        SET balance = balance + p_amount
        WHERE account_id = p_receiver_id;

        -- Audit log for sender
        INSERT INTO Transactions
        (account_id, transaction_type, amount, description)
        VALUES
        (
            p_sender_id,
            'Transfer',
            p_amount,
            CONCAT('Transferred to Account #', p_receiver_id)
        );

        -- Audit log for receiver
        INSERT INTO Transactions
        (account_id, transaction_type, amount, description)
        VALUES
        (
            p_receiver_id,
            'Transfer',
            p_amount,
            CONCAT('Received from Account #', p_sender_id)
        );

        COMMIT;

    END IF;

END //

DELIMITER ;
