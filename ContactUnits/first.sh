#!/bin/bash

detailedFile=$1
pdbFile=$2
chainA=$3
chainB=$4

echo "Calculando distancias en todo el conjunto ..."
./proximity.pl $detailedFile $pdbFile $chainA $chainB | sort -k6 -n | tmp_distances_${chanA}${chainB}
echo "Seleccionando las distancias más cortas entre residuos ..."
./clean_proximity.pl tmp_distances_${chainA}${chainB} > proximities${chainA}${chainB}.txt
rm tmp_distances_${chainA}${chainB}
echo "DONE"