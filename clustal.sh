
input_fasta_file=$1
file=$(echo $input_fasta_file | sed "s/\.txt//g" )
output_fasta_file=$(echo ${file} | sed "s/^.*\///g")


clustalw -infile=$input_fasta_file -outfile=${output_fasta_file}_aligned.fa -output=pir

rm ${file}.dnd

echo "NOTICE: ${file}.dnd has been removed"
