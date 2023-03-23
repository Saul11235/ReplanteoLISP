; Funcion de replanteo en LISP escrita por ESP

(princ "\nEjecuta la aplicacion REPLAnteo")

( defun c:repla () 
    ( progn
     ; Variables sistema ----------------
     (setq DIM_cruz 1) 
     (setq DIM_text 0.5) 
     (setq DIM_weigth 15)
     (setq SCALE_origen_x 0)
     (setq SCALE_origen_y 0)
     (setq SCALE_x 1)
     (setq SCALE_y 1)
     (setq FLAG_draw_cruz  t) ;t por defecto
     (setq FLAG_draw_label t) ;t por defecto
     (setq FLAG_name_punto nil) ; nil defecto
     (setq CONTADOR_puntos 0)
     (setq MEMORIA_puntos "#Repl Puntos\n \n")

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
     ( defun DRAW_label (xlabelCoord ylabelCoord texto)
	( progn
	  ( command "_.mtext"
             (list xlabelCoord ylabelCoord)		    
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
     ( defun Registrar_en_memoria (texto_para_memoria)
	( progn 
	  (setq MEMORIA_puntos (strcat MEMORIA_puntos texto_para_memoria "\n" ) )
	 )     
      )
     ;-----------------------------------
     ( defun PICAR_punto_replanteo ()
	( progn
	  (setq letrero_input (strcat "Seleccione el " (rtos (+ 1 CONTADOR_puntos) ) " punto"))
	  (setq pto_REPLANTEO (PICAR_punto letrero_input))
	  (setq REPLANTEO_X (car  pto_REPLANTEO))
	  (setq REPLANTEO_Y (cadr pto_REPLANTEO))
	  (setq VERDADERO_REPLANTEO_X (VERDADERO_x REPLANTEO_X ))
	  (setq VERDADERO_REPLANTEO_Y (VERDADERO_Y REPLANTEO_Y ))
	  (setq LetreroTabla (strcat (rtos VERDADERO_REPLANTEO_X) "\t" (rtos VERDADERO_REPLANTEO_Y) ) )
	  (setq LetreroPunto (strcat "[ " (rtos VERDADERO_REPLANTEO_X) " ; " (rtos VERDADERO_REPLANTEO_Y) " ]") )
	  (write-line LetreroPunto)

	  (if FLAG_draw_cruz
	    (DRAW_cruz REPLANTEO_X REPLANTEO_Y)
	    ()
	    )

	  (if FLAG_draw_label
	    (DRAW_label REPLANTEO_X REPLANTEO_Y LetreroPunto)
	    ()
	    )



	  )     
      )

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
     ;(DRAW_label 2.1 3 "123\nabc")

     ;(DRAW_label 2.44 3.55 "fff\ggg")
      
     ;(princ (VERDADERO_x 55))
     ;(princ (VERDADERO_x 22))

     ;(princ CONTADOR_puntos)
     ;(Aumentar_contador_puntos)
     ;(princ CONTADOR_puntos)
     ;(Aumentar_contador_puntos)
     ;(princ CONTADOR_puntos)

     ;(Registrar_en_memoria "abc\tddd\t455")
     ;(Registrar_en_memoria "123\tfff\t788")
     ;(Registrar_en_memoria "xyz\t444\t988")
     ;(DRAW_label 0 0 MEMORIA_puntos)

     (PICAR_punto_replanteo)


     ; Finalizacion---------------------
     (write-line "\n>>>>>>> FIN <<<<<<<<<<")
     (write-line "-")

     )
 )

