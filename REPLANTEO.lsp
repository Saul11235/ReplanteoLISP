; Programa de Replanteo CAD LISP
; hecho por Edwin Saul Pareja Molina
; http://edwinsaul.com


(defun c:replanteo()
  
  ;-------------------------------------------
  
  ; VARIABLES DE ESCALA Y ORIGEN DE COORDENADAS
  ; cada punto espresa una coordenada respecto a un origen y una escala
  (setq escalaX 1) 
  (setq escalaY 1) 
  (setq origenX 0) 
  (setq origenY 0) 

  ; VARIABLES DE DIBUJO
  (setq dimensiontexto  1  )
  (setq anchoLetrero    20 )
  (setq dibujarleyenda  t  ) ; TRUE por defecto
  (setq dibujarmarcador t  ) ; TRUE por defecto
  (setq decimales       3  )

  ; VARIABLES INPUT PUNTO
  (setq nombrePunto       nill ) ; FALSE por defecto
  (setq nombreTodosPuntos nill ) ; FALSE por defecto

  ; VARIABLES MEMORIA PUNTOS
  ; string que almacena todos los puntos en un string para su manejo 
  (setq memoriaPuntos "#Pts Replanteo\n \n ")

  ;-------------------------------------------
  ; Dibuja la marca para la visibilidad del punto replanteado
  (defun dibujaCruz (punto) (
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
     )
   )

  ;-------------------------------------------
  ; Dibuja la marca para la visibilidad del punto replanteado
  (defun dibujaLetrero (coor_leyenda_x coor_leyend_y texto) 
    (
       (command "_.mtext"
	(list coor_leyenda_x coor_leyend_y)
	"_H" dimensiontexto;Altura Letras
	"_W" anchoLetrero  ;Ancho leyendas
	texto ""
       )
     )
  )
  
  ;-------------------------------------------4SW3W3
  ; Funcion de picapunto para replanteo
  ;-------------------------------------------
  ; Funcion que obtiene
  (defun picapunto(inputstr)
    ( (setq punto_picado (getpoint inputstr)) 
      (setq var_X ( car  punto_picado ) )
      (setq var_Y ( cadr punto_picado ) )
      (list var_X var_Y)
     )
    )



  ;-------------------------------------------

        
  ;-------------------------------------------

        

  ;-------------------------------------------

        
  ;-------------------------------------------

        
  ;(print "COMANDO REPLANTEO OK")
   (write-line " >>> REPLANTEO <<< por ESPM ")
   (picapunto "pica")
   ;(dibujaLeyenda 0 0 "holaa")



   

  
)
