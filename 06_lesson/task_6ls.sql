
/*
1) Пусть задан некоторый пользователь. Из всех пользователей соц. сети
найдите человека, который больше всех общался с
выбранным пользователем (написал ему сообщений).
*/

SELECT
    COUNT(*) as cnt,
    from_user_id,
    to_user_id as 'Кому',
    (SELECT firstname from users WHERE id = from_user_id) as 'ownName',
    (SELECT lastname from users WHERE id = from_user_id) as 'ownLastName'
FROM messages
WHERE to_user_id = 1
GROUP BY from_user_id
ORDER BY COUNT(*) DESC
LIMIT 1;







/*
2) Подсчитать общее количество лайков, которые получили пользователи младше 10 лет.
*/

SELECT count(*) as 'кол-во'
from likes
where user_id IN (SELECT user_id
                  from profiles
                  WHERE TIMESTAMPDIFF(YEAR, birthday, NOW()) < 10)





/*
3) Определить кто больше поставил лайков (всего): мужчины или женщины.
*/

select
    count(*) as 'кол-во',
    case(sex)
        when 'f' THEN 'женский'
        when 'm' THEN 'мужской'
        end as пол
from (
         SELECT
             user_id as crt,
             (SELECT gender from profiles WHERE user_id = crt) as sex
         from likes
     ) as prepare_table
group by sex
ORDER by COUNT(*) desc
limit 1;
