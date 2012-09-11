chain=$1
code=$2
alignments=$3
path=$4

echo -e "#--------------------------------------------------" > ${path}/k_${chain}.txt
echo -e "#\t\t\t   Chain ${chain}" >> ${path}/k_${chain}.txt
echo -e "#--------------------------------------------------" >> ${path}/k_${chain}.txt
echo -e "#kdN\tdNSE\tkdS\tdSSE\t     Category" >> ${path}/k_${chain}.txt
echo -e "#---\t----\t---\t----\t-------------------" >> ${path}/k_${chain}.txt

echo "# Yang output table ---" > ${path}/YANG_${chain}.txt

for phyle in $(ls ${alignments}/mer_${chain}_*); do
        phyle=$(echo $phyle | sed "s/\//\\\\\//g")
	sed s/_INPUTFILE_/${phyle}/g yn00.tpl | sed s/_OUTPUTFILE_/output.txt/g | sed s/_CODE_/${code}/g > yn00.ctl
	/usr/bin/paml4.5/bin/yn00 > /dev/null
	cat output.txt | grep "+-" | grep "[0-9]" | sed 's/\ +-\ /   /g' | ~/coevolution/./calculatesK.pl ${phyle} >> ${path}/k_${chain}.txt
        echo ${phyle} >> ${path}/YANG_${chain}.txt
        cat output.txt | grep "+-" >> ${path}/YANG_${chain}.txt

done

echo -e "#--------------------------------------------------\n\n" >> ${path}/k_${chain}.txt