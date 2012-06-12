#!/usr/bin/perl
# ChainB_bc1_contact.pl
use strict;
use warnings;


 # This script reads the PDB file (1BE3) for bovine complex III (bc1.pdb2 complex). This structure consist of 22 chains, being chain G the corresponding to subunit 8
 # We want to sort each Chain G residues into two sects. Contact set includes those residues from Chain G that are in close contact (<= 4 Angstroms) with residues from
 # the other chains. The program writes two text files. One with the detailed results (Detailed_2bc1_Results.TXT file) and other containing the 
 # residues from Chain G that are in close contact with other subunits (Contact_2bc1_set.txt).
 

      system ('Clear');

       open (FILE, "modified_2bc1.txt") or print "Could't open the file";

       my @row = <FILE>; # array containing as many scalars as atoms atoms form the protein. Between chains there are one TER line  
       close FILE;

########################################################### Chain A has 3458 atoms    (Core 1, matrix)  
my $i = 0;  my @X_chainA = my @Y_chainA = my @Z_chainA =();      
for ($i=0; $i< 3458; ++$i) { # Chain A extends in the @row array from 0 to 3457 (atoms 1-3458)
      my @temp = split (/\s+/, $row[$i]); # temporal array that contain, for instance (ATOM, 1, N, THR, A, 1, -5.814, 141.666, -25.256, 1.00, 55.17, N)
      push (@X_chainA, $temp[6]);
      push (@Y_chainA, $temp[7]);
      push (@Z_chainA, $temp[8]);     
}

########################################################### Chain B has 3141 atoms  (Core 2, matrix)
my @X_chainB = my @Y_chainB = my @Z_chainB =();      
for ($i=3459; $i< 6600; ++$i) { # Chain B extends in the @row array from 3459 to 6559 (atoms 3460-6600)
      my @temp = split (/\s+/, $row[$i]); # temporal array that contain, for instance (ATOM, 1, N, THR, A, 1, -5.814, 141.666, -25.256, 1.00, 55.17, N)
      push (@X_chainB, $temp[6]);
      push (@Y_chainB, $temp[7]);
      push (@Z_chainB, $temp[8]);     
}

########################################################## Chain C has 3011 atoms (Cytb, intermembrane region)
my @X_chainC = my @Y_chainC = my @Z_chainC =();      
for ($i=6601; $i< 9612; ++$i) { # Chain C extends in the @row array from 6601 to 9611 (atoms 36602-9612)
      my @temp = split (/\s+/, $row[$i]); # temporal array that contain, for instance (ATOM, 1, N, THR, A, 1, -5.814, 141.666, -25.256, 1.00, 55.17, N)
      push (@X_chainC, $temp[6]);
      push (@Y_chainC, $temp[7]);
      push (@Z_chainC, $temp[8]);     
}

########################################################## Chain D has 1919 atoms (Cytc1, intermembrane space)
my @X_chainD = my @Y_chainD = my @Z_chainD =();      
for ($i=9613; $i< 11532; ++$i) { # Chain D extends in the @row array from 9613 to 11531 (atoms 9614-11532)
      my @temp = split (/\s+/, $row[$i]); # temporal array that contain, for instance (ATOM, 1, N, THR, A, 1, -5.814, 141.666, -25.256, 1.00, 55.17, N)
      push (@X_chainD, $temp[6]);
      push (@Y_chainD, $temp[7]);
      push (@Z_chainD, $temp[8]);     
}

########################################################## Chain E has 1519 atoms (ISP, intermembrane space)
my @X_chainE = my @Y_chainE = my @Z_chainE =();      
for ($i=11533; $i< 13052; ++$i) { # Chain E extends in the @row array from 11533 to 13051 (atoms 11534-13052)
      my @temp = split (/\s+/, $row[$i]); # temporal array that contain, for instance (ATOM, 1, N, THR, A, 1, -5.814, 141.666, -25.256, 1.00, 55.17, N)
      push (@X_chainE, $temp[6]);
      push (@Y_chainE, $temp[7]);
      push (@Z_chainE, $temp[8]);     
}

