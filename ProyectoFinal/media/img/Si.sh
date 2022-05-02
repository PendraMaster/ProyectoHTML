#!/bin/bash

if [ ! -d ./SQL ]; then
    mkdir ./SQL
fi

Red='\033[0;31m'
Green='\033[0;32m'
Orange='\033[0;33m'
Blue='\033[0;34m'
Purple='\033[0;35m'
Cyan='\033[0;36m'
LGray='\033[0;37m'
Yellow='\033[1;33m'
NC='\033[0m'

while :; do
    clear

    echo -ne "$Blue\u2554\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550 "
    echo -ne "$Yellow\u2b50$NC"
    echo -ne "$Green WELCOME TO THE INSERTER $NC"
    echo -ne "$Yellow\u2b50$NC"
    echo -e "$Blue \u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2557"
    echo -e "\u2551                                                                                    \u2551"
    echo -e "\u2551$Purple Choose an option:                                                                  $Blue\u2551"
    echo -e "\u2551                                                                                    \u2551"
    echo -e "\u2551$Cyan 1)$Purple Unique file                                                                     $Blue\u2551"
    echo -e "\u2551                                                                                    \u2551"
    echo -e "\u2551$Cyan 2)$Purple Some files                                                                      $Blue\u2551"
    echo -e "\u2551                                                                                    \u2551"
    echo -e "\u2551$Cyan 3)$Purple Folder                                                                          $Blue\u2551"
    echo -e "\u2551                                                                                    \u2551"
    echo -e "\u2551$Cyan 4)$Purple Exit                                                                            $Blue\u2551"
    echo -e "\u2551                                                                                    \u2551"
    echo -e "\u255A\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u255D"

    sleep 0.4

    read -p "$(echo -e "$Yellow\u2b50$NC")Option: " opcion

    case $opcion in
    1)
        read -p "Enter the filename:$(echo -e $Green) " csv
        if [ ! -f $csv ]; then
            clear
            echo -e "$Yellow\u26a0$Red Este archivo introducido no existe ($csv) $Yellow\u26a0$NC"
            read -p "Pulse Intro para continuar"
        else
            extension=$(echo $csv | cut -d "." -f2)
            extension=$(echo ${extension:0:3})
            if [ $extension == "csv" ]; then

                header=$(cat $csv | head -1)
                LineasColocadas=0
                nombrecsv=$(echo $csv | cut -d "." -f1)
                for linea in $(cat $csv | tr -s " " "%"); do
                    linea=$(echo $linea | tr -s "%" " ")
                    if [ $LineasColocadas -eq 0 ]; then
                        echo -n "INSERT INTO $nombrecsv ($linea) VALUES " >>./SQL/$nombrecsv.sql
                    else
                        if [ $LineasColocadas -eq 1 ]; then
                            echo -n "($linea)" >>./SQL/$nombrecsv.sql
                        else
                            echo -n ",($linea)" >>./SQL/$nombrecsv.sql
                        fi
                    fi
                    let LineasColocadas++
                done
                echo -e ";\n" >>./SQL/$nombrecsv.sql

                clear
                echo -e "$Yellow\u2b50${Green}Insert Succesfuly Created In ./SQL/$nombrecsv.sql$Yellow\u2b50$NC"

                read
            else
                clear
                echo -e "$Yellow\u26a0$Red Este archivo introducido no es un csv ($csv) $Yellow\u26a0$NC"
                read -p "Pulse Intro para continuar"
            fi
        fi

        ;;

    2)
        read -p "Enter filenames:$(echo -e $Green) " csv
        clear
        for csv in $csv; do
            if [ ! -f $csv ]; then
                clear
                echo -e "$Yellow\u26a0$Red Este archivo introducido no existe ($csv) $Yellow\u26a0$NC"
                read -p "Pulse Intro para continuar"
            else
                extension=$(echo $csv | cut -d "." -f2)
                extension=$(echo ${extension:0:3})
                if [ $extension == "csv" ]; then
                    header=$(cat $csv | head -1)
                    LineasColocadas=0
                    nombrecsv=$(echo $csv | cut -d "." -f1)
                    for linea in $(cat $csv | tr -s " " "%"); do
                        linea=$(echo $linea | tr -s "%" " ")
                        if [ $LineasColocadas -eq 0 ]; then
                            echo -n "INSERT INTO $nombrecsv ($linea) VALUES " >>./SQL/$nombrecsv.sql
                        else
                            if [ $LineasColocadas -eq 1 ]; then
                                echo -n "($linea)" >>./SQL/$nombrecsv.sql
                            else
                                echo -n ",($linea)" >>./SQL/$nombrecsv.sql
                            fi
                        fi
                        let LineasColocadas++
                    done
                    echo -e ";\n" >>./SQL/$nombrecsv.sql
                    echo -e "$Yellow\u2b50${Green}Insert Succesfuly Created In ./SQL/$nombrecsv.sql$Yellow\u2b50$NC"
                else
                    echo -e "$Yellow\u26a0$Red Este archivo introducido no es un csv ($csv) $Yellow\u26a0$NC"
                    read -p "Pulse Intro para continuar"
                fi
            fi
        done

        read

        ;;

    3)
        read -p "Enter the route:$(echo -e $Green) " ruta
        clear
        if [ ! -d $ruta ]; then
            clear
            echo -e "$Yellow\u26a0$Red Este carpeta no existe $Yellow\u26a0$NC"
            read -p "Pulse Intro para continuar"
        else
            for csv in $(ls $ruta); do
                if [ ! -f $csv ]; then
                    echo -e "$Yellow\u26a0$Red Este archivo introducido no existe ($csv) $Yellow\u26a0$NC"
                    read -p "Pulse Intro para continuar"
                else
                    extension=$(echo $csv | cut -d "." -f2)
                    extension=$(echo ${extension:0:3})
                    if [ $extension == "csv" ]; then
                        header=$(cat $csv | head -1)
                        LineasColocadas=0
                        nombrecsv=$(echo $csv | cut -d "." -f1)
                        for linea in $(cat $csv | tr -s " " "%"); do
                            linea=$(echo $linea | tr -s "%" " ")
                            if [ $LineasColocadas -eq 0 ]; then
                                echo -n "INSERT INTO $nombrecsv ($linea) VALUES " >>./SQL/$nombrecsv.sql
                            else
                                if [ $LineasColocadas -eq 1 ]; then
                                    echo -n "($linea)" >>./SQL/$nombrecsv.sql
                                else
                                    echo -n ",($linea)" >>./SQL/$nombrecsv.sql
                                fi
                            fi
                            let LineasColocadas++
                        done
                        echo -e ";\n" >>./SQL/$nombrecsv.sql
                        echo -e "$Yellow\u2b50${Green}Insert Succesfuly Created In ./SQL/$nombrecsv.sql$Yellow\u2b50$NC"
                    else
                        echo -e "$Yellow\u26a0$Red Este archivo introducido no es un csv ($csv) $Yellow\u26a0$NC"
                        read -p "Pulse Intro para continuar"
                    fi
                fi
            done

        fi

        read

        ;;

    4)
        read -p "Are you sure?$(echo -e $Green) " salir
        if [ $salir == "Yes" ] || [ $salir == "yes" ] || [ $salir == "y" ] || [ $salir == "Y" ]; then
            sleep 0.3
            clear
            exit 0
        fi
        ;;

    esac
done
