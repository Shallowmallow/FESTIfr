;INST_LANG_numbers.scm
(define (INST_LANG_number_point name control)
;;"(catala_number_point name)
;;Elimina els punts dels números
;;NAME = dígits
;;CONTROL = 2    només retorna el número sense punts en format string
;;          1    número femení 
;;       altres  número masculí"
; example "12.51" "2" -> ("cinquante_et_une")("mille" "deux-cent" "cinquante_et_une")
(cond          
   ((string-matches name ".*[\.].*") (INST_LANG_number_point (string-append (string-before name "\.") (string-after name "\.")) control))
   ((string-matches control "2") (string-append name))
   (t (INST_LANG_number name control))))

(define (INST_LANG_number_decimals name kind separator separatorname)
   "(INST_LANG_number_decimals name) 
   Tractament de nombres decimals
   NAME = dígit
   KIND = gènere (1 = femení / altres = masculí)"
   ; example "12,51" "2" "," "virgule"
   (if (string-matches name (string-append ".*[" separator "].*") )
       (cond
          ((string-matches (string-after name separator) "0.*") ; separator ","  name "12,051" 
            (append (INST_LANG_number_point (string-before name separator) kind ) (list separatorname) (INST_LANG_speller (string-after name separator))))
          (t (append (INST_LANG_number_point (string-before name separator) kind ) (list separatorname) (INST_LANG_number_point (string-after name separator) kind))))))



(define (INST_LANG_number name kind)
   "(INST_LANG_number name kind)
   Transforma els dígits en paraules
   NAME = dígit
   KIND = gènere (1 = femení / altres = masculí) "
   ; festival> (INST_LANG_number "1" "1")
   ; ("une")
   ; festival> (INST_LANG_number "1" "0")
   ; ("un")
   ; festival> (INST_LANG_number "0" "0")
   ; ("zéro")
   ; festival> (INST_LANG_number "2" "0")
   ; ("deux")
      
   (if (not (string-matches kind "1"))
      (set! kind "0"))
   (if (string-matches name "0")
      (list "zéro")
      (INST_LANG_number_from_digits (utf8explode name) kind)))


