/*
* 1. Пусть задан некоторый пользователь. 
* Из всех друзей этого пользователя найдите человека, 
* который больше всех общался с нашим пользователем.
*/

/*
 * Первое задание ниасилил =(
 */

/*
*2. Подсчитать общее количество лайков, 
*которые получили пользователи младше 10 лет..
**/

select count(*) as count from likes where media_id in 
	(select id from media where user_id in 
		(select user_id from profiles where timestampdiff(year,birthday,current_date) < 10));

/*
 * Определить кто больше поставил лайков (всего) - мужчины или женщины?
 */

select count(*) as cnt,
	(select 
		(select if (gender='m', "male", "female")
			from profiles where user_id = users.id) 
	from users where users.id = user_id) as gender
from likes group by gender order by cnt desc limit 1;

