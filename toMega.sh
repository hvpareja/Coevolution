
# Error reporting and usage information
if [ $# -lt 5 ]; then
	echo -e "\nERROR: Any argument is missing."
	echo -e "Usage:"
	echo -e "./toMega.sh <contact_file> <pdb_file> <chain> <align_file> <mega_path> [<Gene_code (st=standard -default- or mt=mitochondrial> <ChainList>]\n"
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
gene_code=$6

# Output path
mega_path=$5

# Chain list
listChains=$7
~/coevolution/./rawtable.pl $contact_file $pdb_file $chain $listChains > temp_raw
clear

cat temp_raw | ~/coevolution/./seqMerge.pl $align_file $gene_code > ${mega_path}mer_${chain}_Total.phy
cat temp_raw | grep -P '^.\t.*\t[0-9]*\t[A-Z]\t1' | ~/coevolution/./seqMerge.pl $align_file $gene_code > ${mega_path}mer_${chain}_Contact.phy
cat temp_raw | grep -P '^.\t.*\t[0-9]*\t[A-Z]\t0' | ~/coevolution/./seqMerge.pl $align_file $gene_code > ${mega_path}mer_${chain}_NonContact.phy
cat temp_raw | grep -P '^.\t.*\t[0-9]*\t[A-Z]\t1\t0' | ~/coevolution/./seqMerge.pl $align_file $gene_code > ${mega_path}mer_${chain}_ContactBuried.phy
cat temp_raw | grep -P '^.\t.*\t[0-9]*\t[A-Z]\t1\t1' | ~/coevolution/./seqMerge.pl $align_file $gene_code > ${mega_path}mer_${chain}_ContactExposed.phy
cat temp_raw | grep -P '^.\t.*\t[0-9]*\t[A-Z]\t0\t0' | ~/coevolution/./seqMerge.pl $align_file $gene_code > ${mega_path}mer_${chain}_NonContactBuried.phy
cat temp_raw | grep -P '^.\t.*\t[0-9]*\t[A-Z]\t0\t1' | ~/coevolution/./seqMerge.pl $align_file $gene_code > ${mega_path}mer_${chain}_NonContactExposed.phy

echo "Contact: "
cat temp_raw | grep -P '^.\t.*\t[0-9]*\t[A-Z]\t1'
echo "Non Contact: "
cat temp_raw | grep -P '^.\t.*\t[0-9]*\t[A-Z]\t0'
echo "Contact Buried: "
cat temp_raw | grep -P '^.\t.*\t[0-9]*\t[A-Z]\t1\t0'
echo "Contact Exposed: "
cat temp_raw | grep -P '^.\t.*\t[0-9]*\t[A-Z]\t1\t1'
echo "Non Contact Buried: "
cat temp_raw | grep -P '^.\t.*\t[0-9]*\t[A-Z]\t0\t0'
echo "Non Contact Exposed: "
cat temp_raw | grep -P '^.\t.*\t[0-9]*\t[A-Z]\t0\t1'

echo "Contact: "
cat temp_raw | grep -P '^.\t.*\t[0-9]*\t[A-Z]\t1' | wc -l
echo "Non Contact: "
cat temp_raw | grep -P '^.\t.*\t[0-9]*\t[A-Z]\t0' | wc -l
echo "Contact Buried: "
cat temp_raw | grep -P '^.\t.*\t[0-9]*\t[A-Z]\t1\t0' | wc -l
echo "Contact Exposed: "
cat temp_raw | grep -P '^.\t.*\t[0-9]*\t[A-Z]\t1\t1' | wc -l
echo "Non Contact Buried: "
cat temp_raw | grep -P '^.\t.*\t[0-9]*\t[A-Z]\t0\t0' | wc -l
echo "Non Contact Exposed: "
cat temp_raw | grep -P '^.\t.*\t[0-9]*\t[A-Z]\t0\t1' | wc -l

rm temp_raw

echo "Files generated: "
echo "${mega_path}..."
echo "mer_${chain}_Contact.phy"
echo "mer_${chain}_NonContact.phy"
echo "mer_${chain}_ContactBuried.phy"
echo "mer_${chain}_ContactExposed.phy"
echo "mer_${chain}_NonContactBuried.phy"
echo "mer_${chain}_NonContactExposed.phy"
