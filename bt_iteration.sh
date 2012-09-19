# Error reporting and usage information
if [ $# -lt 3 ]; then
	echo -e "\nERROR: Any argument is missing."
	echo -e "Usage:"
	echo -e "./bt_iteration.sh <SetName> <AlignFile> <NumContact> <NumNonContact> [<GeneticCode st=standar mt=v. mitochondrial>]\n"
	exit
fi

# Nombre del set
setName=$1

# Alineamiento original
alignFile=$2

# Nœmero de codones de contacto
NumContact=$3

# Nœmero de codones de NO contacto
NumNonContact=$4

# Genetic Code
code="st"
#code=$5

# Paml code
pamlCode=0

# Run:
# RandomSubindices.pl generates 2 temporal files
~/coevolution/./RandomSubindices.pl $NumContact $NumNonContact
~/coevolution/./bt_seqMerge.pl $alignFile temp_Contact $code > ${setName}_Contact.phy
~/coevolution/./bt_seqMerge.pl $alignFile temp_NonContact $code > ${setName}_NonContact.phy

sed s/_INPUTFILE_/${setName}_Contact.phy/g yn00.tpl | sed s/_OUTPUTFILE_/output.txt/g | sed s/_CODE_/${pamlCode}/g > yn00.ctl
/usr/bin/paml4.5/bin/yn00 > /dev/null
contactResult=$(cat output.txt | grep "+-" | grep "[0-9]" | sed 's/\ +-\ /   /g' | ~/coevolution/./bt_calculatesK.pl ${setName}_Contact.phy)

sed s/_INPUTFILE_/${setName}_NonContact.phy/g yn00.tpl | sed s/_OUTPUTFILE_/output.txt/g | sed s/_CODE_/${pamlCode}/g > yn00.ctl
/usr/bin/paml4.5/bin/yn00 > /dev/null
nonContactResult=$(cat output.txt | grep "+-" | grep "[0-9]" | sed 's/\ +-\ /   /g' | ~/coevolution/./bt_calculatesK.pl ${setName}_NonContact.phy)

echo -e "${contactResult}\t${nonContactResult}"

#rm temp_*
#rm *Contact.phy
