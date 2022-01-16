# FreePDK45 Makefile

DESIGN_LIB ?= <cadN>
DESIGN ?= <schematic_netlist_name>

COMMON_DIR = /gscratch/ece/common_files/pdks_cadence_config/freepdk45
DESIGN_DIR = $(shell realpath ../../cadence)
#DESIGN_LIB is used below because it is assumed that your linux dir for sims will be the same as your cadence designLib
NETLIST_DIR = $(shell realpath ../netlists)
# VPATH=touchfiles
XNETLIST = ${COMMON_DIR}/scripts/xnetlist.py
SPICESETUP = ${COMMON_DIR}/scripts/spiceSetup.py
GENERATEMEASTABLE = ${COMMON_DIR}/scripts/generateMeasTable.py
STDLIBSETUP = ${COMMON_DIR}/scripts/stdsetup.py
HSPICE = hspice -mt 2 -hpp
all: hspice
PHONY = netlist hspice clean subckt

$(DESIGN).ckt:$(DESIGN_DIR)/$(DESIGN_LIB)/$(DESIGN)/schematic/sch.oa
	$(XNETLIST) -l $(DESIGN_LIB) -c $(DESIGN) -v schematic -d $(DESIGN_DIR) -n $(NETLIST_DIR) #--topsub
	$(SPICESETUP) -i $(NETLIST_DIR)/$(DESIGN)/hspiceD/schematic/netlist/input.ckt -o $(DESIGN).ckt

subckt:$(DESIGN_DIR)/$(DESIGN_LIB)/$(DESIGN)/schematic/sch.oa
	$(XNETLIST) -l $(DESIGN_LIB) -c $(DESIGN) -v schematic -d $(DESIGN_DIR) -n $(NETLIST_DIR) #--topsub
	$(SPICESETUP) -i $(NETLIST_DIR)/$(DESIGN)/hspiceD/schematic/netlist/input.ckt -o $(DESIGN).ckt

hspice: $(DESIGN).ctl $(DESIGN).ckt
	$(STDLIBSETUP) -c $(DESIGN).ctl -b 0 -l $(COMMON_DIR)/cadence_setup/freepdk45.l --corner tt_lib
	hspice $(DESIGN).ctl -o $(DESIGN).lis
	-$(GENERATEMEASTABLE) -i $(DESIGN).mt0 -o $(DESIGN)_meas.tab -v r'*'
	-$(GENERATEMEASTABLE) -i $(DESIGN).ms0 -o $(DESIGN)_meas.tab -v r'*'

netlist:$(DESIGN_DIR)/$(DESIGN_LIB)/$(DESIGN)/schematic/sch.oa
	$(XNETLIST) -l $(DESIGN_LIB) -c $(DESIGN) -v schematic -d $(DESIGN_DIR) -n $(NETLIST_DIR) #--topsub
	$(SPICESETUP) -i $(NETLIST_DIR)/$(DESIGN)/hspiceD/schematic/netlist/input.ckt -o $(DESIGN).ckt

clean:
	rm -rf $(NETLIST_DIR)/$(DESIGN)
	rm -rf $(DESIGN).ckt
	rm -rf $(DESIGN).ckt
	rm -rf $(DESIGN).s*
	rm -rf sx*
	rm -rf $(DESIGN).lis
	rm -rf $(DESIGN).*0
	rm -rf $(DESIGN)_meas.tab
	rm -rf logFile
	rm -rf stdLibs.ctl
