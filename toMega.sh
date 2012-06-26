
# Error reporting and usage information
if [ $# -lt 4 ]; then
	echo -e "\nERROR: Any argument is missing."
	echo -e "Usage:"
	echo -e "./toMega.sh <contact_file> <pdb_file> <chain> <align_file> [<Gene_code (st=standard -default- or mt=mitochondrial>]\n"
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

# Genetic code
gene_code=$5

~/coevolution/./rawtable.pl $contact_file $pdb_file $chain > temp_raw
clear

cat temp_raw | ~/coevolution/./seqMerge.pl $align_file $gene_code
cat temp_raw | grep -P '^.\t[0-9]*\t[A-Z]\t1' | ~/coevolution/./seqMerge.pl $align_file $gene_code > MegaDATA/mer_${chain}_Contact.fa
cat temp_raw | grep -P '^.\t[0-9]*\t[A-Z]\t0' | ~/coevolution/./seqMerge.pl $align_file $gene_code > MegaDATA/mer_${chain}_NonContact.fa
cat temp_raw | grep -P '^.\t[0-9]*\t[A-Z]\t1\t0' | ~/coevolution/./seqMerge.pl $align_file $gene_code > MegaDATA/mer_${chain}_ContactBuried.fa
cat temp_raw | grep -P '^.\t[0-9]*\t[A-Z]\t1\t1' | ~/coevolution/./seqMerge.pl $align_file $gene_code > MegaDATA/mer_${chain}_ContactExposed.fa
cat temp_raw | grep -P '^.\t[0-9]*\t[A-Z]\t0\t0' | ~/coevolution/./seqMerge.pl $align_file $gene_code > MegaDATA/mer_${chain}_NonContactBuried.fa
cat temp_raw | grep -P '^.\t[0-9]*\t[A-Z]\t0\t1' | ~/coevolution/./seqMerge.pl $align_file $gene_code > MegaDATA/mer_${chain}_NonContactExposed.fa

echo "Contact: "
cat temp_raw | grep -P '^.\t[0-9]*\t[A-Z]\t1' | wc -l
echo "Non Contact: "
cat temp_raw | grep -P '^.\t[0-9]*\t[A-Z]\t0' | wc -l
echo "Contact Buried: "
cat temp_raw | grep -P '^.\t[0-9]*\t[A-Z]\t1\t0' | wc -l
echo "Contact Exposed: "
cat temp_raw | grep -P '^.\t[0-9]*\t[A-Z]\t1\t1' | wc -l
echo "Non Contact Buried: "
cat temp_raw | grep -P '^.\t[0-9]*\t[A-Z]\t0\t0' | wc -l
echo "Non Contact Exposed: "
cat temp_raw | grep -P '^.\t[0-9]*\t[A-Z]\t0\t1' | wc -l

rm temp_raw

echo "Files generated: "
echo "MegaDATA/..."
echo "mer_${chain}_Contact.fa"
echo "mer_${chain}_NonContact.fa"
echo "mer_${chain}_ContactBuried.fa"
echo "mer_${chain}_ContactExposed.fa"
echo "mer_${chain}_NonContactBuried.fa"
echo "mer_${chain}_NonContactExposed.fa"
