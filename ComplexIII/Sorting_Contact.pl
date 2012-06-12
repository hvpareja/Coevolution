#!/usr/bin/perl
# Sorting_Contact.pl
use strict;

# This script sorts the Cytb positions (from 13 mammalian species) into 4 sets
# Contact, Noncontact, Burnoncontact, and Expnoncontact

my (%mt_code) =  (
    'TCA' => 'S',           'TCC' => 'S',    'TCG' => 'S',        'TCT' => 'S',
    'TTC' => 'F',           'TTT' => 'F',    'TTA' => 'L',        'TTG' => 'L',
    'TAC' => 'Y',           'TAT' => 'Y',    'TAA' => '_',        'TAG' => '_',
    'TGC' => 'C',           'TGT' => 'C',    'TGA' => 'W',        'TGG' => 'W',
    'CTA' => 'L',           'CTC' => 'L',    'CTG' => 'L',        'CTT' => 'L',
    'CCA' => 'P',           'CCC' => 'P',    'CCG' => 'P',        'CCT' => 'P',
    'CAC' => 'H',           'CAT' => 'H',    'CAA' => 'Q',        'CAG' => 'Q',
    'CGA' => 'R',           'CGC' => 'R',    'CGG' => 'R',        'CGT' => 'R',
    'ATA' => 'M',           'ATC' => 'I',    'ATT' => 'I',        'ATG' => 'M',
    'ACA' => 'T',           'ACC' => 'T',    'ACG' => 'T',        'ACT' => 'T',
    'AAC' => 'N',           'AAT' => 'N',    'AAA' => 'K',        'AAG' => 'K',
    'AGC' => 'S',           'AGT' => 'S',    'AGA' => '_',        'AGG' => 'W',
    'GTA' => 'V',           'GTC' => 'V',    'GTG' => 'V',        'GTT' => 'V',
    'GCA' => 'A',           'GCC' => 'A',    'GCG' => 'A',        'GCT' => 'A',
    'GAC' => 'D',           'GAT' => 'D',    'GAA' => 'E',        'GAG' => 'E',
    'GGA' => 'G',           'GGC' => 'G',    'GGG' => 'G',        'GGT' => 'G',
 );

open (FILE, "Cytb_Btaurus.txt") or die print "Couldn't at 7 \n";
my @Btaurus_Standard = <FILE>;
close FILE;

open (FILE, "ChainC_1be3_cDNA_Alig.fas") or die print "Couldn't at 11 \n";
my @file = <FILE>;
close FILE; 

open (CONTACT, ">Cytb_Contact.txt") or die print "Couldn't at 32 \n";
open (NONCONTACT, ">Cytb_Noncontact.txt") or die print "Couldn't at 33 \n";
open (EXPNONCONTACT, ">Cytb_Exp_Noncontact.txt") or die print "Couldn't at 34 \n";
open (BURNONCONTACT, ">Cytb_Bur_Noncontact.txt") or die print "Couldn't at 35 \n";

#open (OUTPUT1, ">Track_Contact.txt") or die print "Couldn't at 37 \n";
#open (OUTPUT2, ">Track_NonContact.txt") or die print "Couldn't at 38 \n";
#open (OUTPUT3, ">Track_ExpNonContact.txt") or die print "Couldn't at 39 \n";
#open (OUTPUT4, ">Track_BurNonContact.txt") or die print "Couldn't at 40 \n";

for (my $j=1; $j<28; $j += 2) {
    

my $number=0;

for (my $i=0; $i<1135; $i += 3){ # cytb in Bos taurus has 379 Aa, For all other species only the first 379 resiudes are considered
   
      $number = $number + 1;    # it gives the position of the residue
     
      my $codon = substr ($file[$j], $i, 3); #$file[1] is the cDNA for B. taurus cytb
      $codon = uc $codon; # It makes sure that the codon is written in uppercase
      my $residue = $mt_code{$codon};
      
      my @cadena = split (/\s+/, $Btaurus_Standard[$number]);
      
      #if ($cadena[1] ne $residue) {
      #  print "hasta aqui hemos llegado \n $residue \t $cadena[1] \n"; exit;
      #}
     
        if ($cadena[3] != 0) {
            print CONTACT $codon;
            #print OUTPUT1 $number, "\t";
        }
        elsif ($cadena[3] == 0) {
            print NONCONTACT $codon;
            #print OUTPUT2 $number, "\t";
            
            if ($cadena[2] eq "Exposed") {
                print EXPNONCONTACT $codon;
                #print OUTPUT3 $number, "\t";
            }
            elsif ($cadena[2] eq "Buried") {
                print BURNONCONTACT $codon;
                #print OUTPUT4 $number, "\t";
            }
        }
        else { print "Something is awfully wrong \n"; exit
        }      
}
print CONTACT "\n> \n";
print NONCONTACT "\n> \n";
print EXPNONCONTACT "\n> \n";
print BURNONCONTACT "\n> \n";

}
system ("clear");
print "DONE!", "\n";


    
    