########################################################## Chain F has 916 atoms (Subunit 7, intermembrane region)
my @X_chainF = my @Y_chainF = my @Z_chainF =();      
for ($i=13053; $i< 13969; ++$i) { # Chain F extends in the @row array from 13053 to 13968 (atoms 13054-13969)
      my @temp = split (/\s+/, $row[$i]); # temporal array that contain, for instance (ATOM, 1, N, THR, A, 1, -5.814, 141.666, -25.256, 1.00, 55.17, N)
      push (@X_chainF, $temp[6]);
      push (@Y_chainF, $temp[7]);
      push (@Z_chainF, $temp[8]);     
}
 
########################################################## Chain G has 682 atoms (Subunit 8, intermembrane space)
my @X_chainG = my @Y_chainG = my @Z_chainG =();      
for ($i=13970; $i< 14652; ++$i) { # Chain G extends in the @row array from 13970 to 14651 (atoms 13971-14552)
      my @temp = split (/\s+/, $row[$i]); # temporal array that contain, for instance (ATOM, 1, N, THR, A, 1, -5.814, 141.666, -25.256, 1.00, 55.17, N)
      push (@X_chainG, $temp[6]);
      push (@Y_chainG, $temp[7]);
      push (@Z_chainG, $temp[8]);     
}

########################################################## Chain H has 524 atoms (Subunit 6, matrix)
my @X_chainH = my @Y_chainH = my @Z_chainH =();      
for ($i=14653; $i< 15177; ++$i) { # Chain H extends in the @row array from 14653 to 15176 (atoms 14654-15177)
      my @temp = split (/\s+/, $row[$i]); # temporal array that contain, for instance (ATOM, 1, N, THR, A, 1, -5.814, 141.666, -25.256, 1.00, 55.17, N)
      push (@X_chainH, $temp[6]);
      push (@Y_chainH, $temp[7]);
      push (@Z_chainH, $temp[8]);     
}

########################################################## Chain I has 248 atoms (Subunit 11, intermembrane region ?)
my @X_chainI = my @Y_chainI = my @Z_chainI =();      
for ($i=15178; $i< 15426; ++$i) { # Chain I extends in the @row array from 15178 to 15425 (atoms 15179-15426)
      my @temp = split (/\s+/, $row[$i]); # temporal array that contain, for instance (ATOM, 1, N, THR, A, 1, -5.814, 141.666, -25.256, 1.00, 55.17, N)
      push (@X_chainI, $temp[6]);
      push (@Y_chainI, $temp[7]);
      push (@Z_chainI, $temp[8]);     
}

########################################################## Chain J has 512 atoms (Subunit 9, matrix)
my @X_chainJ = my @Y_chainJ = my @Z_chainJ =();      
for ($i=15427; $i< 15939; ++$i) { # Chain J extends in the @row array from 15427 to 15938 (atoms 15428-15939)
      my @temp = split (/\s+/, $row[$i]); # temporal array that contain, for instance (ATOM, 1, N, THR, A, 1, -5.814, 141.666, -25.256, 1.00, 55.17, N)
      push (@X_chainJ, $temp[6]);
      push (@Y_chainJ, $temp[7]);
      push (@Z_chainJ, $temp[8]);     
}

########################################################## Chain K has 159 atoms (Subunit 10, intermembrane region)
my @X_chainK = my @Y_chainK = my @Z_chainK =();      
for ($i=15940; $i< 16099; ++$i) { # Chain K extends in the @row array from 15940 to 16098 (atoms 15941-16099)
      my @temp = split (/\s+/, $row[$i]); # temporal array that contain, for instance (ATOM, 1, N, THR, A, 1, -5.814, 141.666, -25.256, 1.00, 55.17, N)
      push (@X_chainK, $temp[6]);
      push (@Y_chainK, $temp[7]);
      push (@Z_chainK, $temp[8]);     
}



############################################################ Chain A2 has 3458 atoms    (Core 1, matrix)  
my @X_chainAA = my @Y_chainAA = my @Z_chainAA =();      
for ($i=16100; $i< 19558; ++$i) { 
      my @temp = split (/\s+/, $row[$i]); # temporal array that contain, for instance (ATOM, 1, N, THR, A, 1, -5.814, 141.666, -25.256, 1.00, 55.17, N)
      push (@X_chainAA, $temp[6]);
      push (@Y_chainAA, $temp[7]);
      push (@Z_chainAA, $temp[8]);     
}

