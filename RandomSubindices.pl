#!/usr/bin/perl -w
# RandomSubindices.pl

use strict;
use warnings;


# Description ##################################################################
# This script writes a set of subindices ("Pseudocontact_Subindices_X.txt") which is   
# randomly generated, and the complementary set ("Pseudononcontact.Subindices.X.txt
# The size of these sets should be introduced as a parameters ($c and $nc, respectively 
# The identity of X is the third parameter that need to be introduced.
###############################################################################
my $chain = "B"; # Chain id;
my $c = $ARGV[0]; # Number of contact codons
my $nc = $ARGV[1]; # Number of non-contact codons




#system ('clear');

my @random_subindices;
my @pseudo_noncontact;
my $k;

#open (RPC, ">Random_PseudoContact_".$chain.".txt") or die print "Couldn't at \n";
#open (RPNC, ">Random_PseudoNoncontact_".$chain.".txt") or die print "Couldn't at \n";

open (RPC, ">temp_Contact") or die print "Couldn't at \n";
open (RPNC, ">temp_NonContact") or die print "Couldn't at \n";

do { # $c is the number of codons that have to be withdrawn from each gene
        
    my $random_codon_number = int(rand($c+$nc)) + 1;
    
    my @repeted = grep(/$random_codon_number/, @random_subindices);
    
    if (!@repeted) {
        push(@random_subindices, $random_codon_number);
        ++$k;
    }
    
} until ($k == $c);

for (my $i=1; $i < $c+$nc+1; ++$i) {
       
        my @found = grep(/^$i$/, @random_subindices);
        
        if (!@found) {
            push(@pseudo_noncontact, $i);
        }
    
}

foreach (@random_subindices) {print RPC $_, "\n"};
foreach (@pseudo_noncontact) {print RPNC $_, "\n"};
        
# print "\n\n The files have been sucesfully saved \n\n";


  
   
