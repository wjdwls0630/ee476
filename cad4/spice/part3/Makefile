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
.PHONY: setup_rise
.PHONY: setup_fall
.PHONY: hold_rise
.PHONY: hold_fall
.PHONY: netlists
.PHONY: genTable

all: hspice setup_rise setup_fall hold_rise hold_fall 



$(DESIGN).ckt: $(DESIGN_DIR)/$(DESIGN_LIB)/$(DESIGN)/schematic/sch.oa
	$(XNETLIST) -l $(DESIGN_LIB) -c $(DESIGN) -v schematic -d $(DESIGN_DIR) -n $(NETLIST_DIR) --topsub
	$(SPICESETUP) -i $(NETLIST_DIR)/$(DESIGN)/hspiceD/schematic/netlist/input.ckt -o $(DESIGN).ckt
	sed -i "5i + ARTIST=2\n+ INGOLD=2\n+ PARHIER=LOCAL\n+ PSF=2" $(DESIGN).ckt

hspice: $(DESIGN).ctl $(DESIGN).ckt
	$(STDLIBSETUP) -c $(DESIGN).ctl -b 0 -l $(COMMON_DIR)/cadence_setup/freepdk45.l --corner tt_lib
	rm -rf outputs/
	mkdir outputs/	
	$(HSPICE) -i $(DESIGN).ctl -o outputs/ | tee -i outputs/$(DESIGN).$(LOG)
#	$(VIVA) -datadir outputs/ &

setup_rise: $(DESIGN).ckt
	$(STDLIBSETUP) -c $(DESIGN).ctl -b 0 -l $(COMMON_DIR)/cadence_setup/freepdk45.l --corner tt_lib
	rm -rf outputs_setup_rise/
	mkdir outputs_setup_rise/	
	$(HSPICE) -i setup_rise.ctl -o outputs_setup_rise/ | tee -i outputs_setup_rise/setup_rise.$(LOG)
#	$(VIVA) -datadir outputs/ &

setup_fall: $(DESIGN).ckt
	$(STDLIBSETUP) -c $(DESIGN).ctl -b 0 -l $(COMMON_DIR)/cadence_setup/freepdk45.l --corner tt_lib
	rm -rf outputs_setup_fall/
	mkdir outputs_setup_fall/	
	$(HSPICE) -i setup_fall.ctl -o outputs_setup_fall/ | tee -i outputs_setup_fall/setup_fall.$(LOG)
#	$(VIVA) -datadir outputs/ &

hold_rise: $(DESIGN).ckt
	$(STDLIBSETUP) -c $(DESIGN).ctl -b 0 -l $(COMMON_DIR)/cadence_setup/freepdk45.l --corner tt_lib
	rm -rf outputs_hold_rise/
	mkdir outputs_hold_rise/	
	$(HSPICE) -i hold_rise.ctl -o outputs_hold_rise/ | tee -i outputs_hold_rise/hold_rise.$(LOG)
#	$(VIVA) -datadir outputs/ &

hold_fall: $(DESIGN).ckt
	$(STDLIBSETUP) -c $(DESIGN).ctl -b 0 -l $(COMMON_DIR)/cadence_setup/freepdk45.l --corner tt_lib
	rm -rf outputs_hold_fall/
	mkdir outputs_hold_fall/	
	$(HSPICE) -i hold_fall.ctl -o outputs_hold_fall/ | tee -i outputs_hold_fall/hold_fall.$(LOG)
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
