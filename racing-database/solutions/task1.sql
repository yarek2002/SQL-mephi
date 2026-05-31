-- Задача 1
-- Автомобили с наименьшей средней позицией в гонках внутри своего класса.
-- Сортировка: по средней позиции по возрастанию.

WITH car_stats AS (
    SELECT c.name AS car_name,
           c.class AS car_class,
           ROUND(AVG(r.position), 4) AS average_position,
           COUNT(r.race) AS race_count
    FROM Cars c
    INNER JOIN Results r ON c.name = r.car
    GROUP BY c.name, c.class
),
class_best AS (
    SELECT car_class,
           MIN(average_position) AS min_avg_position
    FROM car_stats
    GROUP BY car_class
)
SELECT cs.car_name,
       cs.car_class,
       cs.average_position,
       cs.race_count
FROM car_stats cs
INNER JOIN class_best cb
    ON cs.car_class = cb.car_class
   AND cs.average_position = cb.min_avg_position
ORDER BY cs.average_position;
