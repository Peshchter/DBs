/* Создайте хранимую функцию hello(), 
* которая будет возвращать приветствие, 
* в зависимости от текущего времени суток. 
* С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", 
* с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", 
* с 18:00 до 00:00 — "Добрый вечер", 
* с 00:00 до 6:00 — "Доброй ночи".
* */
drop function if exists hello;
delimiter //
create function hello()
returns varchar(255) not deterministic
begin
	declare time int;
	set time = date_format(current_time(), '%H');
	if (time<6) then  return `Доброй ночи`;
	elseif (time<12) then  return `Доброе утро`;
	elseif (time<18) then  return `Добрый день`;
	elseif (time>18) then  return `Добрый вечер`;
	end if;	
end
delimiter ;



/* В таблице products есть два текстовых поля: 
 * name с названием товара и description с его описанием. 
 * Допустимо присутствие обоих полей или одно из них. 
 * Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. 
 * Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. 
 * При попытке присвоить полям NULL-значение необходимо отменить операцию.
 * */

drop trigger if exists nn;
delimiter //
create trigger nn 
	before insert on products
	for each row
begin
	if (new.name is null) and (new.description is null) 
		then signal sqlstate '45000' 
		set message_text = 'Нельзя ! Оба поля пусты.';
	end if;
end//
delimiter ;
