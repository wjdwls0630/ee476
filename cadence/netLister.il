/* Netlist creation procedure
 * Created by Pamula Venkata Rajesh
 * Version 0.1 - 17 Oct 2015 - Created
 * Changed the default simulator to hspiceD and invokes ADE L
 * followed by netlisting.
 * Procedure is bound to Shift+T
 */

procedure(createNetlist()
   envSetVal("asimenv.startup" "simulator" 'string  "hspiceD")                    ; hspiceD as simulator 
   envSetVal("asimenv.startup" "projectDir" 'string "~/ee476/cadence/netlists")   ; Output directory
   deInstallApp(getCurrentWindow() "analogArtist-Schematic")                      ; Launch ADE L
   session = sevSession(getCurrentWindow())
   ; Couldn't get this to work  
   ;sevChooseSimulator(session)                                       ; Open Simulator/Directory/Host menu
   ;hiGetCurrentForm()->projectDir->value="~/ee476/cadence/netlists"  ; Set output path
   ;hiFormDone(session)
   sevNetlistFile(session 'create)	                                  ; Create netlist file
)

/* Change the default simulator to hspiceD from spectre
 * This is course/class specific customization
 * Can be added to cdsinit/cdsenv depending on flexibility
 * Currently to be loaded individually at startup time
 */
;envSetVal("asimenv.startup" "simulator" 'string  "hspiceD")       ; hspiceD as simulator 

/* Bind the netlist extraction to a bindkey
 * Using Shift+T in this case
 */
hiSetBindKey("Schematics" "Shift<Key>T" "createNetlist()")
