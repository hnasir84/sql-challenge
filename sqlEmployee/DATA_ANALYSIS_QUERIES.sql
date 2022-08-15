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



