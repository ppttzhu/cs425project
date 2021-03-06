--===========================Insert===========================
SELECT * FROM insert_online_client('JJ', 'Lin', 'ssss@ddd.com', 'MY-MASKED-PASSWORD');
SELECT * FROM insert_replenish_m2w(1, 1, 2000, '2019-10-13');
SELECT * FROM insert_replenish_m2w(1, 2, 2000, '2019-10-13');
SELECT * FROM insert_replenish_w2s(1, 1, 1, 200, '2019-10-19');
SELECT * FROM insert_order_online(1, 1, 1, 3, '2019-11-10', 'tracking_number');
SELECT * FROM insert_order_store(1, 1, 1, 3, '2019-11-11');
SELECT * FROM insert_contract(1, 1, 10, 1);
--===========================Update===========================
SELECT * FROM update_online_client_basic(1, 'Jay', 'Zhou');
SELECT * FROM update_online_client_password (1, 'NEW-PASSWORD');
SELECT * FROM update_online_client_pay(1, '312-445-2255', '4345-2456-3333-5556', '2345-5544-5562-4444', 'XX Street', '60616');
SELECT * FROM update_contract(1, 1, 10, 3);
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
SELECT update_online_client_pay(2,'075-361-1225x57681','4167460543864','5534500682702280','623 James Shoals','95945');
SELECT update_online_client_pay(3,'(630)138-6073','3589431294836200','501832415316','0833 Jones Knolls','06040');
SELECT update_online_client_pay(4,'(074)743-9116x2271','4453192068598','585846591147','82195 Elizabeth Extensions','40206');
SELECT update_online_client_pay(5,'9128037168','4305028419001347','3515035906949373','6836 Deanna Square Apt. 817','05452');
SELECT update_online_client_pay(6,'397-959-4112','4083316259822009281','4783517282015070','95122 Hansen Port','94591');
SELECT update_online_client_pay(7,'045.203.1364x8539','5163990960670044','5311777174574448','312 Jennifer Mission Suite 737','85306');
SELECT update_online_client_pay(8,'058.853.9257','5176522106797061','4463750386784419','348 Rice Roads Apt. 007','37209');
SELECT update_online_client_pay(9,'(495)088-1236x84751','502084647432','675992159292','629 Jasmine Creek Apt. 646','85305');
SELECT update_online_client_pay(10,'+1-944-386-4603x640','588755003203','180006846678323','009 Reyes Rest','40208');
SELECT update_online_client_pay(11,'706.903.0028','6583485158588454','3569929992223799','71064 Matthew Curve Suite 168','80003');
SELECT update_online_client_pay(12,'001-057-110-9783x947','180089145226135','3534242069165907','75831 Kaitlyn Roads Suite 719','05037');
SELECT update_online_client_pay(13,'5824506304','4665087542791677506','4068663625095387598','677 Judith Mills','06040');
SELECT update_online_client_pay(14,'341.413.9756','5254321234088914','4739527103946798365','35747 Davis Ways','02664');
SELECT update_online_client_pay(15,'001-484-553-5126','4837500152351','676186637820','974 Sarah Station','37206');
SELECT update_online_client_pay(16,'001-894-359-8215x8227','3528903040903637','4497386536852','42117 Dale Lakes Apt. 254','72704');
SELECT update_online_client_pay(17,'328-959-0990','3519591666484114','4171099358504','44999 Schwartz Valley Apt. 215','36108');
SELECT update_online_client_pay(18,'+1-770-085-4401x21702','060463413843','3588404175506490','826 Davis Haven','37076');
SELECT update_online_client_pay(19,'601-665-2252','3569914769870758','6528964128081327','1604 Smith Square','93908');
SELECT update_online_client_pay(20,'001-846-091-7841','4181272686215839','2224028081672963','5498 Jennifer Stravenue Suite 192','72704');
SELECT update_online_client_pay(21,'001-263-487-3455x749','30556307110820','060458180597','976 Gina Plain Suite 575','72703');
--=====================Insert Fake contract=====================
SELECT insert_contract(2,147,8,18);
SELECT insert_contract(2,341,5,24);
SELECT insert_contract(2,116,17,8);
SELECT insert_contract(3,218,6,28);
SELECT insert_contract(3,262,11,22);
SELECT insert_contract(3,155,3,10);
SELECT insert_contract(3,244,14,12);
SELECT insert_contract(4,237,2,13);
SELECT insert_contract(4,319,11,10);
SELECT insert_contract(5,140,4,5);
SELECT insert_contract(5,338,7,22);
SELECT insert_contract(5,238,15,2);
SELECT insert_contract(5,300,8,13);
SELECT insert_contract(6,24,14,7);
SELECT insert_contract(7,228,12,15);
SELECT insert_contract(7,327,7,21);
SELECT insert_contract(8,107,18,6);
SELECT insert_contract(8,83,11,23);
SELECT insert_contract(8,139,19,1);
SELECT insert_contract(8,160,7,13);
SELECT insert_contract(8,30,14,13);
SELECT insert_contract(9,136,9,19);
SELECT insert_contract(10,273,19,17);
SELECT insert_contract(10,125,9,17);
SELECT insert_contract(10,252,8,15);
SELECT insert_contract(10,265,15,28);
SELECT insert_contract(11,200,3,21);
SELECT insert_contract(11,175,4,1);
SELECT insert_contract(11,5,16,13);
SELECT insert_contract(11,105,15,26);
SELECT insert_contract(12,134,13,21);
SELECT insert_contract(12,221,18,24);
SELECT insert_contract(12,18,8,15);
SELECT insert_contract(12,311,1,12);
SELECT insert_contract(13,47,16,8);
SELECT insert_contract(13,109,16,27);
SELECT insert_contract(13,225,15,3);
SELECT insert_contract(13,216,20,24);
SELECT insert_contract(13,76,6,24);
SELECT insert_contract(13,257,12,26);
SELECT insert_contract(14,322,4,6);
SELECT insert_contract(15,168,4,10);
SELECT insert_contract(15,39,18,7);
SELECT insert_contract(15,233,1,1);
SELECT insert_contract(15,294,16,1);
SELECT insert_contract(15,159,17,11);
SELECT insert_contract(15,243,6,13);
SELECT insert_contract(16,119,5,27);
SELECT insert_contract(16,79,20,16);
SELECT insert_contract(16,268,8,14);
SELECT insert_contract(17,293,15,20);
SELECT insert_contract(17,330,9,9);
SELECT insert_contract(17,56,19,22);
SELECT insert_contract(17,172,1,6);
SELECT insert_contract(17,290,12,14);
SELECT insert_contract(18,350,5,3);
SELECT insert_contract(18,274,11,20);
SELECT insert_contract(18,184,3,22);
SELECT insert_contract(18,75,14,3);
SELECT insert_contract(18,134,1,18);
SELECT insert_contract(18,339,17,26);
SELECT insert_contract(19,137,18,12);
SELECT insert_contract(19,149,15,7);
SELECT insert_contract(19,212,17,25);
SELECT insert_contract(20,245,5,25);
SELECT insert_contract(20,132,9,1);
SELECT insert_contract(20,246,3,13);
SELECT insert_contract(21,89,18,14);
SELECT insert_contract(21,63,3,15);
SELECT insert_contract(21,97,17,13);
SELECT insert_contract(21,274,9,10);
SELECT insert_contract(21,99,20,3);
SELECT insert_contract(21,65,19,5);
--=====================Insert Fake order_online=====================
SELECT insert_order_online(3, 1, 6, 3, '2018-5-12', 'tracking_number');
SELECT insert_order_online(3, 1, 5, 1, '2018-6-17', 'tracking_number');
SELECT insert_order_online(4, 1, 2, 1, '2018-11-13', 'tracking_number');
SELECT insert_order_online(5, 1, 2, 1, '2018-11-12', 'tracking_number');
SELECT insert_order_online(6, 1, 2, 3, '2018-11-27', 'tracking_number');
SELECT insert_order_online(6, 1, 2, 3, '2018-10-19', 'tracking_number');
SELECT insert_order_online(7, 1, 3, 1, '2018-11-15', 'tracking_number');
SELECT insert_order_online(8, 1, 2, 1, '2018-11-8', 'tracking_number');
SELECT insert_order_online(9, 1, 4, 2, '2018-7-13', 'tracking_number');
SELECT insert_order_online(10, 1, 2, 1, '2018-11-13', 'tracking_number');
SELECT insert_order_online(1, 1, 2, 2, '2018-8-01', 'tracking_number');
SELECT insert_order_online(1, 1, 2, 1, '2018-9-02', 'tracking_number');
SELECT insert_order_online(1, 1, 3, 3, '2018-10-03', 'tracking_number');
SELECT insert_order_online(1, 1, 3, 3, '2018-11-03', 'tracking_number');
SELECT insert_order_online(1, 1, 2, 2, '2019-8-01', 'tracking_number');
SELECT insert_order_online(1, 1, 2, 1, '2019-9-02', 'tracking_number');
SELECT insert_order_online(1, 1, 3, 3, '2019-10-03', 'tracking_number');
SELECT insert_order_online(1, 1, 3, 3, '2019-11-03', 'tracking_number');
SELECT insert_order_online(2, 1, 4, 1, '2019-1-03', 'tracking_number');
SELECT insert_order_online(2, 1, 5, 1, '2019-1-04', 'tracking_number');
SELECT insert_order_online(2, 1, 7, 1, '2019-1-03', 'tracking_number');
SELECT insert_order_online(2, 1, 4, 1, '2019-8-23', 'tracking_number');
SELECT insert_order_online(2, 1, 5, 1, '2019-8-15', 'tracking_number');
SELECT insert_order_online(2, 1, 4, 1, '2019-11-22', 'tracking_number');
SELECT insert_order_online(3, 1, 2, 1, '2019-5-22', 'tracking_number');
SELECT insert_order_online(3, 1, 6, 3, '2019-5-12', 'tracking_number');
SELECT insert_order_online(3, 1, 5, 1, '2019-6-17', 'tracking_number');
SELECT insert_order_online(4, 1, 2, 1, '2019-11-13', 'tracking_number');
SELECT insert_order_online(5, 1, 2, 1, '2019-11-12', 'tracking_number');
SELECT insert_order_online(6, 1, 2, 3, '2019-11-27', 'tracking_number');
SELECT insert_order_online(6, 1, 2, 3, '2019-10-19', 'tracking_number');
SELECT insert_order_online(7, 1, 3, 1, '2019-11-15', 'tracking_number');
SELECT insert_order_online(8, 1, 2, 1, '2019-11-8', 'tracking_number');
SELECT insert_order_online(9, 1, 4, 2, '2019-7-13', 'tracking_number');
SELECT insert_order_online(10, 1, 2, 1, '2019-11-13', 'tracking_number');
SELECT insert_order_online(10, 2, 2, 1, '2019-11-13', 'tracking_number');
SELECT insert_order_online(7, 2, 3, 1, '2018-11-15', 'tracking_number');
SELECT insert_order_online(8, 3, 2, 1, '2018-11-8', 'tracking_number');
SELECT insert_order_online(9, 2, 4, 2, '2018-7-13', 'tracking_number');
SELECT insert_order_online(10, 4, 2, 1, '2018-11-13', 'tracking_number');
SELECT insert_order_online(2, 5, 5, 1, '2019-8-15', 'tracking_number');
SELECT insert_order_online(2, 5, 4, 1, '2019-11-22', 'tracking_number');
SELECT insert_order_online(3, 5, 2, 1, '2019-5-22', 'tracking_number');





