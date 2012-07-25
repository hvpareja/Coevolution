#!/usr/bin/perl -w
# calculatesK.pl

# Usage: <STDIN> | ./calculatesK.pl
  my $num_args = $#ARGV + 1;
 if ($num_args < 1) {
 print "ERROR: Missing arguments.\nUsage: <STDIN> | ./calculatesK.pl <FileName>\n";
  exit;
 }

my @dN = ();
my @dNSE = ();
my @dS = ();
my @dSSE = ();
my @omega = ();

my $fileName = $ARGV[0];

for my $row (<STDIN>){

    my @splited = split(/\s+/,$row);
    
    #print $row."\n";
    
    my $seq1  = $splited[1];
    my $seq2  = $splited[2];
    my $S     = $splited[3];
    my $N     = $splited[4];
    my $t     = $splited[5];
    my $kappa = $splited[6];
    my $omega = $splited[7];
    my $dN    = $splited[8];
    my $dNSE  = $splited[9];
    my $dS    = $splited[10];
    my $dSSE  = $splited[11];
    
    # Just in case
    $seq1  =~ s/\n//g;
    $seq2  =~ s/\n//g;
    $S     =~ s/\n//g;
    $N     =~ s/\n//g;
    $t     =~ s/\n//g;
    $kappa =~ s/\n//g;
    $omega =~ s/\n//g;
    $dN    =~ s/\n//g;
    $dNSE  =~ s/\n//g;
    $dS    =~ s/\n//g;
    # Actually needed
    $dSSE  =~ s/\n//g;
    
    #print $seq1."\n";
    #print $seq2."\n";
    #print $S."\n";
    #print $N."\n";
    #print $t."\n";
    #print $kappa."\n";
    #print $opega."\n";
    #print $dN."\n";
    #print $dNSE."\n";
    #print $dS."\n";
    #print $dSSE."\n";
    
    push(@dN, $dN);
    push(@dNSE, $dNSE);
    push(@dS, $dS);
    push(@dSSE, $dSSE);
    push(@omega, $omega);

    #print $row."\n";
    
}

my $kdN    = 0;
my $kdNSE  = 0;
my $kdS    = 0;
my $kdSSE  = 0;
my $kOmega = 0;

# Sum
for my $a (@dN){
    
    # dN sum
    $kdN = $kdN+$a;
    
}

for my $b (@dNSE){
    
    # SE sum
    $kdNSE = $kdNSE+$b;
    
}
for my $c (@dS){
    
    # dS sum
    $kdS = $kdS+$c;
    
}

for my $d (@dSSE){
    
    # SE sum
    $kdSSE = $kdSSE+$d;
    
}

#for my $e (@omega){
    
    # Omega sum
#    if($e != 99.0000){
        
#        $e = 9;
        
#    }
    
#    $kOmega = $kOmega+$e;
    
#}

if($kdN eq "nan"){ $kdN = 0 }
if($kdNSE eq "nan"){ $kdNSE = 0 }
if($kdS eq "nan"){ $kdS = 0 }
if($kdSSE eq "nan"){ $kdSSE = 0 }
if($kOmega eq "nan"){ $kOmega = 0 }

$fileName =~ s/^.*mer_\w+_//g;
$fileName =~ s/.phy$//g;
printf("%.3f\t%.3f\t%.3f\t%.3f\t $fileName\n", ($kdN , $kdNSE, $kdS, $kdSSE));