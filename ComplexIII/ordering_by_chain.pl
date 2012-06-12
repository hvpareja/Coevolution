#!/usr/bin/perl

open (FILE, "ChainC_Contact_2bc1_Set.txt");
@file = <FILE>;
close FILE;

my @withChainA = grep (/Chain A/, @file);
for ($i=0; $i<scalar @withChainA; ++$i) {
    @cadena_A = split (/\s+/, $withChainA[$i]);
    push (@withA, $cadena_A[0], "\n");
}
my %A = map {$_ => 1} @withA; # From array to hash




my @withChainD = grep (/Chain D/, @file);
for ($i = 0; $i < scalar @withChainD; ++$i){
    @cadena_D = split (/\s+/, $withChainD[$i]);
    push (@withD, $cadena_D[0], "\n");
}
my %D = map {$_ => 1} @withD;



my @withChainE = grep (/Chain E\s+/, @file);
for ($i = 0; $i < scalar @withChainE; ++$i) {
    @cadena_E = split (/\s+/, $withChainE[$i]);
    push (@withE, $cadena_E[0], "\n");
}
my %E = map {$_ =>1} @withE;


my @withChainF = grep (/Chain F/, @file);
for ($i=0; $i < scalar @withChainF; ++$i) {
    @cadena_F = split (/\s+/, $withChainF[$i]);
    push (@withF, $cadena_F[0], "\n");
}
my %F = map {$_ => 1} @withF;



my @withChainG = grep (/Chain G/, @file);
for ($i=0; $i< scalar @withChainG; ++$i) {
    @cadena_G = split (/\s+/, $withChainG[$i]);
    push (@withG, $cadena_G[0], "\n");
}

my %G = map {$_ => 1} @withG;


my @withChainCC = grep (/Chain C2/, @file);
for ($i=0; $i< scalar @withChainCC; ++$i) {
    @cadena_CC = split (/\s+/, $withChainCC[$i]);
    push (@withCC, $cadena_CC[0], "\n");
}

my %CC = map {$_ => 1} @withCC;


my @withChainEE = grep (/Chain E2/, @file);
for ($i=0; $i< scalar @withChainEE; ++$i) {
    @cadena_E = split (/\s+/, $withChainEE[$i]);
    push (@withEE, $cadena_E[0], "\n");
}

my %EE = map {$_ => 1} @withEE;

#@EF = grep (defined $F{$_}, @withG);
#print @FG,"\n", scalar @FG, "\n";
#
#@union = (@withA, @withD, @withE, @withF, @withG, @withCC, @withEE);
#
#print @union, "\n"; exit;



#open (OUTPUT, ">Times.txt");
#
#for ($i = 1; $i< 379; ++$i) {
#    
#    @times = grep (/^$i$/, @union);
#    unless (scalar @times == 0) {
#         print OUTPUT $i, "\t", scalar @times, "\n";
#    }
#   
#}
#close OUTPUT;
#
#print "hola!";
#exit;

#    
#
#
#
#my @withChainH = grep (/Chain H/, @file);
#my @withChainI = grep (/Chain I/, @file);
#
#my @withChainJ = grep (/Chain J/, @file);
#my @withChainK = grep (/Chain K/, @file);
#
#

open (OUTPUT, ">temp.txt") or die print"Couldn't at 20 \n";

print OUTPUT "WITH CHAIN A: \n";
print OUTPUT @withChainA,"\n";
print OUTPUT "WITH CHAIN B: \n";
#print OUTPUT @withChainB, "\n";
print OUTPUT "WITH CHAIN D: \n";
print OUTPUT @withChainD,"\n";
print OUTPUT "WITH CHAIN E: \n";
print OUTPUT @withChainE, "\n";
print OUTPUT "WITH CHAIN F: \n";
print OUTPUT @withChainF,"\n";
print OUTPUT "WITH CHAIN G: \n";
print OUTPUT @withChainG, "\n";
print OUTPUT "WITH CHAIN H: \n";
#print OUTPUT @withChainH,"\n";
print OUTPUT "WITH CHAIN I: \n";
#print OUTPUT @withChainI, "\n";
print OUTPUT "WITH CHAIN J: \n";
#print OUTPUT "WITH CHAIN K: \n";
#print OUTPUT @withChainK, "\n";
print OUTPUT "WITH CHAIN C2: \n";
print OUTPUT @withChainCC, "\n";
print OUTPUT "WITH CHAIN E2: \n";
print OUTPUT @withChainEE, "\n";

close OUTPUT;
#
