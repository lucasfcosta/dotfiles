#!/bin/bash
# Main installation script

# This is this file's path
DIR="$( cd "$( dirname "$0" )" && pwd )";


function printMainMenu {
    clear;

    echo "__  ___________    __  __   _____ _________________   ______________";
    echo "\ \/ / ____/   |  / / / /  / ___// ____/  _/ ____/ | / / ____/ ____/";
    echo " \  / __/ / /| | / /_/ /   \__ \/ /    / // __/ /  |/ / /   / __/   ";
    echo " / / /___/ ___ |/ __  /   ___/ / /____/ // /___/ /|  / /___/ /___   ";
    echo "/_/_____/_/  |_/_/ /_/   /____/\____/___/_____/_/ |_/\____/_____/   ";
    echo "                                                                    ";
    echo "                                 The Best Dotfiles Ever Made        ";

    PS3='Select a Config: ';
    options=("Ubuntu" "OSX" "Quit");

    select opt in "${options[@]}"
    do
        case $opt in
            "Ubuntu")
                echo "Installing $opt";
                bash $DIR/ubuntu/install.sh;
                ;;
            "OSX")
                echo "Installing $opt";
                bash $DIR/osx/install.sh;
                ;;
            "Quit")
                exit 0;
                ;;
            *)
                echo Invalid Option;
                read -rsp $'Press any key to continue...\n' -n1 key;
                printMainMenu;
                ;;
        esac
        exit 0;
    done
}

printMainMenu;
