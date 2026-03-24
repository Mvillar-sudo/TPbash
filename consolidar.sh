#!/bin/bash

shopt -s nullglob

ENTRADA=$HOME/EPNro1/entrada
SALIDA=$HOME/EPNro1/salida
PROCESADO=$HOME/EPNro1/procesado

while true; do
    for archivo in "$ENTRADA"/*.txt; do
        cat "$archivo" >> "$SALIDA/$FILENAME.txt"
        mv "$archivo" "$PROCESADO/"
        echo "Procesado: $archivo"
    done
    sleep 5
done

