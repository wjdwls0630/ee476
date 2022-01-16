* ==========================
*   Title, Options, Models
* ==========================
.TITLE RF 

.OPTION
+ NODE
+ NOMOD
+ PROBE
* ==========================
*            DUT
* ==========================
.INCLUDE "./RF.ckt"
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

* rd_data_0<15:0>
c0_0 rd_data_0<0> vss! 40f
c0_1 rd_data_0<1> vss! 40f
c0_2 rd_data_0<2> vss! 40f
c0_3 rd_data_0<3> vss! 40f
c0_4 rd_data_0<4> vss! 40f
c0_5 rd_data_0<5> vss! 40f
c0_6 rd_data_0<6> vss! 40f
c0_7 rd_data_0<7> vss! 40f
c0_8 rd_data_0<8> vss! 40f
c0_9 rd_data_0<9> vss! 40f
c0_10 rd_data_0<10> vss! 40f
c0_11 rd_data_0<11> vss! 40f
c0_12 rd_data_0<12> vss! 40f
c0_13 rd_data_0<13> vss! 40f
c0_14 rd_data_0<14> vss! 40f
c0_15 rd_data_0<15> vss! 40f

* rd_data_1<15:0>
c1_0  rd_data_1<0> vss! 40f
c1_1  rd_data_1<1> vss! 40f
c1_2  rd_data_1<2> vss! 40f
c1_3  rd_data_1<3> vss! 40f
c1_4  rd_data_1<4> vss! 40f
c1_5  rd_data_1<5> vss! 40f
c1_6  rd_data_1<6> vss! 40f
c1_7  rd_data_1<7> vss! 40f
c1_8  rd_data_1<8> vss! 40f
c1_9  rd_data_1<9> vss! 40f
c1_10 rd_data_1<10> vss! 40f
c1_11 rd_data_1<11> vss! 40f
c1_12 rd_data_1<12> vss! 40f
c1_13 rd_data_1<13> vss! 40f
c1_14 rd_data_1<14> vss! 40f
c1_15 rd_data_1<15> vss! 40f



* rd_addr_0<3:0>
x_rd_addr_0_0_i0 rd_addr_0_ideal<0> n_rd_addr_0<0> vdd vss INV1 M=1
x_rd_addr_0_0_i1 n_rd_addr_0<0> rd_addr_0<0> vdd vss INV1 M=1

x_rd_addr_0_1_i0 rd_addr_0_ideal<1> n_rd_addr_0<1> vdd vss INV1 M=1
x_rd_addr_0_1_i1 n_rd_addr_0<1> rd_addr_0<1> vdd vss INV1 M=1

x_rd_addr_0_2_i0 rd_addr_0_ideal<2> n_rd_addr_0<2> vdd vss INV1 M=1
x_rd_addr_0_2_i1 n_rd_addr_0<2> rd_addr_0<2> vdd vss INV1 M=1

x_rd_addr_0_3_i0 rd_addr_0_ideal<3> n_rd_addr_0<3> vdd vss INV1 M=1
x_rd_addr_0_3_i1 n_rd_addr_0<3> rd_addr_0<3> vdd vss INV1 M=1

* rd_addr_1<3:0>
x_rd_addr_1_0_i0 rd_addr_1_ideal<0> n_rd_addr_1<0> vdd vss INV1 M=1
x_rd_addr_1_0_i1 n_rd_addr_1<0> rd_addr_1<0> vdd vss INV1 M=1

x_rd_addr_1_1_i0 rd_addr_1_ideal<1> n_rd_addr_1<1> vdd vss INV1 M=1
x_rd_addr_1_1_i1 n_rd_addr_1<1> rd_addr_1<1> vdd vss INV1 M=1

x_rd_addr_1_2_i0 rd_addr_1_ideal<2> n_rd_addr_1<2> vdd vss INV1 M=1
x_rd_addr_1_2_i1 n_rd_addr_1<2> rd_addr_1<2> vdd vss INV1 M=1

