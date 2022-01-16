* ==========================
*   Title, Options, Models
* ==========================
.TITLE loaded_inverter 

.OPTION
+ ARTIST=2
+ INGOLD=2
+ PARHIER=LOCAL
+ PSF=2
+ NODE
+ NOMOD
+ POST
+ PROBE
+ redefsub
* ==========================
*            DUT
* ==========================
.INCLUDE "./loaded_inverter.ckt"

** include freepdk45.l
.lib "freepdk45.l" tt_lib

.PARAM vdd=1.2
.PARAM vss=0

*  - 0 is a special character in HSPICE for the global ground
*  - Syntax: V<name> FROM<node> TO<node> VALUE

Vvdd vdd! 0 DC=vdd         * A voltage named "vdd" FROM the global node "vdd!" TO ground, of VALUE vdd=1.2
Vvss vss! 0 DC=0           * A voltage named "vss" FROM the global node "vss!" TO ground, of VALUE 0

x1 vi vo loaded_inverter 
* ==========================
*         Stimulus
* ==========================

* Vxx n+ n- <<DC=> val> <tran_func>>
* Vxx n+ n- PULSE <v1(init val) v2(plateau val) td(delay from beginning) tr tf pw(pulse width) per(pulse repetition period)>
* Vxx n+ b- PWL <Time1 Voltage1 <Time2 Voltage2 ...> <R=repeat> <TD=delay>>

Vvi vi 0 PULSE 0 vdd 1e-9 10e-12 10e-12 1e-9 2.02e-9

* ==========================
*         Analysis
* ==========================
* .TRAN tstep1 tstop1 [START=val] [UIC]
* .DC var1 start1 stop1 incr1 <SWEEP var 2 start2 stop2 incr2>
.PARAM step='vdd/300'

.TRAN 1e-12 3.02e-9 START=0 SWEEP vdd POI 2 0.8 1.2

* ==========================
*       Measurement
* ==========================
.MEASURE TRAN rise_delay TRIG V(vi) VAL='vdd*0.5' TD=2e-9 FALL=1 * propagation delay high-to-low
+                        TARG V(vo) VAL='vdd*0.5' RISE=1

.MEASURE TRAN fall_delay TRIG V(vi) VAL='vdd*0.5' TD=0 RISE=1 * propagation delay low-to-high
+                        TARG V(vo) VAL='vdd*0.5' FALL=1

.MEASURE TRAN rise_time TRIG V(vo) VAL='vdd*0.2' TD=2e-9 RISE=1 
+                       TARG V(vo) VAL='vdd*0.8' RISE=1

.MEASURE TRAN fall_time TRIG V(vo) VAL='vdd*0.8' TD=0 FALL=1 
+                       TARG V(vo) VAL='vdd*0.2' FALL=1
* ==========================
*          PROBE
* ==========================
* - Wildcard to probe all voltages/currents
*.probe V(*)
*.probe I(*)
* .probe lx4(M1)  * lx4 is a spice model "handle" for drain current in mos device
.PROBE V(vi) V(vo)

.END

