-- ===========================Entities===========================
CREATE TABLE region (
    zip char(5),
    city varchar(20),
    state char(2),
    PRIMARY KEY (zip)
);

CREATE TABLE address (
    aid int,
    street varchar(100),
    zip char(5),
    PRIMARY KEY (aid),
    FOREIGN KEY (zip) REFERENCES region
);

CREATE TABLE manufacturer (
    mid int,
    name varchar(100),
    phone_number varchar(20),
    aid int,
    PRIMARY KEY (mid),
    FOREIGN KEY (aid) REFERENCES address
);

CREATE TABLE warehouse (
    wid int,
    name varchar(100),
    aid int,
    PRIMARY KEY (wid),
    FOREIGN KEY (aid) REFERENCES address
);

CREATE TABLE store (
    sid int,
    name varchar(100),
    aid int,
    PRIMARY KEY (sid),
    FOREIGN KEY (aid) REFERENCES address
);

CREATE TABLE product (
    pid int,
    name varchar(100),
    type varchar(20),
    description text,
    price money,
    photo varchar(100),
    mid int,
    PRIMARY KEY (pid),
    FOREIGN KEY (mid) REFERENCES manufacturer
);

CREATE TABLE online_client (
    cid int,
    name varchar(100),
    phone_number varchar(20),
    email_address varchar(100),
    aid int,
    card_numbers varchar(20)[],
    account_numbers varchar(20)[],
    password_masked char(64),
    PRIMARY KEY (cid),
    FOREIGN KEY (aid) REFERENCES address
);

CREATE TABLE store_client (
    cid int,
    name varchar(100) DEFAULT 'unknown',
    PRIMARY KEY (cid)
);

-- ===========================Relationship===========================
CREATE TABLE package (
    pkgid int,
    pid int,
    PRIMARY KEY (pkgid, pid),
    FOREIGN KEY (pkgid) REFERENCES product,
    FOREIGN KEY (pid) REFERENCES product
);

-- manufacturer to warehouse
CREATE TABLE replenish_m2w (
    rid int,
    mid int,
    wid int,
    pid int,
    amount int,
    is_filled boolean,
    date date,
    PRIMARY KEY (rid),
    FOREIGN KEY (mid) REFERENCES manufacturer,
    FOREIGN KEY (wid) REFERENCES warehouse,
    FOREIGN KEY (pid) REFERENCES product
);

-- warehouse to store
CREATE TABLE replenish_w2s (
    rid int,
    wid int,
    sid int,
    pid int,
    amount int,
    is_filled boolean,
    date date,
    PRIMARY KEY (rid),
    FOREIGN KEY (wid) REFERENCES warehouse,
    FOREIGN KEY (sid) REFERENCES store,
    FOREIGN KEY (pid) REFERENCES product
);

CREATE TABLE keep_warehouse (
    wid int,
    pid int,
    amount int,
    PRIMARY KEY (wid, pid),
    FOREIGN KEY (wid) REFERENCES warehouse,
    FOREIGN KEY (pid) REFERENCES product
);

CREATE TABLE keep_store (
    sid int,
    pid int,
    amount int,
    PRIMARY KEY (sid, pid),
    FOREIGN KEY (sid) REFERENCES store,
    FOREIGN KEY (pid) REFERENCES product
);

CREATE TABLE order_online (
    oid int,
    cid int,
    wid int,
    pid int,
    amount int,
    discount float,
    date date,
    tracking_number varchar(20),
    rating int,
    review text,
    PRIMARY KEY (oid),
    FOREIGN KEY (cid) REFERENCES online_client,
    FOREIGN KEY (wid) REFERENCES warehouse,
    FOREIGN KEY (pid) REFERENCES product
);

CREATE TABLE contract (
    cid int,
    pid int,
    amount int,
    bill_day int,
    PRIMARY KEY (cid, pid),
    FOREIGN KEY (cid) REFERENCES online_client,
    FOREIGN KEY (pid) REFERENCES product
);

CREATE TABLE order_store (
    oid int,
    cid int,
    sid int,
    pid int,
    amount int,
    discount float,
    date date,
    PRIMARY KEY (oid),
    FOREIGN KEY (cid) REFERENCES store_client,
    FOREIGN KEY (sid) REFERENCES store,
    FOREIGN KEY (pid) REFERENCES product
);

