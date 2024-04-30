#!/bin/bash
RESET="psql --username=freecodecamp --dbname=postgres -t --no-align -c"
PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"

echo "$($RESET "drop database if exists worldcup;")"
echo "$($RESET "create database worldcup;")"

echo "$($PSQL "create table teams();")"
echo "$($PSQL "create table games();")"

echo "$($PSQL "alter table teams add column team_id serial primary key;")"
echo "$($PSQL "alter table teams add column name varchar(20) unique not null;")"

echo "$($PSQL "alter table games add column game_id serial primary key;")"
echo "$($PSQL "alter table games add column year int not null;")"
echo "$($PSQL "alter table games add column round varchar(50) not null;")"

echo "$($PSQL "alter table games add column winner_id int not null;")"
echo "$($PSQL "alter table games add column opponent_id int not null;")"

echo "$($PSQL "alter table games add foreign key (winner_id) references teams (team_id);")"
echo "$($PSQL "alter table games add foreign key (opponent_id) references teams (team_id);")"

echo "$($PSQL "alter table games add column winner_goals int not null;")"
echo "$($PSQL "alter table games add column opponent_goals int not null;")"
