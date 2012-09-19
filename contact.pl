#!/usr/bin/perl -w
# contact.pl

use strict;
use warnings;
use Bio::Structure::Model;
use Bio::Structure::IO::pdb;


# Chapter 1
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

# Chapter 2
# Pool of variables ###########################################################
 
 # Distance Threshold
 my $dis_threshold = $ARGV[3]; if(!$ARGV[3]){ $dis_threshold = 4; }
 
 # The output only shows elements where the distance is lower than D. Threshold
 # (see above). But you can switch to 1 this boolean to show all distances:
 my $all_distances = $ARGV[2]; if(!$ARGV[2]){ $all_distances = 0; }

###############################################################################

# Chapter 3
# File Handling ############################################################### 
  my $num_args = $#ARGV + 1;
 if ($num_args < 2) {
  print "ERROR: Missing arguments.\nUsage: contact.pl <pdbfile> <ouputPath> [<all_distances> <dis_threshold>]\n";
  exit;
 }
 
 # Input pdb file (just lines witch begin with "ATOM")
 my $input_file = $ARGV[0];
 my $output_path = $ARGV[1];
 
 $output_path =~ s/\/$//g;
 $output_path = $output_path."/";
 
 my $file_str = $input_file;
    $file_str =~ s/\..*$//g;
    $file_str =~ s/^.*\///g;
 
 # Avoid overwriting files
 my $number = 1;
 
 # File for atom contacts
 my $output_detailed_file = $output_path."detailed_".$file_str."_".$number.".txt";
 # File for residue contacts
 my $output_contact_file = $output_path."contact_".$file_str."_".$number.".txt";
 
 
 while (-e $output_detailed_file){
    
    my $number2 = $output_detailed_file;
    $number2 =~ s/^.*_//g;
    $number2 =~ s/\.txt$//g;   
    
    $number2++;
    
    # File for atom contacts
    $output_detailed_file = $output_path."detailed_".$file_str."_".$number2.".txt";
    # File for residue contacts
    $output_contact_file = $output_path."contact_".$file_str."_".$number2.".txt";
    
 }
     
 open DETAILED, ">".$output_detailed_file or die $!;
 open CONTACT, ">".$output_contact_file or die $!;
 
 my $stream = Bio::Structure::IO->new(-file => $input_file,
                                      -format => 'PDB') or die "\nInvalid pdb file.\n";

################################################################################

# Chapter 4
#  Algorithm ###################################################################

# Send email 
#system("echo 'Starting Job' | mutt -s 'Starting job' hvalverde\@uma.es");

# For each structure in pdb file (just one)
while (my $struc = $stream->next_structure) {
    
    # Models
    my @models = $struc->get_models;
    my @chains = ();
    foreach my $model (@models){
      
      my @chains_model = $struc->get_chains($model);
      # Store all chains from all models in the same array
      push(@chains, @chains_model);
      
    }
    
    # Check number of chains > 1
    if(scalar @chains <= 1){
        
        print "\nThis pdb file contains only one chain. No contact detected with other chains.\n";
        exit;
        
    }
    
    # For each chain
    for(my $i=0;$i<scalar @chains;$i++){
        
        # Chain
        my $chain = $chains[$i];
        
        # Chain identifier
        my $chainid = $chain->id;
        
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
                                
                                print DETAILED $chain->id."\t".$chain2->id."\t".$atom->serial()." (".$atom->id."-".$res->id.")\t".$atom2->serial()." (".$atom2->id."-".$res2->id.")\t".$distance."\n";
                                print CONTACT $res->id."\t".$chain->id."\t".$res2->id."\t".$chain2->id."\n";
                                
                            }else{
                                # Print if < $dis_threshold
                                if($distance < $dis_threshold){
                                
                                    print DETAILED $chain->id."\t".$chain2->id."\t".$atom->serial()." (".$atom->id."-".$res->id.")\t".$atom2->serial()." (".$atom2->id."-".$res2->id.")\t".$distance."\n";
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

################################################################################

close DETAILED; close CONTACT;

# Chapter 5
# File Cleaning ################################################################

# The Contact_1BE3_Set.txt file contain many repeted elements. For instance,
# when different atoms from a residue (say Met1) are closed to
# different atoms from other residues (say Leu34), we will obtain the same line
# repeted: Met1 Leu34, Met1 Leu34). So, with the
# following code lines we try to removed such repetitions.

open (FILE, $output_contact_file) or die $!;
my @array = <FILE>;
close FILE;

# The array is converted in a hash, giving to each element (key) the value 1
my %hash = map {$_, 1} @array;
# In this way the new_array doesn't contain contain duplicated elements
my @new_array = keys %hash; 

open (OUTPUT, ">".$output_contact_file) or die $!;
# This will order the chain A residues according to the primary structure.
print OUTPUT sort {$a cmp $b} (@new_array);   
# A warning saying something like "Argument whatever isn't numeric" will appear.
# Just ignore it
close OUTPUT;

print "The work has been successfully completed \n\n See $output_contact_file and $output_detailed_file files \n\n";
# Store the name of the files
#system("contact_file=$output_contact_file");
#system("detailed_file=$output_detailed_file");
# Email when finish
system("echo 'The work has been successfully completed \n\n See $output_contact_file and $output_detailed_file files \n\n' | mail -s 'Finish contact job' \$email");
exit;

################################################################################
# END