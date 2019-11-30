-- ===========================Clear===========================
DROP VIEW IF EXISTS product_summary;

DROP TABLE IF EXISTS order_store;

DROP TABLE IF EXISTS contract;

DROP TABLE IF EXISTS order_online;

DROP TABLE IF EXISTS keep_store;

DROP TABLE IF EXISTS keep_warehouse;

DROP TABLE IF EXISTS replenish_w2s;

DROP TABLE IF EXISTS replenish_m2w;

DROP TABLE IF EXISTS package;

DROP TABLE IF EXISTS online_client;

DROP TABLE IF EXISTS product_images;

DROP TABLE IF EXISTS product_categories;

DROP TABLE IF EXISTS product;

DROP TABLE IF EXISTS store;

DROP TABLE IF EXISTS warehouse;

DROP TABLE IF EXISTS manufacturer;

DROP TABLE IF EXISTS address;

DROP TABLE IF EXISTS region;

-- ===========================Entities===========================
CREATE TABLE region (
    zip CHAR(5),
    city VARCHAR(50) NOT NULL,
    state_id CHAR(2) NOT NULL,
    PRIMARY KEY (zip)
);

CREATE TABLE address (
    aid SERIAL,
    street VARCHAR(100) NOT NULL,
    zip CHAR(5) NOT NULL,
    PRIMARY KEY (aid),
    FOREIGN KEY (zip) REFERENCES region ON DELETE CASCADE
);

CREATE TABLE manufacturer (
    mid SERIAL,
    name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(50),
    aid INT,
    PRIMARY KEY (mid),
    FOREIGN KEY (aid) REFERENCES address ON DELETE SET NULL
);

CREATE TABLE warehouse (
    wid SERIAL,
    name VARCHAR(100) NOT NULL,
    aid INT,
    PRIMARY KEY (wid),
    FOREIGN KEY (aid) REFERENCES address ON DELETE SET NULL
);

CREATE TABLE store (
    sid SERIAL,
    name VARCHAR(100) NOT NULL,
    aid INT,
    PRIMARY KEY (sid),
    FOREIGN KEY (aid) REFERENCES address ON DELETE SET NULL
);

CREATE TABLE product (
    pid SERIAL,
    name TEXT NOT NULL,
    price MONEY NOT NULL CHECK (price::numeric > 0),
    mid INT,
    PRIMARY KEY (pid),
    FOREIGN KEY (mid) REFERENCES manufacturer ON DELETE SET NULL
);

CREATE TABLE product_categories (
    pid INT,
    category VARCHAR(50) NOT NULL,
    PRIMARY KEY (pid, category),
    FOREIGN KEY (pid) REFERENCES product ON DELETE CASCADE
);

CREATE TABLE product_images (
    pid INT,
    image_url TEXT NOT NULL,
    PRIMARY KEY (pid, image_url),
    FOREIGN KEY (pid) REFERENCES product ON DELETE CASCADE
);

CREATE TABLE online_client (
    cid SERIAL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email_address VARCHAR(50) UNIQUE NOT NULL,
    phone_number VARCHAR(50),
    aid INT,
    card_number VARCHAR(50),
    account_number VARCHAR(50),
    password_masked CHAR(64) NOT NULL,
    PRIMARY KEY (cid),
    FOREIGN KEY (aid) REFERENCES address ON DELETE SET NULL
);

-- ===========================Relationship===========================
CREATE TABLE package (
    pkgid INT,
    pid INT,
    PRIMARY KEY (pkgid, pid),
    FOREIGN KEY (pkgid) REFERENCES product ON DELETE CASCADE,
    FOREIGN KEY (pid) REFERENCES product ON DELETE CASCADE
);

