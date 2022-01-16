;*******************************************************************************
;*******************************************************************************
;  leSchBindKeys.il
;
;	This file contains an example of bindKeys that can be used with both
;	the layout editor and / or schematic editor. The bindkeys are
;	mapped to functions that are similar in functionality in both 
;	editors.
; 
;	All lower case letter keys have been defined. There are some
;	bindkey combinations such as control b, that are yet undefined.
;
;	These bindkeys are based on the default layout bindkeys. Users that
;	are more familar with the schematic default bindkeys will find
;	different functions associated with the following bindkeys:
;	b, e, shift e, control e, shift f, control f, g, shift g, control g,
;	m, shift m, n, shift n, o, shift o, p, r, shift s, control s, v, w, 
;	shift w, x, shift x, shift z, control z.
;	 
;
;*******************************************************************************
;	$Author: p4admin $
;	$Revision: #1 $
;	$Date: 2013/03/10 $
;	$State: Exp $
;*******************************************************************************
;*******************************************************************************


; legRpDelta is used below in setting Numeric Key Pad Key bindings
legRpDelta = 0.5

hiSetBindKeys("Layout" list(

    ;***************************************************************************
    ; Standard Keys
    ;***************************************************************************

    list("<Key>a"                      "leHiQuickAlign()")
    list("Shift<Key>a"                 "geSingleSelectBox()")
    list("Ctrl<Key>a"                  "geSelectAllFig()")
    list("Ctrl Shift<Key>a"            "leHiAddWireVia(hiGetCurrentWindow() \"down\")")

    list("<Key>b"                      "leReturnToLevel()")
    list("Shift<Key>b"                 "leReturn()")

    list("Ctrl Shift<Key>x"            "leHiCreateBus()")

    list("<Key>c"                      "leHiCopy()")
    list("Shift<Key>c"                 "leHiChop()")

    list("<Key>d"                      "geSubSelectPoint()")
    list("Shift<Key>d"                 "geSubSelectBox()")
    list("Ctrl<Key>d"                  "geDeselectAllFig()")
    list("Ctrl Shift<Key>d"  	       "leHiP2P()")

    list("<Key>e"                      "leHiEditDisplayOptions()")
    list("Shift<Key>e"                 "leHiEditEditorOptions()")

    list("<Key>f"                      "hiZoomAbsoluteScale(hiGetCurrentWindow() 0.9)")
    list("Shift<Key>f"                 "hiGetCurrentWindow()->stopLevel = dbGetMaxHierDepth()")
    list("Ctrl<Key>f"                  "hiGetCurrentWindow()->stopLevel = 0")
    list("Ctrl Shift<Key>f"            "leFinishEntireNet()")


    list("<Key>g"                      "leToggleGravity()")
    list("Ctrl<Key>g"                  "geZoomToGrid(hiGetCurrentWindow())")
    list("Ctrl Shift<Key>g"	       "weGatherBusWires(hiGetCurrentWindow())")

    list("<Key>i"                      "leHiCreateInst()")
    list("Shift<Key>i"  	       "leHiGuidedRoutingReverseEnvelope(hiGetCurrentWindow())")

    list("<Key>k"                      "leHiCreateRuler()")
    list("Shift<Key>k"                 "leHiClearRuler()")

    list("<Key>l"                      "leHiCreateLabel()")

    list("<Key>m"                      "leHiMove()")
    list("Shift<Key>m"                 "leHiMerge()")

    list("<Key>n"                      "leSetFormSnapMode(\"diagonal\")")
    list("Shift<Key>n"                 "leSetFormSnapMode(\"orthogonal\")")
    list("Ctrl<Key>n"                  "leSetFormSnapMode(\"L90XFirst\")")

    list("<Key>o"                      "leHiCreateVia()")

    list("<Key>p"                      "leHiCreateWire()")
    list("Shift<Key>p"                 "leHiCreatePolygon()")
    list("Ctrl<Key>p"                  "leHiCreatePin()")
    list("Ctrl Shift<Key>p"            "weCWHoldWidth()")

    list("<Key>q"                      "leHiEditProp()")
    list("Shift<Key>q"                 "leEditDesignProperties()")
    list("Ctrl Shift<Key>q"            "leHiAddWireVia(hiGetCurrentWindow() \"up\")")
    list("Ctrl<Key>q"		       "rdeInspect()")

    list("<Key>r"                      "leHiCreateRect()")
    list("Shift<Key>r"                 "leHiReShape()")
    list("Ctrl<Key>r"                  "hiRedraw()")

    list("<Key>s"                      "leHiStretch()")
    list("Shift<Key>s"                 "leHiSearch()")
    list("Ctrl<Key>s"                  "leHiSplit()")
    list("Ctrl Shift<Key>s"            "leHiGuidedRouting()")

    list("<Key>t"                      "leHiLayerTap()")
    list("Shift<Key>t"                 "leHiTree()")

    list("<Key>u"                      "hiUndo()")
    list("Shift<Key>u"                 "hiRedo()")

    list("<Key>v"                      "leHiAttach()")
    list("Shift<Key>v"                 "deToggleAssistantVisibility(\"World View\")")
    list("Ctrl<Key>v"                  "hiFocusToCIW(hiGetCurrentWindow())")
    list("Ctrl Shift<Key>v"            "leFinishWire()")

    list("<Key>w"                      "leHiCreateWire()")
    list("Ctrl Shift<Key>w"            "leHiCreateWire()")
    list("Shift<Key>w"                 "hiNextWinView(hiGetCurrentWindow())")
    list("Ctrl<Key>w"                  "hiCloseWindow(hiGetCurrentWindow())")

    list("<Key>x"                      "leHiEditInPlace()")
    list("Shift<Key>x"                 "leHiDescend()")
    list("Ctrl<Key>x"                  "leEIPZoomAbsoluteScale(hiGetCurrentWindow() 0.9)")

    list("<Key>y"                      "leHiYank()")
    list("Shift<Key>y"                 "leHiPaste()")

    list("<Key>z"                      "hiZoomIn()")
    list("Shift<Key>z"                 "hiZoomRelativeScale(hiGetCurrentWindow() 0.5)")
    list("Ctrl<Key>z"                  "hiZoomRelativeScale(hiGetCurrentWindow() 2.0)")
    list("Ctrl Shift<Key>z"            "leWECycleControlWire()")
    list("Ctrl Shift<Btn1Down>"        "hiZoomInMagnifier(hiGetCurrentWindow())")
    list("Ctrl Shift<Btn2Down>"        "hiZoomOutMagnifier(hiGetCurrentWindow())")
    ;***************************************************************************
    ; Special Keys
    ;***************************************************************************

    list("<Key>Escape EF"              "cancelEnterFun()")
    list("<Key>Delete EF"              "leHiDelete()"  )
    list("<Key>Delete"                 "leHiDelete()")
    list("<Key>Tab"                    "hiPan()")
    list("<Key>F2"                     "geSave()")
    list("<Key>F3 EF"                  "hiToggleEnterForm()")
    list("<Key>F3"	               "geSaveAs()")
    list("<Key>F5"                     "deFileOpen()")
    list("<Key>F6"                     "hiRedraw()")
    list("<Key>F11"                    "deToggleAssistants()")

    ;***************************************************************************
    ; Numeric Key Pad (Window Panning Functions)
    ;***************************************************************************

    list("<Key>R7"                     "geScroll(nil \"nw\"    nil)")
    list("<Key>Up"                     "geScroll(nil \"n\"     nil)")
    list("<Key>R9"                     "geScroll(nil \"ne\"    nil)")
    list("<Key>Left"                   "geScroll(nil \"w\"     nil)")
    list("<Key>R11"                    "geScroll(nil \"\"      nil)")
    list("<Key>Right"                  "geScroll(nil \"e\"     nil)")
    list("<Key>R13"                    "geScroll(nil \"sw\"    nil)")
    list("<Key>Down"                   "geScroll(nil \"s\"     nil)")
    list("<Key>R15"                    "geScroll(nil \"se\"    nil)")
    list("<Key>KP_Enter"               "mouseAddPt()")
    list("<Key>KP_Add"                 "leHiSetRefPoint()")
    list("<Key>KP_Subtract"            "leSetRefPointInactive(geGetEditCellView())")
    list("<Key>KP_Equal"               "legRpDelta = 0.5")
    list("<Key>KP_Divide"              "legRpDelta = 1.0")
    list("<Key>KP_Multiply"            "legRpDelta = 2.0")
    list("<Key>R4"                     "legRpDelta = 0.5")
    list("<Key>R5"                     "legRpDelta = 1.0")
    list("<Key>R6"                     "legRpDelta = 2.0")
    list("Shift<Key>R7"                "leMoveCursor(-legRpDelta  legRpDelta)")
    list("Shift<Key>Up"                "leMoveCursor(          0  legRpDelta)")
    list("Shift<Key>R9"                "leMoveCursor( legRpDelta  legRpDelta)")
    list("Shift<Key>Left"              "leMoveCursor(-legRpDelta           0)")
    list("Shift<Key>R11"               "leMoveCursorToRefPoint()")
    list("Shift<Key>Right"             "leMoveCursor( legRpDelta           0)")
    list("Shift<Key>R13"               "leMoveCursor(-legRpDelta -legRpDelta)")
    list("Shift<Key>Down"              "leMoveCursor(0           -legRpDelta)")
    list("Shift<Key>R15"               "leMoveCursor( legRpDelta -legRpDelta)")
    list("Ctrl<Key>R7"                 "geScroll(nil \"nw\"    t)")
    list("Ctrl<Key>Up"                 "geScroll(nil \"n\"     t)")
    list("Ctrl<Key>R9"                 "geScroll(nil \"ne\"    t)")
    list("Ctrl<Key>Left"               "geScroll(nil \"w\"     t)")
    list("Ctrl<Key>R11"                "geScroll(nil \"\"      t)")
    list("Ctrl<Key>Right"              "geScroll(nil \"e\"     t)")
    list("Ctrl<Key>R13"                "geScroll(nil \"sw\"    t)")
    list("Ctrl<Key>Down"               "geScroll(nil \"s\"     t)")
    list("Ctrl<Key>R15"                "geScroll(nil \"se\"    t)")
    list("<Key>space"                  "leHiAddWireVia(hiGetCurrentWindow())")
    list("Ctrl<Key>space"              "(leWECycleSnap)")
    list("Ctrl Shift<Key>space"        "(leWENoSnap)")
    list("<Key>space EF"               "leSpaceBarFunc(hiGetCurrentWindow() t)")
    list("Shift<Key>space EF"          "leSpaceBarFunc(hiGetCurrentWindow() t t)")
    list("Ctrl<Key>space EF"           "leSpaceBarFunc(hiGetCurrentWindow() \"cancel\")")
    list("Ctrl Shift <Key>space EF"    "leSpaceBarFunc(hiGetCurrentWindow() \"ctrlShift\")")
    list("<Key>BackSpace"              "deletePoint()")
  )
)


