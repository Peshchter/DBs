/*
*Составьте список пользователей users, 
*которые осуществили хотя бы один заказ orders в интернет магазине.
*/

select name from users 
where users.id in (select user_id from orders);

/*
*Выведите список товаров products и разделов catalogs, 
*который соответствует товару.
*/
select name, (select name from catalogs where id = catalog_id) as `catalog` from products;

/*
*(по желанию) Пусть имеется таблица рейсов flights (id, from, to) 
*и таблица городов cities (label, name). 
*Поля from, to и label содержат английские названия городов, поле name — русское. 
*Выведите список рейсов flights с русскими названиями городов.
*/

select 
(select name from cities where label = `from`) as `from`,
(select name from cities where label = `to`) as `to` 
from flights;
