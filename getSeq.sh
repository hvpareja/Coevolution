
# Error reporting and usage information
if [ $# -lt 1 ]; then
	echo -e "\nERROR: Any argument is missing."
	echo -e "Usage:"
	echo -e "./getSeq.sh <SequenceID>"
	exit
fi

sequenceID=$1

curl -s "http://www.ncbi.nlm.nih.gov/sviewer/viewer.fcgi?val=${sequenceID}&db=nuccore&dopt=fasta&extrafeat=0&fmt_mask=0&maxplex=1&sendto=t&withmarkup=on&log$=seqview&maxdownloadsize=1000000"
