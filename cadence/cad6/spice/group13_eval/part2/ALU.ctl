* hspice functional analysis of ALU

.INC "ALU_buffered.ckt"
.VEC "ALU_buffered.vec"

.OPTION POST

.probe P(*)

* DUT supply
.param vdd=1.2
vvdd vdd! 0 vdd
vvss vss! 0 0

.PARAM duration = 50n
.PARAM resolution = 10p
.tran resolution duration


* Energy measurements
.PARAM clk_per = 5n
.PARAM add_start  = 5n
.PARAM add_end    = 10n
.PARAM sub_start  = 20n
.PARAM sub_end    = 25n
.MEAS tot_en_deliv_add  INTEG P(vvdd) FROM='add_start' TO='add_end'
.MEAS tot_en_deliv_sub   INTEG P(vvdd) FROM='sub_start' TO='sub_end'
* Energy as asked for in the CAD document
.MEAS TRAN en_deliv_add  PARAM = 'ABS(tot_en_deliv_add)/((add_end - add_start)/clk_per)'
.MEAS TRAN en_deliv_sub   PARAM = 'ABS(tot_en_deliv_sub)/((sub_end - sub_start)/clk_per)'

* Energy from psuedo-'random' ops (they ARE weighted) for calculating the en-delay product.
.MEAS tot_en_deliv_rand INTEG P(vvdd) FROM='sub_end' to='duration'
.MEAS en_deliv_rand PARAM = 'ABS(tot_en_deliv_rand)/((duration-sub_end)/clk_per)'

.end
