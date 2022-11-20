CREATE DATABASE IF NOT EXISTS users;
USE users;
CREATE TABLE IF NOT EXISTS users(
    id            integer unsigned null,
    created_at    datetime         null,
    updated_at    datetime         null,
    deleted_at    datetime         null,
    name          varchar(255)     null,
    password_hash varchar(255)     null,
    remember_hash varchar(255)     null
);
-- Create normal user
CREATE USER 'cansu'@'localhost' IDENTIFIED WITH mysql_native_password BY '1234';
CREATE USER 'cansu'@'%' IDENTIFIED WITH mysql_native_password BY '1234';
CREATE USER 'cansu'@'mysql' IDENTIFIED WITH mysql_native_password BY '1234';
-- Executing this line will make cansu root, so connect with user "root" by the password "1234"
-- or cansu 1234 is sufficient too.
GRANT ALL PRIVILEGES ON *.* TO 'cansu'@'localhost' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'cansu'@'%' WITH GRANT OPTION;
-- Make sure changes are applied.
FLUSH PRIVILEGES;
