;==============================================================================
;
; Sample BindKeys for Composer Schematics and Symbols
;
; Note that the files <install-dir>/share/cdssetup/dfII/bindkeys/Schematics.il
; and Symbol.il are automatically loaded and have the same definitions as given
; here
;
;==============================================================================
;
when( isCallable('schGetEnv)
;******************************************************************************
; Schematics.il - Copyright (C) 1997-2010 Cadence Design Systems, Inc.
;                       All Rights Reserved.
;
; Define the default bind keys for use in Composer as follows:
;     Schematic editor - prefix "Schematics"
;     Read HDL         - prefix "Read HDL" (only if SKILL context loaded)
;
; $Revision: #4 $
; $Date: 2010/02/10 $
;******************************************************************************

; a-z
hiSetBindKey("Schematics" "<Key>a"               "geSingleSelectPoint()")
hiSetBindKey("Schematics" "Shift<Key>a"          "schSingleSelectBox()")
hiSetBindKey("Schematics" "Ctrl<Key>a"           "schSelectAllFig()")

hiSetBindKey("Schematics" "<Key>b"               "schHiCreateBlockInst()")

hiSetBindKey("Schematics" "<Key>c"               "schHiCopy()")

hiSetBindKey("Schematics" "<Key>d"               "geSubSelectPoint()")
hiSetBindKey("Schematics" "Shift<Key>d"          "schSubSelectBox()")
hiSetBindKey("Schematics" "Ctrl<Key>d"           "schDeselectAllFig()")

hiSetBindKey("Schematics" "<Key>e"               "schHiDescendRead()")
hiSetBindKey("Schematics" "Shift<Key>e"          "schHiDescendEdit()")
hiSetBindKey("Schematics" "Ctrl<Key>e"           "schHiReturn()")
hiSetBindKey("Schematics" "Ctrl<Key>e"           "schHiReturn()")
hiSetBindKey("Schematics" "Shift<Key>T"          "schHiTree()")

hiSetBindKey("Schematics" "<Key>f"               "schZoomFit(1.0 0.9)")
hiSetBindKey("Schematics" "Shift<Key>f"          "hiZoomAbsoluteScale(getCurrentWindow() 0.9)")
hiSetBindKey("Schematics" "Ctrl<Key>f"           "schSetSelectOptions()")

hiSetBindKey("Schematics" "<Key>g"               "schHiFindMarker()")
hiSetBindKey("Schematics" "Shift<Key>g"          "schHiFindMarker()")
hiSetBindKey("Schematics" "Ctrl<Key>g"           "geHiDeleteMarker()")

hiSetBindKey("Schematics" "<Key>h"               "schHiHiliteLabel(\"wire\" \"on\")")
hiSetBindKey("Schematics" "Shift<Key>h"          "schHiHiliteLabel(\"wire\" \"off\")")

hiSetBindKey("Schematics" "<Key>i"               "schHiCreateInst()")

when( isCallable('schGetEnv) && schGetEnv("enableKanjiNotes")
   hiSetBindKey("Schematics" "Shift<Key>k"        "schHiCreateKanjiSymbol()")
)

hiSetBindKey("Schematics" "<Key>l"               "schHiCreateWireLabel()")
hiSetBindKey("Schematics" "Shift<Key>l"          "schHiCreateNoteLabel()")

hiSetBindKey("Schematics" "<Key>m"               "schHiStretch()")
hiSetBindKey("Schematics" "Shift<Key>m"          "schHiMove()")

hiSetBindKey("Schematics" "<Key>n"               "schHiCreateNoteShape()")
hiSetBindKey("Schematics" "Shift<Key>n"          "schHiCreateNoteLabel()")

hiSetBindKey("Schematics" "<Key>o"               "schHiDisplayOptions()")
hiSetBindKey("Schematics" "Shift<Key>o"          "schHiEditorOptions()")

hiSetBindKey("Schematics" "<Key>p"               "schHiCreatePin()")

hiSetBindKey("Schematics" "<Key>q"               "schHiObjectProperty()")
hiSetBindKey("Schematics" "Shift<Key>q"          "schHiCellViewProperty()")
hiSetBindKey("Schematics" "<Key>q EF"            "schHiObjectProperty()")
hiSetBindKey("Schematics" "Shift<Key>q EF"       "schHiCellViewProperty()")

hiSetBindKey("Schematics" "<Key>r"               "schHiRotate(t)")
hiSetBindKey("Schematics" "<Key>r EF"            "schSetEnv(\"rotate\" t)")
hiSetBindKey("Schematics" "Shift<Key>r EF"       "schSetEnv(\"sideways\" t)")
hiSetBindKey("Schematics" "Ctrl<Key>r EF"        "schSetEnv(\"upsideDown\" t)")

hiSetBindKey("Schematics" "Shift<Key>s"          "_schHiSave()")
hiSetBindKey("Schematics" "Ctrl<Key>s"           "_schHiSaveAs()")
hiSetBindKey("Schematics" "<Key>s EF"            "schSnapToConn()")

hiSetBindKey("Schematics" "<Key>t"             "schHiEditText()")
hiSetBindKey("Schematics" "Ctrl<Key>t"           "schHiZoomToSelSet()")

hiSetBindKey("Schematics" "<Key>u"               "hiUndo()")
hiSetBindKey("Schematics" "Shift<Key>u"          "hiRedo()")

hiSetBindKey("Schematics" "<Key>v"               "hiVectorPan()")
hiSetBindKey("Schematics" "Shift<Key>v"          "_deToggleAssistant(\"World View\")")
hiSetBindKey("Schematics" "Ctrl<Key>v"           "hiFocusToCIW(hiGetCurrentWindow())")

hiSetBindKey("Schematics" "<Key>w"               "schHiCreateWire(0.0)")
hiSetBindKey("Schematics" "Shift<Key>w"          "schHiCreateWire(schGetEnv(\"defWideWireWidth\"))")
hiSetBindKey("Schematics" "<Key>space"           "schHiCreateWireStubs()")

hiSetBindKey("Schematics" "<Key>x"               "schHiCheck(\"run\")")
hiSetBindKey("Schematics" "Shift<Key>x"          "schHiCheckAndSave()")

hiSetBindKey("Schematics" "<Key>z"               "hiZoomIn()")
hiSetBindKey("Schematics" "Shift<Key>z"          "hiPrevWinView(hiGetCurrentWindow())")
hiSetBindKey("Schematics" "Ctrl<Key>z"           "hiZoomOut()")
hiSetBindKey("Schematics" "Ctrl Shift<Key>z"     "hiNextWinView(hiGetCurrentWindow())")

; numerals 0-9
hiSetBindKey("Schematics" "<Key>5"               "schHiRouteFlightLine()")
hiSetBindKey("Schematics" "<Key>8"               "schHiHiliteLabel(\"instance\" \"on\")")
hiSetBindKey("Schematics" "Shift<Key>8"          "schHiHiliteLabel(\"instance\" \"off\")")
hiSetBindKey("Schematics" "<Key>9"               "geEnterAddNetProbe()")

; other characters
hiSetBindKey("Schematics" "<Key>="               "schHiOpenSymbolOrSchematicView(geGetEditCellView() hiGetCurrentWindow())")
hiSetBindKey("Schematics" "<Key>["               "hiZoomRelativeScale(getCurrentWindow() 0.8)")
hiSetBindKey("Schematics" "<Key>]"               "hiZoomRelativeScale(getCurrentWindow() 1.25)")
hiSetBindKey("Schematics" "<Key>."               "hiToggleMagnifier()")
hiSetBindKey("Schematics" "<Key>#"               "hiToggleAnchorMagnifier()")
hiSetBindKey("Schematics" "<Key>'"               "hiUpdateMagOptions()")

; mouse buttons
hiSetBindKey("Schematics" "None<Btn1Down>"       "schSingleSelectPt()")
hiSetBindKey("Schematics" "Shift<Btn1Down>"      "schAddSelectPt()")
hiSetBindKey("Schematics" "None<Btn1Down>(2) EF" "schMouseApplyOrFinish()")
hiSetBindKey("Schematics" "Shift<Btn1Down>(2)"   "schExtendSelectPt()")

hiSetBindKey("Schematics" "None<Btn2Down> EF"    "schCmdOption()")
hiSetBindKey("Schematics" "Shift<Btn2Down> EF"   "schShiftCmdOption()")

hiSetBindKey("Schematics" "None<Btn3Down>"       "schHiMousePopUp()")
hiSetBindKey("Schematics" "None<Btn3Down> EF"    "schHiMousePopUp()")

hiSetBindKey("Schematics" "None<Btn4Down>"       "hiZoomInAtMouse()")
hiSetBindKey("Schematics" "None<Btn5Down>"       "hiZoomOutAtMouse()")
hiSetBindKey("Schematics" "Shift<Btn4Down>"      "geScroll(nil \"w\" nil)")
hiSetBindKey("Schematics" "Shift<Btn5Down>"      "geScroll(nil \"e\" nil)")
hiSetBindKey("Schematics" "Ctrl<Btn4Down>"       "geScroll(nil \"n\" nil)")
hiSetBindKey("Schematics" "Ctrl<Btn5Down>"       "geScroll(nil \"s\" nil)")

hiSetBindKey("Schematics" "Ctrl Shift<Btn1Down>" "hiZoomInMagnifier(hiGetCurrentWindow())")
hiSetBindKey("Schematics" "Ctrl Shift<Btn2Down>" "hiZoomOutMagnifier(hiGetCurrentWindow())")
hiSetBindKey("Schematics" "Ctrl Shift<Btn4Down>" "_schScaleMagnifier(1.25)")
hiSetBindKey("Schematics" "Ctrl Shift<Btn5Down>" "_schScaleMagnifier(0.80)")

; drag mouse buttons
hiSetBindKey("Schematics" "<DrawThru1>"          "schDirectEdit(1)")
hiSetBindKey("Schematics" "Shift<DrawThru1>"     "schDirectEdit(2)")
hiSetBindKey("Schematics" "Ctrl<DrawThru1>"      "schDirectEdit(3)")

hiSetBindKey("Schematics" "<DrawThru2>"          "hiDynamicPanGrabbing()")
hiSetBindKey("Schematics" "<DrawThru2>EF"        "hiDynamicPanGrabbing()")

; delete/backspace
hiSetBindKey("Schematics" "<Key>BackSpace"       "schHiDelete()")
hiSetBindKey("Schematics" "<Key>Delete"          "schHiDelete()")

; arrow keys
hiSetBindKey("Schematics" "<Key>Down"            "geScroll(nil \"s\" nil)")
hiSetBindKey("Schematics" "<Key>Left"            "geScroll(nil \"w\" nil)")
hiSetBindKey("Schematics" "<Key>Right"           "geScroll(nil \"e\" nil)")
hiSetBindKey("Schematics" "<Key>Up"              "geScroll(nil \"n\" nil)")
hiSetBindKey("Schematics" "Ctrl Shift<Key>Up"    "hiScaleMagnifier(1.25)")
hiSetBindKey("Schematics" "Ctrl Shift<Key>Down"  "hiScaleMagnifier(0.80)")

; fn keys
hiSetBindKey("Schematics" "<Key>F6"              "hiRedraw()")

hiSetBindKey("Schematics" "<Key>F11"             "deToggleAssistants()")
hiSetBindKey("Schematics" "Shift<Key>F11"        "deToggleAssistants() deToggleToolbars()")
hiSetBindKey("Schematics" "Ctrl<Key>F11"         "deToggleToolbars()")

when( isCallable('schHDLReturn)
        ; General bindkeys (prefix "Read HDL").
        ;
        hiSetBindKey("Read HDL" "Ctrl<Key>s"    "hiSaveAsViewfile()")
        hiSetBindKey("Read HDL" "Ctrl<Key>e"    "schHDLReturn()")
)
;******************************************************************************
; Symbol.il - Copyright (C) 1997-2010 Cadence Design Systems, Inc.
;                       All Rights Reserved.
;
; Define the default bind keys for use in Composer Symbol editor
;
; $Revision: #4 $
; $Date: 2010/02/10 $
;******************************************************************************

; a-z
hiSetBindKey("Symbol" "<Key>a"           "geSingleSelectPoint()")
hiSetBindKey("Symbol" "Ctrl<Key>a"       "schSelectAllFig()")
hiSetBindKey("Symbol" "Shift<Key>a"      "schSingleSelectBox()")
hiSetBindKey("Symbol" "<Key>c"           "schHiCopy()")
hiSetBindKey("Symbol" "<Key>d"           "geSubSelectPoint()")
hiSetBindKey("Symbol" "Ctrl<Key>d"       "schDeselectAllFig()")
hiSetBindKey("Symbol" "Shift<Key>d"      "schSubSelectBox()")
hiSetBindKey("Symbol" "Ctrl<Key>e"       "schHiReturn()")
hiSetBindKey("Symbol" "<Key>f"           "schZoomFit(1.0 0.9)")
hiSetBindKey("Symbol" "Ctrl<Key>f"       "schSetSelectOptions()")
hiSetBindKey("Symbol" "Shift<Key>f"      "hiZoomAbsoluteScale(getCurrentWindow() 0.9)")
hiSetBindKey("Symbol" "<Key>g"           "schHiFindMarker()")
hiSetBindKey("Symbol" "Ctrl<Key>g"       "geHiDeleteMarker()")
hiSetBindKey("Symbol" "Shift<Key>g"      "schHiFindMarker()")
when( isCallable('schGetEnv) && schGetEnv("enableKanjiNotes")
        hiSetBindKey("Symbol" "Shift<Key>k"     "schHiCreateKanjiSymbol()")
)
hiSetBindKey("Symbol" "<Key>l"           "schHiCreateSymbolLabel()")
hiSetBindKey("Symbol" "Shift<Key>l"      "schHiCreateNoteLabel()")
hiSetBindKey("Symbol" "<Key>m"           "schHiSymStretch()")
hiSetBindKey("Symbol" "Shift<Key>m"      "schHiMove()")
hiSetBindKey("Symbol" "<Key>n"           "schHiCreateNoteShape()")
hiSetBindKey("Symbol" "Shift<Key>n"      "schHiCreateNoteLabel()")
hiSetBindKey("Symbol" "<Key>o"           "schHiDisplayOptions()")
hiSetBindKey("Symbol" "Shift<Key>o"      "schHiEditorOptions()")
hiSetBindKey("Symbol" "<Key>p"           "schHiCreateSymbolPin()")
hiSetBindKey("Symbol" "<Key>q EF"        "schHiObjectProperty()")
hiSetBindKey("Symbol" "<Key>q"           "schHiObjectProperty()")
hiSetBindKey("Symbol" "Shift<Key>q"      "schHiCellViewProperty()")
hiSetBindKey("Symbol" "Shift<Key>q EF"   "schHiCellViewProperty()")
hiSetBindKey("Symbol" "<Key>r"           "schHiRotate(t)")
hiSetBindKey("Symbol" "<Key>r EF"        "schSetEnv(\"rotate\" t)")
hiSetBindKey("Symbol" "Shift<Key>r EF"   "schSetEnv(\"sideways\" t)")
hiSetBindKey("Symbol" "Ctrl<Key>r EF"    "schSetEnv(\"upsideDown\" t)")
hiSetBindKey("Symbol" "Ctrl<Key>s"       "_schHiSaveAs()")
hiSetBindKey("Symbol" "Shift<Key>s"      "_schHiSave()")
hiSetBindKey("Symbol" "<Key>t"           "schHiEditText()");
hiSetBindKey("Symbol" "Ctrl<Key>t"       "schHiZoomToSelSet()")
hiSetBindKey("Symbol" "<Key>u"           "hiUndo()")
hiSetBindKey("Symbol" "Shift<Key>u"      "hiRedo()")
hiSetBindKey("Symbol" "<Key>v"           "hiVectorPan()")
hiSetBindKey("Symbol" "Ctrl<Key>v"       "hiFocusToCIW(hiGetCurrentWindow())")
hiSetBindKey("Symbol" "Shift<Key>v"      "_deToggleAssistant(\"World View\")")
hiSetBindKey("Symbol" "<Key>x"           "schHiVIC()")
hiSetBindKey("Symbol" "Shift<Key>x"      "schHiVICAndSave()")
hiSetBindKey("Symbol" "<Key>z"           "hiZoomIn()")
hiSetBindKey("Symbol" "Ctrl<Key>z"       "hiZoomOut()")
hiSetBindKey("Symbol" "Ctrl Shift<Key>z" "hiNextWinView(hiGetCurrentWindow())")
hiSetBindKey("Symbol" "Shift<Key>z"      "hiPrevWinView(hiGetCurrentWindow())")

; numerals 0-9
hiSetBindKey("Symbol" "<Key>9" "geEnterAddNetProbe()")

; other characters
hiSetBindKey("Symbol" "<Key>=" "schHiOpenSymbolOrSchematicView(geGetEditCellView() hiGetCurrentWindow())")
hiSetBindKey("Symbol" "<Key>[" "hiZoomRelativeScale(getCurrentWindow() 0.8)")
hiSetBindKey("Symbol" "<Key>]" "hiZoomRelativeScale(getCurrentWindow() 1.25)")
hiSetBindKey("Symbol" "<Key>." "hiToggleMagnifier()")
hiSetBindKey("Symbol" "<Key>#" "hiToggleAnchorMagnifier()")
hiSetBindKey("Symbol" "<Key>'" "hiUpdateMagOptions()")

; mouse buttons
hiSetBindKey("Symbol" "None<Btn1Down>(2) EF" "schMouseApplyOrFinish()")
hiSetBindKey("Symbol" "None<Btn2Down>EF"     "schCmdOption()")
hiSetBindKey("Symbol" "None<Btn3Down> EF"    "schHiMousePopUp()")
hiSetBindKey("Symbol" "None<Btn3Down>"       "schHiMousePopUp()")
hiSetBindKey("Symbol" "Shift<Btn2Down> EF"   "schShiftCmdOption()")

hiSetBindKey("Symbol" "None<Btn4Down>"       "hiZoomInAtMouse()")
hiSetBindKey("Symbol" "None<Btn5Down>"       "hiZoomOutAtMouse()")
hiSetBindKey("Symbol" "Shift<Btn4Down>"      "geScroll(nil \"w\" nil)")
hiSetBindKey("Symbol" "Shift<Btn5Down>"      "geScroll(nil \"e\" nil)")
hiSetBindKey("Symbol" "Ctrl<Btn4Down>"       "geScroll(nil \"n\" nil)")
hiSetBindKey("Symbol" "Ctrl<Btn5Down>"       "geScroll(nil \"s\" nil)")

hiSetBindKey("Symbol" "Ctrl Shift<Btn1Down>" "hiZoomInMagnifier(hiGetCurrentWindow())")
hiSetBindKey("Symbol" "Ctrl Shift<Btn2Down>" "hiZoomOutMagnifier(hiGetCurrentWindow())")
hiSetBindKey("Symbol" "Ctrl Shift<Btn4Down>" "hiScaleMagnifier(1.25)")
hiSetBindKey("Symbol" "Ctrl Shift<Btn5Down>" "hiScaleMagnifier(0.80)")

; drag mouse buttons
hiSetBindKey("Symbol" "<DrawThru1>"      "schDirectEdit(1)")
hiSetBindKey("Symbol" "Ctrl<DrawThru1>"  "schDirectEdit(3)")
hiSetBindKey("Symbol" "Shift<DrawThru1>" "schDirectEdit(2)")

hiSetBindKey("Symbol" "<DrawThru2>"      "hiDynamicPanGrabbing()")
hiSetBindKey("Symbol" "<DrawThru2>EF"    "hiDynamicPanGrabbing()")

; delete/backspace
hiSetBindKey("Symbol" "<Key>BackSpace" "schHiDelete()")
hiSetBindKey("Symbol" "<Key>Delete"    "schHiDelete()")

; arrow keys
hiSetBindKey("Symbol" "<Key>Down"           "geScroll(nil \"s\" nil)")
hiSetBindKey("Symbol" "<Key>Left"           "geScroll(nil \"w\" nil)")
hiSetBindKey("Symbol" "<Key>Right"          "geScroll(nil \"e\" nil)")
hiSetBindKey("Symbol" "<Key>Up"             "geScroll(nil \"n\" nil)")
hiSetBindKey("Symbol" "Ctrl Shift<Key>Up"   "_schScaleMagnifier(1.25)")
hiSetBindKey("Symbol" "Ctrl Shift<Key>Down" "_schScaleMagnifier(0.80)")

; fn keys
hiSetBindKey("Symbol" "<Key>F6"       "hiRedraw()")
hiSetBindKey("Symbol" "<Key>F11"      "deToggleAssistants()")
hiSetBindKey("Symbol" "Shift<Key>F11" "deToggleAssistants() deToggleToolbars()")
hiSetBindKey("Symbol" "Ctrl<Key>F11"  "deToggleToolbars()")
)
