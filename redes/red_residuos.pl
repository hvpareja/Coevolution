#!/usr/bin/perl -w
# red_residuos.pl

my $num_args = $#ARGV + 1;
if ($num_args < 2) {
   print "ERROR: Missing arguments.\nUsage: ./red_residuos.pl <paresSinRepetir> <todosLosPares>\n";
   exit;
}

my $file1 = $ARGV[0];
my $file2 = $ARGV[1];

open PAR, $file1;
open TOD, $file2;

my @sinRepetir = <PAR>;
my @datos = <TOD>;

chomp(@sinRepetir);
chomp(@datos);

close PAR;
close TOD;
# The array is converted in a hash, giving to each element (key) the value 0
my %hash = map {$_, 0} @sinRepetir;

for my $par (@datos){
   
   $hash{$par} = $hash{$par} + 1;
   
}

foreach my $key (keys %hash){
   
   my @splited_key = split(/;/,$key);
   my $firstAA = $splited_key[0];
   my $secondAA = $splited_key[1];
   
   my $string = $firstAA.";".$secondAA.";".$hash{$firstAA.";".$secondAA}.";Undirected";   
   print $string."\n";
   
}



