#!/usr/bin/perl -w
# seqMerge.pl


use warnings;
use Bio::SeqIO;

# Chapter 0
# Description ##################################################################
# This script returns to STDOUT a set of sequences aligned. Each
# one is the result of the concatenated codons speficied in <setFile>
################################################################################
# Debuggin
# Turn this variable to 1 to print WARNINGS if any codon translation is wrong.
my $warning = 0;
################################################################################
################################################################################

# Chapter 1
# Input validation #############################################################
# Usage information. If any argument is missing, the program will exit.
# <STDIN> must contain the table from ./rawtable.pl script. This one contains
# the data about the contact and non contact residues.
################################################################################

# Usage: <STDIN> ./seqMerge.pl <AlignFile> [<GeneticCode>]
  my $num_args = $#ARGV + 1;
 if ($num_args < 1) {
  print "ERROR: Missing arguments.\nUsage: <STDIN> | ./seqMerge.pl <AlignFile> [<GeneticCode (st=standar OR mt=mitochondrial)>]\n";
  exit;
 }
 
 # Genetic Code validation
my $gen_code = $ARGV[1];
if(!$gen_code){ $gen_code = 'st'; }
if($gen_code ne 'mt' && $gen_code ne 'st'){
    
    print "\nERROR: Missing or invalid argument: '<GeneticCode> (st=standar OR mt=mitochondrial)'";
    print "\nUsage: <STDIN> | ./seqMerge.pl <AlignFile> [<GeneticCode (st=standar OR mt=mitochondrial)>]\n";
  exit;
    
}
################################################################################
################################################################################

