printf("general.il\n")

;User specific skill settings and loads
load("SKILL/extractCdl.il")
load("SKILL/commonMenu.il")


;Always open the Library Manager
;ddsOpenLibManager()




;Turn on dialog box for every command
envSetVal("ui", "showOptionForms" `boolean t)

;Fix connectivity problems
;le1MarkNetForm->optionTabs->page2->_leViaLayersScrolledField->OD\-allPurp\-CO\-allPurp\-M1\-allPurp->Select->value =  nil
;le1MarkNetForm->optionTabs->page2->_leViaLayersScrolledField->PO\-allPurp\-CO\-allPurp\-M1\-allPurp->Select->value =  nil