x_rd_addr_1_3_i0 rd_addr_1_ideal<3> n_rd_addr_1<3> vdd vss INV1 M=1
x_rd_addr_1_3_i1 n_rd_addr_1<3> rd_addr_1<3> vdd vss INV1 M=1

* wr_addr<3:0>
x_wr_addr_0_i0 wr_addr_ideal<0> n_wr_addr<0> vdd vss INV1 M=1
x_wr_addr_0_i1 n_wr_addr<0> wr_addr<0> vdd vss INV1 M=1

x_wr_addr_1_i0 wr_addr_ideal<1> n_wr_addr<1> vdd vss INV1 M=1
x_wr_addr_1_i1 n_wr_addr<1> wr_addr<1> vdd vss INV1 M=1

x_wr_addr_2_i0 wr_addr_ideal<2> n_wr_addr<2> vdd vss INV1 M=1
x_wr_addr_2_i1 n_wr_addr<2> wr_addr<2> vdd vss INV1 M=1

x_wr_addr_3_i0 wr_addr_ideal<3> n_wr_addr<3> vdd vss INV1 M=1
x_wr_addr_3_i1 n_wr_addr<3> wr_addr<3> vdd vss INV1 M=1

* wr_data<15:0>
x_wr_data_0_i0 wr_data_ideal<0> n_wr_data<0> vdd vss INV1 M=1
x_wr_data_0_i1 n_wr_data<0> wr_data<0> vdd vss INV1 M=1

x_wr_data_1_i0 wr_data_ideal<1> n_wr_data<1> vdd vss INV1 M=1
x_wr_data_1_i1 n_wr_data<1> wr_data<1> vdd vss INV1 M=1

x_wr_data_2_i0 wr_data_ideal<2> n_wr_data<2> vdd vss INV1 M=1
x_wr_data_2_i1 n_wr_data<2> wr_data<2> vdd vss INV1 M=1

x_wr_data_3_i0 wr_data_ideal<3> n_wr_data<3> vdd vss INV1 M=1
x_wr_data_3_i1 n_wr_data<3> wr_data<3> vdd vss INV1 M=1

x_wr_data_4_i0 wr_data_ideal<4> n_wr_data<4> vdd vss INV1 M=1
x_wr_data_4_i1 n_wr_data<4> wr_data<4> vdd vss INV1 M=1

x_wr_data_5_i0 wr_data_ideal<5> n_wr_data<5> vdd vss INV1 M=1
x_wr_data_5_i1 n_wr_data<5> wr_data<5> vdd vss INV1 M=1

x_wr_data_6_i0 wr_data_ideal<6> n_wr_data<6> vdd vss INV1 M=1
x_wr_data_6_i1 n_wr_data<6> wr_data<6> vdd vss INV1 M=1

x_wr_data_7_i0 wr_data_ideal<7> n_wr_data<7> vdd vss INV1 M=1
x_wr_data_7_i1 n_wr_data<7> wr_data<7> vdd vss INV1 M=1

x_wr_data_8_i0 wr_data_ideal<8> n_wr_data<8> vdd vss INV1 M=1
x_wr_data_8_i1 n_wr_data<8> wr_data<8> vdd vss INV1 M=1

x_wr_data_9_i0 wr_data_ideal<9> n_wr_data<9> vdd vss INV1 M=1
x_wr_data_9_i1 n_wr_data<9> wr_data<9> vdd vss INV1 M=1

x_wr_data_10_i0 wr_data_ideal<10> n_wr_data<10> vdd vss INV1 M=1
x_wr_data_10_i1 n_wr_data<10> wr_data<10> vdd vss INV1 M=1

x_wr_data_11_i0 wr_data_ideal<11> n_wr_data<11> vdd vss INV1 M=1
x_wr_data_11_i1 n_wr_data<11> wr_data<11> vdd vss INV1 M=1

x_wr_data_12_i0 wr_data_ideal<12> n_wr_data<12> vdd vss INV1 M=1
x_wr_data_12_i1 n_wr_data<12> wr_data<12> vdd vss INV1 M=1