-- manufacturer to warehouse
CREATE TABLE replenish_m2w (
    rid SERIAL,
    wid INT,
    pid INT,
    amount INT NOT NULL CHECK (amount > 0),
    is_filled BOOLEAN NOT NULL DEFAULT FALSE,
    date DATE NOT NULL CHECK (date BETWEEN '1900-01-01'
        AND '2100-01-01'),
    PRIMARY KEY (rid),
    FOREIGN KEY (wid) REFERENCES warehouse ON DELETE SET NULL,
    FOREIGN KEY (pid) REFERENCES product ON DELETE SET NULL
);

-- warehouse to store
CREATE TABLE replenish_w2s (
    rid SERIAL,
    wid INT,
    sid INT,
    pid INT,
    amount INT NOT NULL CHECK (amount > 0),
    is_filled BOOLEAN NOT NULL DEFAULT FALSE,
    date DATE NOT NULL CHECK (date BETWEEN '1900-01-01'
        AND '2100-01-01'),
    PRIMARY KEY (rid),
    FOREIGN KEY (wid) REFERENCES warehouse ON DELETE SET NULL,
    FOREIGN KEY (sid) REFERENCES store ON DELETE SET NULL,
    FOREIGN KEY (pid) REFERENCES product ON DELETE SET NULL
);

CREATE TABLE keep_warehouse (
    wid INT,
    pid INT NOT NULL,
    amount INT NOT NULL CHECK (amount >= 0),
    PRIMARY KEY (wid, pid),
    FOREIGN KEY (wid) REFERENCES warehouse ON DELETE CASCADE,
    FOREIGN KEY (pid) REFERENCES product ON DELETE CASCADE
);

CREATE TABLE keep_store (
    sid INT,
    pid INT NOT NULL,
    amount INT NOT NULL CHECK (amount >= 0),
    PRIMARY KEY (sid, pid),
    FOREIGN KEY (sid) REFERENCES store ON DELETE CASCADE,
    FOREIGN KEY (pid) REFERENCES product ON DELETE CASCADE
);

CREATE TABLE order_online (
    oid SERIAL,
    cid INT,
    wid INT,
    pid INT,
    amount INT NOT NULL CHECK (amount > 0),
    date DATE NOT NULL CHECK (date BETWEEN '1900-01-01'
        AND '2100-01-01'),
    tracking_number VARCHAR(50),
    rating INT CHECK (rating BETWEEN 1 AND 5),
    review TEXT,
    PRIMARY KEY (oid),
    FOREIGN KEY (cid) REFERENCES online_client ON DELETE SET NULL,
    FOREIGN KEY (wid) REFERENCES warehouse ON DELETE SET NULL,
    FOREIGN KEY (pid) REFERENCES product ON DELETE SET NULL
);

CREATE TABLE contract (
    cid INT,
    pid INT,
    amount INT NOT NULL CHECK (amount > 0),
    bill_day INT NOT NULL CHECK (bill_day BETWEEN 1 AND 31) DEFAULT 1,
    PRIMARY KEY (cid, pid),
    FOREIGN KEY (cid) REFERENCES online_client ON DELETE SET NULL,
    FOREIGN KEY (pid) REFERENCES product ON DELETE SET NULL
);

CREATE TABLE order_store (
    oid SERIAL,
    cid INT,
    sid INT,
    pid INT,
    amount INT NOT NULL CHECK (amount > 0),
    date DATE NOT NULL CHECK (date BETWEEN '1900-01-01'
        AND '2100-01-01'),
    PRIMARY KEY (oid),
    FOREIGN KEY (cid) REFERENCES online_client ON DELETE SET NULL,
    FOREIGN KEY (sid) REFERENCES store ON DELETE SET NULL,
    FOREIGN KEY (pid) REFERENCES product ON DELETE SET NULL
);

