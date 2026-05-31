-- Задача 4
-- Автомобили со средней позицией лучше (меньше), чем средняя по классу.
-- В классе должно быть не менее двух автомобилей с результатами гонок.
-- Сортировка: по классу, затем по средней позиции по возрастанию.

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
),
class_avg AS (
    SELECT car_class,
           AVG(average_position) AS class_average_position,
           COUNT(*) AS cars_with_results
    FROM car_stats
    GROUP BY car_class
    HAVING COUNT(*) >= 2
)
SELECT cs.car_name,
       cs.car_class,
       cs.average_position,
       cs.race_count,
       cs.car_country
FROM car_stats cs
INNER JOIN class_avg ca ON cs.car_class = ca.car_class
WHERE cs.average_position < ca.class_average_position
ORDER BY cs.car_class,
         cs.average_position;
