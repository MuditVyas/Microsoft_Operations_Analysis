CREATE DATABaSE op_cs2;
USE op_cs2;
CREATE TABLE users(user_id int,	created_at varchar(50),	company_id int,	language varchar(20),	activated_at varchar(50),	state varchar(20));
SELECT * FROM users;
CREATE TABLE email_events(user_id int,	occurred_at varchar(100),	action varchar(50),	user_type int );
CREATE TABLE events(user_id int,	occurred_at varchar(70),	event_type varchar(50),	event_name varchar(50),	location varchar(50),	device varchar(30),	user_type int);

SHOW variables LIKE 'secure_file_priv';

#Table- users
LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/users.csv "
INTO TABLE users
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY  '\n'
IGNORE 1 ROWS;

SELECT * FROM users;

ALTER TABLE users ADD COLUMN temp_cret DATETIME;
UPDATE users SET temp_cret =STR_TO_DATE(created_at,'%d-%m-%Y %H:%i');
ALTER TABLE users DROP COLUMN created_at;
ALTER TABLE users CHANGE COLUMN temp_cret created_at DATETIME;
SELECT * FROM users;

ALTER TABLE users ADD COLUMN temp_activ DATETIME;
UPDATE users SET temp_activ =STR_TO_DATE(activated_at,'%d-%m-%Y %H:%i');
ALTER TABLE users DROP COLUMN activated_at;
ALTER TABLE users CHANGE COLUMN temp_activ activated_at DATETIME;
SELECT * FROM users;

#Table- events
LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/events.csv "
INTO TABLE events
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY  '\n'
IGNORE 1 ROWS;

SELECT * FROM events;

ALTER TABLE events ADD COLUMN temp_occ DATETIME;
UPDATE events SET temp_occ =STR_TO_DATE(occurred_at,'%d-%m-%Y %H:%i');
ALTER TABLE events DROP COLUMN occurred_at;
ALTER TABLE events CHANGE COLUMN temp_occ occurred_at DATETIME;
SELECT * FROM events;

#Table- email_events
LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/email_events.csv "
INTO TABLE email_events
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY  '\n'
IGNORE 1 ROWS;

SELECT * FROM email_events;

ALTER TABLE email_events ADD COLUMN temp_occ DATETIME;
UPDATE email_events SET temp_occ =STR_TO_DATE(occurred_at,'%d-%m-%Y %H:%i');
ALTER TABLE email_events DROP COLUMN occurred_at;
ALTER TABLE email_events CHANGE COLUMN temp_occ occurred_at DATETIME;
SELECT * FROM email_events;


