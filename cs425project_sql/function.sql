-- ===========================Insert===========================
CREATE OR REPLACE FUNCTION insert_address (
    street VARCHAR(100),
    zip CHAR(5)
) RETURNS INT AS 
$$ 
DECLARE ret INT;
BEGIN 
    INSERT INTO address
    VALUES
    (
        DEFAULT,
        street,
        zip
    ) RETURNING aid INTO ret;
    RETURN ret;
END;
$$ 
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION insert_online_client (
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email_address VARCHAR(50),
    password_masked CHAR(64)
) RETURNS INT AS 
$$ 
DECLARE ret INT;
BEGIN 
    INSERT INTO online_client (cid, first_name, last_name, email_address, password_masked)
    VALUES
    (
        DEFAULT,
        first_name,
        last_name,
        email_address,
        password_masked
    ) RETURNING cid INTO ret;
    RETURN ret;
END;
$$ 
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION insert_replenish_m2w (
    wid INT,
    pid INT,
    amount INT,
    date DATE 
) RETURNS INT AS 
$$ 
DECLARE ret INT;
BEGIN 
    INSERT INTO replenish_m2w
    VALUES
    (
        DEFAULT,
        wid,
        pid,
        amount,
        DEFAULT,
        date
    ) RETURNING rid INTO ret;
    RETURN ret;
END;
$$ 
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION insert_replenish_w2s (
    wid INT,
    sid INT,
    pid INT,
    amount INT,
    date DATE 
) RETURNS INT AS 
$$ 
DECLARE ret INT;
BEGIN 
    INSERT INTO replenish_w2s
    VALUES
    (
        DEFAULT,
        wid,
        sid,
        pid,
        amount,
        DEFAULT,
        date
    ) RETURNING rid INTO ret;
    RETURN ret;
END;
$$ 
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION insert_order_online (
    cid INT,
    wid INT,
    pid INT,
    amount INT,
    discount FLOAT,
    date DATE,
    tracking_number VARCHAR(50)
) RETURNS INT AS 
$$ 
DECLARE ret INT;
BEGIN 
    INSERT INTO order_online
    VALUES
    (
        DEFAULT,
        cid,
        wid,
        pid,
        amount,
        discount,
        date,
        tracking_number,
        NULL,
        NULL
    ) RETURNING oid INTO ret;
    RETURN ret;
END;
$$ 
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION insert_order_store (
    cid INT,
    sid INT,
    pid INT,
    amount INT,
    discount FLOAT,
    date DATE
) RETURNS INT AS 
$$ 
DECLARE ret INT;
BEGIN 
    INSERT INTO order_store
    VALUES
    (
        DEFAULT,
        cid,
        sid,
        pid,
        amount,
        discount,
        date
    ) RETURNING oid INTO ret;
    RETURN ret;
END;
$$ 
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION insert_contract (
    cid INT,
    pid INT,
    amount INT,
    bill_day INT
) RETURNS void AS 
$$ 
BEGIN 
    INSERT INTO contract
    VALUES
    (
        cid,
        pid,
        amount,
        bill_day
    );
END;
$$ 
LANGUAGE plpgsql;

-- ===========================Update===========================
CREATE OR REPLACE FUNCTION update_address (
    aid INT,
    street VARCHAR(100),
    zip CHAR(5)
) RETURNS INT AS 
$$ 
BEGIN 
    UPDATE address
    SET street = update_address.street,
        zip = update_address.zip
    WHERE address.aid = update_address.aid;
    RETURN update_address.aid;
END;
$$ 
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_online_client_basic (
    cid INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
) RETURNS void AS 
$$ 
BEGIN 
    UPDATE online_client
    SET first_name = update_online_client_basic.first_name,
        last_name = update_online_client_basic.last_name
    WHERE online_client.cid = update_online_client_basic.cid;
END;
$$ 
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_online_client_password (
    cid INT,
    password_masked CHAR(64)
) RETURNS void AS 
$$ 
BEGIN 
    UPDATE online_client
    SET password_masked = update_online_client_password.password_masked
    WHERE online_client.cid = update_online_client_password.cid;
END;
$$ 
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_online_client_pay (
    cid INT,
    phone_number VARCHAR(50),
    card_number VARCHAR(50),
    account_number VARCHAR(50),
    street VARCHAR(100),
    zip CHAR(5)
) RETURNS void AS 
$$ 
BEGIN 
    UPDATE online_client
    SET phone_number = update_online_client_pay.phone_number,
        card_number = update_online_client_pay.card_number,
        account_number = update_online_client_pay.account_number,
        aid = 
            CASE 
                WHEN 
                    online_client.aid IS NULL 
                THEN 
                    insert_address(update_online_client_pay.street,
                    update_online_client_pay.zip)
                ELSE 
                    update_address(online_client.aid,
                    update_online_client_pay.street, 
                    update_online_client_pay.zip)
            END
    WHERE online_client.cid = update_online_client_pay.cid;
END;
$$ 
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_contract (
    cid INT,
    pid INT,
    amount INT,
    bill_day INT
) RETURNS void AS 
$$ 
BEGIN 
    UPDATE contract
    SET amount = update_contract.amount,
        bill_day = update_contract.bill_day
    WHERE contract.cid = update_contract.cid 
    AND contract.pid = update_contract.pid;
END;
$$ 
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_keep_warehouse (
    wid INT,
    pid INT,
    amount INT
) RETURNS void AS 
$$ 
BEGIN 
    UPDATE keep_warehouse
    SET amount = update_keep_warehouse.amount
    WHERE keep_warehouse.wid = update_keep_warehouse.wid
    AND keep_warehouse.pid = update_keep_warehouse.pid;

    INSERT INTO keep_warehouse
    SELECT update_keep_warehouse.wid, update_keep_warehouse.pid, update_keep_warehouse.amount
    WHERE NOT EXISTS (
        SELECT * FROM keep_warehouse
        WHERE keep_warehouse.wid = update_keep_warehouse.wid
        AND keep_warehouse.pid = update_keep_warehouse.pid
    );
END;
$$ 
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_keep_store (
    sid INT,
    pid INT,
    amount INT
) RETURNS void AS 
$$ 
BEGIN 
    UPDATE keep_store
    SET amount = update_keep_store.amount
    WHERE keep_store.sid = update_keep_store.sid
    AND keep_store.pid = update_keep_store.pid;

    INSERT INTO keep_store
    SELECT update_keep_store.sid, update_keep_store.pid, update_keep_store.amount
    WHERE NOT EXISTS (
        SELECT * FROM keep_store
        WHERE keep_store.sid = update_keep_store.sid
        AND keep_store.pid = update_keep_store.pid
    );
END;
$$ 
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION confirm_replenish_m2w (
    rid INT
) RETURNS void AS 
$$ 
BEGIN 
    UPDATE replenish_m2w
    SET is_filled = TRUE
    WHERE replenish_m2w.rid = confirm_replenish_m2w.rid;
END;
$$ 
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION confirm_replenish_w2s (
    rid INT
) RETURNS void AS 
$$ 
BEGIN 
    UPDATE replenish_w2s
    SET is_filled = TRUE
    WHERE replenish_w2s.rid = confirm_replenish_w2s.rid;
END;
$$ 
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION review_order (
    oid INT,
    rating INT,
    review TEXT
) RETURNS void AS 
$$ 
BEGIN 
    UPDATE order_online
    SET rating = review_order.rating,
        review = review_order.review
    WHERE order_online.oid = review_order.oid;
END;
$$ 
LANGUAGE plpgsql;
