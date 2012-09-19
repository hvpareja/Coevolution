# Error reporting and usage information

if [ $# -lt 1 ]; then
	echo -e "\nERROR: Any argument is missing."
	echo -e "Usage:"
	echo -e "./launchPM.sh <PDBfile> \n"
	exit
fi

inputpdbfile=$1

pymol $inputpdbfile script1.pml -g output.png -c > /dev/null