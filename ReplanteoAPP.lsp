; Funcion de replanteo en LISP escrita por ESP

(princ "\nEjecuta la aplicacion REPLAnteo")

( defun c:repla () 
    ( progn
     ; Variables sistema ----------------
     (setq DIM_cruz 1) 
     (setq DIM_text 1) 
     (setq DIM_weigth 15)
     (setq SCALE_origen_x 0)
     (setq SCALE_origen_y 0)
     (setq SCALE_x 1)
     (setq SCALE_y 1)
     (setq FLAG_draw_cruz  t) ;t por defecto
     (setq FLAG_draw_label t) ;t por defecto
     (setq CONTADOR_puntos 0)

     ; funciones ------------------------
     (defun PICAR_punto (leyenda)
       ( progn 
	 (setq VAR_picada (getpoint (strcat "\n" leyenda ": ")) )
	 (setq VAR_picadaX (car  VAR_picada))
	 (setq VAR_picadaY (cadr VAR_picada))
	 (list VAR_picadaX VAR_picadaY)
	)
       )
     ;-----------------------------------
     ( defun DRAW_cruz (xcruz ycruz)
	( progn
          (setq extremo1 (list (- xcruz DIM_cruz) ycruz))
          (setq extremo2 (list (+ xcruz DIM_cruz) ycruz))
          (setq extremo3 (list xcruz (+ ycruz DIM_cruz)))
          (setq extremo4 (list xcruz (- ycruz DIM_cruz)))
          (command "_.line"   extremo1 extremo2 "" )
          (command "_.line"   extremo3 extremo4 "" )
          (command "_.circle" (list xcruz ycruz) (* DIM_cruz 0.5) "" )
	 )     
      )
     ;-----------------------------------
     ( defun DRAW_label (xlabel ylabel texto)
	( progn
	  ( command "_.mtext"
             (list xlabel ylabel)		    
	     "_H" DIM_text
	     "_W" DIM_weigth
	     texto ""
	   )
	 )
      )
     ;-----------------------------------
     ( defun VERDADERO_x (xleido)
	( progn
	  (setq dist_to_origin (- xleido SCALE_origen_x))
	  (* dist_to_origin SCALE_x)
	 )     
      )
     ;-----------------------------------
     ( defun VERDADERO_y (yleido)
	( progn
	  (setq dist_to_origin (- yleido SCALE_origen_y))
	  (* dist_to_origin SCALE_y)
	 )     
      )
     ;-----------------------------------
     ( defun Aumentar_contador_puntos()
	( progn 
	  (setq CONTADOR_puntos ( + CONTADOR_puntos 1)) )
      )
     ;-----------------------------------

     ;-----------------------------------

     ;-----------------------------------

     ;-----------------------------------

     ;-----------------------------------
     ; EJECUCION PROGRAMA----------------
     (write-line " >>> REPLANTEO por ESPM <<< ")


     ; Pruebas---------------------------

     ;(PICAR_punto "Ejemplo prueba_texto")

     ;(princ (PICAR_punto "texto picado"))

     ;(DRAW_cruz 0 0)
     ;(DRAW_cruz 2 0)
     ;(DRAW_cruz 2 3)

     ;(DRAW_label 0 0 "hola")
     ;(DRAW_label 2 0 "saludos\na ti")
     ;(DRAW_label 2 3 "123\nabc")
      
     ;(princ (VERDADERO_x 55))
     ;(princ (VERDADERO_x 22))

     ;(princ CONTADOR_puntos)
     ;(Aumentar_contador_puntos)
     ;(princ CONTADOR_puntos)
     ;(Aumentar_contador_puntos)
     ;(princ CONTADOR_puntos)


     ; Finalizacion---------------------
     (write-line "\n>>>>>>> FIN <<<<<<<<<<")
     (write-line "-")

     )
 )

