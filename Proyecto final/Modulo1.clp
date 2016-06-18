(defrule PeligrosoInestable (declare (salience 10))
  (Modulo1)
  (ValorCartera (Nombre ?nombre))
  (Inestable ?nombre)
  (ValorIbex
    (Nombre ?nombre)
    (Perd3Consec true)
  )
  =>
  (assert (Peligroso ?nombre))
  (printout t crlf ?nombre " es peligroso(Inestable)." crlf)
)

(defrule Peligroso (declare (salience 0))
  (Modulo1)
  (ValorCartera (Nombre ?nombre))
  (not (Peligroso ?nombre))
  (ValorIbex
    (Nombre ?nombre)
    (Perd5Consec true)
    (PERCVarRespSector5Dias ?var)
  )
  =>
  (if(< ?var -5) then
    (assert (Peligroso ?nombre))
    (printout t crlf ?nombre " es peligroso." crlf)
  )
)
