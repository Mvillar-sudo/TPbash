#!/bin/bash
salir="0" 

FILENAME=$1
export FILENAME
until [[ "$salir" == "1" ]]; do
    echo "-----MENU-----"
    echo "1 - Crear entorno"
    echo "2 - Correr proceso"
    echo "3 - ordenar listado"
    echo "4 - lista de las 10 mejores notas"
    echo "5 - Salir"

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
	    if [[ -f "$HOME/EPNro1/salida/$FILENAME.txt" ]]; then
	        echo "Listado de alumnos ordenados por numero de padron"
	        sort -n "$HOME/EPNro1/salida/$FILENAME.txt"
            else
               echo "El archivo no exsite en la carpeta salida"
            fi;;
        4)
	    if [[ -f "$HOME/EPNro1/salida/$FILENAME.txt" ]]; then
                echo "Lista de los alumnos con las 10 mejores notas"
                sort -k3,3 -n -r "$HOME/EPNro1/salida/$FILENAME.txt" | head -10
            else 
               echo "El archivo no existe en la carpeta salida"
            fi;;
	5)
            echo "Saliendo..."
	    pkill -f consolidar.sh
	    salir="1";;
    esac
done
