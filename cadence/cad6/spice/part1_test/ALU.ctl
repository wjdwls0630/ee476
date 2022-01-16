* ==========================
*   Title, Options, Models
* ==========================
.TITLE ALU_Verification 

.OPTION
+ NODE
+ NOMOD
+ PROBE
* ==========================
*            DUT
* ==========================
.INCLUDE "./ALU.ckt"
.INCLUDE "./BUF1.ckt"

** include freepdk45.l
.lib "freepdk45.l" tt_lib

.PARAM vdd=1.2
.PARAM vss=0

* Definition of the input buffers for ALU inputs
* The inputs to buffer are op0<15:0>, op1<15:0>, and ctrl<2:0>
Vvdd vdd! 0 DC=vdd         * A voltage named "vdd" FROM the global node "vdd!" TO ground, of VALUE vdd=1.2
Vvss vss! 0 DC=0           * A voltage named "vss" FROM the global node "vss!" TO ground, of VALUE 0

Vvdd_buf vdd 0 DC=vdd         * A voltage named "vdd" FROM the global node "vdd!" TO ground, of VALUE vdd=1.2
Vvss_buf vss 0 DC=0           * A voltage named "vss" FROM the global node "vss!" TO ground, of VALUE 0

* ==========================
*        Input Buffer 
* ==========================
* op0<15:0> buffers
x_op0_b0 op0_ideal<0> op0<0> vdd vss BUF1
x_op0_b1 op0_ideal<1> op0<1> vdd vss BUF1
x_op0_b2 op0_ideal<2> op0<2> vdd vss BUF1
x_op0_b3 op0_ideal<3> op0<3> vdd vss BUF1
x_op0_b4 op0_ideal<4> op0<4> vdd vss BUF1
x_op0_b5 op0_ideal<5> op0<5> vdd vss BUF1
x_op0_b6 op0_ideal<6> op0<6> vdd vss BUF1
x_op0_b7 op0_ideal<7> op0<7> vdd vss BUF1
x_op0_b8 op0_ideal<8> op0<8> vdd vss BUF1
x_op0_b9 op0_ideal<9> op0<9> vdd vss BUF1
x_op0_b10 op0_ideal<10> op0<10> vdd vss BUF1
x_op0_b11 op0_ideal<11> op0<11> vdd vss BUF1
x_op0_b12 op0_ideal<12> op0<12> vdd vss BUF1
x_op0_b13 op0_ideal<13> op0<13> vdd vss BUF1
x_op0_b14 op0_ideal<14> op0<14> vdd vss BUF1
x_op0_b15 op0_ideal<15> op0<15> vdd vss BUF1

* op1<15:0> buffers
x_op1_b0 op1_ideal<0> op1<0> vdd vss BUF1
x_op1_b1 op1_ideal<1> op1<1> vdd vss BUF1
x_op1_b2 op1_ideal<2> op1<2> vdd vss BUF1
x_op1_b3 op1_ideal<3> op1<3> vdd vss BUF1
x_op1_b4 op1_ideal<4> op1<4> vdd vss BUF1
x_op1_b5 op1_ideal<5> op1<5> vdd vss BUF1
x_op1_b6 op1_ideal<6> op1<6> vdd vss BUF1
x_op1_b7 op1_ideal<7> op1<7> vdd vss BUF1
x_op1_b8 op1_ideal<8> op1<8> vdd vss BUF1
x_op1_b9 op1_ideal<9> op1<9> vdd vss BUF1
x_op1_b10 op1_ideal<10> op1<10> vdd vss BUF1
x_op1_b11 op1_ideal<11> op1<11> vdd vss BUF1
x_op1_b12 op1_ideal<12> op1<12> vdd vss BUF1
x_op1_b13 op1_ideal<13> op1<13> vdd vss BUF1
x_op1_b14 op1_ideal<14> op1<14> vdd vss BUF1
x_op1_b15 op1_ideal<15> op1<15> vdd vss BUF1

* ctrl<2:0> buffers
x_ctrl_b0 ctrl_ideal<0> ctrl<0> vdd vss BUF1
x_ctrl_b1 ctrl_ideal<1> ctrl<1> vdd vss BUF1
x_ctrl_b2 ctrl_ideal<2> ctrl<2> vdd vss BUF1

xalu0 
+ alu_out<0> alu_out<1> alu_out<2> alu_out<3> alu_out<4> alu_out<5> alu_out<6> alu_out<7>
+ alu_out<8> alu_out<9> alu_out<10> alu_out<11> alu_out<12> alu_out<13> alu_out<14> alu_out<15>
+ op0<0> op0<1> op0<2> op0<3> op0<4> op0<5> op0<6> op0<7>
+ op0<8> op0<9> op0<10> op0<11> op0<12> op0<13> op0<14> op0<15>
+ op1<0> op1<1> op1<2> op1<3> op1<4> op1<5> op1<6> op1<7>
+ op1<8> op1<9> op1<10> op1<11> op1<12> op1<13> op1<14> op1<15>
+ c_flag n_flag v_flag
+ ctrl<0> ctrl<1> ctrl<2>
+ ALU
********************************************************

