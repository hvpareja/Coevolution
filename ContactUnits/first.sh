#!/bin/bash

detailedFile=$1
pdbFile=$2
chainA=$3
chainB=$4

# En primer lugar seleccionamos los átomos pertenecientes a las cadenas de interés
grep -P "^${chainA}\t${chainB}" $detailedFile > tmp${chainA}${chainB}

# En un bucle, calculamos las distancias entre cada uno de los átomos en el archivo
# temporal que hemos creado más arriba
for row in $(< tmp${chainA}${chainB}); do
	echo ${row}
done