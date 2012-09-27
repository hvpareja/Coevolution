#!/usr/bin/perl -w
# proximity.pl

# Script en perl para calcular la distancia entre los ‡tomos de una misma
# cadena (A), que a su vez est‡n en contacto con una cadena (B). Partimos
# de un archivo "detailed" que proviene de uno de los dos output de contact.pl.
# Usage: ./proximity.pl <detailedFile> <pdbFile> <chainA> <chainB>
my $num_args = $#ARGV + 1;
if ($num_args < 4) {
   print "ERROR: Missing arguments.\nUsage: ./proximity.pl <detailedFile> <pdbFile> <chainA> <chainB>\n";
   exit;
}

# Capturamos los argumentos en sus variables:
my $detailedFile = $ARGV[0];
my $pdbFile      = $ARGV[1];
my $chainA       = $ARGV[2];
my $chainB       = $ARGV[3];
 
# En primer lugar leemos el archivo "detailed" y seleccionamos s—lo aquellas
# l’neas que contengan las dos cadenas que deseamos.
open DET, $detailedFile;
open PDB, $pdbFile;
my @pdbData = <PDB>;

my @linesSelected = grep(/^A\tB/, <DET>);

# Array to store "A" atoms
my @A_array = ();
# Array to store "B" atoms
my @B_array = ();

foreach $line (@linesSelected){
    
    # Separa las columnas por tabulador
    my @split_line = split(/\t/,$line);
    # Take the third column and take the ATOM id
    my @A_second_split_line = split(/ /,$split_line[2]);
    # Take the fourth column and take the ATOM id
    my @B_second_split_line = split(/ /,$split_line[3]);
    
    # Aqu’ guardo todos los ‡tomos en contacto de la cadena A
    push(@A_array,$A_second_split_line[0]);
    # Aqu’ guardo todos los ‡tomos en contacto de la cadena B
    push(@B_array,$B_second_split_line[0]);
    
}

# Ahora, por cada uno de los ‡tomos de las cadenas, vamos a almacenar en los
# siguientes arrays:
my @coord_A_x = ();
my @coord_A_y = ();
my @coord_A_z = ();
my @residueA  = ();
my @aas_A     = ();

my @coord_B_x = ();
my @coord_B_y = ();
my @coord_B_z = ();
my @residueB  = ();
my @aas_B     = ();
# las coordenadas de los ‡tomos que est‡n en los arrays creados arriba. As’,
# obtenemos dos pares de array, un para para cada cadena, en el mismo orden.

#print "Searching chain $chainA coordinates ...\n";
for $atomo (@A_array){
    
        # Consulto el PDB y extraigo la l’nea que me interesa
    my @query = grep(/^ATOM\s+$atomo\s+\w+(\s|.+)+\w{3}\s+$chainA/, @pdbData);
    my $atom_info = $query[0];
    my $atom_res  = $atom_info;
    my $residue_type = $atom_info;
    if(!$atom_info){ next; }
    
    # Extraemos el numero de residuo al que pertenece el Ã¡tomo
    $atom_res =~ s/^ATOM\s+\d+\s+\w+(\s|.+)+\w{3}\s+\w+\s+//g;
    $atom_res =~ s/\s+.*$//g;
    
    # Extraemos el typo de residuo (el amino‡cido)
    $residue_type =~ s/^ATOM\s+\d+\s+\w+(\s|.+)+//g;
    $residue_type =~ s/\s+$chainA+.+\s(\S+\.\S+)\s+(\S+\.\S+)\s+(\S+\.\S+)\s+.*$//g;

    # Ahora elimino con expresiones regulares toda la informac’on de la l’nea
    # que no son las coordenadas.
    # m/ATOM\s+\d+\s+(\w+)(\s|.+)+\w{3}\s+$chainID+.+\s(\S+\.\S+)\s+(\S+\.\S+)\s+(\S+\.\S+)\s+.+\..+\..+/ig)
    # Al principio
    $atom_info =~ s/^ATOM\s+$atomo\s+\w+(\s|.+)+\w{3}\s+$chainA\s+\d+\s+//g;
    # Al final
    $atom_info =~ s/\s+\S+\s+\S+\s+\w+\s*$//g;
    
    my @coord_A = split(/\s+/,$atom_info);
    
    push(@aas_A,$residue_type);
    push(@residueA,$atom_res);
    push(@coord_A_x,$coord_A[0]);
    push(@coord_A_y,$coord_A[1]);
    push(@coord_A_z,$coord_A[2]);
    
}