############################################################ Chain B2 has 3141 atoms  (Core 2, matrix)
my @X_chainBB = my @Y_chainBB = my @Z_chainBB =();      
for ($i=19559; $i< 22700; ++$i) { 
      my @temp = split (/\s+/, $row[$i]); # temporal array that contain, for instance (ATOM, 1, N, THR, A, 1, -5.814, 141.666, -25.256, 1.00, 55.17, N)
      push (@X_chainBB, $temp[6]);
      push (@Y_chainBB, $temp[7]);
      push (@Z_chainBB, $temp[8]);     
}
########################################################### Chain C2 has 3011 atoms (Cytb, intermembrane region)
my @X_chainCC = my @Y_chainCC = my @Z_chainCC =();      
for ($i=22701; $i< 25712; ++$i) { 
      my @temp = split (/\s+/, $row[$i]); # temporal array that contain, for instance (ATOM, 1, N, THR, A, 1, -5.814, 141.666, -25.256, 1.00, 55.17, N)
      push (@X_chainCC, $temp[6]);
      push (@Y_chainCC, $temp[7]);
      push (@Z_chainCC, $temp[8]);     
}
########################################################### Chain D2 has 1919 atoms (Cytc1, intermembrane space)
my @X_chainDD = my @Y_chainDD = my @Z_chainDD =();      
for ($i=25713; $i< 27632; ++$i) { # Chain D extends in the @row array from 9613 to 11531 (atoms 9614-11532)
      my @temp = split (/\s+/, $row[$i]); # temporal array that contain, for instance (ATOM, 1, N, THR, A, 1, -5.814, 141.666, -25.256, 1.00, 55.17, N)
      push (@X_chainDD, $temp[6]);
      push (@Y_chainDD, $temp[7]);
      push (@Z_chainDD, $temp[8]);     
}
########################################################### Chain E2 has 1519 atoms (ISP, intermembrane space)
my @X_chainEE = my @Y_chainEE = my @Z_chainEE =();      
for ($i=27633; $i< 29152; ++$i) { 
      my @temp = split (/\s+/, $row[$i]); # temporal array that contain, for instance (ATOM, 1, N, THR, A, 1, -5.814, 141.666, -25.256, 1.00, 55.17, N)
      push (@X_chainEE, $temp[6]);
      push (@Y_chainEE, $temp[7]);
      push (@Z_chainEE, $temp[8]);     
}
########################################################### Chain F2 has 916 atoms (Subunit 7, intermembrane region)
my @X_chainFF = my @Y_chainFF = my @Z_chainFF =();      
for ($i=29153; $i< 30069; ++$i) { # Chain F extends in the @row array from 13053 to 13968 (atoms 13054-13969)
      my @temp = split (/\s+/, $row[$i]); # temporal array that contain, for instance (ATOM, 1, N, THR, A, 1, -5.814, 141.666, -25.256, 1.00, 55.17, N)
      push (@X_chainFF, $temp[6]);
      push (@Y_chainFF, $temp[7]);
      push (@Z_chainFF, $temp[8]);     
}
 
########################################################### Chain G2 has 682 atoms (Subunit 8, intermembrane space)
my @X_chainGG = my @Y_chainGG = my @Z_chainGG =();      
for ($i=30070; $i< 30752; ++$i) { # Chain G extends in the @row array from 13970 to 14651 (atoms 13971-14552)
      my @temp = split (/\s+/, $row[$i]); # temporal array that contain, for instance (ATOM, 1, N, THR, A, 1, -5.814, 141.666, -25.256, 1.00, 55.17, N)
      push (@X_chainGG, $temp[6]);
      push (@Y_chainGG, $temp[7]);
      push (@Z_chainGG, $temp[8]);     
}

