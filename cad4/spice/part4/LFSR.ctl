* ==========================
*   Title, Options, Models
* ==========================
.TITLE LFSR 

.OPTION
+ NODE
+ NOMOD
+ PROBE
* ==========================
*            DUT
* ==========================
.INCLUDE "./LFSR.ckt"
.INCLUDE "./INV1.ckt"

** include freepdk45.l
.lib "freepdk45.l" tt_lib

.PARAM vdd=1.2
.PARAM vss=0

*  - 0 is a special character in HSPICE for the global ground
*  - Syntax: V<name> FROM<node> TO<node> VALUE

Vvdd vdd! 0 DC=vdd         * A voltage named "vdd" FROM the global node "vdd!" TO ground, of VALUE vdd=1.2
Vvss vss! 0 DC=0           * A voltage named "vss" FROM the global node "vss!" TO ground, of VALUE 0

Vvdd_inv vdd 0 DC=vdd         * A voltage named "vdd" FROM the global node "vdd!" TO ground, of VALUE vdd=1.2
Vvss_inv vss 0 DC=0           * A voltage named "vss" FROM the global node "vss!" TO ground, of VALUE 0


xrstinv0 RST_ideal n_rst vdd vss INV1 M=1 
xrstinv1 n_rst rst vdd vss INV1 M=4

xclkinv0 CLK_ideal n_clk vdd vss INV1 M=1 
xclkinv1 n_clk clk vdd vss INV1 M=4

xlfsr0 rst clk 
+ state[0] state[1] state[2] state[3]
+ state[4] state[5] state[6] state[7]
+ state[8] state[9] state[10] state[11]
+ state[12] state[13] state[14] state[15]
+ LFSR
* ==========================
*         Stimulus
* ==========================

* Vxx n+ n- <<DC=> val> <tran_func>>
* Vxx n+ n- PULSE <v1(init val) v2(plateau val) td(delay from beginning) tr tf pw(pulse width) per(pulse repetition period)>
* Vxx n+ b- PWL <Time1 Voltage1 <Time2 Voltage2 ...> <R=repeat> <TD=delay>>
VRST_ideal RST_ideal 0 PWL 0 0 0.39e-9 0 0.4e-9 vdd 1.47e-9 vdd 1.48e-9 0 
VCLK_ideal CLK_ideal 0 PULSE 0 vdd 0.98e-9 0.01e-9 0.01e-9 0.98e-9 2e-9
* ==========================
*         Analysis
* ==========================
* ==========================
*         Analysis
* ==========================
* .TRAN tstep1 tstop1 [START=val] [UIC]
* .DC var1 start1 stop1 incr1 <SWEEP var 2 start2 stop2 incr2>
*.PARAM step='vdd/300'

.TRAN 1e-12 35e-9 START=0 

* ==========================
*       Measurement
* ==========================
*.MEASURE TRAN t_cq_rise TRIG V(clk) VAL='vdd*0.5' RISE=2  
*+                       TARG V(q)   VAL='vdd*0.5' RISE=1
*
*.MEASURE TRAN t_cq_fall TRIG V(clk) VAL='vdd*0.5' RISE=3  
*+                       TARG V(q)   VAL='vdd*0.5' FALL=1
*
*
*.MEASURE TRAN diff PARAM='abs(t_cq_rise-t_cq_fall)' goal=0
*.MEASURE TRAN t_cq PARAM='0.5*(t_cq_rise+t_cq_fall)' goal=0
*
.MEASURE TRAN t_clk_rise_i TRIG AT=0
+                     TARG V(clk) VAL='vdd*0.01' RISE=2
*
.MEASURE TRAN t_clk_rise_f TRIG AT=0
+                     TARG V(clk) VAL='vdd*0.01' RISE=17
*
*.MEASURE TRAN t_clk_steady_i TRIG AT=0
*+                     TARG V(clk) VAL='vdd*0.01' RISE=4
*
*.MEASURE TRAN t_clk_steady_f TRIG AT=0
*+                     TARG V(clk) VAL='vdd*0.01' RISE=5
*
.MEASURE TRAN en_total INTEGRAL '-P(Vvdd)' FROM=t_clk_rise_i TO=t_clk_rise_f
.MEASURE TRAN en_per_clock PARAM='en_total/15'
* ==========================
*          PROBE
* ==========================
* - Wildcard to probe all voltages/currents
.probe V(*) 
*.probe I(*)
* .probe lx4(M1)  * lx4 is a spice model "handle" for drain current in mos device
*.PROBE V(D) V(Q) V(CLK) V(RST)
*.PROBE P(xldfsr0.xdfsr0)
.END
