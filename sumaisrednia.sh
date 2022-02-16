#!bin/zsh

BLUE='\e[34m'
YELLOW='\e[33m'
NC='\e[0m'
BOLD='\e[1m'

echo "Podaj piersza liczbe:"
read num1

while [[ "$num1" == "q" ]]
do
echo "Podaj piersza liczbe:"
read num1
done

while [[ "$num1" != "q" ]]
do
let i+=1
let suma+=$num1
echo "Podaj kolejną liczbę"
read num1
done

echo ""
echo ""

echo "Suma to: ${BOLD}${YELLOW}$suma${NC}"
echo "Średnia to:${YELLOW}${BOLD}"
bc <<< "scale=2; $suma/$i"

