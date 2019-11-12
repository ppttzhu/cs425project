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
--=====================Insert Fake Client=====================
SELECT insert_online_client('Madeline','Hernandez','zhanson@hotmail.com','MY-MASKED-PASSWORD');
SELECT insert_online_client('Raymond','Mcdaniel','bcook@carter.info','MY-MASKED-PASSWORD');
SELECT insert_online_client('Philip','Foley','michael49@hester.com','MY-MASKED-PASSWORD');
SELECT insert_online_client('Robert','Wilson','tamisingh@hotmail.com','MY-MASKED-PASSWORD');
SELECT insert_online_client('Diane','Barker','williamsadriana@pearson.info','MY-MASKED-PASSWORD');
SELECT insert_online_client('Regina','Cruz','jessicahess@yahoo.com','MY-MASKED-PASSWORD');
SELECT insert_online_client('Tracy','Maxwell','ysmith@yahoo.com','MY-MASKED-PASSWORD');
SELECT insert_online_client('Kathy','Jones','andrewnorton@gmail.com','MY-MASKED-PASSWORD');
SELECT insert_online_client('Mary','Oliver','ymartinez@yahoo.com','MY-MASKED-PASSWORD');
SELECT insert_online_client('Alejandro','Watson','stacey47@rogers.info','MY-MASKED-PASSWORD');
SELECT insert_online_client('Justin','Leon','hardingjay@gmail.com','MY-MASKED-PASSWORD');
SELECT insert_online_client('Daniel','Meza','aimeemack@yahoo.com','MY-MASKED-PASSWORD');
SELECT insert_online_client('Joel','Foster','cummingsjuan@yahoo.com','MY-MASKED-PASSWORD');
SELECT insert_online_client('Timothy','Holt','lunajesse@flores-barnes.com','MY-MASKED-PASSWORD');
SELECT insert_online_client('Jennifer','Morgan','rogersstephanie@clark.net','MY-MASKED-PASSWORD');
SELECT insert_online_client('Mark','Morgan','josephtorres@snyder.com','MY-MASKED-PASSWORD');
SELECT insert_online_client('Michael','Chambers','tracey68@brown.com','MY-MASKED-PASSWORD');
SELECT insert_online_client('Travis','Wilson','natalieortiz@hotmail.com','MY-MASKED-PASSWORD');
SELECT insert_online_client('Brittany','Padilla','sanchezjessica@yahoo.com','MY-MASKED-PASSWORD');
SELECT insert_online_client('Sarah','Zamora','qjohnson@yahoo.com','MY-MASKED-PASSWORD');
SELECT insert_online_client('Kathy','Mendez','davidmatthews@bailey-gordon.com','MY-MASKED-PASSWORD');
--=====================Update Fake Pay=====================
