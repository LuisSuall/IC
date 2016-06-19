(defrule propuestaPeligrosa
  (Modulo41)
  (Peligroso ?nombre)
  (ValorIbex
    (Nombre ?nombre)
    (PERCVarMen ?varmen)
    (RPD ?rpd)
    (Sector ?sector)
  )
  (ValorSector
    (Nombre ?sector)
    (PERCVarMen ?varmensector)
  )
  =>
  (if(< ?varmen 0) then
    (if (< (- ?varmen ?varmensector) -3) then
      (assert (VenderPeligroso ?nombre (- 20 ?rpd)))
      (printout t crlf ?nombre " tienes que venderlo, es tope peligroso." crlf)
    )
  )
)
