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
