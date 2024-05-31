CREATE TABLE users (
  id NUMBER(12) NOT NULL,
  role_id NUMBER(4) NOT NULL,
  first_name VARCHAR2(50),
  middle_name VARCHAR2(50),
  last_name VARCHAR2(50),
  username VARCHAR2(50),
  mobile VARCHAR2(15),
  email VARCHAR2(50),
  password_hash VARCHAR2(32) NOT NULL,
  registered_at DATE NOT NULL,
  last_login DATE,
  intro VARCHAR2(4000),
  profile CLOB,
  CONSTRAINT pk_user PRIMARY KEY (id),
  CONSTRAINT uq_username UNIQUE (username),
  CONSTRAINT uq_mobile UNIQUE (mobile),
  CONSTRAINT uq_email UNIQUE (email)
);

CREATE TABLE tasks (
  id NUMBER(12) NOT NULL,
  user_id NUMBER(12) NOT NULL,
  created_by NUMBER(12) NOT NULL,
  updated_by NUMBER(12) NOT NULL,
  title VARCHAR2(512) NOT NULL,
  description VARCHAR2(2048),
  status NUMBER(4) DEFAULT 0 NOT NULL,
  hours NUMBER DEFAULT 0,
  created_at DATE NOT NULL,
  updated_at DATE,
  planned_start_date DATE,
  planned_end_date DATE,
  actual_start_date DATE,
  actual_end_date DATE,
  content CLOB,
  CONSTRAINT pk_task PRIMARY KEY (id),
  CONSTRAINT fk_task_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  CONSTRAINT fk_task_creator FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE CASCADE,
  CONSTRAINT fk_task_updater FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE tags (
  id NUMBER(12) NOT NULL,
  title VARCHAR2(75) NOT NULL,
  slug VARCHAR2(100) NOT NULL,
  CONSTRAINT pk_tag PRIMARY KEY (id)
);

CREATE TABLE task_tags (
  task_id NUMBER(12) NOT NULL,
  tag_id NUMBER(12) NOT NULL,
  CONSTRAINT pk_task_tag PRIMARY KEY (task_id, tag_id),
  CONSTRAINT fk_task_tag_task FOREIGN KEY (task_id) REFERENCES tasks(id) ON DELETE CASCADE,
  CONSTRAINT fk_task_tag_tag FOREIGN KEY (tag_id) REFERENCES tags(id)
);

CREATE TABLE activities (
  id NUMBER(12) NOT NULL,
  user_id NUMBER(12) NOT NULL,
  task_id NUMBER(12) NOT NULL,
  created_by NUMBER(12) NOT NULL,
  updated_by NUMBER(12) NOT NULL,
  title VARCHAR2(512) NOT NULL,
  description VARCHAR2(2048),
  status NUMBER(4) DEFAULT 0 NOT NULL,
  hours NUMBER DEFAULT 0,
  created_at DATE NOT NULL,
  updated_at DATE,
  planned_start_date DATE,
  planned_end_date DATE,
  actual_start_date DATE,
  actual_end_date DATE,
  content CLOB,
  CONSTRAINT pk_activity PRIMARY KEY (id),
  CONSTRAINT fk_activity_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  CONSTRAINT fk_activity_task FOREIGN KEY (task_id) REFERENCES tasks(id) ON DELETE CASCADE,
  CONSTRAINT fk_activity_creator FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE CASCADE,
  CONSTRAINT fk_activity_updater FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE comments (
  id NUMBER(12) NOT NULL,
  task_id NUMBER(12) NOT NULL,
  activity_id NUMBER(12),
  title VARCHAR2(100) NOT NULL,
  created_at DATE NOT NULL,
  updated_at DATE,
  content CLOB,
  CONSTRAINT pk_comment PRIMARY KEY (id),
  CONSTRAINT fk_comment_task FOREIGN KEY (task_id) REFERENCES tasks(id) ON DELETE CASCADE,
  CONSTRAINT fk_comment_activity FOREIGN KEY (activity_id) REFERENCES activities(id) ON DELETE CASCADE
);

INSERT INTO users (id, role_id, first_name, middle_name, last_name, username, mobile, email, password_hash, registered_at, last_login, intro, profile)
VALUES (1, 1, 'John', 'A.', 'Doe', 'johndoe', '1234567890', 'johndoe@example.com', '5f4dcc3b5aa765d61d8327deb882cf99', SYSDATE, SYSDATE, 'A brief intro', 'Profile details here');

INSERT INTO tasks (id, user_id, created_by, updated_by, title, description, status, hours, created_at, updated_at, planned_start_date, planned_end_date, actual_start_date, actual_end_date, content)
VALUES (1, 1, 1, 1, 'Initial Task', 'This is the description of the initial task.', 0, 2.5, SYSDATE, SYSDATE, SYSDATE, SYSDATE + 7, SYSDATE, SYSDATE + 5, 'Detailed content of the task here');

INSERT INTO tags (id, title, slug)
VALUES (1, 'Urgent', 'urgent');

INSERT INTO task_tags (task_id, tag_id)
VALUES (1, 1);

INSERT INTO activities (id, user_id, task_id, created_by, updated_by, title, description, status, hours, created_at, updated_at, planned_start_date, planned_end_date, actual_start_date, actual_end_date, content)
VALUES (1, 1, 1, 1, 1, 'Review Task', 'Review the initial task details.', 1, 1.0, SYSDATE, SYSDATE, SYSDATE, SYSDATE + 1, SYSDATE, SYSDATE + 1, 'Review completed successfully');

INSERT INTO comments (id, task_id, activity_id, title, created_at, updated_at, content)
VALUES (1, 1, 1, 'Initial Comment', SYSDATE, SYSDATE, 'This is a comment on the initial task and activity.');





INSERT INTO users (id, role_id, first_name, middle_name, last_name, username, mobile, email, password_hash, registered_at, last_login, intro, profile)
VALUES (2, 2, 'Jane', 'B.', 'Smith', 'janesmith', '1234567891', 'janesmith@example.com', 'd41d8cd98f00b204e9800998ecf8427e', SYSDATE, SYSDATE, 'Another brief intro', 'Another profile details here');

INSERT INTO users (id, role_id, first_name, middle_name, last_name, username, mobile, email, password_hash, registered_at, last_login, intro, profile)
VALUES (3, 3, 'Alice', 'C.', 'Johnson', 'alicejohnson', '1234567892', 'alicejohnson@example.com', 'aabbccddeeff00112233445566778899', SYSDATE, SYSDATE, 'Intro for Alice', 'Profile details for Alice');

INSERT INTO tasks (id, user_id, created_by, updated_by, title, description, status, hours, created_at, updated_at, planned_start_date, planned_end_date, actual_start_date, actual_end_date, content)
VALUES (2, 2, 2, 2, 'Follow-up Task', 'Description of the follow-up task.', 1, 3.0, SYSDATE, SYSDATE, SYSDATE + 1, SYSDATE + 10, SYSDATE + 2, SYSDATE + 9, 'Content of the follow-up task here');

INSERT INTO tasks (id, user_id, created_by, updated_by, title, description, status, hours, created_at, updated_at, planned_start_date, planned_end_date, actual_start_date, actual_end_date, content)
VALUES (3, 3, 3, 3, 'Finalize Project', 'Final steps to complete the project.', 2, 5.0, SYSDATE, SYSDATE, SYSDATE + 3, SYSDATE + 20, SYSDATE + 4, SYSDATE + 15, 'Content of the final project');

INSERT INTO tags (id, title, slug)
VALUES (2, 'High Priority', 'high_priority');

INSERT INTO tags (id, title, slug)
VALUES (3, 'Low Priority', 'low_priority');

INSERT INTO task_tags (task_id, tag_id)
VALUES (2, 2);

INSERT INTO task_tags (task_id, tag_id)
VALUES (3, 3);

INSERT INTO activities (id, user_id, task_id, created_by, updated_by, title, description, status, hours, created_at, updated_at, planned_start_date, planned_end_date, actual_start_date, actual_end_date, content)
VALUES (2, 2, 2, 2, 2, 'Document Task', 'Document all details of the task.', 1, 2.0, SYSDATE, SYSDATE, SYSDATE, SYSDATE + 1, SYSDATE, SYSDATE + 1, 'Documentation complete');

INSERT INTO activities (id, user_id, task_id, created_by, updated_by, title, description, status, hours, created_at, updated_at, planned_start_date, planned_end_date, actual_start_date, actual_end_date, content)
VALUES (3, 3, 3, 3, 3, 'Close Project', 'Actions to formally close the project.', 2, 4.0, SYSDATE, SYSDATE, SYSDATE, SYSDATE + 5, SYSDATE, SYSDATE + 4, 'Closure actions documented');

INSERT INTO comments (id, task_id, activity_id, title, created_at, updated_at, content)
VALUES (2, 2, 2, 'Comment on Task 2', SYSDATE, SYSDATE, 'Details about follow-up tasks discussed.');

INSERT INTO comments (id, task_id, activity_id, title, created_at, updated_at, content)
VALUES (3, 3, 3, 'Comment on Task 3', SYSDATE, SYSDATE, 'Final project wrap-up notes.');



CREATE TABLE new_users (
  user_id NUMBER(12) NOT NULL,
  role_id NUMBER(4) NOT NULL,
  first_name VARCHAR2(50),
  middle_name VARCHAR2(50),
  last_name VARCHAR2(50),
  username VARCHAR2(50),
  phone_number VARCHAR2(15),
  email_address VARCHAR2(50),
  password_hash VARCHAR2(32) NOT NULL,
  registration_date DATE NOT NULL,
  last_login_date DATE,
  introduction VARCHAR2(4000),
  user_profile CLOB,
  CONSTRAINT pk_new_user PRIMARY KEY (user_id),
  CONSTRAINT uq_new_username UNIQUE (username),
  CONSTRAINT uq_new_phone UNIQUE (phone_number),
  CONSTRAINT uq_new_email UNIQUE (email_address)
);

DROP TABLE new_users;

ALTER TABLE new_users RENAME COLUMN phone_number TO mobile;

ALTER TABLE new_users DROP COLUMN middle_name;

DROP TABLE users;