hiSetBindKeys("Schematics" list(

    ;***************************************************************************
    ; Standard Keys
    ;***************************************************************************

    list("<Key>a"                  	"geSingleSelectPoint()")
    list("Shift<Key>a"             	"geSingleSelectBox()")
    list("Ctrl<Key>a"              	"geSelectAllFig()")
    list("Shift<Key>b"             	"schHiReturn()")
    list("<Key>c"                  	"schHiCopy()")
    list("<Key>d"                  	"geSubSelectPoint()")
    list("Shift<Key>d"             	"geSubSelectBox()")
    list("Ctrl<Key>d"              	"geDeselectAllFig()")
    list("<Key>e"                  	"schHiDisplayOptions()")
    list("Shift<Key>e"             	"schHiEditorOptions()")
    list("Ctrl<Key>e"              	"schHiGridOptions()")
    list("<Key>f"                  	"hiZoomAbsoluteScale(getCurrentWindow() 0.9)")

    list("Ctrl<Key>f"                  	"schSetEnv(\"sideways\" t)")
    list("Ctrl<Key>j"           	"schSetEnv(\"upsideDown\" t)")
    list("<Key>g"                  	"geHiCommonFindMarker()")
    list("Shift<Key>g"             	"geHiExplainMarker()")
    list("Ctrl<Key>g"              	"geHiDeleteMarker()")
    list("<Key>h"                  	"schHiHiliteLabel(\"wire\" \"on\")")
    list("Shift<Key>h"             	"schHiHiliteLabel(\"wire\" \"off\")")
    list("<Key>i"                  	"schHiCreateInst()")
    list("Shift<Key>i"             	"schHiCreateBlockInst()")
;   list("<Key>j"                  	"schHiRotate()")
;   list("<Key>j EF"               	"schSetEnv(\"rotate\" t)")
;   list("Shift<Key>j EF"          	"schSetEnv(\"sideways\" t)")
;   list("Ctrl<Key>j EF"           	"schSetEnv(\"upsideDown\" t)")
    list("<Key>l"                  	"schHiCreateWireLabel()")
    list("Shift<Key>l"             	"schHiCreateNoteLabel()")
    list("<Key>m"                  	"schHiMove()")
    list("<Key>w"                  	"schHiCreateWire(0.0)")
    list("<Key>p"              	"schHiCreatePin()")
    list("<Key>q"                  	"schHiObjectProperty()")
    list("<Key>q EF"               	"schHiObjectProperty()")
    list("Shift<Key>q"             	"schHiCellViewProperty()")
    list("Shift<Key>q EF"          	"schHiCellViewProperty()")
    list("<Key>s"                  	"schHiStretch()")
    list("<Key>s EF"                  	"schSnapToConn()")
    list("Shift<Key>s"             	"schHiFind()")
    list("<Key>t"                       "schHiEditText()")
    list("<Key>u"                  	"hiUndo()")
    list("Shift<Key>u"             	"hiRedo()")
    list("Shift<Key>v"		        "_deToggleAssistant(\"World View\")")
    list("Ctrl<Key>v"              	"hiFocusToCIW(hiGetCurrentWindow())")
    list("Shift<Key>w"             	"hiNextWinView(hiGetCurrentWindow())")
    list("Ctrl<Key>w"              	"hiCloseWindow(hiGetCurrentWindow())")
    list("<Key>x"                  	"schHiEditInPlace()")
    list("Shift<Key>x"             	"schHiDescendEdit()")
    list("Ctrl<Key>x"              	"schHiDescendRead()")
    list("<Key>z"                  	"hiZoomIn()")
    list("Shift<Key>z"             	"hiZoomRelativeScale(getCurrentWindow() 0.8)")
    list("Ctrl<Key>z"              	"hiZoomRelativeScale(getCurrentWindow() 1.25)")
    list("<Key>4 EF"               	"schSnapToConn()")
    list("<Key>5"                  	"schHiRouteFlightLine()")
    list("<Key>8"                  	"schHiHiliteLabel(\"instance\" \"on\")")
    list("Shift<Key>8"             	"schHiHiliteLabel(\"instance\" \"off\")")
    list("<Key>9"                  	"geEnterAddNetProbe()")
    list("<Key>0"                  	"geDeleteNetProbe()")
    list("Ctrl Shift<Btn1Down>"        "hiZoomInMagnifier(hiGetCurrentWindow())")
    list("Ctrl Shift<Btn2Down>"        "hiZoomOutMagnifier(hiGetCurrentWindow())")

    ;***************************************************************************
    ; Special Keys
    ;***************************************************************************

    list("<Key>Delete"             	"schHiDelete()")
    list("<Key>Tab"                	"hiPan()")
    list("<Key>F2"                 	"_schHiSave()")
    list("<Key>F3"                 	"_schHiSaveAs()")
    list("<Key>F4"                 	"schSetSelectOptions()")
    list("<Key>F6"                 	"hiRedraw()")
    list("<Key>F7"                 	"schHiCheck(\"run\")")
    list("<Key>F8"                 	"schHiCheckAndSave()")
    list("<Key>F9"                 	"schHiCreateNoteShape()")
    ;; list("<Key>F9"                 	"schHiCreateNoteLabel()")
    list("<Key>F10"                	"schSetSelectOptions()")
    list("<Key>F11"             	"deToggleAssistants()")
    list("None<Btn1Down>"          	"schSingleSelectPt()")
    list("Shift<Btn1Down>"         	"schAddSelectPt()")
    list("<DrawThru1>"             	"schDirectEdit(1)")
    list("Shift<DrawThru1>"        	"schDirectEdit(2)")
    list("Ctrl<DrawThru1>"         	"schDirectEdit(3)")
    list("None<Btn1Down>(2)"            "when(schSingleSelectPt() schHiDescend())")
    list("Shift<Btn1Down>(2)"           "schExtendSelectPt()")
    list("None<Btn1Down>(2) EF"         "schMouseApplyOrFinish()")

        list("None<Btn3Down>"          	"schHiMousePopUp()")
        list("None<Btn3Down> EF"       	"schHiMousePopUp()")
        list("None<Btn2Down> EF"       	"schCmdOption()")
        list("Shift<Btn2Down> EF"      	"schShiftCmdOption()")

    ;***************************************************************************
    ; Numeric Key Pad (Window Panning Functions)
    ;***************************************************************************

    list("<Key>Up"                 	"geScroll(nil \"n\"     nil)")
    list("<Key>Left"               	"geScroll(nil \"w\"     nil)")
    list("<Key>Right"              	"geScroll(nil \"e\"     nil)")
    list("<Key>Down"               	"geScroll(nil \"s\"     nil)")
  )
)



