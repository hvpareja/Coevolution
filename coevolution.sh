pdbfile=$1
chain=$2

# Calc contacts
perl contact.pl $pdbfile

# Show raw table
# The variable $contact_file is written in system by contact.pl script.
perl rawtable.pl $contact_file $pdbfile $chain