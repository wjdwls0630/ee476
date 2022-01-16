#PROJECT_DIR = <Default cadence
DESIGN_LIB = cad0 
USR = jpark25 
DESIGN_DIR = /mmfs1/home/$(USR)/ee476/cadence
#DESIGN_LIB is used below because it is assumed that your linux dir for sims will be the same as your cadence designLibb
NETLIST_DIR = /mmfs1/home/$(USR)/ee476/$(DESIGN_LIB)/spice/netlists
# VPATH=touchfiles
XNETLIST = /home/projects/ee476/common/scripts/xnetlist.py
SPICESETUP = /home/projects/ee476/common/scripts/spiceSetup.py
GENERATEMEASTABLE = /home/projects/ee476/common/scripts/generateMeasTable.py
HSPICE = hspice -mt 2 -hpp
all: hspice
PHONY = netlist hspice

$(DESIGN).ckt:$(DESIGN_DIR)/$(DESIGN_LIB)/$(DESIGN)/schematic/sch.oa
        $(XNETLIST) -l $(DESIGN_LIB) -c $(DESIGN) -v schematic -d $(DESIGN_DIR) -n $(NETLIST_DIR) --topsub
        $(SPICESETUP) -i $(NETLIST_DIR)/$(DESIGN)/hspiceD/schematic/netlist/input.ckt -o $(DESIGN).ckt


hspice: $(DESIGN).ctl $(DESIGN).ckt
        -hspice $(DESIGN).ctl -o $(DESIGN).lis
        -$(GENERATEMEASTABLE) -i $(DESIGN).mt0 -o $(DESIGN)_meas.tab -v r'*'


netlist:$(DESIGN_DIR)/$(DESIGN_LIB)/$(DESIGN)/schematic/sch.oa
        $(XNETLIST) -l $(DESIGN_LIB) -c $(DESIGN) -v schematic -d $(DESIGN_DIR) -n $(NETLIST_DIR) --topsub
        $(SPICESETUP) -i $(NETLIST_DIR)/$(DESIGN)/hspiceD/schematic/netlist/input.ckt -o $(DESIGN).ckt


genTable: $(FILE)
        -generateMeasTable.py -i $(FILE).mt0 -o $(DESIGN)_meas.tab -v r'*'

