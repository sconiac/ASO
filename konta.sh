#!bin/zsh

# COLORS
CYAN='\e[36m'
MAGENTA='\e[35m'
BLUE='\e[34m'
YELLOW='\e[33m'
GREEN='\e[32m'
RED='\e[31m'

NC='\e[0m'
BOLD='\e[1m'
UNDERLINE='\e[4m'

echo "${BLUE}${BOLD}${UNDERLINE}Co robić:${NC}"
echo "${YELLOW}1 - list kont${NC}"
echo "${RED}2 - usuń konto${NC}"
echo "${GREEN}3 - dodaj konto${NC}"
echo "${MAGENTA}4 - dodaj kilka kont${NC}"
echo "${CYAN}5 - zmień właściwości konta${NC}"

read opt

case $opt in 
    1)
        echo "${BOLD}${YELLOW}List kont:${NC}"
        cat /etc/passwd
    ;;
    2)
        echo "${BOLD}${RED}Podaj nazwę konta:${NC}"
        read user_name
        echo "${BOLD}${RED}Usunąć katalog domowy?${NC}[y/n]"
        read prm1
        if [[ $prm1 == "y" || $prm1 == "Y" ]]
        then
            sudo userdel -r "$user_name" 2> /dev/null
            echo "${GREEN}Usunięto konto $user_name z katalogiem domowym${NC}"
        else
            sudo userdel "$user_name" 2> /dev/null
            echo "${GREEN}Usunięto konto $user_name bez katalogu domowego.${NC}"
        fi
    ;;
    3)
        echo "${BOLD}${GREEN}Podaj nazwę konta:${NC}"
        read new_user_name
        sudo adduser "$new_user_name"
        echo "${GREEN}Dodano nowe konto.${NC}"
    ;;
    4)
        echo "${BOLD}${MAGENTA}Podaj ile kont dodać:${NC}"
        read user_number
        echo "${BOLD}${YELLOW}Utworzyć katalogi domowe?${NC}[y/n]"
        read prm2
        if [[ $prm2 == "y" || $prm2 == "Y" ]]
        then
            for i in {1..$user_number}
            do
                sudo useradd -m user"$i"
            done
            echo "${GREEN}Utworzono $user_number nowych kont z katalogami domowymi.${NC}"
        else
            for i in {1..$user_number}
            do
                sudo useradd user"$i"
            done
            echo "${GREEN}Dodano $user_number nowych kont bez katalogów domowych.${NC}"
        fi
    ;;
    5)
        echo ""
        echo "${BLUE}${BOLD}${UNDERLINE}Ustawienia:${NC}"
        echo "${YELLOW}1 - zmień podstawową grupę"
        echo "${YELLOW}2 - dodaj konto do grupy"
        echo "${CYAN}3 - zmień katalog domowy"
        echo "${MAGENTA}4 - zmień domyślną powłokę"
        echo "${GREEN}5 - zmień nazwę konta"
        echo "${RED}6 - zmień UID konta"
        echo "${RED}7 - zablokuj/odblokuj konto${NC}"
        read opt1

        case $opt1 in
            1)
                echo "${BOLD}${YELLOW}Podaj nazwę konta:${NC}"
                read user_name
                echo "${BOLD}${YELLOW}Podaj nazwę grupy:${NC}"
                read group_name
                echo -e "${BOLD}${YELLOW}Zmienić podstawową grupę na: ${BOLD}${group_name}${NC}${YELLOW}?${NC}[y/n]"
                read prm3
                if [[ $prm3 == "y" || $prm3 == "Y" ]]
                then
                    sudo usermod -G ${group_name} ${user_name}
                    echo "${GREEN}Zmieniono grupę podstawową użytkownika: ${BOLD}${user_name}${NC} ${GREEN}na grupę: ${BOLD}${group_name}${NC}${GREEN}.${NC}"
                else
                    echo "${GREEN}Nie zmieniono grupy podstawowej użytkownika: ${BOLD}${user_name}${NC} ${GREEN}.${NC}"
                fi
            ;;
            2)
                echo "${BOLD}${YELLOW}Podaj nazwę konta:${NC}"
                read user_name
                echo "${BOLD}${YELLOW}Podaj nazwę grupy:${NC}"
                read group_name
                echo -e "${BOLD}${YELLOW}Dodać użytkownika ${BOLD}${user_name}${NC} ${YELLOW}do grupy ${BOLD}${group_name}${NC}${YELLOW}?${NC}[y/n]"
                read prm3
                if [[ $prm3 == "y" || $prm3 == "Y" ]]
                then
                    sudo usermod -a -G ${group_name} ${user_name}
                    echo "${GREEN}Dodano użytkownika ${BOLD}${user_name}${NC} ${GREEN}do grupy ${BOLD}${group_name}${NC}${GREEN}.${NC}"
                else
                    echo "${RED}Nie dodano użytkownika ${BOLD}${user_name}${NC} ${RED}do grupy ${BOLD}${group_name}${NC}${RED}.${NC}"
                fi
            ;;
            3)
                echo "${BOLD}${CYAN}Podaj nazwę konta:${NC}"
                read user_name
                echo "${BOLD}${CYAN}Podaj ścieżkę do nowego katalogu (bądź nazwę, jeśli katalog nie istanieje):${NC}"
                read new_dir_path
                echo "${BOLD}${CYAN}Przenieść zawartość do nowego katalogu?${NC}[y/n]"
                read prm3
                if [[ $prm3 == "y" || $prm3 == "Y" ]]
                then
                    sudo usermod -d $new_dir_path $user_name
                    echo "${GREEN}Przeniesiono zawartość do nowego katalogu.${NC}"
                else
                    sudo usermod $new_dir_path $user_name
                    echo "${GREEN}Zmieniono katalog domowy użytkownika: ${BOLD}${user_name}${NC} ${GREEN}.${NC}"
                fi
            ;;
            4)
                echo "${BOLD}${MAGENTA}Podaj nazwę konta:${NC}"
                read user_name
                echo ""
                echo "${BOLD}${MAGENTA}${UNDERLINE}List dostępnych powłok:${NC}"
                echo ""
                cat /etc/shells
                echo ""
                echo "${BOLD}${MAGENTA}Podaj scieżkę do powłoki: ${NC}"
                read path_to_shell
                echo "${BOLD}${MAGENTA}Zmienić powłokę konta: $user_name, na $path_to_shell?${NC}[y/n]"
                read prm4
                if [[ $prm4 == "y" || $prm4 == "Y" ]]
                then
                    sudo usermod -s $path_to_shell $user_name
                    echo "${GREEN}Zmieniono powłokę konta: $user_name, na $path_to_shell.${NC}"
                else
                    echo "${RED}Anulowano zmianę.${NC}"
                fi
            ;;
            5)
                echo "${BOLD}${GREEN}Podaj nazwę konta (do zmiany):${NC}"
                read user_name
                echo "${BOLD}${GREEN}Podaj nową nazwę konta:${NC}"
                read new_user_name
                echo "${BOLD}${GREEN}Zmienić nazwę konta: $user_name, na $new_user_name?${NC}[y/n]"
                read prm5
                if [[ $prm5 == "y" || $prm5 == "Y" ]]
                then
                    sudo usermod -l $new_user_name $user_name
                    echo "${GREEN}Zmieniono nazwę konta: $user_name, na $new_user_name.${NC}"
                else
                    echo "${RED}Anulowano zmianę.${NC}"
                fi
            ;;
            6)
                echo "${BOLD}${RED}Podaj nazwę konta (do zmiany UID):${NC}"
                read user_name
                echo "${BOLD}${RED}Podaj nową wartość UID:${NC}"
                read new_UID
                echo "${BOLD}${RED}Zmienić UID konta: $user_name, na $new_UID?${NC}[y/n]"
                read prm6
                if [[ $prm6 == "y" || $prm6 == "Y" ]]
                then
                    sudo usermod -u $new_UID $user_name
                    echo "${GREEN}Zmieniono UID konta: $user_name, na $new_UID.${NC}"
                else
                    echo "${RED}Anulowano zmianę.${NC}"
                fi
            ;;
            7)
                echo "${BOLD}${RED}Podaj nazwę konta (do zablokowania/odblokowania):${NC}"
                read user_name
                echo "${BOLD}${RED}Zablokować czy odblokować konto $user_name?${NC}[z/o]"
                read prm7
                if [[ $prm7 == "z" || $prm7 == "Z" ]]
                then
                    sudo usermod -L -e 1 $user_name
                    echo "${RED}Zablokowano konto: $user_name.${NC}"
                    echo "${RED}Użytkownik nie będzie mógł się zalogować.${NC}"
                else
                    echo "${GREEN}Odblokowno konto $user_name.${NC}"
                    echo "${GREEN}Użytkownik może się już zalogować.${NC}"
                fi
            ;;
        esac
    ;;
esac