#print "Searching chain $chainB coordinates ...\n";
for $atomo (@B_array){
    
        # Consulto el PDB y extraigo la l’nea que me interesa
    my @query = grep(/^ATOM\s+$atomo\s+\w+(\s|.+)+\w{3}\s+$chainB/, @pdbData);
    my $atom_info = $query[0];
    my $atom_res  = $atom_info;
    
    my $residue_type = $atom_info;
    if(!$atom_info){ next; }
    
    # Extraemos el numero de residuo al que pertenece el Ã¡tomo
    $atom_res =~ s/^ATOM\s+\d+\s+\w+(\s|.+)+\w{3}\s+\w+\s+//g;
    $atom_res =~ s/\s+.*$//g;
    
    # Extraemos el typo de residuo (el amino‡cido)
    $residue_type =~ s/^ATOM\s+\d+\s+\w+(\s|.+)+//g;
    $residue_type =~ s/\s+$chainB+.+\s(\S+\.\S+)\s+(\S+\.\S+)\s+(\S+\.\S+)\s+.*$//g;
    
    # Ahora elimino con expresiones regulares toda la informac’on de la l’nea
    # que no son las coordenadas.
    # m/ATOM\s+\d+\s+(\w+)(\s|.+)+\w{3}\s+$chainID+.+\s(\S+\.\S+)\s+(\S+\.\S+)\s+(\S+\.\S+)\s+.+\..+\..+/ig)
    # Al principio
    $atom_info =~ s/^ATOM\s+$atomo\s+\w+(\s|.+)+\w{3}\s+$chainB\s+\d+\s+//g;
    # Al final
    $atom_info =~ s/\s+\S+\s+\S+\s+\w+\s*$//g;
    
    my @coord_B = split(/\s+/,$atom_info);
    
    push(@aas_B,$residue_type);
    push(@residueB,$atom_res);
    push(@coord_B_x,$coord_B[0]);
    push(@coord_B_y,$coord_B[1]);
    push(@coord_B_z,$coord_B[2]);
    
}

# Posteriormente, por cada uno de los residuos de cada una de las dos cadenas,
# tomamos las coordenadas en el PDB y calculamos la norma entre cada uno de los
# ‡tomos de la misma cadena, siempre y cuando Žstos pertenezcan a residuos
# distintos.
#print "Calculating chain $chainA distances ...\n";
for(my $i=0;$i<=$#coord_A_x;$i++){
    
    for(my $j=0;$j<=$#coord_A_x;$j++){
     
        my $distance = sqrt( ($coord_A_x[$i]-$coord_A_x[$j])**2 +
                             ($coord_A_y[$i]-$coord_A_y[$j])**2 +
                             ($coord_A_z[$i]-$coord_A_z[$j])**2 );
        
        print $chainA."\t".$A_array[$i]."\t".$A_array[$j]."\t".$residueA[$i]."\t".$residueA[$j]."\t".$distance."\n";
        
    }
    
}
#print "Calculating chain $chainB distances ...\n";
for(my $i=0;$i<=$#coord_B_x;$i++){
    
    for(my $j=0;$j<=$#coord_B_x;$j++){
     
        my $distance = sqrt( ($coord_B_x[$i]-$coord_B_x[$j])**2 +
                             ($coord_B_y[$i]-$coord_B_y[$j])**2 +
                             ($coord_B_z[$i]-$coord_B_z[$j])**2 );
        
        print $chainB."\t".$B_array[$i]."\t".$B_array[$j]."\t".$residueB[$i]."\t".$residueB[$j]."\t".$distance."\n";
        
    }
    
}

