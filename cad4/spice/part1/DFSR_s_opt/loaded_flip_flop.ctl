* ==========================
*   Title, Options, Models
* ==========================
.TITLE loaded_flip_flop 

.OPTION
+ ARTIST=2
+ INGOLD=2
+ PARHIER=LOCAL
+ PSF=2
+ NODE
+ NOMOD
*+ POST
+ PROBE
* ==========================
*            DUT
* ==========================
.INCLUDE "./loaded_flip_flop.ckt"

** include freepdk45.l
.lib "freepdk45.l" tt_lib

.PARAM vdd=1.2
.PARAM vss=0

*  - 0 is a special character in HSPICE for the global ground
*  - Syntax: V<name> FROM<node> TO<node> VALUE
.GLOBAL vdd! vss!
Vvdd vdd! 0 DC=vdd         * A voltage named "vdd" FROM the global node "vdd!" TO ground, of VALUE vdd=1.2
Vvss vss! 0 DC=0           * A voltage named "vss" FROM the global node "vss!" TO ground, of VALUE 0

xdinv0 D_ideal n1 CLKINV1_DFSR Wp=0.4e-6 Wn=0.3e-6
xdinv1 n1 d CLKINV1_DFSR Wp=0.4e-6 Wn=0.3e-6

xrstinv0 RST_ideal n2 CLKINV1_DFSR Wp=0.4e-6 Wn=0.3e-6
xrstinv1 n2 rst CLKINV1_DFSR Wp=0.4e-6 Wn=0.3e-6

xclkinv0 CLK_ideal n3 CLKINV1_DFSR Wp=0.4e-6 Wn=0.3e-6
xclkinv1 n3 clk CLKINV1_DFSR Wp=0.4e-6 Wn=0.3e-6


xldfsr0 d q clk rst loaded_flip_flop 
+ xclki_Wp='xclki_Wp' xclki_Wn='xclki_Wn'
+ xi_Wp='xi_Wp' xi_Wn='xi_Wn'
+ xtg_Wp='xtg_Wp' xtg_Wn='xtg_Wn'
+ xnand_Wp='xnand_Wp' xnand_Wn='xnand_Wn'
+ xnor_Wp='xnor_Wp' xnor_Wn='xnor_Wn'

* ==========================
*    Optimization Setup 
* ==========================
.PARAM w_min=90e-9
.PARAM w_max_p=550e-9
.PARAM w_max_n=350e-9
.PARAM delta=5e-9
* PARAM parameter=optxxx (init_guess, low_limit, upper_limit, delta)
.PARAM xclki_Wp=optw(0.4e-6, w_min, w_max_p, delta)
.PARAM xclki_Wn=optw(0.3e-6, w_min, w_max_n, delta)
.PARAM xi_Wp=optw(0.4e-6, w_min, w_max_p, delta)
.PARAM xi_Wn=optw(0.3e-6, w_min, w_max_n, delta)
.PARAM xtg_Wp=optw(0.25e-6, w_min, w_max_p, delta)
.PARAM xtg_Wn=optw(0.25e-6, w_min, w_max_n, delta)
.PARAM xnand_Wp=optw(0.35e-6, w_min, w_max_p, delta)
.PARAM xnand_Wn=optw(0.35e-6, w_min, w_max_n, delta)
.PARAM xnor_Wp=optw(0.35e-6, w_min, w_max_p, delta)
.PARAM xnor_Wn=optw(0.35e-6, w_min, w_max_n, delta)
.MODEL optmod opt itropt=100

* ==========================
*         Stimulus
* ==========================

* Vxx n+ n- <<DC=> val> <tran_func>>
* Vxx n+ n- PULSE <v1(init val) v2(plateau val) td(delay from beginning) tr tf pw(pulse width) per(pulse repetition period)>
* Vxx n+ b- PWL <Time1 Voltage1 <Time2 Voltage2 ...> <R=repeat> <TD=delay>>
VRST_ideal RST_ideal 0 PWL 0 0 0.39e-9 0 0.4e-9 vdd 1.47e-9 vdd 1.48e-9 0 
VCLK_ideal CLK_ideal 0 PULSE 0 vdd 0.98e-9 0.01e-9 0.01e-9 0.98e-9 2e-9
VD_ideal D_ideal 0 PWL 0 0 2.48e-9 0 2.49e-9 vdd 4.48e-9 vdd 4.49e-9 0
.IC V(q)=0

* ==========================
*         Analysis
* ==========================
* .TRAN tstep1 tstop1 [START=val] [UIC]
* .DC var1 start1 stop1 incr1 <SWEEP var 2 start2 stop2 incr2>
*.PARAM step='vdd/300'

.TRAN 1e-12 10e-9 START=0 SWEEP OPTIMIZE optw
+ RESULTS=t_cq diff MODEL=optmod

* ==========================
*       Measurement
* ==========================
.MEASURE TRAN t_cq_rise TRIG V(clk) VAL='vdd*0.5' RISE=2  
+                       TARG V(q)   VAL='vdd*0.5' RISE=1

.MEASURE TRAN t_cq_fall TRIG V(clk) VAL='vdd*0.5' RISE=3  
+                       TARG V(q)   VAL='vdd*0.5' FALL=1


.MEASURE TRAN diff PARAM='abs(t_cq_rise-t_cq_fall)' goal=0
.MEASURE TRAN t_cq PARAM='0.5*(t_cq_rise+t_cq_fall)' goal=0

.MEASURE TRAN en_deliv_steady INTEGRAL P(xldfsr0.xdfsr0) FROM=6.98e-9 TO=8.98e-9
.MEASURE TRAN en_deliv_switch INTEGRAL P(xldfsr0.xdfsr0) FROM=2.98e-9 TO=4.98e-9

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
