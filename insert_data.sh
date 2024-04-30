#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

# ./create_database.sh

# inserting teams
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $YEAR != year ]]
  then
    INSERT_TEAM_RESULT="$($PSQL "insert into teams (name) values ('$WINNER') on conflict do nothing;")"
    if [[ $INSERT_TEAM_RESULT == "INSERT 0 1" ]]
    then
      echo "Inserted into teams: $WINNER"
    fi
    INSERT_TEAM_RESULT="$($PSQL "insert into teams (name) values ('$OPPONENT') on conflict do nothing;")"
    if [[ $INSERT_TEAM_RESULT == "INSERT 0 1" ]]
    then
      echo "Inserted into teams: $OPPONENT"
    fi
  fi
done

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $YEAR != year ]]
  then
    WINNER_ID=$($PSQL "select team_id from teams where name = '$WINNER';")
    OPPONENT_ID=$($PSQL "select team_id from teams where name = '$OPPONENT';")
    INSERT_GAME_RESULT="$($PSQL "insert into games (year, round, winner_id, opponent_id, winner_goals, opponent_goals) values ($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS);")"
    if [[ $INSERT_GAME_RESULT == "INSERT 0 1" ]]
    then
      echo Inserted into games: $YEAR, $WINNER vs $OPPONENT
    fi
  fi
done