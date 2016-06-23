;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Loading "Analisis.txt"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;(deffacts ReaderStepCounter (Step1))

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
              (EtiqRPD (read mydata))
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
  (assert (Noticias))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Loading Noticias
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule openNoticias (declare (salience 30))
  (Noticias)
  =>
  (open "Data/Noticias.txt" mydata)
  (assert (SeguirLeyendo))
)

(defrule LeerNoticiaFromFile (declare (salience 20))
  (Noticias)
  ?f <- (SeguirLeyendo)
  =>
  (bind ?Leido (read mydata))
  (retract ?f)
  (if (neq ?Leido EOF) then
    (assert (Noticia
              (Sobre ?Leido)
              (Tipo (read mydata))
              (Antiguedad (read mydata))
      )
    )
    (assert (SeguirLeyendo))
  )
)

(defrule CloseNoticias (declare (salience 10))
  ?fact <- (Noticias)
  =>
  (retract ?fact)
  (close mydata)
  (assert (detectarInestable))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Detectar valores inestables
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule AniadirInestableConstruccion (declare (salience 20))
  (detectarInestable)
  (ValorIbex
    (Nombre ?nombre)
    (Sector Construccion)
  )
  =>
  (assert (Inestable ?nombre))
  (printout t crlf ?nombre " es parte del sector de la construccion, por defecto es inestable" crlf)
)

(defrule AniadirInestableServicios (declare (salience 20))
  (detectarInestable)
  (ValorIbex
    (Nombre ?nombre)
    (Sector Servicios)
  )
  (ValorSector
    (Nombre Ibex)
    (PERCVar5Dias ?var)
  )
  =>
  (if (< ?var 0) then
    (assert (Inestable ?nombre))
    (printout t crlf ?nombre " es parte del sector servicios y la economia cae, por defecto es inestable" crlf)
  )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Analisis noticias de caracter general
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule InicioNoticiaGeneral (declare (salience 19))
  (detectarInestable)
  =>
  (assert (NoticiasGenerales))
  (printout t crlf "ESTO EXPLOTA MAZO, COLEGA" crlf)

)

(defrule NoticiaGeneral (declare (salience 18))
  (detectarInestable)
  (NoticiasGenerales)
  (Noticia
    (Sobre Ibex)
    (Tipo Mala)
  )
  (ValorIbex
    (Nombre ?nombre)
  )
  (not (Inestable ?nombre))
  =>
  (assert (Inestable ?nombre))
  (printout t crlf ?nombre " es inestable por una noticia negativa de toda la economia." crlf)
)

(defrule FinNoticiaGeneral (declare (salience 17))
  (detectarInestable)
  ?f <-(NoticiasGenerales)
  =>
  (retract ?f)
  (assert (NoticiaSectorNegativa))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Analisis de noticias de sector
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule NoticiaSectorMala (declare (salience 18))
  (detectarInestable)
  (NoticiaSectorNegativa)
  (Noticia
    (Sobre ?sector)
    (Tipo Mala)
  )
  (ValorIbex
    (Nombre ?nombre)
    (Sector ?sector)
  )
  (not (Inestable ?nombre))
  =>
  (assert (Inestable ?nombre))
  (printout t crlf ?nombre " es inestable por una noticia negativa del sector " ?sector "." crlf)
)

(defrule FinNoticiaSectorNegativas (declare (salience 17))
  (detectarInestable)
  ?f <-(NoticiaSectorNegativa)
  =>
  (retract ?f)
  (assert (NoticiaSectorPositiva))
)

(defrule NoticiaSectorBuena (declare (salience 18))
  (detectarInestable)
  (NoticiaSectorPositiva)
  (Noticia
    (Sobre ?sector)
    (Tipo Buena)
  )
  (ValorIbex
    (Nombre ?nombre)
    (Sector ?sector)
  )
  ?f <- (Inestable ?nombre)
  =>
  (retract ?f)
  (printout t crlf ?nombre " es estable por una noticia positiva del sector " ?sector "." crlf)
)

(defrule FinNoticiaSectorPositiva (declare (salience 17))
  (detectarInestable)
  ?f <-(NoticiaSectorPositiva)
  =>
  (retract ?f)
  (assert (NoticiaEmpresaNegativa))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Analisis de noticias de empresa
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule NoticiaEmpresaMala (declare (salience 18))
  (detectarInestable)
  (NoticiaEmpresaNegativa)
  (Noticia
    (Sobre ?nombre)
    (Tipo Mala)
  )
  (ValorIbex
    (Nombre ?nombre)
  )
  (not (Inestable ?nombre))
  =>
  (assert (Inestable ?nombre))
  (printout t crlf ?nombre " es inestable por una noticia negativa de la empresa." crlf)
)

(defrule FinNoticiaEmpresaNegativas (declare (salience 17))
  (detectarInestable)
  ?f <-(NoticiaEmpresaNegativa)
  =>
  (retract ?f)
  (assert (NoticiaEmpresaPositiva))
)

(defrule NoticiaEmpresaBuena (declare (salience 18))
  (detectarInestable)
  (NoticiaEmpresaPositiva)
  (Noticia
    (Sobre ?nombre)
    (Tipo Buena)
  )
  (ValorIbex
    (Nombre ?nombre)
  )
  ?f <- (Inestable ?nombre)
  =>
  (retract ?f)
  (printout t crlf ?nombre " es estable por una noticia positiva de la empresa." crlf)
)

(defrule FinNoticiaEmpresaPositiva (declare (salience 17))
  (detectarInestable)
  ?f <-(NoticiaEmpresaPositiva)
  =>
  (retract ?f)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Fin de la detección de valores inestables
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule finDeteccionInestable (declare (salience 0))
  ?fact <- (detectarInestable)
  =>
  (retract ?fact)
  (assert (Modulo1))
)
