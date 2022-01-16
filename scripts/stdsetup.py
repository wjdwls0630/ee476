#!/usr/bin/env python3

import sys
import os
import re
from argparse import ArgumentParser

# Version 0.3
# stdsetup.py : autogenerate missing stdLibs symlink in current working directory
#               and stdLibs include in control file
#
# Usage:
#   ./stdsetup.py [-b 0/1] -c <control_file.ctl> -l <stdLibs_file> --corner <corner_name>
#
# If the current working directory does not have stdLibs, it will create a
# symlink to the file. If the control file does not have ".lib <stdLibs_file>
# <corner_name>", it will be added after running the script.
#
# As a safety precaution, the control file are backed up by default with the
# extension .bakN, where N is a number.
# To disable control file backup, set 0 as argument to '-b'
#
# Notes:
# Create symlink to stdLibs in current directory
# Run the script at /home/projects/ee476/<NETID>/cadN/spice/<cellname>/
#
# TODO:
#  * Add warnings for permission errors if open(file) fails
#
# Created and maintained by Hansem Ro

# generateCtlCopy: Create a non-conflicting backup of given control file.
#                  Each backup has the extension .bakN, where N is a number.
def generateCtlCopy(ctlfile):
    i = 1
    while os.path.isfile(f"{ctlfile}.bak{i}"):
        i += 1
    print(f"stdsetup.py: Creating control file backup {ctlfile}.bak{i}")
    os.system(f"cp {ctlfile} {ctlfile}.bak{i}")

parser = ArgumentParser()
parser.add_argument("-c", dest="ctl", help="HSPICE control file")
parser.add_argument("-b", dest="b_en", help="1: enable backup (default); 0: disable backup", default="1")
parser.add_argument("-l", dest="lib", help="standard library file path")
parser.add_argument("--corner", dest="corner", help="corner name in library", default="tt_lib")
args = parser.parse_args()

assert os.path.isfile(args.lib)
assert args.ctl is not None
assert args.lib is not None
assert args.corner is not None

lib_filename = os.path.split(args.lib)[1]

if args.ctl == None:
    print("stdsetup.py: run with -h for help")
else:
    # Create symlink to stdLibs if not found
    if os.path.isfile(os.path.split(args.lib)[1]):
        print(f"stdsetup.py: {args.lib} is found")
    else:
        print(f"stdsetup.py: {args.lib} is not found; Creating symlink to {args.lib} in {os.getcwd()}")
        os.system(f"ln -s {args.lib} ./")

    # Append the $stdlibs include after the last include
    if os.path.isfile(args.ctl):
        stdLibsFound = False
        lastIncludeLine = 0
        with open(args.ctl + "", "r") as ctlfile:
            ctlbuffer = ctlfile.readlines()
        lineCount = 0
        for line in ctlbuffer:
            if re.match(f'.lib \"{lib_filename}\" {args.corner}', line):
                print(f"stdsetup.py: {lib_filename} already imported")
                stdLibsFound = True
                break
            else:
                if re.match('.inc', line, re.IGNORECASE):
                    lastIncludeLine = lineCount
            lineCount += 1
        if not stdLibsFound:
            if not args.b_en == "0":
                generateCtlCopy(args.ctl + "")
            print(f"stdsetup.py: Adding {args.lib} include to control file {args.ctl}")
            with open(args.ctl + "", "w") as ctlfile:
                lineCount = 0
                for line in ctlbuffer:
                    if lineCount == lastIncludeLine:
                        line = line + f"\n** include {lib_filename}\n.lib \"{lib_filename}\" {args.corner}\n"
                    ctlfile.write(line)
                    lineCount += 1
    else:
        print("stdsetup.py: Control file is missing")
