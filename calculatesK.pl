#!/usr/bin/perl -w
# calculatesK.pl

# Usage: <STDIN> | ./calculatesK.pl
  my $num_args = $#ARGV + 1;
 if ($num_args < 1) {
 print "ERROR: Missing arguments.\nUsage: <STDIN> | ./calculatesK.pl <FileName>\n";
  exit;
 }

my @dN = ();
my @SE = ();
my $k  = 0;
my $desv = 0;
my $fileName = $ARGV[0];

for my $row (<STDIN>){

    my @splited = split(/   /,$row);
    my $first = $splited[0];
    my $secon = $splited[1];
    
    $first =~ s/\n//g;
    $secon =~ s/\n//g;
    
    push(@dN, $first);
    push(@SE, $secon);
    
}

for my $a (@dN){
    
    # dN sum
    $k = $k+$a;
    #print "A: ".$a."\n"
    
}

for my $b (@SE){
    
    # SE sum
    $desv = $desv+$b;
    #print "B: ".$b."\n"
    
}

$fileName =~ s/^mer_\w+_//g;
$fileName =~ s/.phy$//g;
print "$k\t$desv\t$fileName\n";