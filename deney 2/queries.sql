1. Sorgu:

CREATE INDEX client_index ON client_master(client_no);

2. Sorgu

CREATE INDEX s_order_no_in ON sales_order (s_order_no);

3. Sorgu: 

CREATE INDEX sales_order_details_in ON sales_order_details (s_order_no, product_no);


4. Sorgu

DROP INDEX sales_order_details_in;

5. sorgu

CREATE VIEW sel_amt_view AS 
SELECT salesman_master.sal_amt
FROM salesman_master
WHERE salesman_master.sal_amt > 3500::numeric;

6. Sorgu

CREATE VIEW client_view AS
SELECT client_master.address1 AS addr1, 
client_master.address2 AS add2, 
client_master.city, client_master.pincode AS pcode, 
client_master.state FROM client_master;

7. Sorgu

SELECT client_master.name AS "bombaylı müşteriler"
FROM client_master 
WHERE client_master.city 
IN (
SELECT client_view.city 
FROM client_view 
WHERE city = 'Bombay');

-- ÇIKTI:

 bombaylı müşteriler 
---------------------
 Ivan
 Pramada
 Basu
 Rukmani
(4 rows)

8. Sorgu

DROP VIEW client_view

9. Sorgu

CREATE VIEW so_gunluk AS 
SELECT sales_order.s_order_no
FROM sales_order
WHERE sales_order.s_order_date = 'now'::text::date;

-- ÇIKTI:

=# SELECT * from so_gunluk;
 s_order_no 
------------
(0 rows)

-- tarihler eski olduğundan dolayı boş sonuç döndü istenen tarhi ayarlanarak çalıştığı görülebilir.
-- örneğin 'now' yerine tablodaki tarihlerden birisi konulduğunda çalışıyor.

10. Sorgu

SELECT  client_master.name, product_master.description 
FROM sales_order_details INNER JOIN sales_order 
ON (sales_order.s_order_no = sales_order_details.s_order_no) 
INNER JOIN product_master ON (product_master.product_no = sales_order_details.product_no) 
INNER JOIN client_master ON (client_master.client_no = sales_order.client_no) 
WHERE sales_order.s_order_date < ('now'::text::date - interval '10' day);

-- ÇIKTI:

  name   |  description  
---------+---------------
 Pramada | 1.44 Floppies
 Vandana | 1.44 Floppies
 Ivan    | 1.44 Floppies
 Ivan    | Monitors
 Pramada | Monitors
 Ivan    | Mouse
 Pramada | Keyboards
 Pramada | CD Drive
 Ivan    | CD Drive
 Basu    | 540 HDD
 Ivan    | 540 HDD
 Basu    | 1.44 Drive
(12 rows)


