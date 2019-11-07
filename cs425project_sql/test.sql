--===========================Insert===========================
SELECT * FROM insert_online_client('JJ', 'Lin', 'ssss@ddd.com', 'MY-MASKED-PASSWORD');
SELECT * FROM insert_replenish_m2w(1, 1, 2000, '2019-10-13');
SELECT * FROM insert_replenish_w2s(1, 1, 1, 2000, '2019-10-19');
SELECT * FROM insert_order_online(1, 1, 1, 3, '2019-11-10', 'tracking_number');
SELECT * FROM insert_order_store(1, 1, 1, 3, '2019-11-11');
SELECT * FROM insert_contract(1, 1, 10, 1);
--===========================Update===========================
SELECT * FROM update_online_client_basic(1, 'Jay', 'Zhou');
SELECT * FROM update_online_client_password (1, 'NEW-PASSWORD');
SELECT * FROM update_online_client_pay(1, '312-445-2255', '4345-2456-3333-5556', '2345-5544-5562-4444', 'XX Street', '60616');
SELECT * FROM update_contract(1, 1, 10, 3);
SELECT * FROM update_keep_warehouse(1, 1, 100);
SELECT * FROM update_keep_store(1, 1, 100);
SELECT * FROM confirm_replenish_m2w(1);
SELECT * FROM confirm_replenish_w2s(1);
SELECT * FROM review_order(1, 5, 'It is Perfect!');