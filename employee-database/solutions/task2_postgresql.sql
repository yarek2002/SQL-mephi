-- Задача 2 (PostgreSQL)
-- Как задача 1 + TotalTasks и TotalSubordinates (только прямые подчинённые).

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
       STRING_AGG(DISTINCT p.ProjectName, ', ' ORDER BY p.ProjectName)
           FILTER (WHERE p.ProjectName IS NOT NULL) AS ProjectNames,
       STRING_AGG(DISTINCT t.TaskName, ', ' ORDER BY t.TaskID DESC)
           FILTER (WHERE t.TaskName IS NOT NULL) AS TaskNames,
       COUNT(DISTINCT t.TaskID) AS TotalTasks,
       (SELECT COUNT(*)
        FROM Employees sub
        WHERE sub.ManagerID = h.EmployeeID) AS TotalSubordinates
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
