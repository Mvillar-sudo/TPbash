#!/bin/bash
salir="0"

FILENAME=$1
export FILENAME

parametro=$1

if [[ "$parametro" == "-d" ]]; then
  echo "Deteniendo el proceso en background y borrando EPNro1..."
  pkill -f consolidar.sh
  rm -r $HOME/EPNro1
else
  until [[ "$salir" == "1" ]]; do
    echo "-----MENU-----"
    echo "1 - Crear entorno"
    echo "2 - Correr proceso"
    echo "3 - Ordenar listado"
    echo "4 - lista de las 10 mejores notas"
    echo "5 - Buscar nombre por nro. de padron"
    echo "6 - Salir"

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
               echo "El archivo no existe en la carpeta salida"
            fi;;
        4)
	    if [[ -f "$HOME/EPNro1/salida/$FILENAME.txt" ]]; then
                echo "Lista de los alumnos con las 10 mejores notas"
                sort -t ' ' -k 5 -n -r "$HOME/EPNro1/salida/$FILENAME.txt" | head -10
            else
               echo "El archivo no existe en la carpeta salida"
            fi;;
	5)
	  if [[ -f "$HOME/EPNro1/salida/$FILENAME.txt" ]]; then
	    echo "Ingrese nro. de padron ('*' para regresar al menu): "
	    read nro
	    until [[ "$nro" == "*" ]]; do
	      chequeo=$(grep $nro $HOME/EPNro1/salida/$FILENAME.txt | wc -l)
	      if [[ $chequeo -eq 0 ]]; then
	        echo "No se encontro" 
	      else
	        grep $nro $HOME/EPNro1/salida/$FILENAME.txt
	      fi
	      echo "Ingrese número de padrón deseado (o '*' para regresar al menu): "
	      read nro
	    done

	    echo "Regresando..."
	  else
	    echo "El archivo no existe en la carpeta salida"
	  fi;;
	6)
	    echo "Saliendo..."
	    salir="1";;
	7)
            echo "Saliendo..."
	    pkill -f consolidar.sh
	    salir="1";; #Para que funcione como failsafe en caso de error
    esac
  done
fi
