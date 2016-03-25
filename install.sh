#!/bin/bash
# Main installation script

echo "__  ___________    __  __   _____ _________________   ______________";
echo "\ \/ / ____/   |  / / / /  / ___// ____/  _/ ____/ | / / ____/ ____/";
echo " \  / __/ / /| | / /_/ /   \__ \/ /    / // __/ /  |/ / /   / __/   ";
echo " / / /___/ ___ |/ __  /   ___/ / /____/ // /___/ /|  / /___/ /___   ";
echo "/_/_____/_/  |_/_/ /_/   /____/\____/___/_____/_/ |_/\____/_____/   ";
echo "                                                                    ";
echo "                                 The Best Dotfiles Ever Made        ";

DIR="$( cd "$( dirname "$0" )" && pwd )"
PS3='Select a Config:'
options=("Ubuntu (Foucault)" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Ubuntu (Foucault)")
            echo "Installing $opt"
            bash $DIR/ubuntu/install.sh
            ;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done
