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
  (printout t crlf crlf ?exp crlf)
  (printout t "¿Toma esta accion? Si(s)/No(otra tecla)"  crlf)
  (bind ?Respuesta (read))
  (if (eq ?Respuesta s) then
    (if (or (eq ?tipo  VenderPeligroso) (eq ?tipo VenderSobrevalorado)) then
      (assert (Operacion Vender ?emp))
    else (if (eq ?tipo  ComprarInfravalorado) then
            (assert (Operacion Comprar ?emp))
          else ;Caso de cambio
            (assert (Operacion Vender ?emp2))
            (assert (Operacion Comprar ?emp))
          )
    )
  )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Realizar acciones
;;;; Son dos grandes reglas, una para comprar y otra para vender.
;;;; En el caso de comprar, se tiene que replicar en dos reglas, segun si
;;;; el valor ya estaba en la cartera o no.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule EjecutarVender (declare (salience 50))
  (Modulo42)
  ?op <- (Operacion Vender ?emp)
  ?f <- (ValorCartera
    (Nombre ?emp)
    (NumAcciones ?num)
  )
  (ValorIbex
    (Nombre ?emp)
    (Precio ?precio)
  )
  ?f2 <- (ValorCartera
      (Nombre DISPONIBLE)
      (ValorTotal ?valor)
  )
  =>
  (retract ?f)
  (retract ?f2)
  (retract ?op)
  (assert (ValorCartera
      (Nombre DISPONIBLE)
      (NumAcciones (+ ?valor (* ?precio ?num 0.95)))
      (ValorTotal  (+ ?valor (* ?precio ?num 0.95)))
    )
  )
  (printout t crlf "Se han vendido todas las acciones de " ?emp " y se han aniadido a la cartera " (* ?precio ?num 0.95)) " Euros." crlf)
  (printout t "En la cartera tienes actualmente: " (+ ?valor (* ?precio ?num 0.95)) crlf)
)

(defrule EjecutarComprarValorEnCartera (declare (salience 49))
  (Modulo42)
  ?op <- (Operacion Comprar ?emp)
  ?f <- (ValorCartera
    (Nombre ?emp)
    (NumAcciones ?numcartera)
  )
  (ValorIbex
    (Nombre ?emp)
    (Precio ?precio)
  )
  ?f2 <- (ValorCartera
      (Nombre DISPONIBLE)
      (ValorTotal ?valor)
  )
  =>
  (retract ?op)
  (printout t crlf "Dispones de " ?valor " en la cartera actualmente." crlf)
  (printout t "El precio de la accion de " ?emp " es " (* ?precio 1.05) " luego puedes comprar " (div ?valor (* ?precio 1.05)) " acciones." crlf)
  (printout t "Introduzca el numero de acciones a comprar:" crlf)
  (bind ?Respuesta (read))
  (if (and (<= ?Respuesta (div ?valor (* ?precio 1.05))) (<= 0 ?Respuesta) )then
    ; Se lleva a cabo la compra
    (printout t crlf "Se han comprado las acciones de " ?emp "." crlf)
    ; Actualizar la cartera
    (retract ?f)
    (assert (ValorCartera
        (Nombre ?emp)
        (NumAcciones (+ ?Respuesta ?numcartera))
        (ValorTotal (*  (+ ?Respuesta ?numcartera) ?precio))
      )
    )
    (retract ?f2)
    (assert (ValorCartera
        (Nombre DISPONIBLE)
        (NumAcciones (- ?valor (* ?precio ?Respuesta 1.05)))
        (ValorTotal  (- ?valor (* ?precio ?Respuesta 1.05)))
      )
    )
  else
    (printout t crlf "Numero introducido incorrecto." crlf)
    (assert (Operacion Comprar ?emp))
  )
)

(defrule EjecutarComprarSinValorEnCartera (declare (salience 49))
  (Modulo42)
  ?op <- (Operacion Comprar ?emp)
  (not (ValorCartera
          (Nombre ?emp)
          (NumAcciones ?numcartera)
      )
  )
  (ValorIbex
    (Nombre ?emp)
    (Precio ?precio)
  )
  ?f <- (ValorCartera
      (Nombre DISPONIBLE)
      (ValorTotal ?valor)
  )
  =>
  (retract ?op)
  (printout t crlf "Dispones de " ?valor " en la cartera actualmente." crlf)
  (printout t "El precio de la accion de " ?emp " es " (* ?precio 1.05) " luego puedes comprar " (div ?valor (* ?precio 1.05)) " acciones." crlf)
  (printout t "Introduzca el numero de acciones a comprar:" crlf)
  (bind ?Respuesta (read))
  (if (and (<= ?Respuesta (div ?valor (* ?precio 1.05))) (<= 0 ?Respuesta) ) then
    ; Se lleva a cabo la compra
    (printout t crlf "Se han comprado las acciones de " ?emp "." crlf)
    ; Actualizar la cartera
    (assert (ValorCartera
        (Nombre ?emp)
        (NumAcciones ?Respuesta)
        (ValorTotal (*  ?Respuesta ?precio))
      )
    )
    (retract ?f)
    (assert (ValorCartera
        (Nombre DISPONIBLE)
        (NumAcciones (- ?valor (* ?precio ?Respuesta 1.05)))
        (ValorTotal  (- ?valor (* ?precio ?Respuesta 1.05)))
      )
    )
  else
    (printout t crlf "Numero introducido incorrecto." crlf)
    (assert (Operacion Comprar ?emp))
  )
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Menu de salida del sistema
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule Salida  (declare (salience 0))
  (Modulo42)
  =>
  (printout t crlf "¿Salir o volver a mostrar propuestas? Salir(s)/Propuestas(otra tecla)"  crlf)
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
