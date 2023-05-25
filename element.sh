PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
NOT_FOUND='FALSE'
if [[ $1 =~ ^[0-9]+$ ]]
then
  ATOMIC_NUMBER=$1
  SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$ATOMIC_NUMBER;")
  if [[ -z $SYMBOL ]]
  then
    NOT_FOUND='TRUE'
  else
    NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$ATOMIC_NUMBER;")
    TYPE=$($PSQL "SELECT type FROM properties LEFT JOIN types USING(type_id) WHERE atomic_number=$ATOMIC_NUMBER;")
    ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER;")
    MELTING_POINT_CELSIUS=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER;")
    BOILING_POINT_CELSIUS=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER;")
  fi
elif [[ ( $1 =~ ^[A-Z]) && ( $1 =~ ^[[:alnum:]]{1,2}$ ) ]]
then
  SYMBOL=$1
  ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$SYMBOL';")
  if [[ -z $ATOMIC_NUMBER ]]
  then
    NOT_FOUND='TRUE'
  else
    NAME=$($PSQL "SELECT name FROM elements WHERE symbol='$SYMBOL';")
    TYPE=$($PSQL "SELECT type FROM properties LEFT JOIN types USING(type_id) WHERE atomic_number=$ATOMIC_NUMBER;")
    ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER;")
    MELTING_POINT_CELSIUS=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER;")
    BOILING_POINT_CELSIUS=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER;")
  fi
elif [[ $1 =~ ^.{3,}$ ]]
then  
  NAME=$1
  ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name='$NAME';")
  if [[ -z $ATOMIC_NUMBER ]]
  then
    NOT_FOUND='TRUE'
  else
    SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$ATOMIC_NUMBER;")
    TYPE=$($PSQL "SELECT type FROM properties LEFT JOIN types USING(type_id) WHERE atomic_number=$ATOMIC_NUMBER;")
    ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER;")
    MELTING_POINT_CELSIUS=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER;")
    BOILING_POINT_CELSIUS=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER;")
  fi
fi

if [[ $NOT_FOUND == 'TRUE' ]]
then
  echo "I could not find that element in the database."
fi

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
  if [[ $NOT_FOUND == 'FALSE' ]] 
  then
    echo -e "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
  fi
fi
