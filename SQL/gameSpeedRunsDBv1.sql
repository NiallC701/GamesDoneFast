-- Name: Niall Connors and Patrick Morrissey
-- Date: 03/03/2026
-- Filename: gameSpeedRunsv1.sql
-- Purpose: To create a database for the games speedrunning app that can be connected to via a Java program

DROP DATABASE IF EXISTS gameSpeedRunsDB;
CREATE DATABASE IF NOT EXISTS gameSpeedRunsDB;
SHOW DATABASES;

USE gameSpeedRunsDB;

DROP TABLE IF EXISTS users;

-- Create Tables
CREATE TABLE users (
user_id INT NOT NULL AUTO_INCREMENT,
username VARCHAR(50) NOT NULL,
email VARCHAR(50) NOT NULL,
userPassword VARCHAR(100) NOT NULL,
country VARCHAR(50), -- if null, have no flag showing in leaderboard
CONSTRAINT user_idPK PRIMARY KEY (user_id)
);

CREATE TABLE games (
game_id INT NOT NULL AUTO_INCREMENT,
game_name VARCHAR(100) NOT NULL,
CONSTRAINT game_idPK PRIMARY KEY (game_id)
);

CREATE TABLE categories (
category_id INT NOT NULL AUTO_INCREMENT, 
category_name VARCHAR(50) NOT NULL,
CONSTRAINT category_idPK PRIMARY KEY (category_id)
);

/* there is a many to many relationship between games and categories so this linked table is needed*/
CREATE TABLE game_categories (
    game_id INT NOT NULL,
    category_id INT NOT NULL,
    PRIMARY KEY (game_id, category_id),
    FOREIGN KEY (game_id) REFERENCES games(game_id),
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

CREATE TABLE runs (
run_id INT NOT NULL AUTO_INCREMENT,
user_id INT NOT NULL,
game_id INT NOT NULL,
category_id INT NOT NULL,
run_time TIME NOT NULL,
date_submitted DATE NOT NULL,
platform VARCHAR(20) NOT NULL,
PRIMARY KEY (run_id),

-- three foreign keys
FOREIGN KEY (user_id) REFERENCES users(user_id),
FOREIGN KEY (game_id) REFERENCES games(game_id),
FOREIGN KEY (category_id) REFERENCES categories(category_id)
);


-- Test Data
INSERT INTO users (username, email, userPassword, country) VALUES
('JohnOfDutyName','JohnOfDutyEmail','JohnOfDutyPassword','Ireland'),
('TestUser1','TestUser1Email','TestUser1Password','Ireland');

INSERT INTO games (game_name) VALUES 
('Garfield Racing'),
('Resident Evil'),
('Burnout 3 Takedown');

INSERT INTO categories (category_name) VALUES 
('Normal'),
('Glitchless'),
('100%'),
("Knife Only");


-- link the games and categories tables data
-- Garfield Racing
INSERT INTO game_categories (game_id, category_id) VALUES 
(1, 1),  -- Normal
(1, 2);  -- Glitchless

-- Resident Evil
INSERT INTO game_categories (game_id, category_id) VALUES 
(2, 1),  -- Normal
(2, 4);  -- knife only

-- Burnout 3 Takedown
INSERT INTO game_categories (game_id, category_id) VALUES 
(3, 1),
(3, 3);  -- Normal + 100%

INSERT INTO runs (user_id, game_id, category_id, run_time, date_submitted, platform) VALUES
(1, 1, 1, '0:07:0', '2025-11-14', 'Playstation 2'),
(2, 2, 1, '5:15:0', '2026-03-28', 'Playstation 1'),
(2, 2, 1, '11:05:0', '2026-05-9', 'Playstation 1'),
(2, 1, 3, '0:02:0', '2024-11-8', 'PC');

-- Display Table Contents
SELECT * FROM users;
SELECT * FROM games;
SELECT * FROM runs;