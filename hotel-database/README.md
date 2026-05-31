# Hotel Database — SQL-задания (3 задачи)

База данных бронирования отелей: отели, номера, клиенты и бронирования.

## Структура

```
hotel-database/
├── schema/mysql/01_create_tables.sql
├── schema/postgresql/01_create_tables.sql
├── data/
│   ├── 02_seed_data.sql
│   └── 03_postgresql_reset_sequences.sql
└── solutions/
    ├── task1_mysql.sql
    ├── task1_postgresql.sql
    ├── task2.sql
    ├── task3_mysql.sql
    └── task3_postgresql.sql
```

## Запуск

```bash
# PostgreSQL
psql -d hotel_db -f schema/postgresql/01_create_tables.sql
psql -d hotel_db -f data/02_seed_data.sql
psql -d hotel_db -f data/03_postgresql_reset_sequences.sql
psql -d hotel_db -f solutions/task1_postgresql.sql

# MySQL
mysql -u root -p hotel_db < schema/mysql/01_create_tables.sql
mysql -u root -p hotel_db < data/02_seed_data.sql
mysql -u root -p hotel_db < solutions/task1_mysql.sql
```

## Задачи

| Задача | Описание |
|--------|----------|
| 1 | Клиенты с > 2 бронированиями в разных отелях; список отелей; средняя длительность |
| 2 | Пересечение: мультиотельные клиенты и сумма бронирований > 500 |
| 3 | Категория отелей по средней цене; предпочтения клиентов |

## Примечания

- **Задача 2:** `total_spent = SUM(Room.price)` по бронированиям (без умножения на число ночей) — согласно тестовым данным (820 / 850).
- **Задача 3:** категории отеля: `< 175` Дешевый, `175–300` Средний, `> 300` Дорогой; приоритет предпочтения: Дорогой → Средний → Дешевый.
