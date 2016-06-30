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
      (assert (Propuesta VenderPeligroso ?nombre vacio (- 20 ?rpd)
                  (str-cat "La empresa " ?nombre
                            " es peligrosa, ademas demuestra una tendencia bajista con respecto a su sector. Segun mi estimacion existe una probabilidad no despreciable de que pueda caer al cabo del anio un 20%, aunque produzca "
                            ?rpd
                            " por dividendos."
                  )
              )
      )
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
    (assert (Propuesta ComprarInfravalorado ?nombre vacio (+(/ (* (- ?permedio ?per) 100) (* ?per 5)) ?rpd)
                (str-cat "La empresa " ?nombre " esta infravalorada y seguramente el PER tienda al PER medio en 5 anios, con lo que se deberia revalorizar un "
                          (/ (* (- ?permedio ?per) 100) (* ?per 5))
                          " anual, a lo que habria que sumar el "
                          ?rpd
                          " de beneficios por dividendos."
                )
            )
    )
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
    (assert (Propuesta VenderSobrevalorado ?nombre vacio (-(/ (* (- ?per ?permediosector) 100) (* ?per 5)) ?rpd)
                (str-cat "La empresa " ?nombre " esta sobrevalorada, es mejor amortizar lo invertido ya que seguramente el PER tan alto debera bajar al PER medio del sector en unos 5 anios, con lo que se deberia devaluar un "
                          (/ (* (- ?per ?permediosector) 100) (* ?per 5))
                          " asi que aunque se pierda el "
                          ?rpd
                          " de beneficios por dividendos saldria rentable."
                )
            )
    )
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
    (assert (Propuesta Cambiar ?nombre2 ?nombre1 (- ?rpd1 (+ 0 (+ ?rpd2 1)))
                (str-cat ?nombre1
                          " debe tener una revalorizacion acorde con la evolucion de la bolsa, por dividendos se espera un "
                          ?rpd1
                          " que es mas de lo que esta dando "
                          ?nombre2
                          " por lo que propongo cambiar los valores."
                )
            )

    )
  )
)

(defrule PasoAModulo42 (declare (salience -1))
  ?f <- (Modulo41)
  =>
  (retract ?f)
  (assert (Modulo42))
)
