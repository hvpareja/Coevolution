
# Merge Sequeces

# Contact
set="Contact"
./empalma.pl ComplexIV/MegaDATA/mer_A_${set}.phy ComplexIV/MegaDATA/mer_B_${set}.phy
./empalma.pl ComplexIV/MegaDATA/mer_A_${set}_mer_B_${set}.phy ComplexIV/MegaDATA/mer_C_${set}.phy
mv ComplexIV/MegaDATA/mer_A_${set}_mer_B_${set}_mer_C_${set}.phy ComplexIV/MegaDATA/mer_MIT_${set}.phy
rm ComplexIV/MegaDATA/mer_A_${set}_mer_B_${set}.phy

# NonContact
set="NonContact"
./empalma.pl ComplexIV/MegaDATA/mer_A_${set}.phy ComplexIV/MegaDATA/mer_B_${set}.phy
./empalma.pl ComplexIV/MegaDATA/mer_A_${set}_mer_B_${set}.phy ComplexIV/MegaDATA/mer_C_${set}.phy
mv ComplexIV/MegaDATA/mer_A_${set}_mer_B_${set}_mer_C_${set}.phy ComplexIV/MegaDATA/mer_MIT_${set}.phy
rm ComplexIV/MegaDATA/mer_A_${set}_mer_B_${set}.phy

# ContactBuried
set="ContactBuried"
./empalma.pl ComplexIV/MegaDATA/mer_A_${set}.phy ComplexIV/MegaDATA/mer_B_${set}.phy
./empalma.pl ComplexIV/MegaDATA/mer_A_${set}_mer_B_${set}.phy ComplexIV/MegaDATA/mer_C_${set}.phy
mv ComplexIV/MegaDATA/mer_A_${set}_mer_B_${set}_mer_C_${set}.phy ComplexIV/MegaDATA/mer_MIT_${set}.phy
rm ComplexIV/MegaDATA/mer_A_${set}_mer_B_${set}.phy

# NonContactBuried
set="NonContactBuried"
./empalma.pl ComplexIV/MegaDATA/mer_A_${set}.phy ComplexIV/MegaDATA/mer_B_${set}.phy
./empalma.pl ComplexIV/MegaDATA/mer_A_${set}_mer_B_${set}.phy ComplexIV/MegaDATA/mer_C_${set}.phy
mv ComplexIV/MegaDATA/mer_A_${set}_mer_B_${set}_mer_C_${set}.phy ComplexIV/MegaDATA/mer_MIT_${set}.phy
rm ComplexIV/MegaDATA/mer_A_${set}_mer_B_${set}.phy

# ContactExposed
set="ContactExposed"
./empalma.pl ComplexIV/MegaDATA/mer_A_${set}.phy ComplexIV/MegaDATA/mer_B_${set}.phy
./empalma.pl ComplexIV/MegaDATA/mer_A_${set}_mer_B_${set}.phy ComplexIV/MegaDATA/mer_C_${set}.phy
mv ComplexIV/MegaDATA/mer_A_${set}_mer_B_${set}_mer_C_${set}.phy ComplexIV/MegaDATA/mer_MIT_${set}.phy
rm ComplexIV/MegaDATA/mer_A_${set}_mer_B_${set}.phy

# NonContactExposed
set="NonContactExposed"
./empalma.pl ComplexIV/MegaDATA/mer_A_${set}.phy ComplexIV/MegaDATA/mer_B_${set}.phy
./empalma.pl ComplexIV/MegaDATA/mer_A_${set}_mer_B_${set}.phy ComplexIV/MegaDATA/mer_C_${set}.phy
mv ComplexIV/MegaDATA/mer_A_${set}_mer_B_${set}_mer_C_${set}.phy ComplexIV/MegaDATA/mer_MIT_${set}.phy
rm ComplexIV/MegaDATA/mer_A_${set}_mer_B_${set}.phy

# Total
set="Total"
./empalma.pl ComplexIV/MegaDATA/mer_A_${set}.phy ComplexIV/MegaDATA/mer_B_${set}.phy
./empalma.pl ComplexIV/MegaDATA/mer_A_${set}_mer_B_${set}.phy ComplexIV/MegaDATA/mer_C_${set}.phy
mv ComplexIV/MegaDATA/mer_A_${set}_mer_B_${set}_mer_C_${set}.phy ComplexIV/MegaDATA/mer_MIT_${set}.phy
rm ComplexIV/MegaDATA/mer_A_${set}_mer_B_${set}.phy