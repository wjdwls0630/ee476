;#SAPR_import patch
;#Visvesh Sathe 11/12/2013

procedure( postProcessAbstract(libName, cellName)
 cv = dbOpenCellViewByType(libName cellName "layout" "maskLayout" "a")
 pinShapes = setof(x cv~>shapes x~>pin!=nil)
 foreach( shape pinShapes 
   name = shape~>pin~>term~>name
   layer= shape~>layerName
   purpose = "pin"
   bBox = shape~>bBox  
   x=(caar(bBox) + caadr(bBox))*0.5
   y=(cadar(bBox) + cadadr(bBox))*0.5
   dbCreateLabel(cv list(layer purpose) x:y name "centerCenter" "R0" "stick" 0.05)
   println(name)
   println(x:y)
 )

 foreach( instance cv~>instances
   leReplaceAnyInstMaster(instance instance~>libName instance~>cellName "layout")
   )
   dbSave(cv)
   dbClose(cv)
)
