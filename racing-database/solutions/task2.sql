-- Задача 2
-- Один автомобиль с наименьшей средней позицией среди всех.
-- При равенстве — выбор по алфавиту (имя автомобиля).

WITH car_stats AS (
    SELECT c.name AS car_name,
           c.class AS car_class,
           cl.country AS car_country,
           ROUND(AVG(r.position), 4) AS average_position,
           COUNT(r.race) AS race_count
    FROM Cars c
    INNER JOIN Classes cl ON c.class = cl.class
    INNER JOIN Results r ON c.name = r.car
    GROUP BY c.name, c.class, cl.country
)
SELECT car_name,
       car_class,
       average_position,
       race_count,
       car_country
FROM car_stats
WHERE average_position = (SELECT MIN(average_position) FROM car_stats)
ORDER BY car_name
LIMIT 1;
