DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Departments;
CREATE TABLE Departments (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50)
);
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(50),
    DeptID INT,
    Salary INT,
    FOREIGN KEY (DeptID) REFERENCES Departments(DeptID)
);
INSERT INTO Departments VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Finance');

INSERT INTO Employees VALUES
(101, 'Alice', 1, 50000),
(102, 'Bob', 2, 70000),
(103, 'Charlie', 2, 80000),
(104, 'Diana', 3, 60000),
(105, 'Eve', 3, 75000);

-- Step 4: Scalar Subquery - Get employees earning more than average salary
SELECT Name, Salary
FROM Employees
WHERE Salary > (SELECT AVG(Salary) FROM Employees);

-- Step 5: IN Subquery - Get employees in IT or Finance departments
SELECT Name
FROM Employees
WHERE DeptID IN (SELECT DeptID FROM Departments WHERE DeptName IN ('IT', 'Finance'));

-- Step 6: EXISTS Subquery - List departments with at least one employee earning > 70000
SELECT DeptName
FROM Departments d
WHERE EXISTS (
    SELECT 1 FROM Employees e
    WHERE e.DeptID = d.DeptID AND e.Salary > 70000
);

-- Step 7: Correlated Subquery - Get highest paid employee in each department
SELECT Name, DeptID, Salary
FROM Employees e1
WHERE Salary = (
    SELECT MAX(Salary) FROM Employees e2
    WHERE e2.DeptID = e1.DeptID
);

-- Step 8: FROM Subquery (Derived Table) - Average salary per department
SELECT DeptName, AvgSalary
FROM (
    SELECT DeptID, AVG(Salary) AS AvgSalary
    FROM Employees
    GROUP BY DeptID
) AS DeptAvg
JOIN Departments d ON DeptAvg.DeptID = d.DeptID;
