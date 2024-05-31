--Row type:How to use row type to fetch a task record?
set serveroutput on
DECLARE
  v_task tasks%ROWTYPE;
BEGIN
  SELECT * INTO v_task FROM tasks WHERE id = 1;
  DBMS_OUTPUT.PUT_LINE('Task Title: ' || v_task.title);
END;
/

--Cursor and Row Count:How to count rows using a cursor in PL/SQL?
set serveroutput on
DECLARE
  CURSOR c_tasks IS SELECT id FROM tasks;
  v_count NUMBER := 0;
BEGIN
  FOR v_task IN c_tasks LOOP
    v_count := v_count + 1;
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('Total Tasks: ' || TO_CHAR(v_count));
END;
/

--How to automatically update the last login time when a user logs in?
set serveroutput on
CREATE OR REPLACE TRIGGER trg_update_last_login
BEFORE UPDATE OF last_login ON users
FOR EACH ROW
BEGIN
  :NEW.last_login := SYSDATE;
END;
/
--Calculate Total Hours for a User's Tasks
CREATE OR REPLACE FUNCTION calculate_total_hours(user_id_param IN users.id%TYPE) RETURN NUMBER IS
  total_hours NUMBER := 0;
BEGIN
  SELECT SUM(hours) INTO total_hours
  FROM tasks
  WHERE user_id = user_id_param;
  
  RETURN total_hours;
END;
/

DECLARE
  v_user_id users.id%TYPE := 1;
  v_total_hours NUMBER;
BEGIN
  v_total_hours := calculate_total_hours(v_user_id); -- Call the function
  
  -- Display the result
  DBMS_OUTPUT.PUT_LINE('Total hours for User ID ' || v_user_id || ': ' || v_total_hours);
END;
/

--fetching task id and status
set serveroutput on
DECLARE
  TYPE t_task_info IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
 
  v_task_ids t_task_info;
  
  v_task_status t_task_info;
  
  v_counter BINARY_INTEGER := 1;
BEGIN
  
  FOR r IN (SELECT id, status FROM tasks WHERE status <> 0) LOOP
    
    v_task_ids(v_counter) := r.id;
    v_task_status(v_counter) := r.status;
    v_counter := v_counter + 1;
  END LOOP;

  FOR i IN 1..v_task_ids.COUNT LOOP
    DBMS_OUTPUT.PUT_LINE('Task ID: ' || v_task_ids(i) || ', Status: ' || v_task_status(i));
  END LOOP;
END;
/



