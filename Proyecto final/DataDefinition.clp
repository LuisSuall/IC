;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Template ValorCartera
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(deftemplate ValorCartera
  (field Nombre)
  (field NumAcciones)
  (field ValorTotal)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Template ValorIbex
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(deftemplate ValorIbex
  (field Nombre)
  (field Precio)
  (field PERCVardia)
  (field Capitalizacion)
  (field PER)
  (field RPD)
  (field Tamano)
  (field PERCIbex)
  (field EtiqPER)
  (field EtiqRPD)
  (field Sector)
  (field PERCVar5Dias)
  (field Perd3Consec)
  (field Perd5Consec)
  (field PERCVarRespSector5Dias)
  (field VRS5)
  (field PERCVarMen)
  (field PERCVarTri)
  (field PERCVarSem)
  (field PERCVar12Mes)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Template ValorSector
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(deftemplate ValorSector
  (field Nombre)
  (field PERCVardia)
  (field Capitalizacion)
  (field PER)
  (field RPD)
  (field PERCIbex)
  (field PERCVar5Dias)
  (field Perd3Consec)
  (field Perd5Consec)
  (field PERCVarMen)
  (field PERCVarTri)
  (field PERCVarSem)
  (field PERCVar12Mes)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Template Noticia
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(deftemplate Noticia
  (field Sobre)
  (field Tipo)
  (field Antiguedad)
)
