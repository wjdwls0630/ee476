## -----------------------------------------------------------------------------
## HEADER
## -----------------------------------------------------------------------------
include ./Makevar

## -----------------------------------------------------------------------------
## Build rules
## -----------------------------------------------------------------------------

HSPICE = hspice64 -mt 2
VIVA = viva
LOG = logs
DATE = `date +%y%m%d_%H:%M:%S`

## -----------------------------------------------------------------------------
## Define targets.
## -----------------------------------------------------------------------------
.PHONY: subckt
.PHONY: netlist
.PHONY: hspice
.PHONY: genTable

all: subckt netlist hspice genTable

#$(DESIGN).ckt : $(DESIGN_DIR)/$(DESIGN_LIB)/$(DESIGN)/schematic/sch.oa
#	$(XNETLIST) -l $(DESIGN_LIB) -c $(DESIGN) -v schematic -d $(DESIGN_DIR) -n $(NETLIST_DIR) --topsub
#	$(SPICESETUP) -i $(NETLIST_DIR)/$(DESIGN)/hspiceD/schematic/netlist/input.ckt -o $(DESIGN).ckt

subckt : $(DESIGN_DIR)/$(DESIGN_LIB)/$(DESIGN)/schematic/sch.oa
	$(XNETLIST) -l $(DESIGN_LIB) -c $(DESIGN) -v schematic -d $(DESIGN_DIR) -n $(NETLIST_DIR) --topsub
	$(SPICESETUP) -i $(NETLIST_DIR)/$(DESIGN)/hspiceD/schematic/netlist/input.ckt -o $(DESIGN).ckt

hspice: 
#	$(STDLIBSETUP) -c $(DESIGN).ctl -b 0 -l $(COMMON_DIR)/cadence_setup/freepdk45.l --corner tt_lib
	rm -rf outputs/
	mkdir outputs/	
	$(HSPICE) -i $(DESIGN).ctl -o outputs/ | tee -i outputs/$(DESIGN).$(LOG)
#	$(GENERATEMEASTABLE) -i outputs/$(DESIGN).mt0 -o $(DESIGN)/$(DESIGN)_meas.tab -v r'*'
#	$(GENERATEMEASTABLE) -i outputs/$(DESIGN).ms0 -o $(DESIGN)/$(DESIGN)_meas.tab -v r'*'
	$(VIVA) -datadir outputs/ &

netlist : $(DESIGN_DIR)/$(DESIGN_LIB)/$(DESIGN)/schematic/sch.oa
	$(XNETLIST) -l $(DESIGN_LIB) -c $(DESIGN) -v schematic -d $(DESIGN_DIR) -n $(NETLIST_DIR) --topsub
	$(SPICESETUP) -i $(NETLIST_DIR)/$(DESIGN)/hspiceD/schematic/netlist/input.ckt -o $(DESIGN).ckt


genTable: $(FILE)
#	$(GENERATEMEASTABLE) -i $(FILE).mt0 -o outputs/$(DESIGN)_meas.tab -v r'*'
#	$(GENERATEMEASTABLE) -i $(FILE).ms0 -o outputs/$(DESIGN)_meas.tab -v r'*'

#clean :
#	rm -rf $(DESIGN).ckt
#	rm -rf CDS.log
