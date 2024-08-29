#!/bin/bash

# Ruta a la carpeta que contiene las imágenes de fondo
directorio="/home/godprogrammer/Pictures/allbackgrounds/"

# Lista de fondos de pantalla en la carpeta
fondos=("$directorio"/*)

# Mezclar la lista de fondos de manera aleatoria
fondos_aleatorios=($(shuf -e "${fondos[@]}"))

# Establecer un fondo de manera aleatoria
fondo_aleatorio="${fondos_aleatorios[2]}"
feh --bg-fill "$fondo_aleatorio"




