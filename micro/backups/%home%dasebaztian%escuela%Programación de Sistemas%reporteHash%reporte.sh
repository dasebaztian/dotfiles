#!/bin/bash

ayuda() {
	cat << EOF
reporte.sh directorio archivoDestino
Parámetros:
	directorio: Directorio del cual se quieren saber los hashes de los archivos
	ArchivoDestino: Archivo en el cual se va a guardar la correspondencia de hashes y archivos
Script que genera los hashes de un directorio y los almacena en un archivo destino, el archivo destino despues se puede usar
para verificar cambios en el directorio.
EOF
}
recursiva() {
    dir_base="$1";
    for sub_dir in "$dir_base"/*; do
	test -d "$sub_dir" && recursiva "$sub_dir"
	file_pass=$(tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c 10)
	export file_pass
	echo "$sub_dir|$file_pass" >> "$ruta_ejecucion/passwords.txt"
	ccrypt -e -E file_pass "$sub_dir"
    done
}
ayuda
