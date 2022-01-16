#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# Don't import from common, so that we only have to distribute one file
import argparse, json, os, re

# ANSI escape sequences for terminal printing
class TermColors:
    BLUE = '\033[34m'
    GREEN = '\033[32m'
    RED = '\033[31m'
    BOLD = '\033[1m'
    ENDC = '\033[0m'

# generic JSON keys for CAD specification
REPORT_KEY  = 'report'
PARTS_KEY   = 'parts'
FILES_KEY   = 'files'
MEAS_KEY    = 'measurements'
CIRCUIT_KEY = 'circuit'
NAME_KEY    = 'name'
PINS_KEY    = 'pins'

# our special specifications.json symbols
COMMENT_SYMBOL = '//'
NEWLINE = '\n'
NONE_SPECIFIED = 'none'

def patch_si_units(value):
    """Takes a string value, e.g. '143p' and replaces any SI prefixes
with their scientific notation ('143e-12')
    """
    # Femto -> 1e-15, pico -> 1e-12, ...
    suffixes = {'f': -15, 'p': -12, 'n': -9, 'u': -6, 'm': -3, 'k': 3, 'G': 9}
    if value and value[-1] in suffixes.keys():
        value = '%se%d'%(value[:-1], suffixes[value[-1]])
    return value


# Remove comments and any newlines to make valid json
# - Takes the name of the json file to be minified
def json_minify(file_name):
    # Load file
    f = open(file_name)
    raw_string = f.read()
    # Remove comments
    num_comments = raw_string.count(COMMENT_SYMBOL)
    for i in range(num_comments):
        comment_start = raw_string.find(COMMENT_SYMBOL)
        if comment_start >= 0:
            comment_end = raw_string.find(NEWLINE, comment_start+len(COMMENT_SYMBOL))
            # Check for weirdness
            if comment_end == -1:
                dbg_len = 30
                print('Comment start: ', raw_string[comment_start:comment_start + dbg_len])
                raise RuntimeError('Unexpected error, could not find end of comment')
            # Otherwise replace with ''
            comment = raw_string[comment_start:comment_end+len(NEWLINE)]
            raw_string = raw_string.replace(comment, '', 1)
    # Remove newlines
    minified = raw_string.replace(NEWLINE, '')

    # Remove trailing commas. Source: http://stackoverflow.com/a/23705538/216292
    # NOTE: this will fail if we expect the json to contain any string literals
    # containing some variant of ", }". But we don't expect that.
    minified = re.sub(",[ \t\r\n]+}", "}", minified)
    minified = re.sub(",[ \t\r\n]+\]", "]", minified)
    return minified


# json loading routine
def json_load(filename):
    # Minify the json file
    json_mini = json_minify(filename)
    try:
        return json.loads(json_mini)
    except ValueError:
        print('Found invalid json (specifications.json?)! Python debug output is not very helpful, try using an online \
JSON editor/viewer (sans comments)')
        raise


# Find the name of the first circuit in the given file
def get_circuit_name(filename):
    f = open(filename)
    # Parse for the circuit (token "** Design cell name:")
    identifier = '** Design cell name:'
    for line in f:
        if line.find(identifier) >= 0:
            # Split on whitespace
            tokens = line.split()
            # Return the token after 'name:'
            return tokens[4]


