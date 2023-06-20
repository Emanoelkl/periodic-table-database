#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

NUMBER_INPUT() {
  DATA=$($PSQL "SELECT * FROM elements FULL JOIN properties USING (atomic_number) FULL JOIN types USING (type_id) WHERE atomic_number = $1;")
  if [[ -z $DATA ]]
  then
   echo "I could not find that element in the database."
  else
    echo "$DATA" | while read ID BAR NUM BAR SYMB BAR NAME BAR MASS BAR MELT BAR BOIL BAR TYPE
    do
      echo "The element with atomic number $NUM is $NAME ($SYMB). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
    done
  fi
}

SYMBOL_INPUT() {
  DATA=$($PSQL "SELECT * FROM elements FULL JOIN properties USING (atomic_number) FULL JOIN types USING (type_id) WHERE symbol = '$1';")
  if [[ -z $DATA ]]
  then
   echo "I could not find that element in the database."
  else
    echo "$DATA" | while read ID BAR NUM BAR SYMB BAR NAME BAR MASS BAR MELT BAR BOIL BAR TYPE
    do
      echo "The element with atomic number $NUM is $NAME ($SYMB). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
    done
  fi
}

NAME_INPUT() {
  DATA=$($PSQL "SELECT * FROM elements FULL JOIN properties USING (atomic_number) FULL JOIN types USING (type_id) WHERE name = '$1';")
  if [[ -z $DATA ]]
  then
   echo "I could not find that element in the database."
  else
    echo "$DATA" | while read ID BAR NUM BAR SYMB BAR NAME BAR MASS BAR MELT BAR BOIL BAR TYPE
    do
      echo "The element with atomic number $NUM is $NAME ($SYMB). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
    done
  fi
}

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    NUMBER_INPUT $1
  else
    LENGTH=$(echo -n "$1" | wc -m)
    if [[ $LENGTH -gt 2 ]]
    then
      NAME_INPUT $1
    else
      SYMBOL_INPUT $1
    fi
  fi
  
fi
