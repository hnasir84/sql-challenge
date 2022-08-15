# sql-challenge

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






-- Data Analysis


-- 1. List the following details of each employee: employee number, last name, first name, sex, and salary.



SELECT employees.employee_no, last_name, first_name, sex, salary 
From employees
JOIN salaries on employees.employee_no = salaries.employee_no;


-- 2. List first name, last name, and hire date for employees who were hired in 1986.

SELECT first_name, last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 1986;

-- 3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.


SELECT departments.department_no, department_name, department_managers.employee_no, employees.last_name, employees.first_name
From departments
JOIN department_managers ON departments.department_no = department_managers.department_no
JOIN employees ON employees.employee_no = department_managers.employee_no;


-- 4. List the department of each employee with the following information: employee number, last name, first name, and department name.

SELECT employees.employee_no, last_name, first_name, departments.department_name
FROM employees
JOIN department_employees ON department_employees.employee_no = employees.employee_no
JOIN departments ON departments.department_no = department_employees.department_no;


-- 5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."

SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';


-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.

SELECT employees.employee_no, last_name, first_name, department_name
FROM employees
JOIN department_employees ON department_employees.employee_no = employees.employee_no
JOIN departments ON departments.department_no = department_employees.department_no
WHERE department_name = 'Sales';


-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT employees.employee_no, last_name, first_name, department_name
FROM employees
JOIN department_employees ON department_employees.employee_no = employees.employee_no
JOIN departments ON departments.department_no = department_employees.department_no
WHERE department_name = 'Sales' OR department_name = 'Development';


-- 8. List the frequency count of employee last names (i.e., how many employees share each last name) in descending order.

SELECT last_name, COUNT(last_name) AS "Last Name Count"
FROM employees
GROUP BY last_name
ORDER BY "Last Name Count" DESC;




SQL CHALLENGE BOUNS

# use jupeternote book

# Dependencies

import pandas as pd

from sqlalchemy import create_engine

import psycopg2

import matplotlib.pyplot as plt

# create engine to access the database in postgresql
engine = create_engine("postgresql://postgres:xoxoxo@localhost/SQL challenge")


# Establish connection between database and pandas
conn = engine.connect()

# create panda dataframe by accessing salaries table in SQL database and perform a query
salariesDF = pd.read_sql("SELECT * FROM salaries", conn)
salariesDF.head()

# confirm salariesDF data type
salariesDF.dtypes

# plot histogram to visualize the salariesDF
salariesDF.plot.hist()
plt.show()
plt.savefig('histogram to visualize the most common salary ranges for employees.png')

# Create a bar chart of average salary by title
# Created a new table in posgresql called salaries_title

# in postresql create a new table by running the below command
#############################################
CREATE TABLE salaries_title AS(
SELECT title.title, salary
FROM salaries
JOIN employees ON employees.employee_no = salaries.employee_no
JOIN title ON title.titleid = employees.employee_title_id);
####################################################

# go back to jupyter notebook
salaries_title_df = pd.read_sql("SELECT * FROM salaries_title", conn)
salaries_title_df.head()

# group the dataframe by average salary
salaries_title_df_grouped = salaries_title_df.groupby("title").mean()["salary"]
salaries_title_df_grouped

# plot a bar chart

salaries_title_df_grouped.plot.bar()
plt.xticks(rotation=45)
plt.xlabel("Title")
plt.ylabel("Average Salary")
plt.show()
plt.savefig('bar chart of average salary by title.png')



The end_Hassan