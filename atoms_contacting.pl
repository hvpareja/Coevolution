#!/usr/bin/perl -w
# atoms_contacting.pl

my $input_file = $ARGV[0];

############### CONTACTING ATOMS
# This script gives the number of atoms interacting with each chain C (chain X, in general) residue

open (FILE, $input_file);
@file = <FILE>;
close FILE;

# This loop stores contact residues
for ($i=0; $i<scalar @file; $i++){
    @cadena = split (/\t+/,$file[$i]);
    if(!$cadena[3]){ next; }
    my $res = $cadena[3];
    $res =~ s/.*-//g;
    $res =~ s/[^0-9]//g;
    #push (@residuo, $res, "\n");
    print $res."\n";
}


for ($i=1; $i<380; $i++) {
    $counter = 0;
    
    for ($j=0; $j<scalar @residuo; ++$j) {
        chomp $residuo[$j];
        
        if ($residuo[$j] == $i) {
            ++$counter;
        }
    }
    
    unless ($counter == 0) {
        print $i, "\t", $counter, "\n";
    }
    
}

############### CONTACTING RESIDUES
# This script give the number of different residues contacting with each chain C (in general chain X) residue
# The document temp.txt can be provided by "ChainC_Contact_2bc1.Set.txt" with minor mofifications.

#open (FILE, "temp.txt") or die print "Couldn't at 34";
#@file =<FILE>;
#close FILE;
#
#for ($i=0; $i<scalar @file; ++$i) {
#    @cadena = split (/\s+/, $file[$i]);
#    push (@residue, $cadena[0]);
#}
#    
#for ($i=1; $i<380; ++$i) {
#    $counter = 0;
#    
#    for ($j=0; $j<scalar @residue; ++$j) {
#        chomp $residue[$j];
#        
#        if ($residue[$j] == $i) {
#            ++$counter;
#        }
#    }
#    unless ($counter == 0) {
#        print $i, "\t", $counter, "\n";
#    }
#    
#}


####################### FULL LIST
# The previous scripts privede list with the chain C residues involved in contact. The following code
# adds those chain C residues that are not involved in contacts together with the number 0 to indicate this fact.
# The file name.txt must be settle to contain: "residue tab number contacts". This information is provided
# by the above code.


#open (FILE, "name.txt");
#@file = <FILE>;
#close FILE;
#
#open (OUTPUT, ">Residue/Atom_conctac.txt") or die print "Couldn't at 7 \n";
#
#
#
#for ($i=1; $i<380; ++$i) {
#    
#    $control = 0;
#    
#    for ($j=0; $j< scalar @file; ++$j) {
#    
#        @cadena = split (/\s+/, $file[$j]);
#        
#        if ($i == $cadena[0]) {
#            print OUTPUT $i, "\t", $cadena[1], "\n";
#            $control = 1;
#        }
#    }
#    
#    if ($control == 0) {
#        print OUTPUT $i, "\t", 0, "\n";
#    }
#    
#}
#
#close OUTPUT;
