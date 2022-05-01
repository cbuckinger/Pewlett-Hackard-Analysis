
-------------------------DELIVERABLE 1

--  create a Retirement Titles table 
--   titles of employees 
--    born between January 1, 1952 and December 31, 1955. 
--    multiple titles in the database use the DISTINCT ON 
--- use the COUNT() function number of retirement-age 
---employees by most recent job title. 
---exclude those employees who have left .
----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

---Retrieve the emp_no, first_name, and last_name 
---columns from the Employees table.
---Retrieve the title, from_date, and to_date columns from the Titles table.
---Create a new table using the INTO clause.

-- Filter the data on the birth_date column to retrieve the employees who
--- were born between 1952 and 1955. Then, order by the employee number.

SELECT emp_no, first_name, last_name
INTO new_emp_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31');
SELECT * FROM new_emp_info;

SELECT emp_no, title, from_date, to_date
INTO new_title_info
FROM titles;
SELECT * FROM new_title_info;

--- Join both tables on the primary key.

SELECT new_emp_info.emp_no,
    new_emp_info.first_name,
    new_emp_info.last_name,
    new_title_info.title,
    new_title_info.from_date,
    new_title_info.to_date
INTO retirement_titles
FROM new_emp_info
LEFT JOIN new_title_info
ON new_emp_info.emp_no = new_title_info.emp_no;

--- Export the Retirement Titles table from the previous step as retirement_titles.csv and 
---save it to your Data folder in the Pewlett-Hackard-Analysis folder.

------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------

---Retrieve the employee number, first and last name, and title columns 
---    from the Retirement Titles table.
-- Exclude those employees that have already left the company by filtering on to_date to 
---   keep only those dates that are equal to '9999-01-01'
--- Use the DISTINCT ON statement to retrieve the first occurrence of the employee number 
--     for each set of rows defined by the ON () clause.
-- Create a Unique Titles table using the INTO clause.
-- Sort the Unique Titles table in ascending order by the employee number 
---  and descending order by the last date (i.e., to_date) of the most recent title.

-- Use Distinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
WHERE to_date = ('9999-01-01')
ORDER BY emp_no, to_date DESC;

-- Export the Unique Titles table as unique_titles.csv and save it to your Data folder in the Pewlett-Hackard-Analysis folder.

--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------

-- Write another query in the Employee_Database_challenge.sql file to retrieve the number of employees by their most recent job title who are about to retire.
-- First, retrieve the number of titles from the Unique Titles table.
-- Then, create a Retiring Titles table to hold the required information.
-- Group the table by title, then sort the count column in descending order.

SELECT COUNT(title),title 
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;

-- Export the Retiring Titles table as retiring_titles.csv and save it to your Data folder in the Pewlett-Hackard-Analysis folder.

---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------


---------------------------------------------------DELIVERABLE 2

---create a mentorship-eligibility table that holds the current employees who were born between January 1, 1965 and December 31, 1965.
-- Retrieve the emp_no, first_name, last_name, and birth_date columns from the Employees table.
-- Retrieve the from_date and to_date columns from the Department Employee table.
-- Retrieve the title column from the Titles table.
-- Use a DISTINCT ON statement to retrieve the first occurrence of the employee number for each set of rows defined by the ON () clause.
-- Create a new table using the INTO clause.
-- Join the Employees and the Department Employee tables on the primary key.
-- Join the Employees and the Titles tables on the primary key.
-- Filter the data on the to_date column to all the current employees, then filter the data on the birth_date columns to get all the employees
---    whose birth dates are between January 1, 1965 and December 31, 1965.
-- Order the table by the employee number.
-- Export the Mentorship Eligibility table as mentorship_eligibilty.csv and save it to your Data folder in the Pewlett-Hackard-Analysis folder.

--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
---Join the Employees and the Department Employee tables on the primary key.

-- SELECT employees.emp_no,
--     employees.first_name,
--     employees.last_name,
--     employees.gender,
--     salary.salary,
--     dept_employees.to_date
-- INTO emp_info
-- FROM employees
-- INNER JOIN salaries
-- ON (employees.emp_no = salaries.emp_no)
-- INNER JOIN dept_emp 
-- ON (employees.emp_no = dept_employeese.emp_no)
-- WHERE (employees.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
--      AND (employees.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
--      AND (dept_employees.to_datASDF 

SELECT DISTINCT ON (titles.emp_no, dept_employees.emp_no) employees.emp_no, 
employees.first_name, 
employees.last_name,
dept_employees.from_date,
dept_employees.to_date,
titles.title
INTO mentorship_eligibility
FROM employees
INNER JOIN dept_employees
ON (employees.emp_no= dept_employees.emp_no)
INNER JOIN titles
ON (employees.emp_no=titles.emp_no)
WHERE (employees.birth_date BETWEEN '1965-01-01' AND '1965-12-31') 
AND  (dept_employees.to_date = '9999-01-01');

