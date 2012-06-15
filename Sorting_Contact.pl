#!/usr/bin/perl -w
# Sorting_Contact.pl
use strict;

# Description ##################################################################
# This script sorts the positions (from species) into 4 sets
# Contact, Noncontact, Burnoncontact, and Expnoncontact
###############################################################################

# Usage: $ ./Sorting_Contact.pl <input1> <input2>

  my $num_args = $#ARGV + 1;
 if ($num_args < 2) {
  print "ERROR: Missing arguments.\nUsage: Sorting_Contact.pl <input1> <input2>\n";
  exit
 }

# Pool of variables ###########################################################

#
my $input_file = $ARGV[0];

# File with alignments
my $align_file = $ARGV[1];


###############################################################################


# Three to one letter translation
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

# File Handling ###############################################################

open (FILE, $input_file) or die $!;
my @Btaurus_Standard = <FILE>;
close FILE;

# Open and handle align file
open (FILE, $align_file) or die $!;
my @file = <FILE>;
close FILE;

my $num = 1;

# Contact file
my $contact_file = "contact_".$num.".txt";
# Non contact file
my $non_contact_file = "non_contact_".$num.".txt";
# Exposed non contact file
my $exp_non_contact_file = "exp_non_contact_".$num.".txt";
#  Buried non contarct file
my $bur_non_contact_file = "bur_non_contact_".$num.".txt";


 while (-e $contact_file){
    
    my $num2 = $contact_file;
    $num2 =~ s/^.*_//g;
    $num2 =~ s/\.txt$//g;   
    
    $num2++;
    
    # Rename if exists
    $contact_file = "contact_".$num2.".txt";
    $non_contact_file = "non_contact_".$num2.".txt";
    $exp_non_contact_file = "exp_non_contact_".$num2.".txt";
    $bur_non_contact_file = "bur_non_contact_".$num2.".txt";
    
 }

open (CONTACT, ">".$contact_file) or die $!;
open (NONCONTACT, ">".$non_contact_file) or die $!;
open (EXPNONCONTACT, ">".$exp_non_contact_file) or die $!;
open (BURNONCONTACT, ">".$bur_non_contact_file) or die $!;

################################################################################

#À?
#open (OUTPUT1, ">Track_Contact.txt") or die print "Couldn't at 37 \n";
#open (OUTPUT2, ">Track_NonContact.txt") or die print "Couldn't at 38 \n";
#open (OUTPUT3, ">Track_ExpNonContact.txt") or die print "Couldn't at 39 \n";
#open (OUTPUT4, ">Track_BurNonContact.txt") or die print "Couldn't at 40 \n";

#  Algorithm ###################################################################

for (my $j=1; $j<28; $j += 2) {
    

      my $number=0;
      
      for (my $i=0; $i<1135; $i += 3){
      # cytb in Bos taurus has 379 Aa, For all other species only the first 379
      #resiudes are considered
         
            $number = $number + 1;    # it gives the position of the residue
           
            my $codon = substr ($file[$j], $i, 3); #$file[1] is the cDNA for B.
            #taurus cytb
            $codon = uc $codon;
            # It makes sure that the codon is written in uppercase
            my $residue = $mt_code{$codon};
            
            my @cadena = split (/\s+/, $Btaurus_Standard[$number]);
            
            #if ($cadena[1] ne $residue) {
            #  print "hasta aqui hemos llegado \n $residue \t $cadena[1] \n";
            #  exit;
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

################################################################################

print "DONE!", "\n";


    
    



