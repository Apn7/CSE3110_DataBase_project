--Count the Total Number of Tasks
SELECT COUNT(*) FROM tasks;

--Find the Minimum Hours Spent on Any Task
SELECT MIN(hours) FROM tasks;

--Calculate the Average Hours Spent per Task
SELECT AVG(hours) FROM tasks;


--Determine the Maximum Hours Logged in a Single Task
SELECT MAX(hours) FROM tasks;

--Aggregate Total Hours of Tasks by User
SELECT user_id, SUM(hours) AS total_hours
FROM tasks
GROUP BY user_id
HAVING SUM(hours) >= 3;

