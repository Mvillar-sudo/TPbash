#!/bin/bash

shopt -s nullglob

ENTRADA=$HOME/EPNro1/entrada
SALIDA=$HOME/EPNro1/salida
PROCESADO=$HOME/EPNro1/procesado

echo "Filename vale : $FILENAME"

while true; do
    echo "Buscando archivos en $ENTRADA"
    for archivo in "$ENTRADA"/*.txt; do
        echo "Encontré: $archivo"
        cat "$archivo" >> "$SALIDA/$FILENAME.txt"
        mv "$archivo" "$PROCESADO/"
        echo "Procesado: $archivo"
    done
    sleep 5
done

