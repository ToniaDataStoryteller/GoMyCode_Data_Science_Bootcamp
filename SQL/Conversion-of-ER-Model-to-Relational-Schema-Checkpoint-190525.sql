CREATE DATABASE RedRush_Unlimited;

--RELATIONAL SCHEMA CHECKPOINT

-- 1. Create DEPARTMENTS
CREATE TABLE Departments (
    Num_S INT PRIMARY KEY,
    Department_Name VARCHAR(50) NOT NULL,
    Manager_Name VARCHAR(50)
);

INSERT INTO DEPARTMENTS (NUM_S, Department_Name, Manager_Name)

VALUES(601, 'Sales', 'Ethan Adeyemo'),
	  (602, 'HR', 'Harry Dale'),
	  (603, 'Operations', 'Susan Eze_Brown'),
	  (604, 'Customer_Support', 'Iremide Clarkson'),
	  (605, 'Protocol', 'Kelvin Ojomo'),
	  (606, 'Admin', 'Bryan Ntekpo');

SELECT * FROM DEPARTMENTS;

-- 2. Create EMPLOYEES table 
CREATE TABLE Employees (
    Num_E INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Position VARCHAR(100),
    Salary DECIMAL(10, 2),
    Num_S INT,  -- Foreign key to Departments
    FOREIGN KEY (Num_S) REFERENCES Departments(Num_S)
);

INSERT INTO EMPLOYEES (NUM_E, Name, Position, Salary, Num_S)

VALUES (121, 'John Deo', 'HR Assistant', 125000, 602),
       (122, 'Mary Slessor', 'Solutions Architect', 250000, 601),
       (123, 'Mungo Parker', 'Account Manager', 220000, 601),
	   (124, 'Kerry Haggermann', 'Protocol Officer', 180000, 605),
	   (125, 'Albert Einstein', 'Sales Engineer', 500000, 601),
	   (126, 'Thomas Edison', 'Customer Care Executive', 150000, 604),
	   (127, 'Elon Muskton', 'Internal Auditor', 170000, 603),
	   (128, 'Jackson Manners', 'Project Manager', 350000, 603),
	   (129, 'Jill Krammer', 'Admin Clerk', 80000, 606),
	   (130, 'Bob Morrison', 'Janitor', 300000, 606),
	   (131, 'Jack Spade', 'Account Manager', 220000, 601),
	   (132, 'Norman Patterson', 'Network Engineer', 160000, 603),
	   (133, 'Zainab Nngoyo', 'Account Manager', 220000, 601),
	   (134, 'Harish Walter', 'Project Officer', 180000, 603),
	   (135, 'Shrane Biggalon', 'Marketing Officer', 120000, 601),
	   (136, 'Malvis Malcom', 'Customer Care Executive', 150000, 604),
	   (137, 'Zoey Preston', 'Data Scientist', 700000, 603),
	   (138, 'Stephane Wellington', 'Project Manager', 350000, 603),
	   (139, 'Tanya Davidson', 'Admin Clerk', 80000, 606),
	   (140, 'Ethan Lennard', 'Software Developer', 820000, 603),
	   (141, 'Eka Azesta', 'UI/UX Designer', 680000, 603),
	   (142, 'Morakinyo Bello', 'Cloud Engineer', 990000, 603),
	   (143, 'Chikoma Heydenson', 'Account Manager', 235000, 601);

SELECT * FROM EMPLOYEES;

-- 3. Create PROJECTS table
CREATE TABLE Projects (
    Num_P INT PRIMARY KEY,
    Project_Title VARCHAR(100) NOT NULL,
    Start_Date DATE,
    End_Date DATE
);

INSERT INTO PROJECTS (NUM_P, Project_Title, Start_Date, End_Date)

VALUES(301, 'HR Policy Digitization', '2025-01-15', '2025-04-15'),
	  (302, 'Sales Automation System', '2025-02-01', '2025-05-30'),
	  (303, 'Customer Feedback App', '2025-01-20', '2025-06-20'),
	  (304, 'Network Infrastructure Upgrade', '2025-03-01', '2025-07-01'),
	  (305, 'Internal Audit Review', '2025-02-15', '2025-03-15'),
	  (306, 'New Protocol Handbook', '2025-01-10', '2025-02-28'),
	  (307, 'Data Analytics Dashboard', '2025-04-01', '2025-08-01'),
	  (308, 'Website Redesign', '2025-01-25', '2025-04-25');

SELECT * FROM PROJECTS

-- 4. Create EMPLOYEE_PROJECTS table
CREATE TABLE Employee_Projects (
    Num_E INT,
    Num_P INT,
    Role VARCHAR(50),
    PRIMARY KEY (Num_E, Num_P),  -- Composite Primary Key
    FOREIGN KEY (Num_E) REFERENCES Employees(Num_E),
    FOREIGN KEY (Num_P) REFERENCES Projects(Num_P)
);

INSERT INTO Employee_Projects (NUM_E, NUM_P, Role)

VALUES(121, 301, 'HR Assistant'),                 -- HR Policy Digitization
	  (122, 302, 'Solutions Architect'),          -- Sales Automation System
	  (123, 302, 'Account Manager'),              -- Sales Automation System
	  (124, 306, 'Protocol Officer'),             -- New Protocol Handbook
	  (125, 302, 'Sales Engineer'),               -- Sales Automation System
	  (126, 303, 'Customer Care Executive'),      -- Customer Feedback App
	  (127, 305, 'Internal Auditor'),             -- Internal Audit Review
	  (128, 307, 'Project Manager'),              -- Data Analytics Dashboard
	  (129, 301, 'Admin Clerk'),                  -- HR Policy Digitization
	  (130, 304, 'Janitor'),                      -- Network Infra Upgrade (support)
	  (131, 302, 'Account Manager'),              -- Sales Automation System
	  (132, 304, 'Network Engineer'),             -- Network Infra Upgrade
	  (133, 303, 'Account Manager'),              -- Customer Feedback App
	  (134, 308, 'Project Officer'),              -- Website Redesign
	  (135, 302, 'Marketing Officer'),            -- Sales Automation System
	  (136, 303, 'Customer Care Executive'),      -- Customer Feedback App
	  (137, 307, 'Data Scientist'),               -- Data Analytics Dashboard
	  (138, 307, 'Project Manager'),              -- Data Analytics Dashboard
	  (139, 301, 'Admin Clerk'),                  -- HR Policy Digitization
	  (140, 308, 'Software Developer'),           -- Website Redesign
	  (141, 308, 'UI/UX Designer'),               -- Website Redesign
	  (142, 304, 'Cloud Engineer'),               -- Network Infra Upgrade
	  (143, 303, 'Account Manager');              -- Customer Feedback App

SELECT * FROM EMPLOYEE_PROJECTS