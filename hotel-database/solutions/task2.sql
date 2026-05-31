-- Задача 2
-- Пересечение двух групп клиентов в одном запросе:
--   1) > 2 бронирований и > 1 уникального отеля;
--   2) сумма цен номеров по бронированиям > 500.
-- Сумма = SUM(Room.price) за каждое бронирование (без умножения на ночи).
-- Сортировка: по total_spent по возрастанию.

WITH booking_stats AS (
    SELECT c.ID_customer,
           c.name,
           COUNT(b.ID_booking) AS total_bookings,
           COUNT(DISTINCT h.ID_hotel) AS unique_hotels,
           SUM(r.price) AS total_spent
    FROM Customer c
    INNER JOIN Booking b ON c.ID_customer = b.ID_customer
    INNER JOIN Room r ON b.ID_room = r.ID_room
    INNER JOIN Hotel h ON r.ID_hotel = h.ID_hotel
    GROUP BY c.ID_customer, c.name
),
multi_hotel_clients AS (
    SELECT ID_customer,
           name,
           total_bookings,
           unique_hotels,
           total_spent
    FROM booking_stats
    WHERE total_bookings > 2
      AND unique_hotels > 1
),
high_spending_clients AS (
    SELECT ID_customer,
           name,
           total_bookings,
           unique_hotels,
           total_spent
    FROM booking_stats
    WHERE total_spent > 500
)
SELECT m.ID_customer,
       m.name,
       m.total_bookings,
       m.total_spent,
       m.unique_hotels
FROM multi_hotel_clients m
INNER JOIN high_spending_clients h ON m.ID_customer = h.ID_customer
ORDER BY m.total_spent ASC;
