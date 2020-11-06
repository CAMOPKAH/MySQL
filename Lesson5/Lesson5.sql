
/*
Практическое задание по теме “Операторы, фильтрация, сортировка и ограничение”
*/
/*
1. Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.
*/

UPDATE  `users`
  SET created_at=IF(created_at is null, NOW(), created_at),
      updated_at=IF(updated_at is null, NOW(), updated_at)
WHERE created_at is NULL OR updated_at is NULL


/*2. Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения в формате "20.10.2017 8:10". Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения. */
 
/* Приводим формат даты к текущему*/
UPDATE users u
   SET u.s_created_at=STR_TO_DATE( u.s_created_at, '%d.%m.%Y %h:%i' ),
       u.s_update_at=STR_TO_DATE( u.s_update_at, '%d.%m.%Y %h:%i' );
/* Меняем тип полей*/

ALTER TABLE `users` CHANGE `s_created_at` `s_created_at` DATETIME NOT NULL, CHANGE `s_update_at` `s_update_at` DATETIME NOT NULL;

/*3. В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, если товар закончился и выше нуля, если на складе имеются запасы. Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. Нулевые запасы должны выводиться в конце, после всех записей.*/

SELECT `id`,`storehouse_id`,`product_id`,`value`,`created_at`,`updated_at` FROM `storehouses_products` s WHERE 1
order by value=0, value;


/*4. (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. Месяцы заданы в виде списка английских названий ('may', 'august') */
SELECT  * FROM `users` u WHERE date_format(`birthday_at`,'%M') IN ( 'May','August');

/* 5. (по желанию) Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, заданном в списке IN. */

SELECT * FROM catalogs WHERE id IN (5, 1, 2)
order by case 
           WHEN id=5 THEN 1 
           WHEN id=1 THEN 2
           WHEN id=2 THEN 3

           END

/*
Практическое задание по теме “Агрегация данных”
*/
/*
1. Подсчитайте средний возраст пользователей в таблице users.
*/
SELECT ROUND(AVG(YEAR(NOW()) - YEAR(u.birthday_at))) FROM users u
 WHERE NOT u.birthday_at is NULL;

/*
2. Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. Следует учесть, что необходимы дни недели текущего года, а не года рождения.
*/
SELECT DATE_FORMAT(
     ADDDATE(u.birthday_at, INTERVAL YEAR(NOW()) - YEAR(u.birthday_at) YEAR) /* Приводим дату рождения к текущему году */
        , '%a') /* Возвращаем день недели дня рождения в текущем году */
 DAY_WEEK, COUNT(*) CNT_WEEK_BIRTHDAY  FROM users u
 WHERE NOT u.birthday_at is NULL
 GROUP BY DAY_WEEK;


/*
3. (по желанию) Подсчитайте произведение чисел в столбце таблицы.
*/

/* логирифм произведений равен сумме логарифмов, потом применим обратную функцию exp*/
SELECT exp(SUM(log(price)))   FROM `products`