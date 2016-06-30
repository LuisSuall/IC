(deffacts CargarPrograma (CargarPrograma))

(defrule Carga
  ?f<-(CargarPrograma)
  =>
  (load "./DataDefinition.clp")
  (load "./DataReader.clp")
  (load "./Modulo1.clp")
  (load "./Modulo2.clp")
  (load "./Modulo3.clp")
  (load "./Modulo4-1.clp")
  (load "./Modulo4-2.clp")
  (retract ?f)
  (assert (Step1))
)
