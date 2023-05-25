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
…
if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
  if [[ $NOT_FOUND == 'FALSE' ]] 
  then
    echo -e "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
  fi
fi