########################################################### Chain H2 has 524 atoms (Subunit 6, matrix)
my @X_chainHH = my @Y_chainHH = my @Z_chainHH =();      
for ($i=30753; $i< 31277; ++$i) { 
      my @temp = split (/\s+/, $row[$i]); # temporal array that contain, for instance (ATOM, 1, N, THR, A, 1, -5.814, 141.666, -25.256, 1.00, 55.17, N)
      push (@X_chainHH, $temp[6]);
      push (@Y_chainHH, $temp[7]);
      push (@Z_chainHH, $temp[8]);     
}

########################################################### Chain I2 has 248 atoms (Subunit 11, intermembrane region ?)
my @X_chainII = my @Y_chainII = my @Z_chainII =();      
for ($i=31278; $i< 31526; ++$i) { 
      my @temp = split (/\s+/, $row[$i]); # temporal array that contain, for instance (ATOM, 1, N, THR, A, 1, -5.814, 141.666, -25.256, 1.00, 55.17, N)
      push (@X_chainII, $temp[6]);
      push (@Y_chainII, $temp[7]);
      push (@Z_chainII, $temp[8]);     
}

########################################################### Chain J2 has 512 atoms (Subunit 9, matrix)
my @X_chainJJ = my @Y_chainJJ = my @Z_chainJJ =();      
for ($i=31527; $i< 32039; ++$i) { 
      my @temp = split (/\s+/, $row[$i]); # temporal array that contain, for instance (ATOM, 1, N, THR, A, 1, -5.814, 141.666, -25.256, 1.00, 55.17, N)
      push (@X_chainJJ, $temp[6]);
      push (@Y_chainJJ, $temp[7]);
      push (@Z_chainJJ, $temp[8]);     
}
########################################################### Chain K2 has 159 atoms (Subunit 10, intermembrane region)
my @X_chainKK = my @Y_chainKK = my @Z_chainKK =();      
for ($i=32040; $i< 32199; ++$i) { 
      my @temp = split (/\s+/, $row[$i]); # temporal array that contain, for instance (ATOM, 1, N, THR, A, 1, -5.814, 141.666, -25.256, 1.00, 55.17, N)
      push (@X_chainKK, $temp[6]);
      push (@Y_chainKK, $temp[7]);
      push (@Z_chainKK, $temp[8]);     
}


############ Computing Euclidean distances

open (OUTPUT, ">ChainG_Detailed_2bc1_Results.txt") or die print "Couldn't write the file \n";
open (CONTACT, ">ChainG_Contact_2bc1_Set.txt") or die print "Couldn't at 121 \n";

my $distance = 0;
my $j = 0;

