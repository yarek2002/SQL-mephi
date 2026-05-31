-- Задача 3 (PostgreSQL)
-- Категория отеля по средней цене номеров; предпочтение клиента: Дорогой > Средний > Дешевый.

WITH hotel_category AS (
    SELECT h.ID_hotel,
           h.name AS hotel_name,
           CASE
               WHEN AVG(r.price) < 175 THEN 'Дешевый'
               WHEN AVG(r.price) <= 300 THEN 'Средний'
               ELSE 'Дорогой'
           END AS hotel_category
    FROM Hotel h
    INNER JOIN Room r ON h.ID_hotel = r.ID_hotel
    GROUP BY h.ID_hotel, h.name
),
customer_visits AS (
    SELECT DISTINCT
           c.ID_customer,
           c.name,
           hc.hotel_name,
           hc.hotel_category
    FROM Customer c
    INNER JOIN Booking b ON c.ID_customer = b.ID_customer
    INNER JOIN Room r ON b.ID_room = r.ID_room
    INNER JOIN hotel_category hc ON r.ID_hotel = hc.ID_hotel
),
customer_preference AS (
    SELECT ID_customer,
           name,
           CASE
               WHEN BOOL_OR(hotel_category = 'Дорогой') THEN 'Дорогой'
               WHEN BOOL_OR(hotel_category = 'Средний') THEN 'Средний'
               ELSE 'Дешевый'
           END AS preferred_hotel_type
    FROM customer_visits
    GROUP BY ID_customer, name
)
SELECT cp.ID_customer,
       cp.name,
       cp.preferred_hotel_type,
       STRING_AGG(DISTINCT cv.hotel_name, ',' ORDER BY cv.hotel_name) AS visited_hotels
FROM customer_preference cp
INNER JOIN customer_visits cv ON cp.ID_customer = cv.ID_customer
GROUP BY cp.ID_customer, cp.name, cp.preferred_hotel_type
ORDER BY CASE cp.preferred_hotel_type
             WHEN 'Дешевый' THEN 1
             WHEN 'Средний' THEN 2
             WHEN 'Дорогой' THEN 3
         END,
         cp.ID_customer;
