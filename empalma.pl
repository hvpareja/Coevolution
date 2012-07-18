#!/usr/bin/perl -w
# empalma.pl

# Usage: <STDIN> | ./empalma.pl
  my $num_args = $#ARGV + 1;
 if ($num_args < 2) {
 print "ERROR: Missing arguments.\nUsage: ./empalma.pl <file1> <file2>\n";
  exit;
 }
 
 my $file1 = $ARGV[0];
 my $file2 = $ARGV[1];
 
 open FH1, $file1;
 open FH2, $file2;
 
 # Remove extension in file1
 $file1 =~ s/\..*$//g;
 
 # Remove path (leave just the file name in the second file)
 $file2 =~ s/^.*\///g;
 
 # Store the output in file1 path
 my $file_output = $file1."_".$file2;
 open FOUT, ">$file_output";
 print "OUTPUT: ".$file_output."\n";
 
 my @complete_file1 = <FH1>;
 my @complete_file2 = <FH2>;
 
 my @header1 = split(/\s+/, $complete_file1[0]);
 my @header2 = split(/\s+/, $complete_file2[0]);
 
 my $seq1_len = $header1[2];
 my $seq2_len = $header2[2];
 
 my $number_of_species = $header1[1];
 
 #print $seq1_len." ".$seq2_len."\n";
 my $new_seq_len = $seq1_len + $seq2_len;
 printf FOUT "%5s%7s\n", $number_of_species,$new_seq_len;

 my @file1_content = grep(/[A,T,G,C]/,<FH1>);
 my @file2_content = grep(/[A,T,G,C]/,<FH2>);

# Handing data from file2
my @file2_sequences = ();
my @file2_names = ();
for my $line2 (@file2_content){
        
    my @splited_line2 = split(/\s+/, $line2);
    my $sequence_name2 = $splited_line2[0];
    my $sequence_seq2 = $splited_line2[1];        
    # Store sequence in array
    push(@file2_sequences, $sequence_seq2);
    push(@file2_names, $sequence_name2);
        
}
 
 for my $line (@file1_content){
    
    my @splited_line = split(/\s+/, $line);
    my $sequence_name = $splited_line[0];
    my $sequence_seq  = $splited_line[1];
    
    my $match = 0;
    
    my $matching_sequence = "";
    my $matching_name = "";

        
    while($match == 0){
        my $counter = 1;
        print "Please, select one of the following sequences to match with the above specified specie:\n";
        
        for my $item (@file2_names){
            
            print $counter.". ".$item."\n";
            $counter++;
            
        }
        
        print "Sequence for ".uc($sequence_name).":\n";
        my $selected_number = <STDIN>;
        # Remove the new line
        $selected_number =~ s/\n//g;
        # Cero is the first one
        $selected_number--;
        if($file2_sequences[$selected_number]){
            $match = 1;
            $matching_sequence = $file2_sequences[$selected_number];
            $matching_name = $file2_names[$selected_number];
            delete $file2_sequences[$selected_number];
            shift(@file2_sequences);
            delete $file2_names[$selected_number];
            shift(@file2_names);
        }else{
            print "Incorrect selection!!\n";
        }
        
    }
    
    print "STORED: ".$sequence_name." + ".$matching_name;
    if($sequence_name eq $matching_name){ print "\n"; }else{ print "\n"; }
    $sequence_name =~ s/\ //g;
    printf FOUT "%-9s  %s%s\n",$sequence_name,$splited_line[1],$matching_sequence;
    
    
 }
 
 close FH1;
 close FH2;
 close FOUT;
 
 
 
