/*
*Создайте таблицу logs типа Archive. 
*Пусть при каждом создании записи в таблицах 
*users, catalogs и products 
*в таблицу logs помещается время и дата создания записи, 
*название таблицы, идентификатор первичного ключа и содержимое поля name.
*/

use shop;
DROP TABLE IF EXISTS logs;
CREATE TABLE logs(
  `id`    SERIAL,
  `time`  datetime default current_timestamp(),
  `table` VARCHAR(255) COMMENT 'Название таблицы',
  `key`   bigint,
  `name`  varchar(255)
) ENGINE=ARCHIVE comment = 'логи';


delimiter //
create procedure logging(in tbl varchar(255), t_key bigint, t_name varchar(255))
begin
	insert into logs(`table`, `key`, `name`) values (tbl, t_key, t_name);
end//

create trigger t1 
	after insert on products
	for each row
begin
	call logging('products', new.id, new.name);
end//

create trigger t2 
	after insert on catalogs
	for each row
begin
	call logging('catalogs', new.id, new.name);
end//

create trigger t3 
	after insert on users
	for each row
begin
	call logging('users', new.id, new.name);
end//

delimiter ;
