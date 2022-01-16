* Autogenerated by common.py:Cad:run_hspice.


* Declare vdd and vss as global nets accessible from any subckt.
* Some students put this declaration in their .ctl files instead of .ckts, so we need to add it.
.GLOBAL vdd! vss!

* Configure parameters that the ctl file expects,
* e.g. vdd settings (this section may be empty)

.param pdk_included=0
* Header generated by common.py:get_pdk_header
.INC ALU.ctl
.IF ('pdk_included' < 0.01)
.param pdk_included=1
.inc "/home/{USER}/FreePDK45_Nangate/FreePDK45/ncsu_basekit/models/hspice/tran_models/models_nom/PMOS_VTL.inc"
.inc "/home/{USER}/FreePDK45_Nangate/FreePDK45/ncsu_basekit/models/hspice/tran_models/models_nom/PMOS_VTG.inc"
.inc "/home/{USER}/FreePDK45_Nangate/FreePDK45/ncsu_basekit/models/hspice/tran_models/models_nom/NMOS_THKOX.inc"
.inc "/home/{USER}/FreePDK45_Nangate/FreePDK45/ncsu_basekit/models/hspice/tran_models/models_nom/NMOS_VTH.inc"
.inc "/home/{USER}/FreePDK45_Nangate/FreePDK45/ncsu_basekit/models/hspice/tran_models/models_nom/PMOS_VTH.inc"
.inc "/home/{USER}/FreePDK45_Nangate/FreePDK45/ncsu_basekit/models/hspice/tran_models/models_nom/NMOS_VTG.inc"
.inc "/home/{USER}/FreePDK45_Nangate/FreePDK45/ncsu_basekit/models/hspice/tran_models/models_nom/NMOS_VTL.inc"
.inc "/home/{USER}/FreePDK45_Nangate/FreePDK45/ncsu_basekit/models/hspice/tran_models/models_nom/PMOS_THKOX.inc"

.ENDIF
.END