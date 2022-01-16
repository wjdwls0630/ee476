## -----------------------------------------------------------------------------
## HEADER
## -----------------------------------------------------------------------------
include ./Makevar

## -----------------------------------------------------------------------------
## Build rules
## -----------------------------------------------------------------------------

HSPICE = hspice64 -mt 4
VIVA = viva
LOG = logs
DATE = `date +%y%m%d_%H:%M:%S`

## -----------------------------------------------------------------------------
## Define targets.
## -----------------------------------------------------------------------------
.PHONY: hspice
.PHONY: netlists
.PHONY: genTable

all: netlist hspice genTable


hspice: $(DESIGN).ctl $(DESIGN).ckt
	$(STDLIBSETUP) -c $(DESIGN).ctl -b 0 -l $(COMMON_DIR)/cadence_setup/freepdk45.l --corner tt_lib
	rm -rf outputs/
	mkdir outputs/	
	$(HSPICE) -i $(DESIGN).ctl -o outputs/ | tee -i outputs/$(DESIGN).$(LOG)
#	$(VIVA) -datadir outputs/ &

netlists: $(DESIGN_DIR)/$(DESIGN_LIB)/$(DESIGN)/schematic/sch.oa
	$(XNETLIST) -l $(DESIGN_LIB) -c $(DESIGN) -v schematic -d $(DESIGN_DIR) -n $(NETLIST_DIR) --topsub
	$(SPICESETUP) -i $(NETLIST_DIR)/$(DESIGN)/hspiceD/schematic/netlist/input.ckt -o $(DESIGN).ckt
	sed -i "5i + ARTIST=2\n+ INGOLD=2\n+ PARHIER=LOCAL\n+ PSF=2" $(DESIGN).ckt

genTable: $(GENTABFILE)
	$(GENERATEMEASTABLE) -i $(GENTABFILE) -o outputs/$(DESIGN)_meas.tab -v r'*'

#clean :
#	rm -rf $(DESIGN).ckt
#	rm -rf CDS.log
