-- Процдуру для поиска всех товаров когда-либо заказывал конкретный пользоваетель

DROP PROCEDURE IF EXISTS mydb_shop.sp_buyers;

DELIMITER $$
$$
CREATE PROCEDURE mydb_shop.sp_buyers(user_id BIGINT)
BEGIN
    SELECT DISTINCT op.product_id  from orders o
                                            join order_products op ON op.order_id = o.id
    where o.buyer = user_id;
END$$
DELIMITER ;


call mydb_shop.sp_buyers(4);



-- Тут начал делать и понял что вложенный запрос плохо и не смог его сделать JOIN
-- не могли бы Вы подсказать я хотел как на уроке предложить товары одной марки, который
-- покупал пользователь. получилось только с вложенным вывести товары данного бренда


SELECT * FROM products p
where p.brand_id IN (
    SELECT p.brand_id from products p
                               join orders o ON o.buyer = 8
                               JOIN order_products op on op.order_id = o.id and p.id = op.product_id
    GROUP BY p.brand_id
)
