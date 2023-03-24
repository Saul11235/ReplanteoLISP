; Funcion de replanteo en LISP escrita por ESP

(princ "\nEjecuta la aplicacion REPLAnteo")

( defun c:repla () 
    ( progn
     ; Variables sistema ----------------
     (setq DIM_cruz 1) 
     (setq DIM_text 0.5) 
     (setq DIM_weigth 20)
     (setq SCALE_origen_x 0)
     (setq SCALE_origen_y 0)
     (setq SCALE_x 1)
     (setq SCALE_y 1)
     (setq FLAG_draw_cruz  t) ;t por defecto
     (setq FLAG_draw_label t) ;t por defecto
     (setq FLAG_name_punto nil) ; nil defecto
     (setq CONTADOR_puntos 0)
     (setq MEMORIA_puntos "")
     (setq FLAG_nombre_tabla nil)
     (setq NOMBRE_TABLA "")

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
     ( defun VERDADERO_x (xleido) ; calcula la coordenada real de terreno
	( progn
	  (setq dist_to_origin (- xleido SCALE_origen_x))
	  (* dist_to_origin SCALE_x)
	 )     
      )
     ;-----------------------------------
     ( defun VERDADERO_y (yleido) ; calcula la coordenada real de terreno
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
	  (Aumentar_contador_puntos)
	 )     
      )
     ;-----------------------------------
     (defun BOTON_ActivarNombre()
       (progn
	 (setq FLAG_name_punto t)
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
	  (setq LetreroPunto (strcat "[  " (rtos VERDADERO_REPLANTEO_X) " ; " (rtos VERDADERO_REPLANTEO_Y) " ]") )
	  (write-line LetreroPunto)
	  ; -------------
	  (if FLAG_draw_cruz
	    (DRAW_cruz REPLANTEO_X REPLANTEO_Y)
	    ()
	    )
	  ; -------------
	  ( if FLAG_name_punto
	       (progn
		 (setq FLAG_name_punto nil)
	         (setq letrero_input (strcat "Nombre el " (rtos (+ 1 CONTADOR_puntos) ) " punto: "))
		 (setq NOMBRE_REPLANTEO (getstring letrero_input))
		 (setq LetreroTabla (strcat LetreroTabla "\t" NOMBRE_REPLANTEO ))
		 (setq LetreroPunto (strcat " " NOMBRE_REPLANTEO "\n" LetreroPunto ))
		 )
	       ()
	   )
	  ; -------------
	  (if FLAG_draw_label
	    (DRAW_label REPLANTEO_X REPLANTEO_Y LetreroPunto)
	    ()
	    )
	  ; -------------
	  (Registrar_en_memoria LetreroTabla)
	  ; -------------
	  )     
      )
     ;-----------------------------------
     (defun PICAR_tabla ()
       ( progn
	 (setq PUNTO_TABLA (PICAR_punto "punto para tabla")) 
	 (setq Tabla_X (car  PUNTO_TABLA) )
	 (setq Tabla_Y (cadr PUNTO_TABLA) )
	 (setq stringTituloTabla "")
	 (if FLAG_nombre_tabla
	   (setq stringTituloTabla (strcat "\n# " NOMBRE_TABLA) )
	   ()
	   )
	 (setq String_superior (strcat "# " (rtos CONTADOR_puntos ) " puntos" stringTituloTabla "\n#--------\n\n") )
	 (setq DatosTabla (strcat String_superior MEMORIA_puntos "\n#--------" ))

	 (DRAW_label Tabla_X Tabla_Y DatosTabla)
	)
       )
     ;-----------------------------------
     (defun PONER_nombre_tabla () 
       (progn
	 (setq FLAG_nombre_tabla t)
	 (setq NOMBRE_TABLA (getstring "Nombre del replanteo: "))
	)
       )
     ;-----------------------------------
     (defun FALSO_x (xleido) ; calcula x en plano digital
       ( progn
	 (setq dist_virtual (/ xleido SCALE_x))
	 (+ SCALE_origen_x dist_virtual)
	)
       )
     ;-----------------------------------
     (defun FALSO_y (yleido) ; calcula y en plano digital
       ( progn
	 (setq dist_virtual (/ yleido SCALE_y))
	 (+ SCALE_origen_y dist_virtual)
	)
       )
     ;-----------------------------------
     ; FUNCION QUE DIBUJA UN PUNTO SI SE CONOCEN 
     ; SUS COORDENADAS DE TERRENO 
     ( defun DIBUJA_PUNTO_XY(xterreno yterreno) 
	(progn
	  (DRAW_cruz (FALSO_x xterreno) (FALSO_y yterreno))
	  (setq etiqueta_pto_dibujado (strcat " < " (rtos xterreno ) " ; " (rtos yterreno) " >") )
	  (DRAW_label (FALSO_x xterreno) (FALSO_y yterreno) etiqueta_pto_dibujado )
	 )     
      )
     ; FUNCION QUE DIBUJA UN PUNTO SI SE CONOCEN 
     ; SUS COORDENADAS DE TERRENO y NOMBRE PTO
     ( defun DIBUJA_PUNTO_XYN(xterreno yterreno nombrePto) 
	(progn
	  (DRAW_cruz (FALSO_x xterreno) (FALSO_y yterreno))
	  (setq etiqueta_pto_dibujado (strcat "  ##" nombrePto "\n < " (rtos xterreno ) " ; " (rtos yterreno) " >") )
	  (DRAW_label (FALSO_x xterreno) (FALSO_y yterreno) etiqueta_pto_dibujado )
	 )     
      )
     ;-----------------------------------
     ( defun LANZA_INTERFAZ ()
	( progn
	  (setq INTERFAZ (new_dialog "Replanteo"))
	  (action_tile "Aceptar"  "(done_dialog 1)") 
	  (action_tile "Cancelar" "(done_dialog 0)") 
	  (start_dialog INTERFAZ)
	 )
      )

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

     ;(PONER_nombre_tabla)

     ;(PICAR_punto_replanteo)
     ;(PICAR_punto_replanteo)
     ;(BOTON_ActivarNombre)
     ;(PICAR_punto_replanteo)
     ;(PICAR_punto_replanteo)
     ;(BOTON_ActivarNombre)
     ;(PICAR_punto_replanteo)
     ;(PICAR_tabla)

     ;(princ (FALSO_x -1))
     ;(princ (FALSO_y  3.3))

     ;(DIBUJA_PUNTO_XY 1  -3.2)
     ;(DIBUJA_PUNTO_XY 2.2 4)

     ;(DIBUJA_PUNTO_XYN 10  -3.2 "HOLAMUNDO")
     ;(DIBUJA_PUNTO_XYN -1 -2.2  "HOLAOTRAVEZ")
     (LANZA_INTERFAZ)



     ; Finalizacion---------------------
     (write-line "\n>>>>>>> FIN <<<<<<<<<<")
     (write-line "-")

     )
 )

