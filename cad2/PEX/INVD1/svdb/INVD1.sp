* SPICE NETLIST
***************************************

.SUBCKT INVD1 vi vo vss! vdd!
** N=4 EP=4 IP=0 FDC=2
M0 vo vi vss! vss! NMOS_VTG L=6e-08 W=3e-07 AD=3.15e-14 AS=3.15e-14 PD=8.1e-07 PS=8.1e-07 $X=5570 $Y=-13400 $D=5
M1 vo vi vdd! vdd! PMOS_VTG L=6e-08 W=4e-07 AD=4.2e-14 AS=4.2e-14 PD=1.01e-06 PS=1.01e-06 $X=5570 $Y=-12830 $D=4
.ENDS
***************************************
