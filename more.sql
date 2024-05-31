--List Task IDs Having atleast a Tag
SELECT task_id FROM task_tags GROUP BY task_id HAVING COUNT(tag_id) > 0;

--Tasks With Either High or Low Priority
SELECT task_id FROM task_tags WHERE tag_id IN (SELECT id FROM tags WHERE title = 'High Priority' OR title = 'Low Priority');

-- Count Tasks by Status Using WITH Clause
WITH TaskStatus AS (
  SELECT status, COUNT(*) AS total_tasks
  FROM tasks
  GROUP BY status
)

--Retrieve User Details Where Last Login is Newest Using Nested Subquery
SELECT username, email
FROM users
WHERE last_login = (
  SELECT MAX(last_login)
  FROM users
);

-- Find Tasks with No Comments Using EXISTS
SELECT id, title
FROM tasks t
WHERE NOT EXISTS (
  SELECT 1
  FROM comments c
  WHERE c.task_id = t.id
);

--update login data
UPDATE users
SET last_login = SYSDATE
WHERE id = 3;



