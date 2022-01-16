/** Get the bounding box for the cell layout **/

(defun  getArea (libName cellName)
    cv = dbOpenCellViewByType(libName cellName "layout" "maskLayout" "r")
    bBox = (cv~>bBox)
    area =  ((car (car bBox)) - (car (car (cdr bBox)))) * ((car (cdr (car bBox))) - (car (cdr (car (cdr bBox)))))

)

(defun getBBox (libName cellName)
    cv = dbOpenCellViewByType(libName cellName "layout" "maskLayout" "r")
    println(cv~>bBox)
)

