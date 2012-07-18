#!/usr/bin/perl -w
# empalma.pl

# Usage: <STDIN> | ./empalma.pl
  my $num_args = $#ARGV + 1;
 if ($num_args < 2) {
 print "ERROR: Missing arguments.\nUsage: ./empalma.pl <file1> <file2> [<file3> <file4> ...]\n";
  exit;
 }
 
 my $counter;
 for my $file (@ARGV){
    
    print $file."\n";
    open FH, $file;
    my @sequences = grep(/^[^0-9]/, <FH>);
    
    $counter = 0;
    for my $sequence (@sequences){
        
        print $sequence.$assembly[$counter];
        $counter++;
        
    }
    
    
 }