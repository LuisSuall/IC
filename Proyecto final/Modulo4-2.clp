;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Mostrar propuesta
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule AniadirContador (declare (salience 20))
  (Modulo42)
  =>
  (assert (Contador 0))
)

(defrule MostrarMejorResultado  (declare (salience 10))
  (Modulo42)

  ?fcont <- (Contador ?i)
  (test (< ?i 5))

  ?fprop <- (Propuesta ?tipo ?emp ?emp2 ?RE1 ?exp)
  (not  (and (Propuesta ?tipox ?empx ?emp2x ?RE2 ?expx) (test(> ?RE2 ?RE1))))
  =>
  (retract ?fcont)
  (assert (Contador (+ ?i 1)))

  (retract ?fprop)
  (printout t ?exp crlf)
  (printout t "¿Toma esta accion? Si(s)/No(otra tecla)"  crlf)
  (bind ?Respuesta (read))
  (if (eq ?Respuesta s) then
    (assert (Operacion ?tipo ?emp ?emp2))
  )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Realizar acciones
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Menu de salida del sistema
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule Salida  (declare (salience 0))
  (Modulo42)
  =>
  (printout t "¿Salir o volver a mostrar propuestas? Salir(s)/Propuestas(otra tecla)"  crlf)
  (bind ?Respuesta (read))
  (if (or (eq ?Respuesta S) (eq ?Respuesta s)) then
    (assert (salir))
  else
    (assert (recalcular))
  )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Salida del sistema
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule abrirCartera  (declare (salience 50))
  (Modulo42)
  (salir)
  =>
  (open "Data/NuevaCartera.txt" mydata "w")
)

(defrule llenarCartera (declare (salience 49))
  (Modulo42)
  (salir)
  (ValorCartera
    (Nombre ?nombre)
    (NumAcciones ?num)
    (ValorTotal ?valor)
  )
  =>
  (printout mydata (str-cat ?nombre " " ?num " " ?valor) crlf)
)

(defrule salir (declare (salience 48))
  (Modulo42)
  (salir)
  =>
  (close mydata)
  (exit)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Relanzar sistema
;;;; Tenemos que eliminar los valores peligrosos (pueden cambiar) y recalcular
;;;; todas las propuestas, luego tambien las tenemos que eliminar.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule borrarPeligrosos (declare (salience 50))
  (Modulo42)
  (recalcular)
  ?f <- (Peligroso ?nombre)
  =>
  (retract ?f)
)

(defrule borrarPropuestas (declare (salience 50))
  (Modulo42)
  (recalcular)
  ?f <- (Propuesta ?tipo ?emp ?emp2 ?RE1)
  =>
  (retract ?f)
)

(defrule reiniciar (declare (salience 49))
  ?mod <- (Modulo42)
  ?rec <- (recalcular)
  ?cont <- (Contador ?i)
  =>
  (retract ?mod)
  (retract ?rec)
  (retract ?cont)
  (assert (Modulo1))
)
