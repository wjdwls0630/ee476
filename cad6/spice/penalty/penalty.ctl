.OPTION
+ NODE
+ NOMOD
+ PROBE
* ==========================
*            DUT
* ==========================
.INCLUDE "./penalty.ckt"

** include freepdk45.l
.lib "freepdk45.l" tt_lib

x_invdut VOUT IN VSS! VDD! penalty
.PARAM vdd=1.2
.PARAM vss=0

Vsup VDD! 0 vdd
Vgnd VSS! 0 vss
Vvin IN VSS! pulse(vdd 0 100p 5p 5p 1n 2n)



.tran 1p 900p 


.meas tran td trig V(IN) VAL=0.6 FALL=1  targ V(VOUT) VAL=0.6 rise=1
