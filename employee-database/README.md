# Employee Database — SQL-задания (3 задачи)

База данных сотрудников: иерархия подчинения, отделы, роли, проекты и задачи. Решения используют **рекурсивные CTE** (`WITH RECURSIVE`).

## Структура

```
employee-database/
├── schema/mysql/01_create_tables.sql
├── schema/postgresql/01_create_tables.sql
├── data/
│   ├── 02_seed_data.sql
│   └── 03_postgresql_reset_sequences.sql
└── solutions/
    ├── task1_mysql.sql / task1_postgresql.sql
    ├── task2_mysql.sql / task2_postgresql.sql
    └── task3_mysql.sql / task3_postgresql.sql
```

## Требования

- **MySQL 8.0+** (поддержка `WITH RECURSIVE`)
- **PostgreSQL** 9.1+

## Запуск

```bash
# PostgreSQL
psql -d employee_db -f schema/postgresql/01_create_tables.sql
psql -d employee_db -f data/02_seed_data.sql
psql -d employee_db -f data/03_postgresql_reset_sequences.sql
psql -d employee_db -f solutions/task1_postgresql.sql

# MySQL
mysql -u root -p employee_db < schema/mysql/01_create_tables.sql
mysql -u root -p employee_db < data/02_seed_data.sql
mysql -u root -p employee_db < solutions/task1_mysql.sql
```

## Задачи

| Задача | Описание |
|--------|----------|
| **1** | Иван Иванов (ID=1) и все подчинённые рекурсивно; проекты отдела, задачи сотрудника |
| **2** | То же + `TotalTasks`, `TotalSubordinates` (только **прямые** подчинённые) |
| **3** | Роль «Менеджер», есть подчинённые; `TotalSubordinates` — **вся** иерархия вниз |

## Примечания

- **Проекты** привязаны к отделу сотрудника (`Projects.DepartmentID`).
- **Задачи** — по `Tasks.AssignedTo`; в списке сортировка по `TaskID DESC`.
