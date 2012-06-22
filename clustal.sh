
# Error reporting and usage information
if [ $# -lt 1 ]; then
	echo -e "\nERROR: Input file is missing."
	echo -e "Usage:"
	echo -e "./clustal.sh <input_fasta_file>\n"
	exit
fi

input_fasta_file=$1

if [ ! -f $input_fasta_file ]; then
	echo -e "\nERROR: Input file does not exist."
	echo -e "Usage:"
	echo -e "./clustal.sh <input_fasta_file>\n"
	exit
fi

file=$(echo $input_fasta_file | sed "s/\.txt//g" )
output_fasta_file=$(echo ${file} | sed "s/^.*\///g")


clustalw -infile=$input_fasta_file -outfile=${output_fasta_file}_aligned.fa -output=pir -outorder=input

clear
echo -e "\nCLUSTAL REPORT:\n"
echo "${output_fasta_file}_aligned.fa has been created"
rm ${file}.dnd
echo "NOTICE: ${file}.dnd has been removed"
