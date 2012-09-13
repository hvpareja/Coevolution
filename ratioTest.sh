#!/bin/bash
# Initial setings:
matlabPath="/Applications/MATLAB_R2011a.app"
matlabScript="statRatioTest.m"
# Matlab will be called as following:
# $matlabPath/bin/./matlab -nojvm -nodesktop -r <$script>

# Error reporting and usage information
if [ $# -lt 4 ]; then
	echo -e "\nERROR: Any argument is missing."
	echo -e "Usage:"
	echo -e "./ratioTest.sh <file1> <code1 (0=standar,1=v.mitoch.)> <file2> <code2>\n"
	exit
fi

# Capture filenames
filename1=$1
filename2=$3

# Capture genetic code
code1=$2
code2=$4

# Call yn00 and run calculatesK.pl
    # Escape the bars
    file1=$(echo $filename1 | sed "s/\//\\\\\//g")
    file2=$(echo $filename2 | sed "s/\//\\\\\//g")
    # Create the ctl file1
    sed s/_INPUTFILE_/${file1}/g yn00.tpl | sed s/_OUTPUTFILE_/output1.txt/g | sed s/_CODE_/${code1}/g > yn00.ctl
    # Call yn00 and ignore stdout
    /usr/bin/paml4.5/bin/yn00 > /dev/null
    # Create the ctl file2
    sed s/_INPUTFILE_/${file2}/g yn00.tpl | sed s/_OUTPUTFILE_/output2.txt/g | sed s/_CODE_/${code2}/g > yn00.ctl
    # Call yn00 and ignore stdout
    /usr/bin/paml4.5/bin/yn00 > /dev/null
    
# Store the output data for matlab
cat output1.txt | grep "+-" | grep "[0-9]" | sed 's/\ +-\ /   /g' | ~/coevolution/./calculatesK.pl ${file1} 1 > ratioTestData1.txt
cat output2.txt | grep "+-" | grep "[0-9]" | sed 's/\ +-\ /   /g' | ~/coevolution/./calculatesK.pl ${file2} 1 > ratioTestData2.txt

# Call matlab
$matlabPath/bin/./matlab -nodesktop -nosplash -nodisplay -r "run ./$matlabScript; quit;"

# Merge the resulting figures from matlab script
montage dNplot.png dSplot.png -geometry +4+4 figure.png
open figure.png

# Correlation results
cat temp_matlab_data

# Remove temporal files
rm output1.txt
rm output2.txt
rm ratioTestData1.txt
rm ratioTestData2.txt
rm temp_matlab_data
rm dNplot.png
rm dSplot.png
#rm figure.png

#

# Reset the shell to unlock the keyboard
# (More info: http://www.mathworks.es/support/solutions/en/data/1-CFTJX8/index.html?product=ML)
reset