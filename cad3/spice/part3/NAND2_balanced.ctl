* ==========================
*   Title, Options, Models
* ==========================
.TITLE NAND2_balanced 

.OPTION
+ NODE
+ NOMOD
+ POST
+ PROBE
* ==========================
*            DUT
* ==========================
.INCLUDE "./NAND2_balanced.ckt"

** include freepdk45.l
.lib "freepdk45.l" tt_lib

.PARAM vdd=1.2
.PARAM vss=0

*  - 0 is a special character in HSPICE for the global ground
*  - Syntax: V<name> FROM<node> TO<node> VALUE

Vvdd vdd! 0 DC=vdd         * A voltage named "vdd" FROM the global node "vdd!" TO ground, of VALUE vdd=1.2
Vvss vss! 0 DC=0           * A voltage named "vss" FROM the global node "vss!" TO ground, of VALUE 0

x1 a b z NAND2_balanced W='W' 
* ==========================
*    Optimization Setup 
* ==========================
.PARAM w_min=90e-9
.PARAM w_max=1000e-9
.PARAM delta=2.5e-9
* PARAM parameter=optxxx (init_guess, low_limit, upper_limit, delta)
.PARAM W=optw(350e-9, w_min, w_max, delta)
.MODEL optmod opt itropt=40

* ==========================
*         Stimulus
* ==========================

* Vxx n+ n- <<DC=> val> <tran_func>>
* Vxx n+ n- PULSE <v1(init val) v2(plateau val) td(delay from beginning) tr tf pw(pulse width) per(pulse repetition period)>
* Vxx n+ b- PWL <Time1 Voltage1 <Time2 Voltage2 ...> <R=repeat> <TD=delay>>

Va a 0 PULSE 0 vdd 1e-9 10e-12 10e-12 3.02e-9 6.06e-9
Vb b 0 PULSE 0 vdd 1e-9 10e-12 10e-12 1e-9 2.02e-9

* ==========================
*         Analysis
* ==========================
* .TRAN tstep1 tstop1 [START=val] [UIC]
* .DC var1 start1 stop1 incr1 <SWEEP var 2 start2 stop2 incr2>
*.PARAM step='vdd/300'

.TRAN 1e-12 5.04e-9 START=0 SWEEP OPTIMIZE optw
+ RESULTS=diff MODEL=optmod

* ==========================
*       Measurement
* ==========================
.MEASURE TRAN fall_delay_1 TRIG V(b) VAL='vdd*0.5' RISE=1  * A: 0 B: 0 -> A: 1 B: 1
+                          TARG V(z) VAL='vdd*0.5' FALL=1

.MEASURE TRAN fall_delay_2 TRIG V(b) VAL='vdd*0.5' RISE=2  * A: 1 B: 0 -> A: 1 B: 1
+                          TARG V(z) VAL='vdd*0.5' FALL=2

.MEASURE TRAN fall_delay PARAM='max(fall_delay_1, fall_delay_2)'

.MEASURE TRAN rise_delay_1 TRIG V(b) VAL='vdd*0.5' FALL=1  * A: 1 B: 1 -> A: 1 B: 0
+                          TARG V(z) VAL='vdd*0.5' RISE=1

.MEASURE TRAN rise_delay_2 TRIG V(b) VAL='vdd*0.5' FALL=2  * A: 1 B: 1 -> A: 0 B: 0
+                          TARG V(z) VAL='vdd*0.5' RISE=2

.MEASURE TRAN rise_delay PARAM='max(rise_delay_1, rise_delay_2)'

.MEASURE TRAN rise_time_1 TRIG V(z) VAL='vdd*0.2' RISE=1 
+                         TARG V(z) VAL='vdd*0.8' RISE=1

.MEASURE TRAN rise_time_2 TRIG V(z) VAL='vdd*0.2' RISE=2 
+                         TARG V(z) VAL='vdd*0.8' RISE=2

.MEASURE TRAN rise_time PARAM='max(rise_time_1, rise_time_2)'


.MEASURE TRAN fall_time_1 TRIG V(z) VAL='vdd*0.8' FALL=1 
+                         TARG V(z) VAL='vdd*0.2' FALL=1

.MEASURE TRAN fall_time_2 TRIG V(z) VAL='vdd*0.8' FALL=2
+                         TARG V(z) VAL='vdd*0.2' FALL=2

.MEASURE TRAN fall_time PARAM='max(fall_time_1, fall_time_2)'

.MEASURE TRAN diff PARAM='abs(rise_time-fall_time)' goal=0

* ==========================
*          PROBE
* ==========================
* - Wildcard to probe all voltages/currents
*.probe V(*)
*.probe I(*)
* .probe lx4(M1)  * lx4 is a spice model "handle" for drain current in mos device
.PROBE V(a) V(b) V(z)
.END

