* ==========================
*   Title, Options, Models
* ==========================
.TITLE gate_cap
.OPTION
+ NODE
+ NOMOD
+ POST
+ PROBE

.LIB "/gscratch/ece/common_files/pdks_cadence_config/freepdk45/cadence_setup/freepdk45.l" tt_lib
* ==========================
*            DUT
* ==========================
.INCLUDE "./gate_cap.ckt"
.PARAM vdd=1.0
.PARAM vss=0

*  - 0 is a special character in HSPICE for the global ground
*  - Syntax: V<name> FROM<node> TO<node> VALUE
.GLOBAL vdd! vss!
Vvdd vdd! 0 DC=vdd         * A voltage named "vdd" FROM the global node "vdd!" TO ground, of VALUE vdd=1.2
Vvss vss! 0 DC=0           * A voltage named "vss" FROM the global node "vss!" TO ground, of VALUE 0

x1 vgs gate_cap L=60e-9 W=1e-6
* ==========================
*         Stimulus
* ==========================

* Vxx n+ n- <<DC=> val> <tran_func>>
* Vxx n+ n- PULSE <v1(init val) v2(plateau val) td(delay from beginning) tr tf pw(pulse width) per(pulse repetition period)>
* Vxx n+ b- PWL <Time1 Voltage1 <Time2 Voltage2 ...> <R=repeat> <TD=delay>>

Vvgs vgs 0 PWL 0 0 0.49e-9 0 0.5e-9 vdd

* ==========================
*         Analysis
* ==========================
* .TRAN tstep1 tstop1 [START=val] [UIC]
* .DC var1 start1 stop1 incr1 <SWEEP var 2 start2 stop2 incr2>

.TRAN 1e-12 1e-9 START=0


* ==========================
*       Measurement
* ==========================
.MEASURE TRAN gate_cap INTEGRAL '-I(Vvgs)' FROM=0.49e-9 TO=0.5e-9 

.MEASURE TRAN Qg_049 FIND lx14(x1.m0) AT=0.49e-9 
.MEASURE TRAN Qg_05 FIND lx14(x1.m0) AT=0.5e-9 
.MEASURE TRAN gate_cap_cal PARAM='Qg_05-Qg_049'

*.MEASURE TRAN cg_lx18 FIND lx18(x1.m0) AT=0.5e-9
*.MEASURE TRAN cgd_lx19 FIND lx19(x1.m0) AT=0.5e-9
*.MEASURE TRAN cgs_lx20 FIND lx20(x1.m0) AT=0.5e-9
*.MEASURE TRAN cgb_lx21 FIND lx21(x1.m0) AT=0.5e-9
* ==========================
*          PROBE
* ==========================
* - Wildcard to probe all voltages/currents
*.probe V(*)
*.probe I(*)
* .probe lx4(M1)  * lx4 is a spice model "handle" for drain current in mos device
.PROBE V(vgs) I(vgs)

.END

