-- Задача 1 (MySQL)
-- Клиенты с более чем 2 бронированиями в разных отелях.
-- Средняя длительность пребывания: DATEDIFF(check_out, check_in) в днях.

SELECT c.name,
       c.email,
       c.phone,
       COUNT(b.ID_booking) AS total_bookings,
       GROUP_CONCAT(DISTINCT h.name ORDER BY h.name SEPARATOR ', ') AS hotels,
       ROUND(AVG(DATEDIFF(b.check_out_date, b.check_in_date)), 4) AS average_stay_days
FROM Customer c
INNER JOIN Booking b ON c.ID_customer = b.ID_customer
INNER JOIN Room r ON b.ID_room = r.ID_room
INNER JOIN Hotel h ON r.ID_hotel = h.ID_hotel
GROUP BY c.ID_customer, c.name, c.email, c.phone
HAVING COUNT(b.ID_booking) > 2
   AND COUNT(DISTINCT h.ID_hotel) > 1
ORDER BY total_bookings DESC;