for ($i=0; $i< 682; ++$i) {
      
      for ($j = 0; $j < 3458; ++$j) { # distances to atoms from chain A
            $distance = sqrt( ($X_chainG[$i]-$X_chainA[$j])**2 + ($Y_chainG[$i]-$Y_chainA[$j])**2 + ($Z_chainG[$i]-$Z_chainA[$j])**2 );
            if ($distance <= 4) {
                  print OUTPUT $row[$i+13970], $row[$j], "Distance =", $distance, "\n\n";
                  my @fromchainG = split (/\s+/, $row[$i+13970]);
                  my @fromchainA = split (/\s+/, $row[$j]);
                  print CONTACT  $fromchainG[5]." ".$fromchainG[3], "\t", $fromchainA[3]." ".$fromchainA[5], "    Chain A (Core 1) \n";
            }
      }

      for ($j = 0; $j < 3141; ++$j) { # distances to atoms from chain B
            $distance = sqrt( ($X_chainG[$i]-$X_chainB[$j])**2 + ($Y_chainG[$i]-$Y_chainB[$j])**2 + ($Z_chainG[$i]-$Z_chainB[$j])**2 );
            if ($distance <= 4) {
                  print OUTPUT $row[$i+13970], $row[$j+3459], "Distance =", $distance, "\n\n";
                  my @fromchainG = split (/\s+/, $row[$i+13970]);
                  my @fromchainB = split (/\s+/, $row[$j+3459]);
                  print CONTACT  $fromchainG[5]." ".$fromchainG[3], "\t", $fromchainB[3].$fromchainB[5], "    Chain B (Core 2) \n";
            }

      }

      for ($j = 0; $j < 3011; ++$j) { # distances to atoms from chain C
            $distance = sqrt( ($X_chainG[$i]-$X_chainC[$j])**2 + ($Y_chainG[$i]-$Y_chainC[$j])**2 + ($Z_chainG[$i]-$Z_chainC[$j])**2 );
            if ($distance <= 4) {
                  print OUTPUT $row[$i+13970], $row[$j+6601], "Distance =", $distance, "\n\n";
                  my @fromchainC = split (/\s+/, $row[$j+6601]);
                  my @fromchainG = split (/\s+/, $row[$i+13970]);
                  print CONTACT  $fromchainG[5]." ".$fromchainG[3], "\t", $fromchainC[3].$fromchainC[5], "    Chain C (Cytb) \n";
            }
      }
      
      for ($j = 0; $j < 1919; ++$j) { # distances to atoms from chain D
            $distance = sqrt( ($X_chainG[$i]-$X_chainD[$j])**2 + ($Y_chainG[$i]-$Y_chainD[$j])**2 + ($Z_chainG[$i]-$Z_chainD[$j])**2 );
            if ($distance <= 4) {
                  print OUTPUT $row[$i+13970], $row[$j+9613], "Distance =", $distance, "\n\n";
                  my @fromchainG = split (/\s+/, $row[$i+13970]);
                  my @fromchainD = split (/\s+/, $row[$j+9613]);
                  print CONTACT  $fromchainG[5]." ".$fromchainG[3], "\t", $fromchainD[3].$fromchainD[5], "    Chain D (Cytc1) \n";
            }
      }
      for ($j=0; $j< 1519; ++$j) { # distances to atoms from chain E
            $distance = sqrt( ($X_chainG[$i]-$X_chainE[$j])**2 + ($Y_chainG[$i]-$Y_chainE[$j])**2 + ($Z_chainG[$i]-$Z_chainE[$j])**2 );
            if ($distance <= 4) {
                  print OUTPUT $row[$i+13970], $row[$j+11533], "Distance =", $distance, "\n\n";
                  my @fromchainG = split (/\s+/, $row[$i+13970]);
                  my @fromchainE = split (/\s+/, $row[$j+11533]);
                  print CONTACT $fromchainG[5]."  ".$fromchainG[3], "\t", $fromchainE[3].$fromchainE[5], "    Chain E (ISP) \n";
            }
      }

      for ($j=0; $j< 916; ++$j) { # distances to atoms from chain F
            $distance = sqrt( ($X_chainG[$i]-$X_chainF[$j])**2 + ($Y_chainG[$i]-$Y_chainF[$j])**2 + ($Z_chainG[$i]-$Z_chainF[$j])**2 );
            if ($distance <= 4) {
                  print OUTPUT $row[$i+13970], $row[$j+13053], "Distance =", $distance, "\n\n";
                  my @fromchainG = split (/\s+/, $row[$i+13970]);
                  my @fromchainF = split (/\s+/, $row[$j+13053]);
                  print CONTACT $fromchainG[5]." ".$fromchainG[3], "\t", $fromchainF[3].$fromchainF[5], "    Chain F (Subunit 7) \n";
            }
      }

      for ($j=0; $j< 524; ++$j) { # distances to atoms from chain H
            $distance = sqrt( ($X_chainG[$i]-$X_chainH[$j])**2 + ($Y_chainG[$i]-$Y_chainH[$j])**2 + ($Z_chainG[$i]-$Z_chainH[$j])**2 );
            if ($distance <= 4) {
                  print OUTPUT $row[$i+13970], $row[$j+14653], "Distance =", $distance, "\n\n";
                  my @fromchainG = split (/\s+/, $row[$i+13053]);
                  my @fromchainH = split (/\s+/, $row[$j+13970]);
                  print CONTACT $fromchainG[5]." ".$fromchainG[3], "\t", $fromchainH[3].$fromchainH[5], "    Chain H (Subunit 6) \n";
            }
      }

      for ($j=0; $j< 248; ++$j) { # distances to atoms from chain I
            $distance = sqrt( ($X_chainG[$i]-$X_chainI[$j])**2 + ($Y_chainG[$i]-$Y_chainI[$j])**2 + ($Z_chainG[$i]-$Z_chainI[$j])**2 );
            if ($distance <= 4) {
                  print OUTPUT $row[$i+13970], $row[$j+15178], "Distance =", $distance, "\n\n";
                  my @fromchainG = split (/\s+/, $row[$i+13970]);
                  my @fromchainI = split (/\s+/, $row[$j+15178]);
                  print CONTACT $fromchainG[5]." ".$fromchainG[3], "\t", $fromchainI[3].$fromchainI[5], "    Chain I (Subunit 11?) \n";
            }
      }
      
      for ($j=0; $j< 512; ++$j) { # distances to atoms from chain J
            $distance = sqrt( ($X_chainG[$i]-$X_chainJ[$j])**2 + ($Y_chainG[$i]-$Y_chainJ[$j])**2 + ($Z_chainG[$i]-$Z_chainJ[$j])**2 );
            if ($distance <= 4) {
                  print OUTPUT $row[$i+13970], $row[$j+15427], "Distance =", $distance, "\n\n";
                  my @fromchainG = split (/\s+/, $row[$i+13970]);
                  my @fromchainJ = split (/\s+/, $row[$j+15427]);
                  print CONTACT $fromchainG[5]." ".$fromchainG[3], "\t", $fromchainJ[3].$fromchainJ[5], "    Chain J (Subunit 9) \n";
            }
      }
      
      for ($j=0; $j< 159; ++$j) { # distances to atoms from chain K
            $distance = sqrt( ($X_chainG[$i]-$X_chainK[$j])**2 + ($Y_chainG[$i]-$Y_chainK[$j])**2 + ($Z_chainG[$i]-$Z_chainK[$j])**2 );
            if ($distance <= 4) {
                  print OUTPUT $row[$i+13970], $row[$j+15940], "Distance =", $distance, "\n\n";
                  my @fromchainG = split (/\s+/, $row[$i+13970]);
                  my @fromchainK = split (/\s+/, $row[$j+15940]);
                  print CONTACT $fromchainG[5]." ".$fromchainG[3], "\t", $fromchainK[3].$fromchainK[5], "    Chain K (Subunit 10) \n";
            }
      }
      
      
      for ($j = 0; $j < 3458; ++$j) { # distances to atoms from chain A2
            $distance = sqrt( ($X_chainG[$i]-$X_chainAA[$j])**2 + ($Y_chainG[$i]-$Y_chainAA[$j])**2 + ($Z_chainG[$i]-$Z_chainAA[$j])**2 );
            if ($distance <= 4) {
                  print OUTPUT $row[$i+13970], $row[$j+16100], "Distance =", $distance, "\n\n";
                  my @fromchainG = split (/\s+/, $row[$i+13970]);
                  my @fromchainAA = split (/\s+/, $row[$j+16100]);
                  print CONTACT  $fromchainG[5]." ".$fromchainG[3], "\t", $fromchainAA[3].$fromchainAA[5], "    Chain A2 (Core 2) \n";
            }

      }
      
      for ($j = 0; $j < 3141; ++$j) { # distances to atoms from chain B2
            $distance = sqrt( ($X_chainG[$i]-$X_chainBB[$j])**2 + ($Y_chainG[$i]-$Y_chainBB[$j])**2 + ($Z_chainG[$i]-$Z_chainBB[$j])**2 );
            if ($distance <= 4) {
                  print OUTPUT $row[$i+13970], $row[$j+19559], "Distance =", $distance, "\n\n";
                  my @fromchainG = split (/\s+/, $row[$i+13970]);
                  my @fromchainBB = split (/\s+/, $row[$j+19559]);
                  print CONTACT  $fromchainG[5]." ".$fromchainG[3], "\t", $fromchainBB[3].$fromchainBB[5], "    Chain B2 (Core 2) \n";
            }

      }

      for ($j = 0; $j < 3011; ++$j) { # distances to atoms from chain C2
            $distance = sqrt( ($X_chainG[$i]-$X_chainCC[$j])**2 + ($Y_chainG[$i]-$Y_chainCC[$j])**2 + ($Z_chainG[$i]-$Z_chainCC[$j])**2 );
            if ($distance <= 4) {
                  print OUTPUT $row[$i+13970], $row[$j+22701], "Distance =", $distance, "\n\n";
                  my @fromchainCC = split (/\s+/, $row[$j+22701]);
                  my @fromchainG = split (/\s+/, $row[$i+13970]);
                  print CONTACT  $fromchainG[5]." ".$fromchainG[3], "\t", $fromchainCC[3].$fromchainCC[5], "    Chain C2 (Cytb) \n";
            }
      }
      
      for ($j = 0; $j < 1919; ++$j) { # distances to atoms from chain D2
            $distance = sqrt( ($X_chainG[$i]-$X_chainDD[$j])**2 + ($Y_chainG[$i]-$Y_chainDD[$j])**2 + ($Z_chainG[$i]-$Z_chainDD[$j])**2 );
            if ($distance <= 4) {
                  print OUTPUT $row[$i+13970], $row[$j+25713], "Distance =", $distance, "\n\n";
                  my @fromchainG = split (/\s+/, $row[$i+13970]);
                  my @fromchainDD = split (/\s+/, $row[$j+25713]);
                  print CONTACT  $fromchainG[5]." ".$fromchainG[3], "\t", $fromchainDD[3].$fromchainDD[5], "    Chain D2 (Cytc1) \n";
            }
      }
      
      for ($j=0; $j< 1519; ++$j) { # distances to atoms from chain E2
            $distance = sqrt( ($X_chainG[$i]-$X_chainEE[$j])**2 + ($Y_chainG[$i]-$Y_chainEE[$j])**2 + ($Z_chainG[$i]-$Z_chainEE[$j])**2 );
            if ($distance <= 4) {
                  print OUTPUT $row[$i+13970], $row[$j+27633], "Distance =", $distance, "\n\n";
                  my @fromchainG = split (/\s+/, $row[$i+13970]);
                  my @fromchainEE = split (/\s+/, $row[$j+27633]);
                  print CONTACT $fromchainG[5]."  ".$fromchainG[3], "\t", $fromchainEE[3].$fromchainEE[5], "    Chain E2 (ISP) \n";
            }
      }

      for ($j=0; $j< 916; ++$j) { # distances to atoms from chain F2
            $distance = sqrt( ($X_chainG[$i]-$X_chainFF[$j])**2 + ($Y_chainG[$i]-$Y_chainFF[$j])**2 + ($Z_chainG[$i]-$Z_chainFF[$j])**2 );
            if ($distance <= 4) {
                  print OUTPUT $row[$i+13970], $row[$j+29153], "Distance =", $distance, "\n\n";
                  my @fromchainG = split (/\s+/, $row[$i+13970]);
                  my @fromchainFF = split (/\s+/, $row[$j+29153]);
                  print CONTACT $fromchainG[5]." ".$fromchainG[3], "\t", $fromchainFF[3].$fromchainFF[5], "    Chain F2 (Subunit 7) \n";
            }
      }
      
      for ($j=0; $j< 682; ++$j) { # distances to atoms from chain G2
            $distance = sqrt( ($X_chainG[$i]-$X_chainGG[$j])**2 + ($Y_chainG[$i]-$Y_chainGG[$j])**2 + ($Z_chainG[$i]-$Z_chainGG[$j])**2 );
            if ($distance <= 4) {
                  print OUTPUT $row[$i+13970], $row[$j+30070], "Distance =", $distance, "\n\n";
                  my @fromchainG = split (/\s+/, $row[$i+13970]);
                  my @fromchainGG = split (/\s+/, $row[$j+30070]);
                  print CONTACT $fromchainG[5]." ".$fromchainG[3], "\t", $fromchainGG[3].$fromchainGG[5], "    Chain G2 (Subunit 8) \n";
            }
      }

      for ($j=0; $j< 524; ++$j) { # distances to atoms from chain H2
            $distance = sqrt( ($X_chainG[$i]-$X_chainHH[$j])**2 + ($Y_chainG[$i]-$Y_chainHH[$j])**2 + ($Z_chainG[$i]-$Z_chainHH[$j])**2 );
            if ($distance <= 4) {
                  print OUTPUT $row[$i+13970], $row[$j+30753], "Distance =", $distance, "\n\n";
                  my @fromchainG = split (/\s+/, $row[$i+13970]);
                  my @fromchainHH = split (/\s+/, $row[$j+30753]);
                  print CONTACT $fromchainG[5]." ".$fromchainG[3], "\t", $fromchainHH[3].$fromchainHH[5], "    Chain H2 (Subunit 6) \n";
            }
      }

      for ($j=0; $j< 248; ++$j) { # distances to atoms from chain I2
            $distance = sqrt( ($X_chainG[$i]-$X_chainII[$j])**2 + ($Y_chainG[$i]-$Y_chainII[$j])**2 + ($Z_chainG[$i]-$Z_chainII[$j])**2 );
            if ($distance <= 4) {
                  print OUTPUT $row[$i+13970], $row[$j+31278], "Distance =", $distance, "\n\n";
                  my @fromchainG = split (/\s+/, $row[$i+13970]);
                  my @fromchainII = split (/\s+/, $row[$j+31278]);
                  print CONTACT $fromchainG[5]." ".$fromchainG[3], "\t", $fromchainII[3].$fromchainII[5], "    Chain I2 (Subunit 11?) \n";
            }
      }
      
      for ($j=0; $j< 512; ++$j) { # distances to atoms from chain J2
            $distance = sqrt( ($X_chainG[$i]-$X_chainJJ[$j])**2 + ($Y_chainG[$i]-$Y_chainJJ[$j])**2 + ($Z_chainG[$i]-$Z_chainJJ[$j])**2 );
            if ($distance <= 4) {
                  print OUTPUT $row[$i+13970], $row[$j+31527], "Distance =", $distance, "\n\n";
                  my @fromchainG = split (/\s+/, $row[$i+13970]);
                  my @fromchainJJ = split (/\s+/, $row[$j+31527]);
                  print CONTACT $fromchainG[5]." ".$fromchainG[3], "\t", $fromchainJJ[3].$fromchainJJ[5], "    Chain J2 (Subunit 9) \n";
            }
      }
      
      for ($j=0; $j< 159; ++$j) { # distances to atoms from chain K2
            $distance = sqrt( ($X_chainG[$i]-$X_chainKK[$j])**2 + ($Y_chainG[$i]-$Y_chainKK[$j])**2 + ($Z_chainG[$i]-$Z_chainKK[$j])**2 );
            if ($distance <= 4) {
                  print OUTPUT $row[$i+13970], $row[$j+32040], "Distance =", $distance, "\n\n";
                  my @fromchainG = split (/\s+/, $row[$i+13970]);
                  my @fromchainKK = split (/\s+/, $row[$j+32040]);
                  print CONTACT $fromchainG[5]." ".$fromchainG[3], "\t", $fromchainKK[3].$fromchainKK[5], "    Chain K2 (Subunit 10) \n";
            }
      }
      
}
close OUTPUT; close CONTACT;

# The Contact_1BE3_Set.txt file contain many repeted elements. For instance, when different atoms from a residue (say Met1) are closed to
# different atoms from other residues (say Leu34), we will obtain the same line repeted: Met1 Leu34, Met1 Leu34). So, with the
# following code lines we try to removed such repetitions.

open (FILE, "ChainG_Contact_2bc1_Set.txt") or die print "Couldn't at 447 \n";
my @array = <FILE>;
close FILE;

my %hash = map {$_, 1} @array; # The array is converted in a hash, giving to each element (key) the value 1
my @new_array = keys %hash; # In this way the new_array doesn't contain contain duplicated elements

open (OUTPUT, ">ChainG_Contact_2bc1_Set.txt") or die print "Couldn't at 454 \n";
print OUTPUT sort {$a<=>$b} (@new_array); # This will order the chain A residues according to the primary structure.  
# A warning saying something like "Argument whatever isn't numeric" will appear. Just ignore it
close OUTPUT;

print "The work has been successfully completed \n\n See Detailed_1BE3_Results.txt and Contact_1BE3_Set files \n\n";
exit;


