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

CREATE OR REPLACE FUNCTION insert_order_online (
    cid INT,
    wid INT,
    pid INT,
    amount INT,
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
        date,
        tracking_number,
        NULL,
        NULL
    ) RETURNING oid INTO ret;

    UPDATE keep_warehouse
    SET amount = keep_warehouse.amount - insert_order_online.amount
    WHERE keep_warehouse.wid = insert_order_online.wid
    AND keep_warehouse.pid = insert_order_online.pid;

    RETURN ret;
END;
$$ 
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION insert_order_store (
    cid INT,
    sid INT,
    pid INT,
    amount INT,
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
    SET amount = keep_warehouse.amount + update_keep_warehouse.amount
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
    SET amount = keep_store.amount + update_keep_store.amount
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
        date
    ) RETURNING rid INTO ret;

    PERFORM update_keep_warehouse(wid, pid, amount);

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
        date
    ) RETURNING rid INTO ret;

    PERFORM update_keep_warehouse(wid, pid, -amount);
    PERFORM update_keep_store(sid, pid, amount);

    RETURN ret;
END;
$$ 
LANGUAGE plpgsql;

-- ===========================Query===========================
CREATE OR REPLACE FUNCTION filter_by_category (
    category VARCHAR(50) 
) RETURNS TABLE (pid INT) AS 
$$ 
    SELECT pid
    FROM product_categories
    WHERE product_categories.category = filter_by_category.category;
$$ 
LANGUAGE SQL;

CREATE OR REPLACE FUNCTION select_online_client (
    email_address VARCHAR(50)
) RETURNS TABLE (
    cid INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email_address VARCHAR(50),
    phone_number VARCHAR(50),
    street VARCHAR(100),
    zip CHAR(5),
    city VARCHAR(50),
    state_id CHAR(2),
    card_number VARCHAR(50),
    account_number VARCHAR(50),
    password_masked CHAR(64)
) AS 
$$ 
    WITH client AS (
        SELECT *
        FROM online_client 
        WHERE online_client.email_address = select_online_client.email_address
    )
    SELECT client.cid,
        client.first_name,
        client.last_name,
        client.email_address,
        client.phone_number,
        address.street,
        address.zip,
        region.city,
        region.state_id,
        client.card_number,
        client.account_number,
        client.password_masked
    FROM client LEFT OUTER JOIN address
        ON client.aid = address.aid
        LEFT OUTER JOIN region
        ON address.zip = region.zip;
$$ 
LANGUAGE SQL;

CREATE OR REPLACE FUNCTION select_order_online (
    cid INT
) RETURNS TABLE (
    oid INT,
    cid INT,
    wid INT,
    pid INT,
    amount INT,
    date DATE,
    tracking_number VARCHAR(50),
    rating INT,
    review TEXT
) AS 
$$ 
    SELECT oid, cid, wid, pid, amount, date, tracking_number, rating, review
    FROM order_online
    WHERE order_online.cid = select_order_online.cid
    ORDER BY oid DESC;
$$ 
LANGUAGE SQL;

CREATE OR REPLACE FUNCTION select_keep_warehouse (
    wid INT
) RETURNS TABLE (
    wid INT,
    pid INT ,
    amount INT
) AS 
$$ 
    SELECT wid, pid, amount
    FROM keep_warehouse
    WHERE keep_warehouse.wid = select_keep_warehouse.wid;
$$ 
LANGUAGE SQL;

CREATE OR REPLACE FUNCTION select_keep_store (
    sid INT
) RETURNS TABLE (
    sid INT,
    pid INT ,
    amount INT
) AS 
$$ 
    SELECT sid, pid, amount
    FROM keep_store
    WHERE keep_store.sid = select_keep_store.sid;
$$ 
LANGUAGE SQL;

CREATE OR REPLACE FUNCTION get_current_month_report (
    yer FLOAT,
    mon FLOAT
) RETURNS TABLE (
    Year FLOAT,
    Month FLOAT,
    Product_ID INT,
    Unit_price MONEY,
    Sales BIGINT,
    Sales_amount MONEY
) AS 
$$ 
    SELECT Year, Month, Product_ID, Unit_price, Sales, Sales_amount
    FROM sales_monthly_report
    WHERE sales_monthly_report.Month = get_current_month_report.mon
    AND sales_monthly_report.Year = get_current_month_report.yer;
$$ 
LANGUAGE SQL;