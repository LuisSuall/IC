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

(defrule propuestaInfravalorados
  (Modulo41)
  (Infravalorado ?nombre)
  (ValorIbex
    (Nombre ?nombre)
    (PER ?per)
    (RPD ?rpd)
  )
  (ValorSector
    (Nombre Ibex)
    (PER ?permedio)
  )
  =>
  (if (!= ?per 0) then
    (assert (ComprarInfravalorado ?nombre (+(/ (* (- ?permedio ?per) 100) (* ?per 5)) ?rpd) ))
    (printout t crlf ?nombre " tienes que comprar " ?nombre ", es un chollo." crlf)
  )
)

(defrule propuestaSobrevalorados
  (Modulo41)
  (Sobrevalorado ?nombre)
  (ValorCartera
    (Nombre ?nombre)
  )
  (ValorIbex
    (Nombre ?nombre)
    (PER ?per)
    (RPD ?rpd)
    (Sector ?sector)
  )
  (ValorSector
    (Nombre ?sector)
    (PER ?permediosector)
  )
  =>
  ;TODO: falta una condicion
  (if (!= ?per 0) then
    (assert (VenderSobrevalorado ?nombre (-(/ (* (- ?per ?permediosector) 100) (* ?per 5)) ?rpd) ))
    (printout t crlf ?nombre " tienes que vender " ?nombre ", esta sobrevaloradisisisisimo." crlf)
  )
)

(defrule propuestaCambio
  (Modulo41)
  (ValorIbex
    (Nombre ?nombre1)
    (RPD ?rpd1)
  )
  (not (Sobrevalorado ?nombre1))
  (ValorCartera
    (Nombre ?nombre2)
  )
  (ValorIbex
    (Nombre ?nombre2)
    (RPD ?rpd2)
  )
  (not (Infravalorado ?nombre2))
  =>
  (if (< (+ 0 (+ ?rpd2 1)) ?rpd1) then
    (assert (Cambiar ?nombre2 ?nombre1 (- ?rpd1 (+ 0 (+ ?rpd2 1))) ))
    (printout t crlf ?nombre1 " es mejor que " ?nombre2 " colega." crlf)
  )
)
