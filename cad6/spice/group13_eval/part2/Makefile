.PHONY: all hspice prep
all: hspice

prep:
	sed -i -e "s/{USER}/${USER}/g" launch_ALU.ctl

hspice:prep
	hspice -mt 32 -i launch_ALU.ctl -o out/out 
