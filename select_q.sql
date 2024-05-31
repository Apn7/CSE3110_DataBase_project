SELECT id, username, role_id,last_login FROM users;

SELECT first_name, last_name, email, mobile FROM users WHERE username = 'johndoe';

SELECT id, title FROM tasks WHERE status = 0;

SELECT title, description FROM tasks WHERE id = 1;

SELECT id, title, planned_end_date FROM tasks WHERE planned_end_date < SYSDATE + 7;

SELECT tag_id FROM task_tags WHERE task_id = 1;

SELECT id, title FROM activities WHERE task_id = 1;

SELECT content FROM comments WHERE created_at > SYSDATE - 30;

SELECT status, hours FROM activities WHERE id = 1;

--List Tags and Their Usage Count
SELECT tag_id, COUNT(tag_id) AS usage_count FROM task_tags GROUP BY tag_id;

SELECT username, description from users join tasks where id = 1;

