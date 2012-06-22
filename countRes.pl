#!/usr/bin/perl -w
# countRes.pl

use strict;
use warnings;
use Bio::Structure::Model;
use Bio::Structure::IO::pdb;

  my $num_args = $#ARGV + 1;
 if ($num_args < 1) {
  print "ERROR: Missing arguments.\nUsage: countRes.pl <pdbfile>\n";
  exit;
 }
 
 my $input_file = $ARGV[0];
 
 my $stream = Bio::Structure::IO->new(-file => $input_file,
                                      -format => 'PDB') or die "\nInvalid pdb file.\n";
 
 while (my $struc = $stream->next_structure) {
    
    # Models
    my @models = $struc->get_models;
    my @chains = ();
    foreach my $model (@models){
      
      my @chains_model = $struc->get_chains($model);
      # Store all chains from all models in the same array
      push(@chains, @chains_model);
      
    }
    
    foreach my $chain (@chains){
        
        my @res = $struc->get_residues($chain);
        
        print "Chain ".$chain->id.": ".scalar @res." residues.\n";
        
    }
    
 }