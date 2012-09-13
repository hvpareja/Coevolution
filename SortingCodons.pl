#!/usr/bin/perl
# SortingCodons.pl

use strict;
system("clear");

# This code takes a fasta alignment (sequences without gaps and with the same
# length, which is a multiple of 3). The two first entry in this file are binary
# vectors. Ther first one ("Contact") contains as many coordinates as codons
# the aligned sequences, each coordinates will be 0 -> Noncontact, 1 -> Contact.
# The second one (Accessibility) contains the same number of coordenates,
# 0 -> buried, 1 -> expossed. The script sort each codon in each species to
# provide 6 different sets (alignmens):
# mer_chain_Contact, mer_chain_Contact_Expossed, mer_chain_Contact_Buried
# mer_chain_NonContact, mer_chain_NonContact_Expossed, mer_chain_NonContact_Buried

################################################################################
my $ChainID = "A";
my $alignement_file = "/Users/eib/Desktop/Contact_k/Alignments/Amended_COX1_alignment.fas";
################################################################################


open(FILE, "$alignement_file") or die;
my @file = <FILE>;
close FILE;


my @species = grep(/>/, @file);
foreach(@species) {
    chomp $_;
}
shift @species; shift @species; # Removes the first two elements which are no species' names


my $file = join('', @file);

$file =~ s/>.+\n/;/g;
my @seq = split(/;/, $file);
shift(@seq); # Removes the first empty seq

my $Contact_vector = $seq[0];
my @Contact_vector = split('', $Contact_vector); # From scalar to array
my $Accessibility_vector = $seq[1];
my @Accessibility_vector = split('', $Accessibility_vector);

shift(@seq); shift(@seq); # Removes the first two elements which are not Aa seq

open (CONTACT, ">mer_".$ChainID."_Contact.fas") or die;
open (CONTACTBUR, ">mer_".$ChainID."_Contact_Buried.fas") or die print "couldn't";
open (CONTACTEXP, ">mer_".$ChainID."_Contact_Expossed.fas") or die;

open (NONCONTACT, ">mer_".$ChainID."_NonContact.fas") or die;
open (NONCONTACTBUR, ">mer_".$ChainID."_NonContact_Buried.fas") or die;
open (NONCONTACTEXP, ">mer_".$ChainID."_NonContact_Expossed.fas") or die;

chomp $seq[1];
my $sequence_length = length $seq[1]; #### Checking sequence lengths


if ($sequence_length % 3 != 0) {  # Checking the length is a multiple of 3
    print "sequence length is not multiple of 3 \n";
    exit;
}
my $counter;

foreach (@seq) { # Checking the length of each sequence
    $_ =~s/\s+//g; 
    ++$counter;
    if (length $_ != $sequence_length) {
        print "unequal sequence lengths, $counter \n";
        print "Sequence length    ",  $sequence_length, "\t", length $_, "\n";
        exit;
    }
}

my @codon = ();

for (my $i=0; $i<scalar @seq; ++$i) {
    
    print CONTACT $species[$i], "\n";
    print CONTACTBUR $species[$i], "\n";
    print CONTACTEXP $species[$i], "\n";
    print NONCONTACT $species[$i], "\n";
    print NONCONTACTBUR $species[$i], "\n";
    print NONCONTACTEXP $species[$i], "\n";
    
    for (my $j=0; $j < scalar @Contact_vector; ++$j) {
        
        $codon[$j] = substr($seq[$i], 3*$j, 3);
        
        if ($Contact_vector[$j] == 0) {
            print NONCONTACT $codon[$j];
            if ($Accessibility_vector[$j] == 0) {
                print NONCONTACTBUR $codon[$j];
            }
            elsif ($Accessibility_vector[$j] == 1){
                print NONCONTACTEXP $codon[$j]
            }
            else {
                print "Something wrong!"; exit
            }
        }
        elsif ($Contact_vector[$j] == 1){
            print CONTACT $codon[$j];
            if ($Accessibility_vector[$j] == 0) {
                print CONTACTBUR $codon[$j]
            }
            elsif ($Accessibility_vector[$j] == 1) {
                print CONTACTEXP $codon[$j]
            }
            else {
                print "Something wrong!" ; exit
            }
        }
        else {
            print "Something wrong!"; exit
        }  
    }
    print CONTACT "\n";
    print CONTACTBUR "\n";
    print CONTACTEXP "\n";
    print NONCONTACT "\n";
    print NONCONTACTBUR "\n";
    print NONCONTACTEXP "\n";
}

close CONTACT; close CONTACTBUR; close CONTACTEXP; 
close NONCONTACT; close NONCONTACTBUR; close NONCONTACTEXP;

print "\n WORK DONE \n\n";

