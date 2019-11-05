-- ===========================Clear===========================
DROP TABLE IF EXISTS order_store;

DROP TABLE IF EXISTS contract;

DROP TABLE IF EXISTS order_online;

DROP TABLE IF EXISTS keep_store;

DROP TABLE IF EXISTS keep_warehouse;

DROP TABLE IF EXISTS replenish_w2s;

DROP TABLE IF EXISTS replenish_m2w;

DROP TABLE IF EXISTS package;

DROP TABLE IF EXISTS online_client;

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
    name VARCHAR(100) NOT NULL,
    type VARCHAR(50),
    description TEXT,
    price MONEY NOT NULL CHECK (price::numeric > 0),
    photo VARCHAR(100),
    mid INT,
    PRIMARY KEY (pid),
    FOREIGN KEY (mid) REFERENCES manufacturer ON DELETE SET NULL
);

CREATE TABLE online_client (
    cid SERIAL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(50) NOT NULL,
    email_address VARCHAR(100) NOT NULL,
    aid INT,
    card_numbers VARCHAR(50)[],
    account_numbers VARCHAR(50)[],
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
    mid INT,
    wid INT,
    pid INT,
    amount INT NOT NULL CHECK (amount > 0),
    is_filled BOOLEAN NOT NULL DEFAULT FALSE,
    date DATE NOT NULL CHECK (date BETWEEN '1900-01-01'
        AND '2100-01-01'),
    PRIMARY KEY (rid),
    FOREIGN KEY (mid) REFERENCES manufacturer ON DELETE SET NULL,
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
    discount FLOAT NOT NULL DEFAULT 1.0,
    date DATE NOT NULL CHECK (date BETWEEN '1900-01-01'
        AND '2100-01-01'),
    tracking_number VARCHAR(50),
    rating INT,
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
    bill_day INT NOT NULL CHECK (bill_day BETWEEN 1 AND 28),
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
    discount FLOAT NOT NULL DEFAULT 1.0,
    date DATE NOT NULL CHECK (date BETWEEN '1900-01-01'
        AND '2100-01-01'),
    PRIMARY KEY (oid),
    FOREIGN KEY (cid) REFERENCES online_client ON DELETE SET NULL,
    FOREIGN KEY (sid) REFERENCES store ON DELETE SET NULL,
    FOREIGN KEY (pid) REFERENCES product ON DELETE SET NULL
);

