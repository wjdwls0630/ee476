* ==========================
*   Title, Options, Models
* ==========================
.TITLE ring_osc_plot 

.OPTION
+ NODE
+ NOMOD
+ POST
+ PROBE
* ==========================
*            DUT
* ==========================
.INCLUDE "./ring_osc.ckt"
.INCLUDE "./ring_osc.pex.netlist"
.INCLUDE "./ring_osc_2x.ckt"

** include freepdk45.l
.lib "freepdk45.l" tt_lib

.PARAM vdd=1.2
.PARAM vss=0

*  - 0 is a special character in HSPICE for the global ground
*  - Syntax: V<name> FROM<node> TO<node> VALUE

Vvdd vdd! 0 DC=vdd         * A voltage named "vdd" FROM the global node "vdd!" TO ground, of VALUE vdd=1.2
Vvss vss! 0 DC=0           * A voltage named "vss" FROM the global node "vss!" TO ground, of VALUE 0

x1 osc_en osc_out ring_osc 
x2 osc_en osc_out_layout ring_osc_pex 
x3 osc_en osc_out_2x ring_osc_2x 
* ==========================
*         Stimulus
* ==========================

* Vxx n+ n- <<DC=> val> <tran_func>>
* Vxx n+ n- PULSE <v1(init val) v2(plateau val) td(delay from beginning) tr tf pw(pulse width) per(pulse repetition period)>
* Vxx n+ n- PWL <Time1 Voltage1 <Time2 Voltage2 ...> <R=repeat> <TD=delay>>

Ven osc_en 0 PWL 0 0 1e-9 0 1.01e-9 vdd

* ==========================
*         Analysis
* ==========================
* .TRAN tstep1 tstop1 [START=val] [UIC]
* .DC var1 start1 stop1 incr1 <SWEEP var 2 start2 stop2 incr2>
.PARAM step='(1.2-0.7)/10'

.TRAN 1e-12 10e-9 START=0 SWEEP vdd 0.7 1.2 step 

* ==========================
*       Measurement
* ==========================
.MEASURE TRAN osc_period TRIG V(osc_out) VAL='vdd*0.5' TD=5e-9 RISE=1
+                          TARG V(osc_out) VAL='vdd*0.5' RISE=2

.MEASURE TRAN osc_freq PARAM='1/osc_period'

.MEASURE TRAN osc_period_layout TRIG V(osc_out_layout) VAL='vdd*0.5' TD=5e-9 RISE=1
+                          TARG V(osc_out_layout) VAL='vdd*0.5' RISE=2

.MEASURE TRAN osc_freq_layout PARAM='1/osc_period_layout'

.MEASURE TRAN osc_period_2x TRIG V(osc_out_2x) VAL='vdd*0.5' TD=5e-9 RISE=1
+                          TARG V(osc_out_2x) VAL='vdd*0.5' RISE=2

.MEASURE TRAN osc_freq_2x PARAM='1/osc_period_2x'

* ==========================
*          PROBE
* ==========================
* - Wildcard to probe all voltages/currents
*.probe V(*)
*.probe I(*)
* .probe lx4(M1)  * lx4 is a spice model "handle" for drain current in mos device
.PROBE V(osc_en) V(osc_out) V(osc_out_layout) V(osc_out_2x)
.PROBE PAR(osc_freq) PAR(osc_freq_layout) PAR(osc_freq_2x)
.END

