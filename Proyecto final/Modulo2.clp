(defrule SobrevaloradoGeneral
  (Modulo2)
  (ValorIbex
    (Nombre ?nombre)
    (EtiqPER Alto)
    (EtiqRPD Bajo)
  )
  (not (Sobrevalorado ?nombre))
  =>
  (assert (Sobrevalorado ?nombre))
  (printout t crlf ?nombre " esta sobrevalorado (General)." crlf)
)

(defrule SobrevaloradoEmpPeque
  (Modulo2)
  (or
    (ValorIbex
      (Nombre ?nombre)
      (Tamano PEQUENIA)
      (EtiqPER Alto)
    )
    (ValorIbex
      (Nombre ?nombre)
      (Tamano PEQUENIA)
      (EtiqPER Medio)
      (EtiqRPD Bajo)
    )
  )
  (not (Sobrevalorado ?nombre))
  =>
  (assert (Sobrevalorado ?nombre))
  (printout t crlf ?nombre " esta sobrevalorado (Empresa pequenia)." crlf)
)

(defrule SobrevaloradoEmpGrande
  (Modulo2)
  (or
    (ValorIbex
      (Nombre ?nombre)
      (Tamano GRANDE)
      (EtiqPER Alto)
      (EtiqRPD Medio)
    )
    (ValorIbex
      (Nombre ?nombre)
      (Tamano GRANDE)
      (EtiqPER Alto)
      (EtiqRPD Bajo)
    )
    (ValorIbex
      (Nombre ?nombre)
      (Tamano GRANDE)
      (EtiqPER Medio)
      (EtiqRPD Bajo)
    )
  )
  (not (Sobrevalorado ?nombre))
  =>
  (assert (Sobrevalorado ?nombre))
  (printout t crlf ?nombre " esta sobrevalorado (Empresa grande)." crlf)
)

(defrule PasoAModulo3 (declare (salience 0))
  ?f <- (Modulo2)
  =>
  (retract ?f)
  (assert (Modulo3))
)