# Return the list of pins for the given circuit
# - assumes circuit exists in the given file
def get_circuit_pins(filename, circuit_name, pin_list):
    # Conver to lowercase
    pin_list = [pin.lower() for pin in pin_list]
    circuit_name = circuit_name.lower()
    pins_found = {}
    try:
        f = open(filename)
    except IOError:
        for pin in pin_list:
            pins_found[pin] = False
        return pins_found
    # Get rid of any sub-circuits (just in case...)
    subcircuit_start = '.subckt'
    subcircuit_end = '.ends'
    filtered_file = []
    skip_line = False
    for line in f:
        if line.find(subcircuit_start) >= 0:
            skip_line = True
        elif line.find(subcircuit_end) >= 0:
            skip_line = False
        if ~skip_line:
            filtered_file.append(line)

    # Parse for the circuit
    identifier = '** Cell name:'
    begin_pin_search = False
    # Assume the pins follow after the identifier
    for line in filtered_file:
        if line.find(identifier) >= 0:
            # Split on whitespace, convert to lowercase
            tokens = [tok.lower() for tok in line.split()]
            # If the token after 'name:' matches, look for each pin
            if tokens[3] == circuit_name:
                begin_pin_search = True
        if begin_pin_search:
            tokens = [tok.lower() for tok in line.split()]
            for pin in pin_list:
                # Record the pin as found if the pin name appears somewhere
                if pin in tokens:
                    pins_found[pin] = True
    # Cover the case where students may write their own CKT files, and the netlist structure
    # is not as predictable (just look for the pin tokens)
    for line in filtered_file:
        # Split on whitespace, convert to lowercase
        tokens = [tok.lower() for tok in line.split()]
        # Match against the list of pins
        for pin in pin_list:
            if pin in tokens:
                pins_found[pin] = True

    # Record the statuses of any remaining pins as not found
    for pin in pin_list:
        if pin not in pins_found:
            pins_found[pin] = False
    # Return the list of {pin_name: found/notfound} dicts
    return pins_found


#Checks to see if there is a student path in the json file.
def get_path_info(path=None):
    if path is not None:
        cad_spec = json_load(path)
    try:
        library_path = cad_spec["path"]
    except KeyError:
        print("No Student Path Found")
        library_path = "None"
    return library_path

# Check that all files exist
# - Takes the CAD json specification
def get_spec_info(cad_spec=None, path=None):
    if path is not None:
        cad_spec = json_load(path)
    files_info = [[]]  # A list containing lists of dicts
    # Check for report
    report = cad_spec[REPORT_KEY]
    if report != NONE_SPECIFIED:
        report_found = os.path.isfile(report)
        # Convenient to reserve [0] for the report
        files_info[0].append({
            'type': 'report',
            'val': report,
            'status': report_found
        })
    # Parse each CAD Part sequentially
    for partnum in range(1, len(cad_spec[PARTS_KEY])+1):
        files_info.append([])
        part = str(partnum)
        cad_part = cad_spec[PARTS_KEY][part]
        # Parse each file
        for fname in cad_part[FILES_KEY]:
            # Skip if none
            if fname == NONE_SPECIFIED:
                continue
            # Check if file exists
            file_found = os.path.isfile(fname)
            # Actions for type 'other'
            if cad_part[FILES_KEY][fname] == NONE_SPECIFIED:
                files_info[partnum].append({
                    'type': 'other',
                    'val': fname,
                    'status': file_found
                })
            # Actions for type 'cktfile'
            elif cad_part[FILES_KEY][fname].keys()[0] == CIRCUIT_KEY:
                    files_info[partnum].append({
                        'type': 'cktfile',
                        'val': fname,
                        'status': file_found})
                    circuit_dict = cad_part[FILES_KEY][fname][CIRCUIT_KEY]
                    circuit_name = ''
                    if file_found:
                        circuit_name = get_circuit_name(fname)
                    circuit_found = ((circuit_name == circuit_dict[NAME_KEY]) and file_found)
                    files_info[partnum].append({
                        'type': 'circuit',
                        'val': circuit_dict[NAME_KEY],
                        'status': circuit_found
                    })
                    # Check pin information
                    pin_spec = circuit_dict[PINS_KEY]
                    pins_found = get_circuit_pins(fname, circuit_dict[NAME_KEY], pin_spec)
                    for pin in pins_found:
                        pin_found = (pins_found[pin] and circuit_found)
                        files_info[partnum].append({
                            'type': 'pin',
                            'val': pin,
                            'status': pin_found
                        })
                        if (circuit_found and not pin_found):
                            print('\n\n\n')
                            print('============= !!!!!!!!!!!! '
                                  + TermColors.RED + 'Warning' + TermColors.ENDC +
                                  ' !!!!!!!!!!!! ===============')
                            print('Circuit "' + circuit_name + '" was found, '
                                                               'but pin "' + pin + '" not found')
                            print('Are your pins named correctly?')
                            print('===============================================================')
        # Parse each measurement
        for meas_name in cad_part[MEAS_KEY]:
            # Skip if none
            if meas_name == NONE_SPECIFIED:
                continue
            # Else read in the measurement
            meas_val_raw = cad_part[MEAS_KEY][meas_name]
            meas_val = patch_si_units(meas_val_raw)
            try:
                meas_valid = isinstance(float(meas_val), float)
            except ValueError:  # catch if value is empty, or not a number
                print("WARNING: invalid measurement value: %r" %(meas_val_raw))
                meas_valid = False
                meas_val = "none"
            files_info[partnum].append({
                'type': 'meas',
                'val': [meas_name, meas_val],
                'status': meas_valid
            })
    # Return extracted information
    return files_info


