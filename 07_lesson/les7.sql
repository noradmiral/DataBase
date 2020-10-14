/*
1) Составьте список пользователей users, которые осуществили хотя
бы один заказ orders в интернет магазине.
 */

use lesson6;
SELECT login, name, `password`, is_admin
from users
where name in (select buyer from orders where buyer = name GROUP by buyer)

/* JOIN */

SELECT
    users.id, users.name
FROM
    users AS users
        JOIN
    orders AS orders
    ON
            users.name = orders.buyer


/*
2) Выведите список товаров products и разделов catalogs,
который соответствует товару.
 */
SELECT
    id,
    name,
    price,
    (SELECT name FROM catalogs WHERE id = products.catalog_id) AS catalogs
FROM
    products;

/* 2 var*/

SELECT
    products.id,
    products.name,
    products.price,
    (SELECT
         catalogs.name FROM catalogs WHERE catalogs.id = products.catalog_id) AS catalogs
FROM
    products;


/* JOIN */


SELECT
    p.id,
    p.name,
    p.price,
    c.name as catalogs
FROM
    products AS p
        LEFT JOIN
    catalogs AS c
ON
        p.catalog_id = c.id;



/*
3) (по желанию) Пусть имеется таблица рейсов flights (id, from, to)
и таблица городов cities (label, name). Поля from, to и label содержат
английские названия городов, поле name — русское. Выведите список рейсов
flights с русскими названиями городов.
 */



use eng_to_rus_flights;
SELECT id,
       (SELECT name from cities where label = f.`from`) as 'Вылет из',
       (SELECT name from cities where label = f.`to`) as 'город прибытия'
from flights f


/* JOIN */



SELECT f.id, c.name as 'vilet', c_to.name as 'prilet'
FROM flights as f
   Join
cities as c
on
       f.`from` = c.label
   JOIN
cities as c_to
on
       f.to = c_to.label
order by f.id