x_wr_data_13_i0 wr_data_ideal<13> n_wr_data<13> vdd vss INV1 M=1
x_wr_data_13_i1 n_wr_data<13> wr_data<13> vdd vss INV1 M=1

x_wr_data_14_i0 wr_data_ideal<14> n_wr_data<14> vdd vss INV1 M=1
x_wr_data_14_i1 n_wr_data<14> wr_data<14> vdd vss INV1 M=1

x_wr_data_15_i0 wr_data_ideal<15> n_wr_data<15> vdd vss INV1 M=1
x_wr_data_15_i1 n_wr_data<15> wr_data<15> vdd vss INV1 M=1

* wr_en
x_wr_en_i0 wr_en_ideal n_wr_en vdd vss INV1 M=1 
x_wr_en_i1 n_wr_en wr_en vdd vss INV1 M=1

* clk
x_clk_i0 CLK_ideal n_clk vdd vss INV1 M=1 
x_clk_i1 n_clk clk vdd vss INV1 M=1


xRF0 
+ rd_data_0<0> rd_data_0<1> rd_data_0<2> rd_data_0<3> rd_data_0<4> rd_data_0<5> rd_data_0<6> rd_data_0<7>
+ rd_data_0<8> rd_data_0<9> rd_data_0<10> rd_data_0<11> rd_data_0<12> rd_data_0<13> rd_data_0<14> rd_data_0<15>
+ rd_data_1<0> rd_data_1<1> rd_data_1<2> rd_data_1<3> rd_data_1<4> rd_data_1<5> rd_data_1<6> rd_data_1<7>
+ rd_data_1<8> rd_data_1<9> rd_data_1<10> rd_data_1<11> rd_data_1<12> rd_data_1<13> rd_data_1<14> rd_data_1<15>
+ rd_addr_0<0> rd_addr_0<1> rd_addr_0<2> rd_addr_0<3> 
+ rd_addr_1<0> rd_addr_1<1> rd_addr_1<2> rd_addr_1<3> 
+ wr_addr<0> wr_addr<1> wr_addr<2> wr_addr<3> 
+ wr_data<0> wr_data<1> wr_data<2> wr_data<3> wr_data<4> wr_data<5> wr_data<6> wr_data<7>
+ wr_data<8> wr_data<9> wr_data<10> wr_data<11> wr_data<12> wr_data<13> wr_data<14> wr_data<15>
+ wr_en clk
+ RF
* ==========================
*         Stimulus
* ==========================

* Vxx n+ n- <<DC=> val> <tran_func>>
* Vxx n+ n- PULSE <v1(init val) v2(plateau val) td(delay from beginning) tr tf pw(pulse width) per(pulse repetition period)>
* Vxx n+ b- PWL <Time1 Voltage1 <Time2 Voltage2 ...> <R=repeat> <TD=delay>>
.PARAM per=1e-9
.PARAM tr=0.01e-9
.PARAM tf=0.01e-9
.PARAM pw='(per/2)-tr-tf'

VCLK_ideal CLK_ideal 0 PULSE 0 vdd pw tr tf pw per 

.vec 'RF_vector.vec'

* ==========================
*         Analysis
* ==========================
* .TRAN tstep1 tstop1 [START=val] [UIC]
* .DC var1 start1 stop1 incr1 <SWEEP var 2 start2 stop2 incr2>
*.PARAM step='vdd/300'

.TRAN 1e-12 'per*35' START=0 

* ==========================
*       Measurement
* ==========================
.MEASURE TRAN en_deliv_write_total INTEGRAL '-P(Vvdd)' FROM=0 TO=13e-9
.MEASURE TRAN en_deliv_write PARAM='en_deliv_write_total/13'

.MEASURE TRAN en_deliv_read_total INTEGRAL '-P(Vvdd)' FROM=17e-9 TO=30e-9
.MEASURE TRAN en_deliv_read PARAM='en_deliv_read_total/13'

.Measure TRAN tcq_test TRIG V(CLK_ideal) TD=32e-9 VAL='vdd*0.5' RISE=1
+                      TARG V(rd_data_0<0>) VAL='vdd*0.5' FALL=1 
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
