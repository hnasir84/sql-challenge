-- SCHEMAS

-- create table title and import the title csv file
CREATE TABLE title (
	titleID VARCHAR PRIMARY KEY,
	title VARCHAR
);

SELECT * FROM title;

-- create table employees and import data from employee csv file

CREATE TABLE employees(
	employee_no INT PRIMARY KEY,
	employee_title_id VARCHAR,
	birth_date DATE,
	first_name VARCHAR,
	last_name VARCHAR,
	sex VARCHAR,
	hire_date DATE,
	FOREIGN KEY (employee_title_id) REFERENCES title(titleID)
);

-- check the data is loaded correctly
SELECT * FROM employees;



-- create table departments and import the department csv file

CREATE TABLE departments(
	department_no VARCHAR PRIMARY KEY,
	department_name VARCHAR
	
);

-- check the data is loaded correctly
SELECT * FROM departments;


-- create table department_managers and import the department_managers csv file

CREATE TABLE department_managers (
	department_no VARCHAR,
	FOREIGN KEY(department_no) REFERENCES departments(department_no),
	employee_no INT,
	FOREIGN KEY (employee_no) REFERENCES employees(employee_no),
	PRIMARY KEY (department_no, employee_no)
	
);

-- check the data is loaded correctly
SELECT * FROM department_managers;


-- create table department_employees and import the department employee csv file

CREATE TABLE department_employees (
	employee_no INT,
	FOREIGN KEY (employee_no) REFERENCES employees(employee_no),
	department_no VARCHAR,
	FOREIGN KEY (department_no) REFERENCES departments(department_no),
	PRIMARY KEY (employee_no, department_no)
);

-- check the data is loaded correctly
SELECT * FROM department_employees;


-- create table salaries and import salaries csv file

CREATE TABLE salaries (
	employee_no INT PRIMARY KEY,
	salary INT,
	FOREIGN KEY (employee_no) REFERENCES employees(employee_no)
);

-- check the data is loaded correctly
SELECT * FROM salaries;

