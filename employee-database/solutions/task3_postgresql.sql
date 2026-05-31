-- Задача 3 (PostgreSQL)
-- Сотрудники с ролью «Менеджер» и хотя бы одним подчинённым (вся иерархия вниз).

WITH RECURSIVE descendants AS (
    SELECT m.EmployeeID AS manager_id,
           e.EmployeeID AS subordinate_id
    FROM Employees m
    INNER JOIN Roles rm ON m.RoleID = rm.RoleID
    INNER JOIN Employees e ON e.ManagerID = m.EmployeeID
    WHERE rm.RoleName = 'Менеджер'

    UNION ALL

    SELECT d.manager_id,
           e.EmployeeID
    FROM descendants d
    INNER JOIN Employees e ON e.ManagerID = d.subordinate_id
),
subordinate_counts AS (
    SELECT manager_id,
           COUNT(*) AS TotalSubordinates
    FROM descendants
    GROUP BY manager_id
    HAVING COUNT(*) > 0
)
SELECT e.EmployeeID,
       e.Name AS EmployeeName,
       e.ManagerID,
       d.DepartmentName,
       r.RoleName,
       STRING_AGG(DISTINCT p.ProjectName, ', ' ORDER BY p.ProjectName)
           FILTER (WHERE p.ProjectName IS NOT NULL) AS ProjectNames,
       STRING_AGG(DISTINCT t.TaskName, ', ' ORDER BY t.TaskID DESC)
           FILTER (WHERE t.TaskName IS NOT NULL) AS TaskNames,
       sc.TotalSubordinates
FROM Employees e
INNER JOIN subordinate_counts sc ON e.EmployeeID = sc.manager_id
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID
INNER JOIN Roles r ON e.RoleID = r.RoleID
LEFT JOIN Projects p ON p.DepartmentID = e.DepartmentID
LEFT JOIN Tasks t ON t.AssignedTo = e.EmployeeID
GROUP BY e.EmployeeID,
         e.Name,
         e.ManagerID,
         d.DepartmentName,
         r.RoleName,
         sc.TotalSubordinates
ORDER BY e.Name;
