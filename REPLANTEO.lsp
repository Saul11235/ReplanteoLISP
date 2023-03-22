; Programa de Replanteo CAD LISP
; hecho por Edwin Saul Pareja Molina
; http://edwinsaul.com

(defun c:repl()
  
  ;-------------------------------------------
  
  ; VARIABLES DE ESCALA Y ORIGEN DE COORDENADAS
  ; cada punto espresa una coordenada respecto a un origen y una escala
  (setq escalaX 1) 
  (setq escalaY 1) 
  (setq origenX 0) 
  (setq origenY 0) 

  ; VARIABLES DE DIBUJO
  (setq dimensiontexto 0.5)
  (setq dibujarleyenda  1 ) ; TRUE por defecto
  (setq dibujarmarcador 1 ) ; TRUE por defecto

  ; VARIABLES INPUT PUNTO
  (setq nombrePunto       0 ) ; FALSE por defecto
  (setq nombreTodosPuntos 0 ) ; FALSE por defecto

  ; VARIABLES MEMORIA PUNTOS
  ; string que almacena todos los puntos en un string para su manejo 
  (setq memoriaPuntos "texto\njkjkj\nlalala")

  ;-------------------------------------------
  ; Dibuja la marca para la visibilidad del punto replanteado
  (defun dibujaMarcadorPunto (punto)
    (setq longitud ( * dimensiontexto 4 ) )
    (setq coordenadax (car punto ) )
    (setq coordenaday (cadr punto) )
    (setq coordCentro (list coordenadax coordenaday)) ; coordenadas cruz
    (setq extremo1    (list (- coordenadax longitud) coordenaday ))
    (setq extremo2    (list (+ coordenadax longitud) coordenaday ))
    (setq extremo3    (list coordenadax (+ coordenaday longitud) ))
    (setq extremo4    (list coordenadax (- coordenaday longitud) ))
    (command "_.line"   extremo1 extremo2 "" )
    (command "_.line"   extremo3 extremo4 "" )
    (command "_.circle" coordCentro (* longitud 0.5) "" )
    (dibujaLeyenda punto memoriaPuntos)
   )

  ;-------------------------------------------
  ; Dibuja la marca para la visibilidad del punto replanteado
  (defun dibujaLeyenda (punto, texto)
    (setq longitud ( * dimensiontexto 4 ) )
    (setq coordenadax (car punto ) )
    (setq coordenaday (cadr punto) )
    ; ETIQUETA -----
    
    ;---------------
    
   )

  ;-------------------------------------------


  ;-------------------------------------------

        
  ;(print "COMANDO REPLANTEO OK")
   (dibujaMarcadorPunto (getpoint "pica un punto "))  
   (dibujaMarcadorPunto (getpoint "pica un punto ")) 
   (dibujaMarcadorPunto (getpoint "pica un punto "))
   (dibujaMarcadorPunto (getpoint "pica un punto "))
)
