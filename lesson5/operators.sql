/*
 Пусть в таблице users поля created_at и updated_at оказались незаполненными. 
 Заполните их текущими датой и временем.
 */

update table users set created_at=NOW(), updated_at=NOW();

/*
Таблица users была неудачно спроектирована. 
Записи created_at и updated_at были заданы типом VARCHAR 
и в них долгое время помещались значения в формате "20.10.2017 8:10". 
Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.
*/
/*
 * Решение видится следующее: 
 * добавляем новые столбцы с нужным типом данных
 * переносим в них преобразованную дату
 * удаляем старые столбцы
 * переименовываем новые так, чтобы называдлись как старые
 */
alter table users add column new_created_at DATETIME not null after created_at;
alter table users add column new_updated_at DATETIME not null after updated_at;
update users set new_created_at=STR_TO_DATE(created_at, '%e.%m.%Y %k:%i'), 
                 new_updated_at=STR_TO_DATE(updated_at, '%e.%m.%Y %k:%i');
alter table users drop column created_at;
alter table users drop column updated_at;
alter table users change new_created_at created_at DATETIME not null;
alter table users change new_updated_at updated_at DATETIME not null;


/*
 * В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 
 * 0, если товар закончился и выше нуля, если на складе имеются запасы. 
 * Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. 
 * Однако, нулевые запасы должны выводиться в конце, после всех записей.
 */
/*
 * Для вывода такого комбинированного условия пришлось добавить
 * дополнительный столбец (назвал grp ) есть ли в наличии или нет (1 или 0)
 * и впервую очередь сортировал по нему по убыванию, потом по количеству по возрастанию.
 */

select *, if (value!=0, 1,0) as grp from storehouses_products order by grp desc, value;
