
# A partir de los contactos entre A y B (contact file > raw_contact_A_B.txt):
# Creamos los identificadores únicos de los nodos de A:
cat raw_contact_A_B.txt | cut -f 1 | sort -u | sed "s/^...-/A-/g" > ids_A.txt
# Creamos los identificadores únicos de los nodos de B:
cat raw_contact_A_B.txt | cut -f 3 | sort -u | sed "s/^...-/B-/g" > ids_B.txt

# Completamos la tabla con los nodos de A y B
# en el archivo nodos.csv
cat nodosA.txt | sed "s/$/;1/g" > tmp_A
cat nodosB.txt | sed "s/$/;2/g" > tmp_B
echo "Id;Modularity Class" > nodos.csv
cat tmp_A tmp_B >> nodos.csv
rm tmp_A
rm tmp_B

# Ahora vamos con las aristas
echo "Source;Target;Type" > aristas.csv
cat raw_contact_A_B.txt | sed "s/	A	/	/g" | sed "s/	B$//g" | sed "s/	/;/g" | sed "s/$/;Undirected/g" >> aristas.csv
