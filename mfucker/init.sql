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
CREATE USER 'cansu'@'127.0.0.1' IDENTIFIED WITH authentication_plugin BY '1234';
-- Executing this line will make cansu root, so connect with user "root" by the password "1234"
GRANT ALL PRIVILEGES ON *.* TO 'cansu'@'127.0.0.1' WITH GRANT OPTION;
-- Make sure changes are applied.
FLUSH PRIVILEGES;