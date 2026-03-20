#!/bin/bash
salir="0" 

FILENAME=$1
export FILENAME
until [[ "$salir" == "1" ]]; do
    echo "-----MENU-----"
    echo "1 - Crear entorno"
    echo "2 - Correr proceso"
    echo "3 - Salir"

    echo "Ingrese la opción del menú: "
    read opcion

    case $opcion in
        1)
            mkdir $HOME/EPNro1
            mkdir $HOME/EPNro1/entrada
            mkdir $HOME/EPNro1/salida
            mkdir $HOME/EPNro1/procesado;;
        2)
            echo "Corriendo proceso en background"
	    bash consolidar.sh & # Ejecuto el script consolidar.sh en background
	    PID=$!
	    echo "$PID";;
        3)
            echo "Saliendo..."
	    pkill -f consolidar.sh
	    salir="1";;
    esac
done
