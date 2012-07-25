#!/bin/bash
# Initial setings:
email="hvalverde@uma.es"

clear 
echo "#######################################################"
echo "#                                                     #"
echo "# ANÁLISIS EVOLUTIVO DE INTERACCIONES ENTRE PROTEÍNAS #"
echo "# HÉCTOR VALVERDE PAREJA (hvalverde@uma.es)           #"
echo "# JUAN CARLOS ALEDO RAMOS                             #"
echo "# Versión 0.1, Julio de 2012                          #"
echo "# Departamento de Biología Molecular y Bioquímica     #"
echo "# Universidad de Málaga                               #"
echo "#                                                     #"
echo "#######################################################"
echo 
echo "Selecciona una opción del menú para continuar:"
echo 
echo "1. Generar archivo de contactos"
echo "2. Generar secuencias agrupadas"
echo "3. Cálculo de dN"
echo 
echo -e "Opción:"; read option


case $option in

	1)
	clear
	echo "#######################################################"
	echo "# ANALISIS DE CONTACTOS DEL COMPLEJO PROTEICO         #"
	echo "#######################################################"
	echo 
	echo "Introduce la ruta del archivo de coordenadas del complejo (PDB file)"
	echo "(X para volver al menú principal):"
	# PDB file
	read pdbfile
	if [ "$pdbfile" == "X" ]; then ./coevol.sh; exit; fi
	if [ "$pdbfile" == "x" ]; then ./coevol.sh; exit; fi
	if [ ! -f $pdbfile ]; then echo "No se puede encontrar el archivo ($pdbfile)"; exit; fi
	echo "Introduce la carpeta de destino en la que se guardarán los resultados:"
	# Path results
	read pathresults
        if [ ! -d $pathresults ]; then 
		echo "El directorio seleccionado no existe, ¿desea crearlo? (S/n):"
		read crearDirectorioDestino
		case $crearDirectorioDestino in
			"s") mkdir $pathresults;;
			"S") mkdir $pathresults;;
			"n") echo "Fin de la ejecución"; exit;;
			"N") echo "Fin de la ejecución"; exit;;
		esac
	fi
	echo
	echo "Calculando contactos ... este proceso puede durar horas dependiendo del tamaño del complejo"
	echo
	./contact.pl $pdbfile $pathresults
	echo "Trabajo completado"; exit;;
	
	2)
	clear
	echo "#######################################################"
	echo "# CONSTRUCCIÓN DE ALINEAMIENTOS EN GRUPOS             #"
	echo "#######################################################"
	echo
	echo "Introduce la ruta del archivo de coordenadas del complejo (PDB file)"
	echo "(X para volver al menú principal):"
	# PDB file
	read pdbfile
	if [ "$pdbfile" == "X" ]; then ./coevol.sh; exit; fi
	if [ "$pdbfile" == "x" ]; then ./coevol.sh; exit; fi
	if [ ! -f $pdbfile ]; then echo "No se puede encontrar el archivo ($pdbfile)"; exit; fi
	echo "Introduce el archivo de alineamiento original (formato FASTA):"
	echo "(X para volver al menú principal):"
	# Alignment
	read alignment
	if [ "$alignment" == "X" ]; then ./coevol.sh; exit; fi
	if [ "$alignment" == "x" ]; then ./coevol.sh; exit; fi
	if [ ! -f $alignment ]; then echo "No se puede encontrar el archivo ($alignment)"; exit; fi
	echo "Introduce el archivo de contactos:"
	echo "(X para volver al menú principal):"
	# Contact file
	read contactFile
	if [ "$contactFile" == "X" ]; then ./coevol.sh; exit; fi
	if [ "$contactFile" == "x" ]; then ./coevol.sh; exit; fi
	if [ ! -f $contactFile ]; then echo "No se puede encontrar el archivo ($contactFile)"; exit; fi
	echo "Introduce la cadena a procesar:"
	# List of chains
	read c
	echo "Introduce la carpeta de destino en la que se guardarán los resultados:"
	# Path results
	read pathresults
        if [ ! -d $pathresults ]; then 
		echo "El directorio seleccionado no existe, ¿desea crearlo? (S/n):"
		read crearDirectorioDestino
		case $crearDirectorioDestino in
			"s") mkdir $pathresults;;
			"S") mkdir $pathresults;;
			"n") echo "Fin de la ejecución"; exit;;
			"N") echo "Fin de la ejecución"; exit;;
		esac
	fi
	echo "Introduce el código genético (0 = estándar, 1 = mitocondrial):"
	# Genetic code
	read genCode
	if [ "$genCode" == "1" ]; then genCode="mt"; echo "Código genético mitocondrial seleccionado."
	else genCode="st"; echo "Código genético estándar seleccionado."
	fi 
	echo "Introduce la secuencia de cadenas de contacto (e.g. \"A B C D\"):"
	# Chain contacts
	read contactChains
	formatedContactChains=""
	for chain in $contactChains; do
		formatedContactChains=$(echo ${formatedContactChains}-${chain})
	done
        contactChains=$(echo $formatedContactChains | sed s/^-//g)
	echo
	echo "Generando subgrupos alineados ..."
        echo
	./toMega.sh $contactFile $pdbfile $c $alignment $pathresults $genCode $contactChains
        echo
        echo "Trabajo completado"; exit;;
        
        3)
	clear
	echo "#######################################################"
	echo "# CÁLCULO DE SUMATORIO DE dN                          #"
	echo "#######################################################"
	echo
	echo "Todos los nombres de archivo que se van a procesar deben tener el siguiente formato:"
        echo "mer_\$chain_\$grupo.phy, donde $chain es la cadena y $grupo es el subset"
        echo "Introduce la carpeta donde se encuentran los alineamientos:"
        # Path alignments
	read alignments
        echo "Introduce la cadena:"
        # Chain
        read chain
        if [ "$chain" == "X" ]; then ./coevol.sh; exit; fi
	if [ "$chain" == "x" ]; then ./coevol.sh; exit; fi
        echo "Introduce el código genético (0 = estándar, 1 = mitocondrial):"
        # Genetic code
	read genCode
	if [ "$genCode" == "1" ]; then echo "Código genético mitocondrial seleccionado."
	else echo "Código genético estándar seleccionado."
	fi
        echo "Introduce la carpeta de destino en la que se guardarán los resultados:"
        # Path results
	read pathresults
        if [ ! -d $pathresults ]; then 
		echo "El directorio seleccionado no existe, ¿desea crearlo? (S/n):"
		read crearDirectorioDestino
		case $crearDirectorioDestino in
			"s") mkdir $pathresults;;
			"S") mkdir $pathresults;;
			"n") echo "Fin de la ejecución"; exit;;
			"N") echo "Fin de la ejecución"; exit;;
		esac
	fi
        echo
	echo "Calculando ..."
        echo
        ./paml.sh $chain $genCode $alignments $pathresults
        echo "Trabajo completado:";
        echo "Resultados ($pathresults/k_$chain.txt):"
        cat $pathresults/k_$chain.txt
        exit;
esac