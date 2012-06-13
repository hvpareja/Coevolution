#!/usr/bin/perl -w
# contact.pl

use strict;
use warnings;
use Bio::Structure::Model;
use Bio::Structure::IO::pdb;

# Description ##################################################################
# This script reads a PDB file and calculates the distance between each atom
# from distinct chains.
# It return two files:
# FILE 1: detailed_file.txt ->
# a table with the following structure (header):
# Chain1|Chain2|AtomNumber(ResidueNumber)1|AtomNumber(ResidueNumber)2|Distance(A)
# FILE 2: contact_file.txt ->
# A table with the contact between residues insead atoms
###############################################################################

# Pool of variables ###########################################################

 my $num_args = $#ARGV + 1;
 if ($num_args != 1) {
  print "ERROR: Missing arguments.\nUsage: contact.pl <pdbfile>\n";
  exit;
 }
 
 # Input pdb file (just lines witch begin with "ATOM")
 my $input_file = $ARGV[0];
 
 my $file_str = $input_file;
    $file_str =~ s/\..*$//g;
    $file_str =~ s/^.*\///g;
 
 # File for atom contacts
 my $output_detailed_file = ">detailed_".$file_str.".txt";
 print $output_detailed_file;
 open DETAILED, $output_detailed_file or die $!;
 
 # File for residue contacts
 my $output_contact_file = ">contact_".$file_str.".txt";
 open CONTACT, $output_contact_file or die $!;
 
 # Distance Threshold
 my $dis_threshold = 4;
 
 # The output only shows elements where the distance is lower than D. Threshold
 # (see above). But you can switch to 1 this boolean to show all distances:
 my $all_distances = 0;

###############################################################################
 
my $stream = Bio::Structure::IO->new(-file => $input_file,
                                      -format => 'PDB');

# For each structure in pdb file (just one)
while (my $struc = $stream->next_structure) {
    
    # All chains
    my @chains = $struc->get_chains;
    
    # For each chain
    for(my $i=0;$i<scalar @chains;$i++){
        
        # Chain
        my $chain = $chains[$i];
        
        # Chain identifier
        my $chainid = $chain->id;
        print DETAILED "Chain ".$chainid."\n";
        
        # For remaining chains
        for (my $j=$i+1;$j<scalar @chains;$j++){
            
            # Do not compare with it self
            if ($j eq $i){ $j++; }
            
            # Chain 2
            my $chain2 = $chains[$j];
            
            # For each residue from Chain
            for my $res ($struc->get_residues($chain)) {
                
                # For each atom from Chain
                for my $atom ($struc->get_atoms($res)){
                    
                    # For each residue from Chain2
                    for my $res2 ($struc->get_residues($chain2)) {
                
                         # For each atom from Chain2
                        for my $atom2 ($struc->get_atoms($res2)){
                    
                            # Distance
                            my $distance = sqrt( ($atom->x()-$atom2->x())**2 +
                                              ($atom->y()-$atom2->y())**2 +
                                              ($atom->z()-$atom2->z())**2 );
                            
                            # Print always
                            if($all_distances){
                                
                                print DETAILED $chain->id."\t".$chain2->id."\t".$atom->serial()." (".$atom->id."-".$res->id.")\t".$atom2->serial()." (".$atom->id."-".$res2->id.")\t".$distance."\n";
                                print CONTACT $res->id."\t".$chain->id."\t".$res2->id."\t".$chain2->id."\n";
                                
                            }else{
                                # Print if < $dis_threshold
                                if($distance < $dis_threshold){
                                
                                    print DETAILED $chain->id."\t".$chain2->id."\t".$atom->serial()." (".$atom->id."-".$res->id.")\t".$atom2->serial()." (".$atom->id."-".$res2->id.")\t".$distance."\n";
                                    print CONTACT $res->id."\t".$chain->id."\t".$res2->id."\t".$chain2->id."\n";
                                    
                                }
                            }
                    
                        }
                
                    }
                    
                }
                
            }
              
        }
        
    }
    
}

close DETAILED; close CONTACT;