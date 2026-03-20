#!/bin/bash
salir="0"

until [[ "$salir" == "1" ]]; do
    echo "-----MENU-----"
    echo "1 - Crear entorno"
    echo "2 - Correr proceso"
    echo "* - Salir"

    echo "Ingrese la opción del menú: "
    read opcion

    case $opcion in
        1)
            mkdir $HOME/TPNro1
            mkdir $HOME/TPNro1/entrada
            mkdir $HOME/TPNro1/salida
            mkdir $HOME/TPNro1/procesado;;
        2)
            echo "Corriendo proceso en background"
	    bash consolidar.sh &;;
        *)
            echo "Saliendo..."
	    salir="1";;
    esac
done
