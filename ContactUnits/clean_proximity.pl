#!/usr/bin/perl -w
# clean_proximity.pl

# Script en perl para eliminar de la tabla "proximity" aquellos pares de ‡tomos
# pertenecientes a residuos que tienen otros pares m‡s cercanos. (Eliminar
# residuos respetidos para quedarnos solo con el valor de proximidad m‡s bajo.)
# Usage: ./clean_proximity.pl <detailedFile>
my $num_args = $#ARGV + 1;
if ($num_args < 1) {
   print "ERROR: Missing arguments.\nUsage: ./clean_proximity.pl <detailedFile>\n";
   exit;
}

# Archivo de entrada:
my $fileName = $ARGV[0];
open DET, $fileName;
my @list = <DET>;
close DET;

# Nueva lista (la de salida)
my @new_list = ();
for $line (@list){
   
   my @splited_line = split(/\t/,$line);
   
   my $cadena = $splited_line[0];
   my $res1   = $splited_line[3];
   my $res2   = $splited_line[4];
   
   if($res1 != $res2){
      if(!grep(/^$cadena\t[0-9]*\t[0-9]*\t$res1\t$res2/,@new_list) && !grep(/^$cadena\t[0-9]*\t[0-9]*\t$res2\t$res1/,@new_list)){   
         push(@new_list, $line);
      }
   }
   
}

for $line (@new_list){
   
   print $line;
   
}