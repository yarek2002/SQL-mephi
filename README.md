# SQL-задания — учебные проекты

Репозиторий содержит **четыре независимых проекта** по работе с MySQL и PostgreSQL. Каждый проект — отдельная база данных, свои скрипты и решения.

## Структура репозитория

```
.
├── README.md
├── vehicle-database/         ← транспортные средства (2 задачи)
├── racing-database/          ← гонки и автомобили (5 задач)
├── hotel-database/           ← бронирование отелей (3 задачи)
└── employee-database/        ← сотрудники и иерархия (3 задачи, RECURSIVE)
```

## Проекты

| Папка | Тема | Задач | Подробности |
|-------|------|-------|-------------|
| [vehicle-database/](vehicle-database/) | Vehicle, Car, Motorcycle, Bicycle | 2 | [README](vehicle-database/README.md) |
| [racing-database/](racing-database/) | Classes, Cars, Races, Results | 5 | [README](racing-database/README.md) |
| [hotel-database/](hotel-database/) | Hotel, Room, Customer, Booking | 3 | [README](hotel-database/README.md) |
| [employee-database/](employee-database/) | Employees, Departments, Tasks | 3 | [README](employee-database/README.md) |

## Быстрый старт

В каждой папке проекта:

1. Создайте базу данных (`vehicle_db`, `racing_db`, `hotel_db` или `employee_db`).
2. Выполните `schema/mysql/` или `schema/postgresql/01_create_tables.sql`.
3. Выполните `data/02_seed_data.sql`.
4. Запустите файлы из `solutions/`.
