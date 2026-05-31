-- После явной вставки ID в PostgreSQL обновите счётчики SERIAL (выполнить после 02_seed_data.sql)

SELECT setval(pg_get_serial_sequence('Hotel', 'ID_hotel'), (SELECT MAX(ID_hotel) FROM Hotel));
SELECT setval(pg_get_serial_sequence('Room', 'ID_room'), (SELECT MAX(ID_room) FROM Room));
SELECT setval(pg_get_serial_sequence('Customer', 'ID_customer'), (SELECT MAX(ID_customer) FROM Customer));
SELECT setval(pg_get_serial_sequence('Booking', 'ID_booking'), (SELECT MAX(ID_booking) FROM Booking));