-- ===========================View===========================
CREATE OR REPLACE VIEW product_summary AS
    WITH ratings AS (
        SELECT pid, avg(rating) as client_rating
        FROM order_online
        GROUP BY pid
    ),
    max_storage AS (
        SELECT pid, max(amount) as item_left
        FROM keep_warehouse
        GROUP BY pid
    ),
    storage AS (
        SELECT DISTINCT ON (pid) pid, wid as default_wid, item_left
        FROM keep_warehouse
        NATURAL JOIN max_storage
    ),
    image AS (
        SELECT DISTINCT ON (pid) pid, image_url
        FROM product_images
    )
    SELECT product.pid, name, price, image_url, client_rating, item_left, default_wid
    FROM (
        product
        LEFT OUTER JOIN ratings
        ON product.pid = ratings.pid
        LEFT OUTER JOIN storage
        ON product.pid = storage.pid
        LEFT OUTER JOIN image
        ON product.pid = image.pid
        )
    ORDER BY product.pid;

CREATE OR REPLACE VIEW product_total_sales AS
    WITH product_total AS(
        SELECT pid, COUNT(amount) as amount
        FROM order_online
        GROUP BY pid
    )
    SELECT pid, amount, price, (amount*price) as total_price
        FROM product_total NATURAL JOIN product
        ORDER BY total_price DESC, price DESC;

CREATE OR REPLACE VIEW category_total_sales AS
    SELECT category, SUM(total_price) AS total_price
        FROM product_total_sales NATURAL JOIN product_categories
        GROUP BY category
        ORDER BY total_price DESC;

CREATE OR REPLACE VIEW customer_consume_report AS
    WITH customer_buy AS(
        SELECT cid, pid, COUNT(amount) as c
        FROM order_online
        GROUP BY cid, pid
        ),
        expendamount_pid AS(
        SELECT cid, pid, c, price, (price*c) as expendamount_p
        FROM customer_buy NATURAL JOIN product
        )
    SELECT cid, SUM(expendamount_p) as expendamount
    FROM expendamount_pid
    GROUP BY cid
    ORDER BY expendamount DESC;

CREATE OR REPLACE VIEW sales_monthly_report AS
    WITH sales_report AS(
        SELECT EXTRACT(year from date) as yr,
        EXTRACT(month from date) as mon,
        pid, 
        COUNT(amount) as sales_number
        FROM order_online
        GROUP BY EXTRACT(year from date),
        EXTRACT(month from date), 
        pid
        ORDER BY yr DESC, mon DESC, pid ASC
    )   
    SELECT yr, mon, pid, sales_number, price, (price * sales_number) as sales_total
        FROM sales_report NATURAL JOIN product;

CREATE OR REPLACE VIEW sales_year_report AS
    WITH sales_report AS(
        SELECT EXTRACT(year from date) as yr,
        pid, 
        COUNT(amount) as sales_number
        FROM order_online
        GROUP BY EXTRACT(year from date), pid
        ORDER BY yr DESC, pid ASC
    )   
    SELECT yr, pid, sales_number, price, (price * sales_number) as sales_total
        FROM sales_report NATURAL JOIN product;

CREATE OR REPLACE VIEW region_total_sales AS
    WITH pid_total AS(
        SELECT pid, wid, SUM(amount) as amount
        FROM order_online
        GROUP BY pid, wid
        ),
        pid_price_total AS(
        SELECT pid, wid, price, (price*amount) AS total_sales, amount
        FROM pid_total NATURAL JOIN product
        ),
        wid_total AS(
        SELECT wid, SUM(amount) AS amount, SUM(total_sales) AS total_sales
        FROM pid_price_total
        GROUP BY wid
        ),
        aid_total AS(
        SELECT aid, SUM(amount) AS amount, SUM(total_sales) AS total_sales
        FROM wid_total NATURAL JOIN warehouse
        GROUP BY aid
        ),
        zip_total AS(
        SELECT zip, SUM(amount) as amount_zip, SUM(total_sales) AS total_sales
        FROM aid_total NATURAL JOIN address
        GROUP BY zip
        )
        SELECT zip, city, state_id, amount_zip as amount, total_sales
        FROM zip_total NATURAL JOIN region
        ORDER BY total_sales DESC;