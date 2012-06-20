#!/usr/bin/perl -w
# seqMerge.pl


use warnings;
use Bio::SeqIO;

# Chapter 1
# Description ##################################################################
# This script returns to STDOUT a set of sequences in align fasta format. Each
# one is the result of the concatenated codons speficied in <setFile>
################################################################################

# Usage: ./seqMerge.pl <setFile> <AlignFile>
  my $num_args = $#ARGV + 1;
 if ($num_args < 2) {
  print "ERROR: Missing arguments.\nUsage: ./seqMerge.pl <setFile> <AlignFile>\n";
  exit;
 }
 
# Chapter 2
# File handle ##################################################################
# Input set_file
my $set_file = $ARGV[0];
open LIST, $set_file;
# Extract in @list the codons within the set
while (my $line = <LIST>) {
    $line =~ s/^..//g;
    $line =~ s/....$//g;
    $line =~ s/\n//g;
    push(@list, $line);
}
# Input AlignFile
my $align_file = $ARGV[1];
my $stream = Bio::SeqIO->new(-file => $align_file);
################################################################################

# Chapter 3
# Data proccess ################################################################

# For each sequence
while (my $seq = $stream->next_seq) {
    
    my $merge_seq = "";
    
    # For each codon in LIST
    for my $codon (@list){
        
        my $codon_no = $codon-1;
        
        # Concatenate (uc = upper case)
        $merge_seq = $merge_seq.substr(uc($seq->seq),$codon_no*3,3);
        
        #print "($codon, ".substr(uc($seq->seq),$codon_no*3,3).")\n";
        
    }
    
    print ">".$seq->id."\n";
    print $merge_seq."\n";
    
}

################################################################################