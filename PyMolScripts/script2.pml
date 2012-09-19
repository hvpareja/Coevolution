
# Este script muestra la superficie de la cadena A y las cadenas laterales
# de los residuos de las cadenas en contacto con ella.
# En primer lugar es necesario correr el script 1 (script1.pml).
@script1.pml
# Posteriormente:

# Creamos dos grupos de cadenas: Cadenas en contacto (contactChains) y
# cadenas no en contacto (nonContactChains). En nuestro caso son:
select nonContactChains, chain E or chain H or chain N or chain O or chain P or chain Q or chain R or chain S or chain V or chain W or chain X or chain Y or chain Z or chain U
select contactChains, chain L or chain C or chain J or chain M or chain D or chain B or chain G or chain T or chain F or chain I or chain K

# Posteriormente escondemos el grupo de las cadenas de no contacto.
hide everything, nonContactChains

# Orientamos la proteína y hacemos zoom en la zona en la que estamos trabajando
orient
zoom contactChains

# Mostramos las cadenas en contacto como tubos
show cartoon, contactChains
cartoon tube

# Ahora activamos la ayuda para mostrar cadenas laterales de residuos. Según
# la wiki de PyMol: "is an easy way (in cartoon mode) to only show the side
# chain of a residue".
set cartoon_side_chain_helper, on

# Mostramos las cadenas laterales (poly) de las cadenas en contacto
show sticks, poly and contactChains

# Seleccionamos solo las cadenas laterales
select sidechains, contactChains and not n. C+O+N+CA

# Las coloreamos de azul
color blue, sidechains

# Configuramos la resolución a 2.5.
set gaussian_resolution, 2.5

# Creamos un mapa de las cadenas laterales. Este comando se suele usar
# para crear superficies de baja resolución. La sintaxis es la siguiente:
# map_new name [, type [, grid [, selection [, buffer [, box [, state]]]]]]
# Donde (ver http://www.pymolwiki.org/index.php/Map_new):
# ------
# name      = string: name of the map object to create or modify
# type      = vdw, gaussian, gaussian_max, coulomb, coulomb_neutral,
              coulomb_local {default: gaussian}
# grid      = float: grid spacing {default: gaussian_resolution/3.0}
# selection = string: atoms about which to generate the map {default: (all)}
# buffer    = float: cutoff {default: gaussian_resolution}
# state     = integer: object state {default: 0}
# state     > 0: use the indicated state
# state     = 0: use all states independently with independent extents
# state     = -1: use current global state
# state     = -2: use effective object state(s)
# state     = -3: use all states in one map
# state     = -4: use all states independent states by with a unified extent
# ------
# Ojo, tarda bastante en computar
map_new map, gaussian, 0.2, sidechains, 5

# Una vez creado el mapa, creamos la superficie a partir de él. El comando
# isosurface tiene la sintaxis:
# isosurface name, map, level [, (selection) [, buffer [,state [,carve]]]]
# Donde (ver http://www.pymolwiki.org/index.php/Isosurface):
# ------
# name      = the name for the new mesh isosurface object.
# map       = the name of the map object to use for computing the mesh.
# level     = the contour level.
# selection = an atom selection about which to display the mesh with an
#             additional "buffer" (if provided).
# state     = the state into which the object should be loaded (default=1)
#             (set state=0 to append new surface as a new state)
# carve     = a radius about each atom in the selection for which to include density.
#             If "carve= not provided, then the whole brick is displayed.
# ------
# Ojo, tarda muchísimo en computar (cierra todos los programas antes de esto)
isosurface surf, map, 5.0

# Coloreamos la superficie de las cadenas laterales (a la que le hemos llamado
# surf en la línea anterior). No hace caso y no sé por qué :(
color blue, surf
hide sticks
 
# reconnect the main chain to the blobs
show sticks, sidechains n. CA+CB