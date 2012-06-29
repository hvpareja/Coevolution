#!/usr/bin/perl -w
# seqMerge.pl


use warnings;
use Bio::SeqIO;

# Chapter 1
# Description ##################################################################
# This script returns to STDOUT a set of sequences in align fasta format. Each
# one is the result of the concatenated codons speficied in <setFile>
################################################################################

# Usage: <STDIN> ./seqMerge.pl <AlignFile> [<GeneticCode>]
  my $num_args = $#ARGV + 1;
 if ($num_args < 1) {
  print "ERROR: Missing arguments.\nUsage: <STDIN> | ./seqMerge.pl <AlignFile> [<GeneticCode (st=standar OR mt=mitochondrial)>]\n";
  exit;
 }
 
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
 
# Chapter 2
# File handle ##################################################################
# Extract in @list the codons within the set
# Extract in @aas the residues encoded.
my $counter = 0;
while (my $line = <STDIN>) {
    
    
    # Avoid header
    if($counter < 3){ $counter++; next; }
    
    my @columns = split(/\t/,$line);
    
    my $num = $columns[1];
    my $aa = $columns[2];
    
    
    push(@aas, $aa);
    push(@list, $num);
    
}

# Genetic Code
my $gen_code = $ARGV[1];
if(!$gen_code){ $gen_code = 'st'; }
if($gen_code ne 'mt' && $gen_code ne 'st'){
    
    print "\nERROR: Missing or invalid argument: '<GeneticCode> (st=standar OR mt=mitochondrial)'";
    print "\nUsage: <STDIN> | ./seqMerge.pl <AlignFile> [<GeneticCode (st=standar OR mt=mitochondrial)>]\n";
  exit;
    
}

# Input AlignFile
my $align_file = $ARGV[0];
my $stream = Bio::SeqIO->new(-file => $align_file);
################################################################################

# Chapter 3
# Data proccess ################################################################

# For each sequence
my $sequence_number = 0;
my $ref_sequence = "";
while (my $seq = $stream->next_seq) {
    
    if($sequence_number == 0){ $ref_sequence = $seq->seq; }
    
    my $sequence = $seq->seq;
    my $previous_seq = "";
    my $merge_seq = "";
    my $shift = 0;
    
    # For each codon in LIST
    for($codon=0;$codon < scalar @list;$codon++){
        
        # Get the codon ########################################################
        my $codon_no = $list[$codon]-1;
        my $margin = 0;
        my $previous_seq1 = substr(uc($ref_sequence),0,($codon_no*3)+$shift);
        my $prox_seq = "";
        if(length($ref_sequence) > ($codon_no*3)+$shift){
        $prox_seq = substr(uc($ref_sequence),($codon_no*3)+$shift,3);
        }
        $margin = 2 + (scalar @{[$prox_seq =~ /-/g]});
        my $previous_seq = substr(uc($ref_sequence),0,($codon_no*3)+$shift+$margin);
        $shift = scalar @{[$previous_seq =~ /-/g]};
        if(length($sequence) <= ($codon_no*3)+$shift){  next; }
        my $triplet = substr(uc($sequence),($codon_no*3)+$shift,3);
        my $no_gaps = 0;        
        while((scalar @{[$triplet =~ /[A-Z]/g]}) < 3){
            $no_gaps++;    
            $triplet = substr(uc($sequence),($codon_no*3)+$shift,3+$no_gaps);
            if($no_gaps > 3){ last; }
        }
        if($no_gaps > 3){ next; }
        # End: Get the codon ###################################################
        ########################################################################
        # Translate  ###########################################################
        my $coding_triplet = $triplet;
        $coding_triplet =~ s/-//g;
        my $triplet_ref = "";
        my $res_pdb = "";
        
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
        if($sequence_number == 0){
        
            if(!$triplet_ref){ $triplet_ref = "??"; }
            if($triplet_ref && $triplet_ref ne $aas[$codon]){
                
                print "\n---------------------------------------------------------------------";
                print "\nWARNING: Non coincidence encountered in residue number: $codon_no.\n";
                print $triplet." => ".$triplet_ref." (Residue in PDB: ".$aas[$codon]." - Gaps: ".$shift." - )";
                print "\n---------------------------------------------------------------------\n";
                
            }
            
        }
        # End: Validate with PDB ###############################################
        ########################################################################
        
        # Concatenate 
        #$merge_seq = $merge_seq.$triplet;
        # Concatenate Debug
        $merge_seq = $merge_seq."| (".$codon_no.") ".$triplet." ".$triplet_ref."-".$aas[$codon];
        
    }
    
    $sequence_number++;
    
    # Output <STDOUT>
    print ">".$seq->id."\n";
    print $merge_seq."\n";
    
}

################################################################################