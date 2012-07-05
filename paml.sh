
phyle=$1
code=$2

sed s/_INPUTFILE_/${phyle}/g yn00.tpl | sed s/_OUTPUTFILE_/output.txt/g | sed s/_CODE_/${code}/g > yn00.ctl; bin/yn00; cat output.txt | grep "+-" | grep "[0-9]" | cut -c 52-67 | sed 's/\ +-\ /   /g' | ./calculatesK.pl ${phyle}
