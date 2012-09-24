#!/usr/bin/perl -w
# red_cadenas.pl

my $num_args = $#ARGV + 1;
if ($num_args < 1) {
   print "ERROR: Missing arguments.\nUsage: ./red_cadenas.pl <contactFile>\n";
   exit;
}


# Contact file
my $contactFile = $ARGV[0];
open CON, $contactFile;
my @contactData = <CON>;
close CON;

# Array de las columnas
my @first = ();
my @secon = ();
my @hash_keys = ();
# Introduzco cada identificador de columna en
# un array distinto. Luego los recorremos y contamos
# cada par.
for my $line (@contactData){
   
   my @splited_line = split(/\t/, $line);
   my $split_one = $splited_line[1];
   my $split_two = $splited_line[3];
   
   chomp($split_one);
   chomp($split_two);
   
   push(@first,$split_one);
   push(@secon,$split_two);
   push(@hash_keys,$split_one.$split_two);
   #print $split_one.$split_two."\n";
      
}

# Eliminar los repetidos de las keys del hash
# The array is converted in a hash, giving to each element (key) the value 0
my %hash = map {$_, 0} @hash_keys;

for(my $i=0;$i<=$#first;$i++){
   
   $hash{$first[$i].$secon[$i]} = $hash{$first[$i].$secon[$i]} + 1;
   
}

foreach my $key (keys %hash) {
   
   print substr($key,0,1).";".substr($key,1,1).";".$hash{$key}."\n";
   
}

