a=0 
while [ $a -lt $1 ]; do
./bt_iteration.sh Set ComplexIV/Alignments/ChainE_aligned.fasta 43 62
let a=a+1
done

rm temp_*
rm *Contact.phy
