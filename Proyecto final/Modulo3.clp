(defrule Infravalorado1
  (Modulo3)
  (ValorIbex
    (Nombre ?nombre)
    (EtiqPER Bajo)
    (EtiqRPD Alto)
  )
  (not (Infravalorado ?nombre))
  =>
  (assert (Infravalorado ?nombre))
  (printout t crlf ?nombre " esta Infravalorado (Regla-1)." crlf)
)

(defrule Infravalorado2
  (Modulo3)
  (or
    (ValorIbex
      (Nombre ?nombre)
      (EtiqPER Bajo)
      (PERCVarMen ?varmen)
      (PERCVarTri ?varlong)
    )
    (ValorIbex
      (Nombre ?nombre)
      (EtiqPER Bajo)
      (PERCVarMen ?varmen)
      (PERCVarSem ?varlong)
    )
    (ValorIbex
      (Nombre ?nombre)
      (EtiqPER Bajo)
      (PERCVarMen ?varmen)
      (PERCVar12Mes ?varlong)
    )
  )
  (not (Infravalorado ?nombre))
  =>
  (if(< ?varlong -30) then
    (if(> ?varmen 0) then
      (if(< ?varmen 10) then
        (assert (Infravalorado ?nombre))
        (printout t crlf ?nombre " esta Infravalorado (Regla-2)." crlf)
      )
    )
  )
)

(defrule Infravalorado3
  (Modulo3)
  (ValorIbex
    (Nombre ?nombre)
    (Tamano GRANDE)
    (EtiqPER Medio)
    (EtiqRPD Alto)
    (PERCVar5Dias ?var)
    (PERCVarRespSector5Dias ?varsector)
  )
  (not (Infravalorado ?nombre))
  =>
  (if(> ?var 0) then
    (if(> ?varsector 0) then
      (assert (Infravalorado ?nombre))
      (printout t crlf ?nombre " esta Infravalorado (Regla-3)." crlf)
    )
  )
)

(defrule PasoAModulo4 (declare (salience -10))
  ?f <- (Modulo3)
  =>
  (retract ?f)
  (assert (Modulo4))
)
