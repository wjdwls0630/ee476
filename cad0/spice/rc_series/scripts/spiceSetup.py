#!/usr/bin/python

import re
import os
import sys
import getopt

#This package deals with performing any pre processing of the spice netlist, including preparing for
#Build a hash of options
def getOptions(literals):
    optionDict={}
    options,rest = getopt.getopt(sys.argv[1:], literals)
    for option,argument in options:
        option_sub = re.sub(r'\-',"",option)
        optionDict[option_sub] = argument
    return optionDict

options=getOptions("i:o:");

oldLine = ""
wfh=open(options["o"],'w')

for header in range(3):
    wfh.write('** DO NOT MODIFY THE COMMENTS STARTED WITH "**" AND .LIB STATEMENTS IN THIS DOCUMENT')
    wfh.write('\n')

wfh.write('\n')

with open(options["i"],'r') as rfh:
    for line in rfh:
        line=line.rstrip()
        oldLine=line
        oldLine=oldLine.replace('<', '[')
        oldLine=oldLine.replace('>',']')
        wfh.write(oldLine)
        wfh.write('\n')
        oldLine=""


#Take care of the final line

wfh.write(oldLine)
rfh.close()
wfh.close()
