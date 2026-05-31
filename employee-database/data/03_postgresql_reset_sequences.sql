-- Выполнить после 02_seed_data.sql в PostgreSQL

SELECT setval(pg_get_serial_sequence('Departments', 'DepartmentID'), (SELECT MAX(DepartmentID) FROM Departments));
SELECT setval(pg_get_serial_sequence('Roles', 'RoleID'), (SELECT MAX(RoleID) FROM Roles));
SELECT setval(pg_get_serial_sequence('Employees', 'EmployeeID'), (SELECT MAX(EmployeeID) FROM Employees));
SELECT setval(pg_get_serial_sequence('Projects', 'ProjectID'), (SELECT MAX(ProjectID) FROM Projects));
SELECT setval(pg_get_serial_sequence('Tasks', 'TaskID'), (SELECT MAX(TaskID) FROM Tasks));
