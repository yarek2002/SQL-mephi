# Racing Database — SQL-задания (5 задач)

База данных гоночных автомобилей: классы, автомобили, гонки и результаты.

## Структура

```
racing-database/
├── schema/mysql/01_create_tables.sql
├── schema/postgresql/01_create_tables.sql
├── data/02_seed_data.sql
└── solutions/
    ├── task1.sql … task5.sql
```

## Запуск

```bash
# PostgreSQL
psql -d racing_db -f schema/postgresql/01_create_tables.sql
psql -d racing_db -f data/02_seed_data.sql
psql -d racing_db -f solutions/task1.sql

# MySQL
mysql -u root -p racing_db < schema/mysql/01_create_tables.sql
mysql -u root -p racing_db < data/02_seed_data.sql
mysql -u root -p racing_db < solutions/task1.sql
```

## Задачи

| Задача | Описание |
|--------|----------|
| 1 | Лучший по средней позиции автомобиль в каждом классе |
| 2 | Один лучший автомобиль среди всех (при ничьей — по алфавиту) |
| 3 | Все автомобили из классов с наименьшей средней позицией |
| 4 | Автомобили лучше среднего по классу (≥ 2 участника в классе) |
| 5 | Классы с макс. числом автомобилей со средней позицией > 3.0 |
