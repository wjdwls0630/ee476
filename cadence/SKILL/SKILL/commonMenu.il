/* Rajesh Pamula on 11 June 2013
 * Creates a simple short cut menu for commonly used symbols
 * Short cut is 1. Devices Idc, Vdc, Vsin, pmos, nmos and gnd
 * mimcap 2fF/um2 is addded, Resistance from analogLib is added
 */
 
/* Updated by Rajesh on 11 Oct 2015
 * UW 90nm process customization
 */ 

/* Hacked by Visvesh on 4/5/16 for UW 65nm */
/* (Hacked)^2 by Hansem on 9/26/16 for FreePDK45 and added vss*/

procedure(placeMenuBasic(item lib)
	schHiCreateInst(lib item "symbol")
); for analogLib components

procedure(makeMenu()
    ; variables
    let((vddHandle vssHandle gndHandle noConnHandle resHandle capHandle idcHandle vdcHandle pmosHandle nmosHandle invHandle nandHandle norHandle)


    vddHandle = hiCreateMenuItem(?name 'vddItem ?itemText "vdd" ?callback "placeMenuBasic(\"vdd\" \"analogLib\")")
    vssHandle = hiCreateMenuItem(?name 'vssItem ?itemText "vss" ?callback "placeMenuBasic(\"vss\" \"analogLib\")")
    gndHandle = hiCreateMenuItem(?name 'gndItem ?itemText "gnd" ?callback "placeMenuBasic(\"gnd\" \"analogLib\")")
    noConnHandle = hiCreateMenuItem(?name 'noConnItem ?itemText "noConn" ?callback "placeMenuBasic(\"noConn\" \"basic\")")
    resHandle = hiCreateMenuItem(?name 'resItem ?itemText "res" ?callback "placeMenuBasic(\"res\" \"analogLib\")")
    capHandle = hiCreateMenuItem(?name 'capItem ?itemText "cap" ?callback "placeMenuBasic(\"cap\" \"analogLib\")")
    idcHandle = hiCreateMenuItem(?name 'idcItem ?itemText "idc" ?callback "placeMenuBasic(\"idc\" \"analogLib\")")
     vdcHandle = hiCreateMenuItem(?name 'vdcItem ?itemText "vdc" ?callback "placeMenuBasic(\"vdc\" \"analogLib\")")
    ;mimHandle = hiCreateMenuItem(?name 'mimItem ?itemText "mimCap2fF" ?callback "placeMenuBasic(\"mimcap_2p0_sin\" \"analogLib\")")
    ;vsinHandle = hiCreateMenuItem(?name 'vsinItem ?itemText "vsin" ?callback "placeMenuBasic(\"vsin\" \"analogLib\")")

    ;FreePDK45 design lib handles
    pmosHandle = hiCreateMenuItem(?name 'pmosItem ?itemText "pmosNom" ?callback "placeMenuBasic(\"PMOS_VTL\" \"NCSU_Devices_FreePDK45\")")
    nmosHandle = hiCreateMenuItem(?name 'nmosItem ?itemText "nmosNom" ?callback "placeMenuBasic(\"NMOS_VTL\" \"NCSU_Devices_FreePDK45\")")
    invHandle = hiCreateMenuItem(?name 'invItem ?itemText "inv" ?callback "placeMenuBasic(\"INV_X1\" \"NangateOpenCellLibrary\")")
    nandHandle = hiCreateMenuItem(?name 'nandItem ?itemText "nand" ?callback "placeMenuBasic(\"NAND2_X1\" \"NangateOpenCellLibrary\")")
    norHandle = hiCreateMenuItem(?name 'norItem ?itemText "nor" ?callback "placeMenuBasic(\"NOR2_X1\" \"NangateOpenCellLibrary\")")


    ;Menuhandle
    menuHandle = hiCreateMenu('menuHandle "CommonItems" list('pmosHandle, 'nmosHandle, 'vddHandle, 'vssHandle, 'gndHandle, 'noConnHandle, 'capHandle, 'resHandle, 'invHandle, 'nandHandle, 'norHandle, 'vdcHandle, 'idcHandle))


    hiDisplayMenu(menuHandle)
    menuHandle = nil

    )
)

; Bindkey setting
hiSetBindKey("Schematics" "<Key>1" "makeMenu()")
