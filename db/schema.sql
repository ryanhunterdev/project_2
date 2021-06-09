create database buskr

\c buskr

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    user_name TEXT,
    password_digest TEXT,
    email TEXT,
    user_img TEXT, 
    user_bio TEXT,
    user_link TEXT,
    user_location TEXT
);

CREATE TABLE tracks (
    id SERIAL PRIMARY KEY, 
    user_id INTEGER,
    track_name TEXT,
    track_img TEXT, 
    track_info TEXT,
    purchase_link TEXT,
    genre TEXT,
    track_audio TEXT 
);

CREATE TABLE tips (
    id SERIAL PRIMARY KEY,
    tipper_id INTEGER,
    tipper_name TEXT,
    track_id INTEGER,
    track_name TEXT,
    track_publisher_id INTEGER,
    track_publisher_name TEXT,
    tip_amount DECIMAL(10,2),
    tip_comment TEXT
);