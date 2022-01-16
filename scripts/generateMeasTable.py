#!/usr/bin/env python3

import spiceMeasFile
import re
import os
import sys
import getopt

#./generateMeasTable.py -i <inputfile> -o <outputfile> -v <comma separated string of variables'

# mf = spiceMeasFile.spiceMeasFile("cpm.mt0")
# mf.build_measTable()
# mf.report_failed_measurements()
#print spice measurement to desired table

def getOptions(literals):
    optionDict={}
    options,rest = getopt.getopt(sys.argv[1:], literals)
    for option,argument in options:
        option_sub = re.sub(r'\-',"",option)
        optionDict[option_sub] = argument
    return optionDict

options=getOptions("i:o:v:");

# oldLine = ""
# wfh=open(options["o"],'w')
# with open(options["i"],'r') as rfh:

if options["i"] is not None:
    if os.path.isfile(options["i"]):
        mf=spiceMeasFile.spiceMeasFile(options["i"])
        mf.write_measTable(options["o"],options["v"])
        exit(0)

print("No measurement file; skipping")
