* ==========================
*   Title, Options, Models
* ==========================
.TITLE loaded_flip_flop_hold_rise 

.OPTION
+ NODE
+ NOMOD
+ PROBE
* ==========================
*            DUT
* ==========================
.INCLUDE "./loaded_flip_flop.ckt"
.INCLUDE "./INVD1.ckt"

** include freepdk45.l
.lib "freepdk45.l" tt_lib

.PARAM vdd=1.2
.PARAM vss=0

*  - 0 is a special character in HSPICE for the global ground
*  - Syntax: V<name> FROM<node> TO<node> VALUE

Vvdd vdd! 0 DC=vdd         * A voltage named "vdd" FROM the global node "vdd!" TO ground, of VALUE vdd=1.2
Vvss vss! 0 DC=0           * A voltage named "vss" FROM the global node "vss!" TO ground, of VALUE 0

xdinv0 D_ideal n_d INVD1 
xdinv1 n_d d INVD1 

xrstinv0 RST_ideal n_rst INVD1 
xrstinv1 n_rst rst INVD1 

xclkinv0 CLK_ideal n_clk INVD1 
xclkinv1 n_clk clk INVD1 

xldfsr0 d rst q clk loaded_flip_flop 

* ==========================
*    Optimization Setup 
* ==========================
.PARAM delay=optd(-0.5n -0.5n -1.5n)

.MODEL optmod opt
+ METHOD=passfail
+relin=0.0001 relout=0.001
* ==========================
*         Stimulus
* ==========================

* Vxx n+ n- <<DC=> val> <tran_func>>
* Vxx n+ n- PULSE <v1(init val) v2(plateau val) td(delay from beginning) tr tf pw(pulse width) per(pulse repetition period)>
* Vxx n+ b- PWL <Time1 Voltage1 <Time2 Voltage2 ...> <R=repeat> <TD=delay>>
VRST_ideal RST_ideal 0 PWL 0 0 0.39e-9 0 0.4e-9 vdd 1.47e-9 vdd 1.48e-9 0 
*VCLK_ideal CLK_ideal 0 PULSE 0 vdd 0.98e-9 0.01e-9 0.01e-9 0.98e-9 2e-9
*VD_ideal D_ideal 0 PWL 0 0 2.48e-9 0 2.49e-9 vdd 4.48e-9 vdd 4.49e-9 0

VD_ideal D_ideal 0 PWL
+ 0 0
+ 4.5n 0
+ 4.51n vdd
+ 6.01n vdd
+ 6.02n 0
+ Td = "delay"

*VD_ideal D_ideal 0 PWL
*+ 0 0
*+ 4n 0
*+ 4.01n vdd
*+ Td = "delay"

VCLK_ideal CLK_ideal 0 PWL
+ 0 0
+ 1n 0
+ 1.01n vdd
+ 2.01n vdd
+ 2.02n 0
+ 5n 0
+ 5.01n vdd

.IC V(q)=0

* ==========================
*         Analysis
* ==========================
* .TRAN tstep1 tstop1 [START=val] [UIC]
* .DC var1 start1 stop1 incr1 <SWEEP var 2 start2 stop2 incr2>
*.PARAM step='vdd/300'

.TRAN 1e-12 8e-9 START=0 SWEEP OPTIMIZE=optd
+                              RESULTS=t_cq_rise v_q_min
+                              MODEL=optmod 

*.TRAN 1e-12 8e-9 START=0 
* ==========================
*       Measurement
* ==========================
.MEASURE TRAN t_cq_rise TRIG V(clk) VAL='vdd*0.5' RISE=2  
+                       TARG V(q)   VAL='vdd*0.5' RISE=2
+                       pushout=10p lower

.MEASURE TRAN t_q_r_i TRIG AT=0
+ TARG V(q) VAL='vdd*0.99' RISE=1

.MEASURE TRAN v_q_min MIN V(q) GOAL='vdd*0.9' FROM=t_q_r_i TO=8e-9

.MEASURE TRAN t_h_rise TRIG V(clk) VAL='vdd*0.5' RISE=2
+                      TARG V(d)   VAL='vdd*0.5' FALL=1

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
