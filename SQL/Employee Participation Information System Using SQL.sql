CREATE DATABASE Innov8_Unlimited_corrected

-- CREATE TABLES

-- Department Table
CREATE TABLE Department (
    Num_S INT PRIMARY KEY,
    Label VARCHAR(50) NOT NULL,
    Manager_Name VARCHAR(100)
);

-- Employee Table
CREATE TABLE Employee (
    Num_E INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Position VARCHAR(100),
    Salary DECIMAL(10, 2),
    Department_Num_S INT,
    FOREIGN KEY (Department_Num_S) REFERENCES Department(Num_S)
);

-- Project Table
CREATE TABLE Project (
    Num_P INT PRIMARY KEY,
    Title VARCHAR(100) NOT NULL,
    Start_Date DATE,
    End_Date DATE,
    Department_Num_S INT,
    FOREIGN KEY (Department_Num_S) REFERENCES Department(Num_S)
);

-- Employee_Project Table
CREATE TABLE Employee_Project (
    Employee_Num_E INT,
    Project_Num_P INT,
    Role VARCHAR(100),
    PRIMARY KEY (Employee_Num_E, Project_Num_P),
    FOREIGN KEY (Employee_Num_E) REFERENCES Employee(Num_E) ON DELETE CASCADE,
    FOREIGN KEY (Project_Num_P) REFERENCES Project(Num_P) ON DELETE CASCADE
);

-- INSERT RECORDS

-- Insert Departments
INSERT INTO Department (Num_S, Label, Manager_Name)
VALUES
(1, 'IT', 'Alice Johnson'),
(2, 'HR', 'Bob Smith'),
(3, 'Marketing', 'Clara Bennett');

-- Insert Employees
INSERT INTO Employee (Num_E, Name, Position, Salary, Department_Num_S)
VALUES
(101, 'John Doe', 'Developer', 60000.00, 1),
(102, 'Jane Smith', 'Analyst', 55000.00, 2),
(103, 'Mike Brown', 'Designer', 50000.00, 3),
(104, 'Sarah Johnson', 'Data Scientist', 70000.00, 1),
(105, 'Emma Wilson', 'HR Specialist', 52000.00, 2);

-- Insert Projects
INSERT INTO Project (Num_P, Title, Start_Date, End_Date, Department_Num_S)
VALUES
(201, 'Website Redesign', '2024-01-15', '2024-06-30', 1),
(202, 'Employee Onboarding', '2024-03-01', '2024-09-01', 2),
(203, 'Market Research', '2024-02-01', '2024-07-31', 3),
(204, 'IT Infrastructure Setup', '2024-04-01', '2024-12-31', 1);

-- Insert Employee_Project Roles
INSERT INTO Employee_Project (Employee_Num_E, Project_Num_P, Role)
VALUES
(101, 201, 'Frontend Developer'),
(104, 201, 'Backend Developer'),
(102, 202, 'Trainer'),
(105, 202, 'Coordinator'),
(103, 203, 'Research Lead'),
(101, 204, 'Network Specialist');

-- UPDATE RECORD

-- Change the role of employee 101 in project 201
UPDATE Employee_Project
SET Role = 'Full Stack Developer'
WHERE Employee_Num_E = 101 AND Project_Num_P = 201;

-- DELETE RECORDS

-- Delete project assignment(s) for employee 103
DELETE FROM Employee_Project
WHERE Employee_Num_E = 103;

-- Then delete employee 103 from Employee table
DELETE FROM Employee
WHERE Num_E = 103;

SELECT * FROM Department
SELECT * FROM Employee
SELECT * FROM Employee_Project
SELECT * FROM Project

-- Employees assigned to more than one project with total project count
SELECT 
    E.Name,
    COUNT(EP.Project_Num_P) AS Total_Projects
FROM Employee E
JOIN Employee_Project EP ON E.Num_E = EP.Employee_Num_E
GROUP BY E.Name
HAVING COUNT(EP.Project_Num_P) > 1;

-- List of projects managed by each department, including department label and manager name
SELECT 
    D.Label AS Department_Label,
    D.Manager_Name,
    P.Title AS Project_Title
FROM Department D
JOIN Project P ON D.Num_S = P.Department_Num_S
ORDER BY D.Label, P.Title;

-- Names of employees working on the project "Website Redesign" with their roles
SELECT 
    E.Name,
    EP.Role
FROM Employee E
JOIN Employee_Project EP ON E.Num_E = EP.Employee_Num_E
JOIN Project P ON EP.Project_Num_P = P.Num_P
WHERE P.Title = 'Website Redesign';

-- Department with the highest number of employees (including label, manager name, and total employees)
SELECT TOP 1
    D.Label AS Department_Label,
    D.Manager_Name,
    COUNT(E.Num_E) AS Total_Employees
FROM Department D
JOIN Employee E ON D.Num_S = E.Department_Num_S
GROUP BY D.Label, D.Manager_Name
ORDER BY Total_Employees DESC;

-- Names and positions of employees earning salary > 60,000, including their department names
SELECT 
    E.Name,
    E.Position,
    D.Label AS Department_Label
FROM Employee E
JOIN Department D ON E.Department_Num_S = D.Num_S
WHERE E.Salary > 60000;

-- Number of employees assigned to each project, including project title
SELECT 
    P.Title,
    COUNT(EP.Employee_Num_E) AS Number_of_Employees
FROM Project P
LEFT JOIN Employee_Project EP ON P.Num_P = EP.Project_Num_P
GROUP BY P.Title;

-- Summary of roles employees have across different projects (employee name, project title, role)
SELECT 
    E.Name AS Employee_Name,
    P.Title AS Project_Title,
    EP.Role
FROM Employee_Project EP
JOIN Employee E ON EP.Employee_Num_E = E.Num_E
JOIN Project P ON EP.Project_Num_P = P.Num_P
ORDER BY E.Name, P.Title;

-- Total salary expenditure for each department, including department label and manager name
SELECT 
    D.Label AS Department_Label,
    D.Manager_Name,
    SUM(E.Salary) AS Total_Salary_Expenditure
FROM Department D
JOIN Employee E ON D.Num_S = E.Department_Num_S
GROUP BY D.Label, D.Manager_Name
ORDER BY Total_Salary_Expenditure DESC;
