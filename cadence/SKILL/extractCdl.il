;procedure to extract the Cdl netlist
procedure( extractCdl( libName cellName viewName runDir )
  if(!isContextLoaded("transUI") then
    loadContext(strcat(prependInstallPath("etc/context/transUI.cxt")))
  )
  transCdlOutForm->cdlOLibName->value = libName
  transCdlOutForm->cdlOTopCell->value = cellName
  transCdlOutForm->cdlOViewName->value = viewName
  transCdlOutForm->cdlONetlistFile->value = strcat(cellName ".cdl")
  transCdlOutForm->cdlORunDir->value = runDir
  transCdlOutForm->cdlONetlistingMode->value= "Analog"
  ;transCdlOutForm->cdlOResistorValue->value = 0.0
  ;transCdlOutForm->cdlODiodeCheck->value = "area"
  transCdlOutForm->cdlOCheckLDD->value =  t
  hiFormDone(transCdlOutForm)
  hiRegTimer("hiDBoxOK(simNetNoOp6)" 10)
  hiRegTimer("hiDBoxOK(simNetNoOp5)" 11)
)
