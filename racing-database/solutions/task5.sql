-- Задача 5
-- Классы с максимальным числом автомобилей со средней позицией > 3.0.
-- Вывод: автомобили со средней позицией > 3.0 из классов-победителей (при ничьей — все такие классы).
-- low_position_count — число автомобилей класса со средней позицией >= 3.0.
-- total_races — суммарное число гонок автомобилей класса.
-- Сортировка: по low_position_count по убыванию.

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
class_metrics AS (
    SELECT car_class,
           SUM(race_count) AS total_races,
           SUM(CASE WHEN average_position > 3.0 THEN 1 ELSE 0 END) AS bad_avg_count,
           SUM(CASE WHEN average_position >= 3.0 THEN 1 ELSE 0 END) AS low_position_count
    FROM car_stats
    GROUP BY car_class
),
max_bad AS (
    SELECT MAX(bad_avg_count) AS max_count
    FROM class_metrics
)
SELECT cs.car_name,
       cs.car_class,
       cs.average_position,
       cs.race_count,
       cs.car_country,
       cm.total_races,
       cm.low_position_count
FROM car_stats cs
INNER JOIN class_metrics cm ON cs.car_class = cm.car_class
CROSS JOIN max_bad mb
WHERE cm.bad_avg_count = mb.max_count
  AND cs.average_position > 3.0
ORDER BY cm.low_position_count DESC,
         cs.car_class,
         cs.car_name;
