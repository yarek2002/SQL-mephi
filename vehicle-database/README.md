# Vehicle Database — SQL-задания (2 задачи)

База данных транспортных средств: автомобили, мотоциклы и велосипеды.

## Структура

```
vehicle-database/
├── schema/mysql/01_create_tables.sql
├── schema/postgresql/01_create_tables.sql
├── data/02_seed_data.sql
└── solutions/
    ├── task1.sql
    ├── task2_mysql.sql
    └── task2_postgresql.sql
```

## Запуск

```bash
# PostgreSQL
psql -d vehicle_db -f schema/postgresql/01_create_tables.sql
psql -d vehicle_db -f data/02_seed_data.sql
psql -d vehicle_db -f solutions/task1.sql

# MySQL
mysql -u root -p vehicle_db < schema/mysql/01_create_tables.sql
mysql -u root -p vehicle_db < data/02_seed_data.sql
mysql -u root -p vehicle_db < solutions/task2_mysql.sql
```

## Задачи

| Задача | Описание |
|--------|----------|
| 1 | Спортивные мотоциклы: мощность > 150, цена < 20 000, тип Sport |
| 2 | UNION выборка Car / Motorcycle / Bicycle по критериям ТЗ |