(define (INST_LANG_number_from_digits digits kind)
  "(INST_LANG_number_from_digits digits kind)
   Agafa una llista de dígits i la converteix en una llista de paraules dient el número.
   "
   ;;festival> (INST_LANG_number_from_digits (list "2" "1")  1)
   ;;("vingt_et_une")
   ; TODO too french septante, octante, nonante
   ;      17: (disle "123 456 789" -1)
   ; festival> (length  '("1" "." "2" "3" "4" "5" "6" "7" "9" "e" "+" "0" "8"))
   ;13
   (format t "INST_LANG_number_from_digits %l\n"  digits)
   (let ((l (length digits) x))
 
      (cond
         ((equal? l 0)
            nil)
         ((string-equal (car digits) "0")  (INST_LANG_number_from_digits (cdr digits) kind)  ;; digits = 0x, elimina el 0 i torna a cridar la funció
            )
         ((equal? l 1)
            (cond 
               ((string-equal (car digits) "0")(list "zéro"))
               ((string-equal (car digits) "1") 
                  (if (string-equal kind "1")
                     (list "une")
                     (list "un")))
               ((string-equal (car digits) "2") (list "deux"))
               ((string-equal (car digits) "3") (list "trois"))
               ((string-equal (car digits) "4") (list "quatre"))
               ((string-equal (car digits) "5") (list "cinq"));  "k_ﬂ"))
               ((string-equal (car digits) "6") (list "six"))
               ((string-equal (car digits) "7") (list "sept"))
               ((string-equal (car digits) "8") (list "huit"))
               ((string-equal (car digits) "9") (list "neuf"))
               ;; fill in the rest
               (t (list " "))));; $$$ what should say?; erreur\n
         ((equal? l 2)
            (cond
               ((string-equal (car digits) "0");; 0x 
                  (INST_LANG_number_from_digits (cdr digits) kind))
     
               ((string-equal (car digits) "1");; 1x
                  (cond
                     ((string-equal (car (cdr digits)) "0") (list "dix"))
                     ((string-equal (car (cdr digits)) "1") (list "onze"))
                     ((string-equal (car (cdr digits)) "2") (list "douze"))
                     ((string-equal (car (cdr digits)) "3") (list "treize"))
                     ((string-equal (car (cdr digits)) "4") (list "quatorze"))
                     ((string-equal (car (cdr digits)) "5") (list "quinze"))
                     ((string-equal (car (cdr digits)) "6") (list "seize"))
                     (t (list "dix" (car (INST_LANG_number_from_digits (cdr digits) kind))))))

               ((string-equal (car digits) "2");; 2x
                  (cond 
                     ((string-equal (car (cdr digits)) "0") (list "vingt"));  "t_ﬂ"
                     ((and (string-equal (car (cdr digits)) "1") (string-equal kind "1")) (list "vingt_et_une"))
                     ((string-equal (car (cdr digits)) "1") (list "vingt_et_un"))
                     (t (list "vingt"  (car (INST_LANG_number_from_digits (cdr digits) kind))))
                     ))
               ((string-equal (car digits) "3");; 3x
                  (cond 
                     ((string-equal (car (cdr digits)) "0") (list "trente"))
                     ((and (string-equal (car (cdr digits)) "1") (string-equal kind "1")) (list "trente_et_une"))
                      ((string-equal (car (cdr digits)) "1") (list "trente_et_un"))
                      (t (list "trente"  (car (INST_LANG_number_from_digits (cdr digits) kind))))
                  ))
               ((string-equal (car digits) "4");; 4x
                  (cond 
                     ((string-equal (car (cdr digits)) "0") (list "quarante"))
                     ((and (string-equal (car (cdr digits)) "1") (string-equal kind "1")) (list "quarante_et_une"))
                     ((string-equal (car (cdr digits)) "1") (list "quarante_et_un"))
                     (t (list "quarante" (car (INST_LANG_number_from_digits (cdr digits) kind))))
                     ))
               ((string-equal (car digits) "5");; 5x
                  (cond 
                     ((string-equal (car (cdr digits)) "0") (list "cinquante"))
                     ((and (string-equal (car (cdr digits)) "1") (string-equal kind "1")) (list "cinquante_et_une"))
                     ((string-equal (car (cdr digits)) "1") (list "cinquante_et_un"))
                     (t (list "cinquante"  (car (INST_LANG_number_from_digits (cdr digits) kind))))
                  ))
               ((string-equal (car digits) "6");; 6x
                  (cond 
                     ((string-equal (car (cdr digits)) "0") (list "soixante"))
                     ((and (string-equal (car (cdr digits)) "1") (string-equal kind "1")) (list "soixante_et_une"))
                     ((string-equal (car (cdr digits)) "1") (list "soixante_et_un"))
                     (t (list "soixante"  (car (INST_LANG_number_from_digits (cdr digits) kind))))
                  ))
               ((string-equal (car digits) "7");; 7x
                  (cond 
                     ((string-equal (car (cdr digits)) "1")
                      (list "soixante-et-onze"))
                     (t 
                        (set! x (INST_LANG_number_from_digits (cons '1 (cdr digits)) kind))
                        (append (list "soixante") x))))
               ((string-equal (car digits) "8");; 8x
                  (cond 
                     ((string-equal (car (cdr digits)) "0") (list "quatre-vingts"))
                     (t (list "quatre-vingt"  (car (INST_LANG_number_from_digits (cdr digits) kind))))
                  )) 
               ((string-equal (car digits) "9");; 9x

                     
                       (set! x (INST_LANG_number_from_digits (cons '1 (cdr digits)) kind))
                      (append (list "quatre_vingt") x)); pourquoi "-" ; append (list "quatre-vingt") x))
         ))
     
         ((equal? l 3);; in the hundreds
            (cond 
               ((string-equal (car digits) "1");; 1xx
                  (cons "cent" (INST_LANG_number_from_digits (cdr digits) kind)))
               (t;; ?xx

                  (if (INST_LANG_number_from_digits (cdr digits) kind)
                     ; deux cent un et deux cents  999 vérifier les tirets ?
                     (append
                        (list(car (INST_LANG_number_from_digits (list (car digits)) kind)) "cent")
                        (INST_LANG_number_from_digits (cdr digits) kind))
                     (append 
                        (list(car (INST_LANG_number_from_digits (list (car digits)) kind)) "cents")
                        (INST_LANG_number_from_digits (cdr digits) kind)))
                  )
               )
         )
         ((and (equal? l 4) (string-equal (car digits) "1")) ; 1xxx
            ; (format stderr "INST_LANG_number_from_digits digits %s\n" (car digits)) ; ex 1.12.97
            ; (format stderr "INST_LANG_number_from_digits digits %l\n" (cdr digits)) ; ex 1.12.97

            (set! sub_thousands ; integer ? 64125("6" "4" "1" "2" "5") 
                         ; thousands ("6" "4")sub_thousands ("1""2""5")("6" "4")
                  (list 
                     (car (cdr (cdr (reverse digits)))); "1"
                     (car (cdr (reverse digits))); "2"
                     (car (reverse digits)); "5"
                  )
               )
            (append
                  (list "mille")
                  (INST_LANG_number_from_digits sub_thousands kind)
               )
            )

         ((< l 7)
            (let (thousand   sub_thousands)
               (set! sub_thousands ; integer ? 64125("6" "4" "1" "2" "5") 
                         ; thousands ("6" "4")sub_thousands ("1""2""5")("6" "4")
                  (list 
                     (car (cdr (cdr (reverse digits)))); "1"
                     (car (cdr (reverse digits))); "2"
                     (car (reverse digits)); "5"
                  )
               )
               (set! thousands (reverse (cdr (cdr (cdr (reverse digits))))))
               (format t "thousands %l\n" thousands) ; thousands ("6" "4")
               
               ;(format stderr "sub_thousands %l\n" sub_thousands)

               (append
                  (INST_LANG_number_from_digits thousands kind)
                  (list "mille")
                  (INST_LANG_number_from_digits sub_thousands kind)
               )
            )
         )
         ((< l 10)
            (let (sub_million millions); 512.345.678
               (set! sub_million 
                     (list 
                        (caddr (cdddr (reverse digits)))
                        ;(car (cdr (cdr (cdr (cdr (cdr (reverse digits)))))))
                        (cadr (cdddr (reverse digits)))
                        (car (cdddr( reverse digits)))
                        
                        (caddr (reverse digits))
                        (cadr (reverse digits))
                        (car (reverse digits))
                     )
               ; (format stderr "%l\n" (list (caddr (reverse digits)) (cadr (reverse digits)) (car (reverse digits))))                     
               )
               (set! millions (reverse (cdddr (cdddr (reverse digits)))))
               (set! x (INST_LANG_number_from_digits millions kind))
               (append
                  (if (or (string-equal (car x) "un") (string-equal (car x) "une")) 
                     (list "un" "million")
                     (append x (list "millions")))
                  (INST_LANG_number_from_digits sub_million kind))
         ))
      (t
         (print "Erreur: trop grand nombre")
         (list "Erreur" "Nombre" "trop" "grand" "pour" "être" "lu"))
   )))

(provide 'INST_LANG_numbers)