# Helper for report_check_spec; returns the correct prefix depending on if the info was found
def get_pfix(found_pfix, nfound_pfix, info_status):
    if info_status:
        return found_pfix
    else:
        return nfound_pfix


# Report results of validity check
# (basically just custom formatting based on the information)
def report_check_spec(files_info, outfile=''):
    info_strings = []
    f_pfix  = TermColors.GREEN + 'FOUND     [X] ' + TermColors.ENDC
    nf_pfix = TermColors.RED + 'NOT FOUND [ ] ' + TermColors.ENDC
    indent_l0 = '   '
    indent_l1 = '      '
    indent_l2 = '         '
    # Report each part sequentially
    for part_num in range(len(files_info)):
        # Part/report header
        if part_num == 0:
            info_strings.append(TermColors.BOLD + '==== Report ====' + TermColors.ENDC)
        else:
            info_strings.append(TermColors.BOLD + '==== Part ' + str(part_num) + ' ===='
                                + TermColors.ENDC)
        # Body for each part
        if len(files_info[part_num]) == 0:
            info_strings.append(indent_l0 + 'nothing to submit')
            info_strings.append('\n')
            continue
        for info_dict in files_info[part_num]:
            itype = info_dict['type']
            ival = info_dict['val']
            istat = info_dict['status']
            info_line = ''
            if   itype == 'report':
                info_line += indent_l0 + get_pfix(f_pfix, nf_pfix, istat) + ' (report PDF) ' + ival
            elif itype == 'other':
                info_line += indent_l0 + get_pfix(f_pfix, nf_pfix, istat) + ' (other) ' + ival
            elif itype == 'cktfile':
                info_line += indent_l0 + get_pfix(f_pfix, nf_pfix, istat) + ' (netlist) ' + ival
            elif itype == 'circuit':
                info_line += indent_l1 + get_pfix(f_pfix, nf_pfix, istat) + ' (circuit) ' + ival
            elif itype == 'pin':
                info_line += indent_l2 + get_pfix(f_pfix, nf_pfix, istat) + ' (circuit pin) ' + ival
            elif itype == 'meas':
                info_line += indent_l0 + get_pfix(f_pfix, nf_pfix, istat) + ' (measurement) ' + ival[0]
            info_strings.append(info_line)
        # Vertical whitespace after each part
        info_strings.append('\n')
    # Either print to file or to stdout
    if outfile == '':
        print('\n')
        for l in info_strings:
            print(l)
    else:
        f = open(outfile, 'w')
        for l in info_strings:
            f.write(l, '\n')
        f.close()


# Command line interface
def cli(py_interface=False, cad_spec='specifications.json', log_file=''):
    # Parse cl arguments
    describe = 'check_spec.py checks an existing file/directory structure for the items \
specified in the provided .json file.'
    parser = argparse.ArgumentParser(
        description=describe
    )
    parser.add_argument(
        '-f', dest='json_spec', required=True, type=str, action='store',
        help='JSON specification/measurement file for the CAD'
    )
    parser.add_argument(
        '-o', dest='log_file', required=False, type=str, action='store',
        help='Log file for result output'
    )
    if py_interface:
        args = parser.parse_args(['-f', cad_spec, '-o', log_file])
    else:
        args = parser.parse_args()
    # Load cad json specification
    raw_spec = json_load(args.json_spec)
    # Get file and circuit information
    spec_info = get_spec_info(raw_spec)
    # Generate report and return the spec. information
    report_check_spec(spec_info)
    return spec_info

if __name__ == '__main__':
    cli()
