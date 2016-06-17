;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Loading "Analisis.txt"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(deffacts ReaderStepCounter (Step1))

(defrule openAnalisis (declare (salience 30))
  (Step1)
  =>
  (open "Data/Analisis.txt" mydata)
  (assert (SeguirLeyendo))
)

(defrule LeerValoresCierreFromFile (declare (salience 20))
  (Step1)
  ?f <- (SeguirLeyendo)
  =>
  (bind ?Leido (read mydata))
  (retract ?f)
  (if (neq ?Leido EOF) then
    (assert (ValorIbex
              (Nombre ?Leido)
              (Precio (read mydata))
              (PERCVardia (read mydata))
              (Capitalizacion (read mydata))
              (PER (read mydata))
              (RPD (read mydata))
              (Tamano (read mydata))
              (PERCIbex (read mydata))
              (EtiqPER (read mydata))
              (Etiq.RPD (read mydata))
              (Sector (read mydata))
              (PERCVar5Dias (read mydata))
              (Perd3Consec (read mydata))
              (Perd5Consec (read mydata))
              (PERCVarRespSector5Dias (read mydata))
              (VRS5 (read mydata))
              (PERCVarMen (read mydata))
              (PERCVarTri (read mydata))
              (PERCVarSem (read mydata))
              (PERCVar12Mes (read mydata))
      )
    )
    (assert (SeguirLeyendo))
  )
)

(defrule closeAnalisis (declare (salience 10))
  ?fact <- (Step1)
  =>
  (retract ?fact)
  (close mydata)
  (assert(Step2))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Loading "AnalisisSectores.txt"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule openAnalisisSectores (declare (salience 30))
  (Step2)
  =>
  (open "Data/AnalisisSectores.txt" mydata)
  (assert (SeguirLeyendo))
)

(defrule LeerValoresCierreSectoresFromFile (declare (salience 20))
  (Step2)
  ?f <- (SeguirLeyendo)
  =>
  (bind ?Leido (read mydata))
  (retract ?f)
  (if (neq ?Leido EOF) then
  (assert (ValorSector
            (Nombre ?Leido)
            (PERCVardia (read mydata))
            (Capitalizacion (read mydata))
            (PER (read mydata))
            (RPD (read mydata))
            (PERCIbex (read mydata))
            (PERCVar5Dias (read mydata))
            (Perd3Consec (read mydata))
            (Perd5Consec (read mydata))
            (PERCVarMen (read mydata))
            (PERCVarTri (read mydata))
            (PERCVarSem (read mydata))
            (PERCVar12Mes (read mydata))
    )
  )
    (assert (SeguirLeyendo))
  )
)

(defrule closeAnalisisSectores (declare (salience 10))
  ?fact <- (Step2)
  =>
  (retract ?fact)
  (close mydata)
  (assert(Step3))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Loading "Cartera.txt"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule openCartera (declare (salience 30))
  (Step3)
  =>
  (open "Data/Cartera.txt" mydata)
  (assert (SeguirLeyendo))
)

(defrule LeerCarteraFromFile (declare (salience 20))
  (Step3)
  ?f <- (SeguirLeyendo)
  =>
  (bind ?Leido (read mydata))
  (retract ?f)
  (if (neq ?Leido EOF) then
    (assert (ValorCartera
              (Nombre ?Leido)
              (NumAcciones (read mydata))
              (ValorTotal (read mydata))
      )
    )
    (assert (SeguirLeyendo))
  )
)

(defrule CloseCartera (declare (salience 10))
  ?fact <- (Step3)
  =>
  (retract ?fact)
  (close mydata)
)
