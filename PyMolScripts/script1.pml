
# En este primer script de PyMol, vamos a trabajar con el complejo IV de la
# cadena transportadora de electrones. Vamos a mostrar la superficie de la
# cadena A (COX I) coloreada de rojo las zonas de contacto, y de amarillo en
# las zonas de no contacto. En el resto del complejo no mostraremos la super-
# ficie.

# Primero descargamos el complejo proteico usando el identificador PDB. El
# parámetro 'async (0 ó 1)' sirve para realizar el resto de las tareas de forma
# asíncrona (si su valor es 1) o por partes (si su valor es 0). En este caso
# necesitamos que sea por partes porque necesitamos descargar el fichero pdb
# antes de comenzar con el resto de las operaciones.
fetch 2occ, async=0

# Esconder todo para luego ir mostrando de forma selectiva lo que queremos
# manejar.
hide everything, all

# Mostrar todo de forma 'cartoon'. Existen distintas formas de mostrar las
# cadenas de las proteínas:
# ------------------------------------------------------------------------
#  angles      cgo         ellipsoids  lines       ribbon      surface   
#  callback    dashes      everything  mesh        slice       volume    
#  cartoon     dihedrals   extent      nb_spheres  spheres   
#  cell        dots        labels      nonbonded   sticks
# ------------------------------------------------------------------------
# Será interesante ir explorándolas todas
show cartoon, all

# Guardamos la cadena A en un objeto llamado 'obj_a'
create obj_a, chain A

# Coloreamos la cadena A de amarillo
color yellow, chain A

# Centramos la imagen en la cadena A, puesto que es la zona que nos interesa
# ver.
zoom chain A

# Mostramos la superficie de la cadena A pero llamando al objeto, no a la
# propia cadena.
show surface, obj_a

# Creamos una selección llamada 'contacto'. Esta selección debe cumplir
# con los criterios: resi <set separado por comas> AND chain A (que perte-
# nezcan a la cadena A). Los residuos que se han introducido provienen de otros
# cálculos realizados en perl (https://github.com/hvpareja/Coevolution)
select contacto, (resi 2,4,5,6,8,10,21,24,25,28,29,32,33,36,39,42,43,44,45,47,48,50,51,52,53,55,57,90,94,95,96,97,99,100,103,104,107,110,111,114,116,117,118,119,120,123,124,129,130,131,132,135,137,140,141,144,145,148,152,162,166,169,170,171,174,175,176,178,179,180,189,190,193,196,197,200,204,208,212,214,215,216,217,218,219,222,223,224,225,227,229,230,232,233,234,237,263,264,265,266,268,269,270,271,275,278,282,285,286,288,294,295,296,298,299,300,302,303,310,314,318,321,322,324,325,328,329,330,331,333,334,342,346,357,360,361,362,363,365,366,368,369,400,401,403,404,408,409,411,412,415,416,430,433,434,437,438,439,440,441,442,444,445,446,447,448,449,450,453,456,459,460,462,463,466,467,469,470,472,473,474,476,477,478,479,480,481,482,483,484,485,486,489,490,492,495,496,497,499,501,502,503,505,506,507,508,509,510,511,512,513,514 and chain A)

# Coloreamos de rojo la selección que hemos creado previamente
color red, contacto

# Eliminamos la selección para que no salgan puntos en la imagen
deselect

# Cambiamos el color de fondo a blanco
bg_color white

# Aquí termina el script, pero si queremos aprender un poco más como curiosidad
# sigamos:

# Ahora podemos animar la imagen para crear un video animado
# En primer lugar creamos una película con 60 frames
#mset 1 x60

# Ahora rotamos la molécula 360 grados en 60 frames
#util.mroll 1,60

# Para comenzar una animación en el mismo pymol:
#mplay

# Para parar la animación
#mstop

# Si queremos exportar los frames
#mpng frame

# Si lo que queremos es renderizar los frames (tardará mucho)
#set ray_trace_frames=1
#mpng frame

# Para crear el gif animado usaremos otras herramientas (png2gif & gifsicle)

