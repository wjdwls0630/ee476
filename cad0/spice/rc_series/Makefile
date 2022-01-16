# Modified EE476 Makefile
# Version 1.5 (Oct. 5, 2021)
# Maintained by Hansem Ro

DESIGN_LIB ?= cad0
DESIGN ?= rc_series

# PRB (current design problem) can be specified if borrowing a schematic from a different part.
# By default, PRB=DESIGN
#
# 	Ex. Suppose we want to reuse netlist design from problem 'foo' for the problem 'bar'
#
# 		We can set DESIGN=foo and PRB=bar, so that we can reuse foo.ckt
# 		Note that you need to then include "foo.ckt" since that is what is being
# 		generated and placed in bar's directory

PRB?=$(DESIGN)

# EL (extended/extra label) can be specified if there are different control files
#
# 	Ex. Working on PRB=mos_res_2 and we have 3 control files: mos_res_2_a.ctl, mos_res_2_b.ctl
# 		and mos_res_2_c.ctl
#
#		If we want to run mos_res_2_a.ctl then define the extra label extension EL=_a

#EL?=<Extra Label>

# Uncomment and change BASE_DIR to common directory's full path.
BASE_DIR = /gscratch/ece/courses/freepdk45
DESIGN_DIR = ../../cadence
#DESIGN_LIB is used below because it is assumed that your linux dir for sims will be the same as your cadence designLib
NETLIST_DIR = ../netlists
# VPATH=touchfiles
XNETLIST = ${BASE_DIR}/scripts/xnetlist.py
SPICESETUP = ${BASE_DIR}/scripts/spiceSetup.py
GENERATEMEASTABLE = ${BASE_DIR}/scripts/generateMeasTable.py
#STDLIBSETUP = ${BASE_DIR}/scripts/stdsetup.py
# Control file backup enable:
# 	0 : disable
#   1 : enable
CKTBACKUPENABLE = 1
HSPICE = hspice -mt 2 -hpp
all: hspice
PHONY = netlist hspice clean clean_bak subckt

$(DESIGN).ckt:$(DESIGN_DIR)/$(DESIGN_LIB)/$(DESIGN)/schematic/sch.oa 
	$(XNETLIST) -l $(DESIGN_LIB) -c $(DESIGN) -v schematic -d $(DESIGN_DIR) -n $(NETLIST_DIR)
	$(SPICESETUP) -i $(NETLIST_DIR)/$(DESIGN)/hspiceD/schematic/netlist/input.ckt -o $(DESIGN).ckt
	# cp $(NETLIST_DIR)/$(DESIGN)/hspiceD/schematic/netlist/input.ckt $(DESIGN).ckt

subckt:$(DESIGN_DIR)/$(DESIGN_LIB)/$(DESIGN)/schematic/sch.oa 
	$(XNETLIST) -l $(DESIGN_LIB) -c $(DESIGN) -v schematic -d $(DESIGN_DIR) -n $(NETLIST_DIR) --topsub
	$(SPICESETUP) -i $(NETLIST_DIR)/$(DESIGN)/hspiceD/schematic/netlist/input.ckt -o $(DESIGN).ckt
	# cp $(NETLIST_DIR)/$(DESIGN)/hspiceD/schematic/netlist/input.ckt $(DESIGN).ckt

hspice: $(PRB)$(EL).ctl $(DESIGN).ckt
	#$(STDLIBSETUP) -c $(PRB)$(EL).ctl -b $(CKTBACKUPENABLE) -l $(BASE_DIR)/freepdk45.l --corner tt_lib
	hspice $(PRB)$(EL).ctl -o $(PRB)$(EL).lis
	$(GENERATEMEASTABLE) -i $(PRB)$(EL).ms0 -o $(PRB)$(EL)_meas.tab -v r'*'

netlist:$(DESIGN_DIR)/$(DESIGN_LIB)/$(DESIGN)/schematic/sch.oa 
	$(XNETLIST) -l $(DESIGN_LIB) -c $(DESIGN) -v schematic -d $(DESIGN_DIR) -n $(NETLIST_DIR) --topsub
	$(SPICESETUP) -i $(NETLIST_DIR)/$(DESIGN)/hspiceD/schematic/netlist/input.ckt -o $(DESIGN).ckt

genTable: $(PRB)$(EL)
	$(MEASWRAPPER) $(PRB)$(EL) $(GENERATEMEASTABLE)

clean: 
	rm -rf $(NETLIST_DIR)/$(DESIGN)
	rm -rf $(DESIGN).ckt
	rm -rf $(PRB)$(EL).ckt
	rm -rf $(PRB)$(EL).s*
	rm -rf sx*
	rm -rf $(PRB)$(EL).lis
	rm -rf $(PRB)$(EL).*0
	rm -rf $(PRB)$(EL)_meas.tab
	rm -rf logFile
	rm -rf stdLibs.ctl

clean_bak:
	rm -rf $(PRB)$(EL).ctl.bak*
