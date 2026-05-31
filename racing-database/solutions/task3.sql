-- Задача 3
-- Классы с наименьшей средней позицией в гонках; все автомобили из этих классов.
-- При равенстве средней по классу — выбираются все такие классы.

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
           ROUND(AVG(average_position), 4) AS class_average_position
    FROM car_stats
    GROUP BY car_class
),
best_classes AS (
    SELECT car_class
    FROM class_avg
    WHERE class_average_position = (SELECT MIN(class_average_position) FROM class_avg)
)
SELECT cs.car_name,
       cs.car_class,
       cs.average_position,
       cs.race_count,
       cs.car_country,
       (SELECT SUM(cs2.race_count)
        FROM car_stats cs2
        WHERE cs2.car_class = cs.car_class) AS total_races
FROM car_stats cs
INNER JOIN best_classes bc ON cs.car_class = bc.car_class
ORDER BY cs.car_class, cs.car_name;
