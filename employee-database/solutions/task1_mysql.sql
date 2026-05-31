-- Задача 1 (MySQL 8+)
-- Рекурсивно: Иван Иванов (ID=1) и все подчинённые.
-- Проекты — по отделу сотрудника; задачи — по AssignedTo.
-- Сортировка: по имени сотрудника.

WITH RECURSIVE hierarchy AS (
    SELECT e.EmployeeID,
           e.Name,
           e.ManagerID,
           e.DepartmentID,
           e.RoleID
    FROM Employees e
    WHERE e.EmployeeID = 1

    UNION ALL

    SELECT e.EmployeeID,
           e.Name,
           e.ManagerID,
           e.DepartmentID,
           e.RoleID
    FROM Employees e
    INNER JOIN hierarchy h ON e.ManagerID = h.EmployeeID
)
SELECT h.EmployeeID,
       h.Name AS EmployeeName,
       h.ManagerID,
       d.DepartmentName,
       r.RoleName,
       GROUP_CONCAT(DISTINCT p.ProjectName ORDER BY p.ProjectName SEPARATOR ', ') AS ProjectNames,
       GROUP_CONCAT(DISTINCT t.TaskName ORDER BY t.TaskID DESC SEPARATOR ', ') AS TaskNames
FROM hierarchy h
INNER JOIN Departments d ON h.DepartmentID = d.DepartmentID
INNER JOIN Roles r ON h.RoleID = r.RoleID
LEFT JOIN Projects p ON p.DepartmentID = h.DepartmentID
LEFT JOIN Tasks t ON t.AssignedTo = h.EmployeeID
GROUP BY h.EmployeeID,
         h.Name,
         h.ManagerID,
         d.DepartmentName,
         r.RoleName
ORDER BY h.Name;
