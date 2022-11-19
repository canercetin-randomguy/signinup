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
