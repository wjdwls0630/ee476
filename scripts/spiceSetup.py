#!/usr/bin/env python3

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

options=getOptions("i:o:")

oldLine = ""
wfh=open(options["o"],'w')

with open(options["i"],'r') as rfh:
    for line in rfh:
        line=line.rstrip()
        if(re.search(r'^(\s*\.param|\s*\.lib|\s*.temp|\s*end$)', line, re.IGNORECASE)):
# re.search(r'^\s*\.(param)|(lib)|(temp)|(end$)', line, re.IGNORECASE)):
            continue
        if(re.search(r'^\s*\*',line)):
            continue
        oldLine=line
        if(re.match(r'^\s*\+', line)): #This is a line continuation
            line = re.sub(r'^\s*\+\s*'," ",line)
            oldLine+=line
            continue
        else:#A line of its own...keep going...
            oldLine=oldLine.replace('<', '[')
            oldLine=oldLine.replace('>',']')
            wfh.write(oldLine)
            wfh.write('\n')
            oldLine=""


#Take care of the final line

wfh.write(oldLine)
rfh.close()
wfh.close()