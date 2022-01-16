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
#PHONY = netlist hspice
.PHONY: netlist
.PHONY: hspice

all: hspice

$(DESIGN).ckt : $(DESIGN_DIR)/$(DESIGN_LIB)/$(DESIGN)/schematic/sch.oa
	$(XNETLIST) -l $(DESIGN_LIB) -c $(DESIGN) -v schematic -d $(DESIGN_DIR) -n $(NETLIST_DIR) --topsub
	$(SPICESETUP) -i $(NETLIST_DIR)/$(DESIGN)/hspiceD/schematic/netlist/input.ckt -o $(DESIGN).ckt


hspice: $(DESIGN).ctl $(DESIGN).ckt
	rm -rf $(DESIGN)/
	mkdir $(DESIGN)/	
	$(HSPICE) -i $(DESIGN).ctl -o $(DESIGN)/ | tee -i $(DESIGN)/$(DESIGN).$(LOG)
	$(GENERATEMEASTABLE) -i $(DESIGN)/$(DESIGN).mt0 -o $(DESIGN)/$(DESIGN)_meas.tab -v r'*'
	$(VIVA) -datadir $(DESIGN)/ &

netlist : $(DESIGN_DIR)/$(DESIGN_LIB)/$(DESIGN)/schematic/sch.oa
	$(XNETLIST) -l $(DESIGN_LIB) -c $(DESIGN) -v schematic -d $(DESIGN_DIR) -n $(NETLIST_DIR) --topsub
	$(SPICESETUP) -i $(NETLIST_DIR)/$(DESIGN)/hspiceD/schematic/netlist/input.ckt -o $(DESIGN).ckt


genTable: $(FILE)
	$(GENERATEMEASTABLE) -i $(FILE).mt0 -o $(DESIGN)/$(DESIGN)_meas.tab -v r'*'

