#!/usr/bin/perl -w
# rawtable.pl


use warnings;
use Bio::Structure::Model;
use Bio::Structure::IO::pdb;
use Bio::Structure::SecStr::DSSP::Res;

# ASA calculated for residue X in a GXG tripeptide with the main chain in an
# extended conformation. This hash information is necessary to calculate
# the relative exposition of each type of residue.
my %ASA_GXG_total =  (
   'A' => 113,
   'R' => 241,
   'N' => 158,
   'D' => 151,
   'C' => 140,
   'Q' => 189,
   'E' => 183,
   'G' => 85,
   'H' => 194,
   'I' => 182,
   'L' => 180,
   'K' => 211,
   'M' => 204,
   'F' => 218,
   'P' => 143,
   'S' => 122,
   'T' => 146,
   'W' => 259,
   'Y' => 229,
   'V' => 160,
# X: ambigueties
   'X' => 90
 );

# Chapter 1
# Description ##################################################################
# This script generates a "raw table":
# Chain| Residue num. | Bool(contact) | Bool(exposed)
# Input file from contact.pl is needed: "contact_file"
# PDB file is also needed to calculate surface
# DSSP algorithm is required in the system
################################################################################

# Usage: ./rawtable.pl <contact_file> <pdb_file> <chainID> [ <listChainContact -separated with "-"-> <Exp_threshold> <Thresh_margin>]
  my $num_args = $#ARGV + 1;
 if ($num_args < 3) {
  print "ERROR: Missing arguments.\nUsage: ./rawtable.pl <contact_file> <pdb_file> <chainID> [ <listChainContact -separated with "-"-> <Exp_threshold> <Thresh_margin>]\n";
  exit;
 }
 
# Chains contact with
my @chains_contact = ();
$string_contacts = $ARGV[3];
if($string_contacts){
    my @SplitedContact = split(/-/, $string_contacts);
    for my $ChainContactW (@SplitedContact){
        push(@chains_contact, $ChainContactW);
        #print $ChainContactW."\n";
    }
}

# Chapter 2
# File handle ##################################################################
# Input contact_file
my $contact_file = $ARGV[0];
open CONTACT, $contact_file;
my @contact_data = <CONTACT>;
close CONTACT;
# PDB file
my $pdb_file = $ARGV[1];
open PDB, $pdb_file;
my @pdbArray = <PDB>;
close PDB;
# TEMP file
my $temp_file = "temp";
open TEMP, ">".$temp_file;
################################################################################

# Chapter 3
# Data preparation #############################################################
my $chainID = $ARGV[2];
my $th_expo = $ARGV[4]; if(!$ARGV[4]){ $th_expo = 0.05; }
my $th_margin = $ARGV[5]; if(!$ARGV[5]){ $th_margin = 0; }
# Chain extractor
my $coord = "";
# parse the input file saving only backbone atoms coordinates
# format: [string "ATOM"] [number] [atom] [aa] whatever [3 decimal numbers] whateva with two dots in between
for (my $line = 0; $line < scalar @pdbArray; $line++) {
    if ($pdbArray[$line] =~ m/ATOM\s+\d+\s+(\w+)\s+\w{3}\s+$chainID+.+\s(\S+\.\S+)\s+(\S+\.\S+)\s+(\S+\.\S+)\s+.+\..+\..+/ig) {
        if (1) {
            $coord = $coord.$pdbArray[$line];
        }
    }
}

print TEMP $coord;
close TEMP;

# DSSP calling
system("dssp $temp_file dssp_temp");

# DSSP processor
#  GETTING DSSP INFORMATION
#  This part of the script uses the previously called library (Bioperl)
#  The argument "'-fh'=>\*STDIN" instead a file name is to read the
#  text from the standar input. So, it is necesary to put the dssp data
#  in the console and not in a file.
my $dssp = new Bio::Structure::SecStr::DSSP::Res('-file' => "dssp_temp" );

#  Store the whole information about each residue
my @residues = $dssp->residues();

#  Store the sequence
my @seq = $dssp->getSeq();
    
# Chain length
my $chain_length = scalar(@residues);

my @bin_array = ();
foreach my $residueID (@residues) {
    
    # Just one residue
    my $res = $dssp->resAA($residueID);
    
    # The residue
    # Sometimes, Cys resisues are designated wiht the characters 'a' or 'b'
    if ($res eq 'a' or $res eq 'b'){ $res = 'C'; }
    
    # The secondary structure of such residue
    my $sur = $dssp->resSecStr($residueID);
    
    # 0: buried, 1: exposed
    my $bin = '0';
    my $total_asa = $ASA_GXG_total{"$res"};
 
    # The decision    
        if($dssp->resSolvAcc($residueID)/$total_asa > $th_expo + $th_margin){
            $bin = '1';
        }elsif($dssp->resSolvAcc($residueID)/$total_asa <= $th_expo - $th_margin){
            $bin = '0';
        }else{
            $bin = '-';
        }
    
    
    push(@bin_array,$bin);
    #push(@bin_array,$dssp->resSolvAcc($residueID)/$total_asa);
    
}


################################################################################

# Chapter 4
# Table drawing ################################################################
print "#Raw Table for $chainID.\n";
print "#ChainID\tChainID2\tRes num.\tAA\tContact\tExposition ($th_expo)\n";
print "#-------\t-------\t--------\t--\t-------\t-----------------\n";


#for(my $i=0;$i<=$chain_length;$i++){
for(my $i=0;$i<scalar @bin_array;$i++){   
    my $no = $i+1;
    my $pdbNum = $dssp->_pdbNum( $no );
    my $aa = $dssp->resAA($pdbNum);
    my $chainID2 = "--";
    
    # Check if the residue is in conctact
    my @bool_contact = grep /.{3}-$pdbNum\t$chainID/, @contact_data;
    
    if(@bool_contact){
        
        my @array_res_con = ();
        
        $contact = 1;
        for my $one_contact (@bool_contact){
            
            my @cols = split(/\t/,$one_contact);
                
                my $res_one = $cols[1];
                my $res_two = $cols[3];
                
                $res_one =~ s/\n//g;
                $res_two =~ s/\n//g;
                
                my $res_con = "";
                
                if($res_one eq $chainID){
                    
                    $res_con = $res_two;
                    
                }else{
                    
                    $res_con = $res_one;
                    
                }
                
                
                
                push(@array_res_con, $res_con);
                
                if($chainID2 eq "--"){
                
                    $chainID2 = $res_con;
                
                }else{
                    
                    $chainID2 = $chainID2."|".$res_con;
                    
                }
            
        }
        
        $chainID2 = "";
        # The array is converted in a hash, giving to each element (key) the value 1
        my %hash = map {$_, 1} @array_res_con;
        # In this way the new_array doesn't contain contain duplicated elements
        my @new_array_rc = keys %hash;
        
        for my $res (@new_array_rc){
            
            if($chainID2 eq ""){
                
                    $chainID2 = $res;
                
                }else{
                    
                    $chainID2 = $chainID2."|".$res;
                    
                }
            
        }
        
        #IF Mode 2
        if($string_contacts){
            # Change boolean if doesn't contact with one of the specified chains 
            $contact = 0;
            foreach my $chain_c (@chains_contact){
                
                foreach my $chain_d (@new_array_rc){
                    
                    if($chain_c eq $chain_d){ $contact = 1; }
                    
                }
                
            }
        }
                      
    }else{
        
        $contact = 0;
        
    }
    
    print "$chainID\t$chainID2\t$pdbNum\t$aa\t$contact\t$bin_array[$i]\n";
    
}

system("rm $temp_file");
system("rm dssp_temp");
exit;
