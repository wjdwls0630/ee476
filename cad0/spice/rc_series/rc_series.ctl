* ==========================
*   Title, Options, Models
* ==========================
.TITLE rc_series 
.OPTION
+ NODE
+ NOMOD
+ POST
+ PROBE
* ==========================
*            DUT
* ==========================
.include ./rc_series.ckt
.PARAM vdd =1.2
.PARAM vss =0

*  - 0 is a special character in HSPICE for the global ground
*  - Syntax: V<name> FROM<node> TO<node> VALUE
Vvdd vdd! 0 DC=vdd         * A voltage named "vdd" FROM the global node "vdd!" TO ground, of VALUE vdd=1.2
Vvss vss! 0 DC=0           * A voltage named "vss" FROM the global node "vss!" TO ground, of VALUE 0

x1 vi vo rc_series
* ==========================
*         Stimulus
* ==========================

* Vxx n+ n- <<DC=> val> <tran_func>>
* Vxx n+ n- PULSE <v1(init val) v2(plateau val) td(delay from beginning) tr tf pw(pulse width) per(pulse repetition period)>
* Vxx n+ b- PWL <Time1 Voltage1 <Time2 Voltage2 ...> <R=repeat> <TD=delay>>

.param period = 20n
.PARAM tr = 0p
* Generate the input waveform
* - Uses an HSPICE command called PULSE, many other input patterns exist
Vvi vi 0 PULSE(0 vdd 0 tr tr 'period/4-tr' 'period/2')

* ==========================
*         Analysis
* ==========================
* .TRAN tstep1 tstop1 [START=val] [UIC]
.TRAN 1p 50n

* ==========================
*       Measurement
* ==========================
* Results appear as text data in .mt[0-9] files, for instance "rc_circuit.mt0"

* Trigger measurement when vo = 20% vdd, on the 2nd rising edge, until vo = 80% vdd
.MEAS TRAN rise_time
	+ TRIG V(vo) VAL='0.2*vdd' RISE=1 TD=0 * '+' for line continuation
	+ TARG V(vo) VAL='0.8*vdd' RISE=1 TD=0

* Trigger measurement on 2nd rising edge of "Vi", use 2nd rising edge of "vo" as the target
.MEAS TRAN rise_delay TRIG V(vi) VAL='0.5*vdd' RISE=1 TD=2n TARG V(vo) VAL='0.5*vdd' RISE=1 TD=2n

* ==========================
*          PROBE
* ==========================
* - Sampled into waveforms
* - Wildcard to probe all voltages/currents
.probe V(*)
.probe I(*)
* .probe lx4(M1)  * lx4 is a spice model "handle" for drain current in mos device

.END

