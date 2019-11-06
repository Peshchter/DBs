/*
 * Создайте двух пользователей которые имеют доступ к базе данных shop. 
 * Первому пользователю shop_read должны быть доступны только запросы на чтение данных, 
 * второму пользователю shop — любые операции в пределах базы данных shop.
 */

create user `shop`@`%` identified with sha256_password by 'password';
create user `shop_read`@`%` identified with sha256_password by 'pass';
grant all on shop.* to shop;
grant select on shop.* to shop_read;
