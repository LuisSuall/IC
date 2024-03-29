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
)

(defrule PasoAModulo3 (declare (salience -10))
  ?f <- (Modulo2)
  =>
  (retract ?f)
  (assert (Modulo3))
)