* ==========================
*         Output load
* ==========================
* alu_out<15:0>
c0_0 alu_out<0> vss! 40f
c0_1 alu_out<1> vss! 40f
c0_2 alu_out<2> vss! 40f
c0_3 alu_out<3> vss! 40f
c0_4 alu_out<4> vss! 40f
c0_5 alu_out<5> vss! 40f
c0_6 alu_out<6> vss! 40f
c0_7 alu_out<7> vss! 40f
c0_8 alu_out<8> vss! 40f
c0_9 alu_out<9> vss! 40f
c0_10 alu_out<10> vss! 40f
c0_11 alu_out<11> vss! 40f
c0_12 alu_out<12> vss! 40f
c0_13 alu_out<13> vss! 40f
c0_14 alu_out<14> vss! 40f
c0_15 alu_out<15> vss! 40f

* flags
c1_0  c_flag vss! 40f
c1_1  n_flag vss! 40f
c1_2  v_flag vss! 40f

* ==========================
*         Stimulus
* ==========================
.vec 'ALU_verification.vec'

* ==========================
*         Analysis
* ==========================
* .TRAN tstep1 tstop1 [START=val] [UIC]
* .DC var1 start1 stop1 incr1 <SWEEP var 2 start2 stop2 incr2>
*.PARAM step='vdd/300'

.TRAN 0.5e-9 1300n START=0 

* ==========================
*       Measurement
* ==========================

* ==========================
*          PROBE
* ==========================
* - Wildcard to probe all voltages/currents
.probe V(*) 
*.probe I(*)
* .probe lx4(M1)  * lx4 is a spice model "handle" for drain current in mos device
*.PROBE V(D) V(Q) V(CLK) V(RST)
*.PROBE P(xldfsr0.xdfsr0)

.ALTER ALU
* ==========================
*         Stimulus
* ==========================
.vec 'ALU.vec'

* ==========================
*         Analysis
* ==========================
* .TRAN tstep1 tstop1 [START=val] [UIC]
* .DC var1 start1 stop1 incr1 <SWEEP var 2 start2 stop2 incr2>
*.PARAM step='vdd/300'

.TRAN 1e-12 45n START=0 

* ==========================
*       Measurement
* ==========================
.MEASURE TRAN en_deliv_add INTEGRAL '-P(Vvdd)' FROM=0 TO=1.5e-9

.MEASURE TRAN tpdf_alu_15 TRIG V(op0<0>) VAL='vdd*0.5' RISE=1
+                         TARG V(alu_out<15>) VAL='vdd*0.5' FALL=1

.MEASURE TRAN tpdr_alu_15 TRIG V(op0<0>) TD=2.0e-9 VAL='vdd*0.5' FALL=1
+                         TARG V(alu_out<15>) VAL='vdd*0.5' RISE=1

.MEASURE TRAN tpdf_n TRIG V(op0<0>) VAL='vdd*0.5' RISE=1
+                    TARG V(n_flag) VAL='vdd*0.5' FALL=1

.MEASURE TRAN tpdr_n TRIG V(op0<0>) TD=2.0e-9 VAL='vdd*0.5' FALL=1
+                    TARG V(n_flag) VAL='vdd*0.5' RISE=1

.MEASURE TRAN tpdr_c TRIG V(op0<0>) VAL='vdd*0.5' RISE=1
+                    TARG V(c_flag) VAL='vdd*0.5' RISE=1

.MEASURE TRAN tpdf_c TRIG V(op1<0>) TD=14e-9 VAL='vdd*0.5' RISE=1
+                    TARG V(c_flag) VAL='vdd*0.5' FALL=1

.MEASURE TRAN tpdr_v TRIG V(op1<0>) TD=12e-9 VAL='vdd*0.5' FALL=1
+                    TARG V(v_flag) VAL='vdd*0.5' RISE=1

.MEASURE TRAN tpdf_v TRIG V(op1<0>) TD=14e-9 VAL='vdd*0.5' RISE=1
+                    TARG V(v_flag) VAL='vdd*0.5' FALL=1

.MEASURE TRAN max_delay PARAM='max(tpdf_alu_15, tpdr_alu_15, tpdr_n, tpdf_n, tpdr_c, tpdf_c, tpdr_v, tpdf_v)' 

.MEASURE energy_delay_product PARAM='en_deliv_add*max_delay'

.END

