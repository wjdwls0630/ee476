* ==========================
*   Title, Options, Models
* ==========================
.TITLE q5d
.OPTION
+ NODE
+ NOMOD
+ POST
+ PROBE

.LIB "/gscratch/ece/common_files/pdks_cadence_config/freepdk45/cadence_setup/freepdk45.l" tt_lib
* ==========================
*            DUT
* ==========================
.INCLUDE "./q5d.ckt"
.PARAM vdd=1.2
.PARAM vss=0

*  - 0 is a special character in HSPICE for the global ground
*  - Syntax: V<name> FROM<node> TO<node> VALUE
.GLOBAL vdd! vss!
Vvdd vdd! 0 DC=vdd         * A voltage named "vdd" FROM the global node "vdd!" TO ground, of VALUE vdd=1.2
Vvss vss! 0 DC=0           * A voltage named "vss" FROM the global node "vss!" TO ground, of VALUE 0

x1 vds vgs q5d L=60e-9 W=1e-6
* ==========================
*         Stimulus
* ==========================

* Vxx n+ n- <<DC=> val> <tran_func>>
* Vxx n+ n- PULSE <v1(init val) v2(plateau val) td(delay from beginning) tr tf pw(pulse width) per(pulse repetition period)>
* Vxx n+ b- PWL <Time1 Voltage1 <Time2 Voltage2 ...> <R=repeat> <TD=delay>>

Vvgs vgs 0 DC=0.6
Vvds vds 0 DC=0

* ==========================
*         Analysis
* ==========================
* .TRAN tstep1 tstop1 [START=val] [UIC]
* .DC var1 start1 stop1 incr1 <SWEEP var 2 start2 stop2 incr2>
.PARAM step='(vdd)/10000'

.DC Vvds 0 vdd step 


* ==========================
*       Measurement
* ==========================
.MEASURE gds DERIVATIVE i1(x1.m0) WHEN V(vds)=0.6
.MEASURE Ids FIND i1(x1.m0) WHEN V(vds)=0.6
.MEASURE Lambda PARAM='gds/Ids'
*.MEASURE gds_lx8 FIND lx8(x1.m0) WHEN V(vds)=0.6
*.MEASURE leff FIND lx63(x1.m0) WHEN V(vds)=0.6
* ==========================
*          PROBE
* ==========================
* - Wildcard to probe all voltages/currents
*.probe V(*)
*.probe I(*)
* .probe lx4(M1)  * lx4 is a spice model "handle" for drain current in mos device
.PROBE i1(x1.m0)

.END
