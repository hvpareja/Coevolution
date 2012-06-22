
# Error reporting and usage information
if [ $# -lt 4 ]; then
	echo -e "\nERROR: Any argument is missing."
	echo -e "Usage:"
	echo -e "./toMega.sh <contact_file> <pdb_file> <chain> <align_file>\n"
	exit
fi

# Contact file from contact.pl
contact_file=$1

# Path to pdb file
pdb_file=$2

# Chain to process
chain=$3

# Fasta file with aligned nucleotide sequence for this chain
align_file=$4

~/coevolution/./rawtable.pl $contact_file $pdb_file $chain | grep -P '^.\t[0-9]*\t1' | ~/coevolution/./seqMerge.pl $align_file > mer_${chain}_Contact.fa
~/coevolution/./rawtable.pl $contact_file $pdb_file $chain | grep -P '^.\t[0-9]*\t0' | ~/coevolution/./seqMerge.pl $align_file > mer_${chain}_NonContact.fa
~/coevolution/./rawtable.pl $contact_file $pdb_file $chain | grep -P '^.\t[0-9]*\t1\t0' | ~/coevolution/./seqMerge.pl $align_file > mer_${chain}_ContactBuried.fa
~/coevolution/./rawtable.pl $contact_file $pdb_file $chain | grep -P '^.\t[0-9]*\t1\t1' | ~/coevolution/./seqMerge.pl $align_file > mer_${chain}_ContactExposed.fa
~/coevolution/./rawtable.pl $contact_file $pdb_file $chain | grep -P '^.\t[0-9]*\t0\t0' | ~/coevolution/./seqMerge.pl $align_file > mer_${chain}_NonContactBuried.fa
~/coevolution/./rawtable.pl $contact_file $pdb_file $chain | grep -P '^.\t[0-9]*\t0\t1' | ~/coevolution/./seqMerge.pl $align_file > mer_${chain}_NonContactExposed.fa

clear

echo "Files generated: "
echo "mer_${chain}_Contact.fa"
echo "mer_${chain}_NonContact.fa"
echo "mer_${chain}_ContactBuried.fa"
echo "mer_${chain}_ContactExposed.fa"
echo "mer_${chain}_NonContactBuried.fa"
echo "mer_${chain}_NonContactExposed.fa"