# Chapter 2
# Auxiliary data   #############################################################
# Genetic codes
################################################################################
# Three to one letter translation
my %mt_code =  (
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

my %standard_code =  (
    'TCA' => 'S',           'TCC' => 'S',    'TCG' => 'S',        'TCT' => 'S',
    'TTC' => 'F',           'TTT' => 'F',    'TTA' => 'L',        'TTG' => 'L',
    'TAC' => 'Y',           'TAT' => 'Y',    'TAA' => '_',        'TAG' => '_',
    'TGC' => 'C',           'TGT' => 'C',    'TGA' => '_',        'TGG' => 'W',
    'CTA' => 'L',           'CTC' => 'L',    'CTG' => 'L',        'CTT' => 'L',
    'CCA' => 'P',           'CCC' => 'P',    'CCG' => 'P',        'CCT' => 'P',
    'CAC' => 'H',           'CAT' => 'H',    'CAA' => 'Q',        'CAG' => 'Q',
    'CGA' => 'R',           'CGC' => 'R',    'CGG' => 'R',        'CGT' => 'R',
    'ATA' => 'I',           'ATC' => 'I',    'ATT' => 'I',        'ATG' => 'M',
    'ACA' => 'T',           'ACC' => 'T',    'ACG' => 'T',        'ACT' => 'T',
    'AAC' => 'N',           'AAT' => 'N',    'AAA' => 'K',        'AAG' => 'K',
    'AGC' => 'S',           'AGT' => 'S',    'AGA' => 'R',        'AGG' => 'R',
    'GTA' => 'V',           'GTC' => 'V',    'GTG' => 'V',        'GTT' => 'V',
    'GCA' => 'A',           'GCC' => 'A',    'GCG' => 'A',        'GCT' => 'A',
    'GAC' => 'D',           'GAT' => 'D',    'GAA' => 'E',        'GAG' => 'E',
    'GGA' => 'G',           'GGC' => 'G',    'GGG' => 'G',        'GGT' => 'G',
 );

################################################################################
################################################################################

# Chapter 3
# Extract data from STDIN ######################################################
# Put the contact information into arrays.
################################################################################
# Extract in @list the codons within the set
# Extract in @aas the residues encoded.
my @list = ();
while (my $line = <STDIN>) {
    
    # Avoid header from Raw Table
    if(!(grep(/^#/,$line))){
    
        my @columns = split(/\t/,$line);
        
        my $num = $columns[2];
        my $aa = $columns[3];
        
        
        push(@aas, $aa);
        push(@list, $num);
        
    }
    
}

# Order by num
@list = sort {$a <=> $b} @list;

# Input AlignFile
my $align_file = $ARGV[0];
# Read sequences with BioPerl
# See API: http://doc.bioperl.org/releases/bioperl-1.6.1/
my $stream = Bio::SeqIO->new(-file => $align_file);
my $stream2 = Bio::SeqIO->new(-file => $align_file);

# Count number of sequences
my $num_sequences = 0;
while (my $seq2 = $stream2->next_seq) {
    $num_sequences++;
}

################################################################################
################################################################################

# Chapter 3
# Proccess #####################################################################
# For each sequence, take triplets according to the set in Raw Table
################################################################################

# For each sequence
my $sequence_number = 0;
my $ref_sequence = "";
my @new_list = ();
while (my $seq = $stream->next_seq) {
    
    
    # Current entire sequence
    my $sequence = $seq->seq;
    # Current merge sequence
    my $merge_seq = "";
    # The array with the codons
    my @all_triplets = ();
    # If there is not correspondence with the firs sequence (caused by insertions),
    # the codon is deleted
    my $eliminated_codons = 0;
    
        
# IF ###########################################################################
# Specie = Bos taurus (the first one)
################################################################################

        if($sequence_number == 0){
            
            # For each number in the set (@list)
            for($codon=0;$codon < scalar @list;$codon++){
                
                # While the set begins from 1, the string begins from 0
                my $codon_no = $list[$codon]-1;
                
                # Shift (number of gaps before the current position)
                my $shift = 0;
                
                # Sequence before the current position
                my $previous_seq = substr(uc($sequence),0,($codon_no*3));
                
                # Count the number of gaps
                while (scalar @{[$previous_seq =~ /-/g]} > $shift){
                    $shift++;
                    $previous_seq = substr(uc($sequence),0,($codon_no*3)+$shift);
                }
                
                # Extract the codon
                my $triplet = substr(uc($sequence),($codon_no*3)+$shift,3);
                
                # Number of gaps into the codon
                my $no_gaps = 0;        
                while((scalar @{[$triplet =~ /[A-Z]/g]}) < 3){
                    $no_gaps++;    
                    $triplet = substr(uc($sequence),($codon_no*3)+$shift,3+$no_gaps);
                    # If something different than A-Z or "-" is found
                    # End loop
                    if(grep(m/([^A-Z])|([^-])/g,$triplet)){ last; }
                }
                
                # Store the triplet only it is complete.
                if(length($triplet) == 3){
                    # Store the triplets
                    push(@all_triplets, $triplet);
                    # Store further information for the rest of the sequences
                    push(@new_list, $codon_no."-".$shift."-".$no_gaps);
                }else{
                    $eliminated_codons++;
                }
                # Continue ...
# WARNING ######################################################################
# If $warning == 1, Warning reporting in output files
################################################################################
                
                # Translate  ###########################################################
                # Remove gaps
                my $coding_triplet = $triplet;
                $coding_triplet =~ s/-//g;
                
                # Residue from sequence
                my $triplet_ref = "";
                # Residue from PDB
                my $res_pdb = "";
                
                # Compare
                if($gen_code eq 'mt'){
        
                    $triplet_ref = $mt_code{$coding_triplet};
                    $res_pdb = $mt_code{$aas[$codon]}
                    
                }else{
                    
                    $triplet_ref = $standard_code{$coding_triplet};
                    $res_pdb = $standard_code{$aas[$codon]}
                    
                }
                # End: Translate  ######################################################
                
                ########################################################################
                # Validate with PDB ####################################################
                # First sequence (Bos taurus)
                if($warning){
                    if(!$triplet_ref){ $triplet_ref = "??"; }
                    if($triplet_ref && $triplet_ref ne $aas[$codon]){
                        
                        print "\n---------------------------------------------------------------------";
                        print "\nWARNING: Non coincidence encountered in residue number: $codon_no.\n";
                        print $triplet." => ".$triplet_ref." (Residue in PDB: ".$aas[$codon]." - Gaps: ".$shift." - )";
                        print "\n---------------------------------------------------------------------\n";
                    }
                # End: Validate with PDB ###############################################
                ########################################################################
                }
            }

# ELSE #########################################################################
# For sequences different from Bos taurus
################################################################################

        }else{
            # For each codon in NEW LIST
            for $codon_new (@new_list){
                
                # Extract information
                my @splited = split(/-/,$codon_new);
                my $codon = $splited[0];
                my $shift = $splited[1];
                my $no_gaps = $splited[2];
                
                if(length($sequence) > $codon*3){
                    # Extract from sequence
                    my $triplet = substr(uc($sequence),$codon*3+$shift,3+$no_gaps);
                    # Store for concatenate
                    push(@all_triplets, $triplet);
                }else{
                    # If there is no codon in this position (begin and end)
                    push(@all_triplets, "---");
                }
                
            }
        }

################################################################################
################################################################################

# Chapter 4
# Concatena ####################################################################
# Build the sequences
################################################################################
    for my $triplet (@all_triplets){
          
        # Concatenate
        $merge_seq = $merge_seq.$triplet;
        
    }

# Chapter 5
# Write in specified format ####################################################
# Set $format to "phy" for PHYLIPS or anythig for FASTA
################################################################################
   my $format = "phy";
   
    my $seq_name = substr($seq->id,0,9);
    if($format eq "phy"){
    
        # Output <STDOUT> (Phylip format)
        if($sequence_number == 0){
            my $ln = scalar(@list);
            $ln = $ln*3-$eliminated_codons*3;
            my $ns = $num_sequences;
            print "   ".$ns."    ".$ln."\n";
        }
        my $spaces = "";
        while(length($seq_name.$spaces) < 10){
            $spaces = $spaces." ";
        }
        print $seq_name."  ".$spaces;
        #$merge_seq =~ s/-//g;
        print $merge_seq."\n";
        
    }else{
        
        # Output <STDOUT> (Fasta format)
        print ">".$seq_name." \n";
        #$merge_seq =~ s/-//g;
        print $merge_seq."\n";
        
    }
    
    $sequence_number++;
    
}
# End While
################################################################################