hiSetBindKeys("Symbol" list(

    ;***************************************************************************
    ; Standard Keys
    ;***************************************************************************

    list("<Key>a"                      "geSingleSelectPoint()")
    list("Shift<Key>a"                 "geSingleSelectBox()")
    list("Ctrl<Key>a"                  "geSelectAllFig()")
    list("Shift<Key>b"                 "schHiReturn()")
    list("<Key>c"                      "schHiCopy()")
    list("<Key>d"                      "geSubSelectPoint()")
    list("Shift<Key>d"                 "geSubSelectBox()")
    list("Ctrl<Key>d"                  "geDeselectAllFig()")
    list("<Key>e"                      "schHiDisplayOptions()")
    list("Shift<Key>e"                 "schHiEditorOptions()")
    list("Ctrl<Key>e"                  "schHiDisplayOptions()")
    list("<Key>f"                      "hiZoomAbsoluteScale(getCurrentWindow() 0.9)")
    list("<Key>g"                      "geHiCommonFindMarker()")
    list("Shift<Key>g"                 "geHiExplainMarker()")
    list("Ctrl<Key>g"                  "geHiDeleteMarker()")
    list("<Key>j"                      "schHiRotate(t)")
    list("<Key>j EF"                   "schSetEnv(\"rotate\" t)")
    list("Shift<Key>j EF"              "schSetEnv(\"sideways\" t)")
    list("Ctrl<Key>j EF"               "schSetEnv(\"upsideDown\" t)")
    list("<Key>l"                      "schHiCreateSymbolLabel()")
    list("Shift<Key>l"                 "schHiCreateNoteLabel()")
    list("<Key>m"                      "schHiMove()")
    list("Ctrl<Key>p"                  "schHiCreateSymbolPin()")
    list("<Key>q"                      "schHiObjectProperty()")
    list("<Key>q EF"                   "schHiObjectProperty()")
    list("Shift<Key>q"                 "schHiCellViewProperty()")
    list("Shift<Key>q EF"              "schHiCellViewProperty()")
    list("<Key>s"                      "schHiSymStretch()")
    list("<Key>t"                      "schHiEditText()")
    list("<Key>u"                      "hiUndo()")
    list("Shift<Key>u"                 "hiRedo()")
    list("Shift<Key>v"		       "_deToggleAssistant(\"World View\")")
    list("Ctrl<Key>v"                  "hiFocusToCIW(hiGetCurrentWindow())")
    list("<Key>w"                      "hiPrevWinView(hiGetCurrentWindow())")
    list("Shift<Key>w"                 "hiNextWinView(hiGetCurrentWindow())")
    list("Ctrl<Key>w"                  "hiCloseWindow(hiGetCurrentWindow())")
    list("<Key>x"                      "schHiEditInPlace()")
    list("<Key>z"                      "hiZoomIn()")
    list("Shift<Key>z"                 "hiZoomRelativeScale(getCurrentWindow() 0.8)")
    list("Ctrl<Key>z"                  "hiZoomRelativeScale(getCurrentWindow() 1.25)")
    list("<Key>9"                      "geEnterAddNetProbe()")
    list("<Key>0"                      "geDeleteNetProbe()")

    ;***************************************************************************
    ; Special Keys
    ;***************************************************************************

    list("<Key>Delete"                 "schHiDelete()")
    list("<Key>Tab"                    "hiPan()")
    list("<Key>F2"                     "_schHiSave()")
    list("<Key>F3"                     "_schHiSaveAs()")
    list("<Key>F6"                     "hiRedraw()")
    list("<Key>F9"                     "schHiCreateNoteShape()")
    ;; list("<Key>F9"                     "schHiCreateNoteLabel()")
    list("<Key>F10"                    "schSetSelectOptions()")
    list("<Key>F11"                    "deToggleAssistants()")

    list("<DrawThru1>"                 "schDirectEdit(1)")
    list("Shift<DrawThru1>"            "schDirectEdit(2)")
    list("Ctrl<DrawThru1>"             "schDirectEdit(3)")
    list("None<Btn1Down>(2) EF"        "schMouseApplyOrFinish()")

        list("None<Btn3Down>"          	"schHiMousePopUp()")
        list("None<Btn3Down> EF"       	"schHiMousePopUp()")
        list("None<Btn2Down> EF"       	"schCmdOption()")
        list("Shift<Btn2Down> EF"      	"schShiftCmdOption()")
    
    ;***************************************************************************
    ; Numeric Key Pad (Window Panning Functions)
    ;***************************************************************************

    list("<Key>Up"                     "geScroll(nil \"n\"     nil)")
    list("<Key>Left"                   "geScroll(nil \"w\"     nil)")
    list("<Key>Right"                  "geScroll(nil \"e\"     nil)")
    list("<Key>Down"                   "geScroll(nil \"s\"     nil)")
  )
)
