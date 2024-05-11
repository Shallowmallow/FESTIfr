; INST_LANG_norm
; toujours en mouvement, on ne cherche ps encore à optimiser
; à terme  un script externe ?
; TODO use external script

; /!\ utf8
; notamment  pour string-replace
(require 'util)
(defvar verbose_norm t)

; à reprendre 
(define (sampa? name)
    (string-matches name "@@.*"))
(define (norm_sampa texte)
  "maud me donne [[a l 0 b a 0 t rh o s 0]], je sers @@a l'b a't rh o s'"
  texte)







; mais pour ce qui est de norm
; changement de point de vue
; *norm* dédié à une normalisation typographique, aucune réforme lexicale ne sera promue
; 
  
  
(define (norm texte)
 (let (alias after multi_word text text1)
    ;  á å ä ā í ì î ñ œ ò ú
    ; ñ ?
    (if (sampa? texte)
        
        (norm_sampa texte)
        (begin 
          (set! text  texte)
          ; TODO le 1er suffit, text pour mise au point associé à verbose_norm ! 
  
          (set! text (string-replace text " " " "))
          (set! text (string-replace text " " " ")) ; "Oh !
          (set! text (string-replace text " " " ")) ; TODO tout blanc non ascii TODO
          (set! text (string-replace text " " " ")) ; (utf8ord " " 160)

          (set! text (string-replace text "œ" "oe"))
          (set! text (string-replace text "á" "a"))
          (set! text (string-replace text "À" "à"))
          (set! text (string-replace text "å" "a"))
          (set! text (string-replace text "ä" "a"))
          (set! text (string-replace text "ā" "a"))
          (set! text (string-replace text "í" "i"))
          (set! text (string-replace text "ì" "i"))
          (set! text (string-replace text "î" "i"))
          (set! text (string-replace text "ò" "o"))
          (set! text (string-replace text "ú" "u"))
          ;;/ bug utf8 
          (set! text (string-replace text "°" "_o"));; n° et °C
          (set! text (string-replace text "€" " _Euro")); espace pour séparer 2€
          (set! text (string-replace text "¥" " _yen"))
          (set! text (string-replace text "£" " _pound"))
          (set! text (string-replace text "¢" " _cent"))
          ;; bug utf8 question ponctuation
          (set! text (string-replace text "–" " ")) ; utf8 vu comme  "€“"
          (set! text (string-replace text "„" "\\\""))
          
          (set! text (string-replace text "…" "...")  )
          (set! text (string-replace text "¸" ","))

          ;(set! text (string-replace text "\"" " \""))
          (set! text (string-replace text "« " "\\\""))
          (set! text (string-replace text " »" "\\\""))
          (set! text (string-replace text "«" "\\\""))
          (set! text (string-replace text "»" "\\\""))



          (set! text (string-replace text " …" "..."))  ; + typo pas d'espace devant des  points de suspsension !


          (set! text (string-replace text "!." ".")) ; bad typo
          (set! text (string-replace text "...." ""))  ; pas d'excès !

          (set! text (string-replace text "--" " \""))  ; gutenberg TODO pas optimum
          (set! text (string-replace text "’" "'"))  
          ; 
          (set! text (string-replace text "´" "'"))

          (set! text (string-replace text " ," ",")) ; bad typo
          (set! text (string-replace text "," ", ")) ; bad typo
          (set! text (string-replace text ".(" ". (")); bad typo
          (set! text (string-replace text ";(" "; (")); bad typo

          (set! text (string-replace text " . " ".")) ; bad typo
          (set! text (string-replace text " ." ".")) ; bad typo

          ; on ajuste les ponctuations françaises et anglaises, assez proches pour ne pas tout refaire
          (set! text (string-replace text " ?" "?")); -> english typo
          (set! text (string-replace text " )" ")")); -> english typo
          (set! text (string-replace text "( " "(")); -> english typo ;  sinon ça complique le token_to_words où,notamment ) serit vu comme un mot
          (set! text (string-replace text " :" ":")) 
          (set! text (string-replace text " !" "!"))
          (set! text (string-replace text ";" "; ")) ; ;trop collé
          (set! text (string-replace text " ;" ";")) ; ; pour coller avec la typo anglaise


            (set! text (string-replace text ".," ".")) ; pour VOLT., essai
            (set! text (string-replace text "quart-" "quar-"))

            (set! text (string-replace text "demi-" "demi "))
            (set! text (string-replace text "semi-" "semi "))
            (set! text (string-replace text "Demi-" "demi "))
            (set! text (string-replace text "Semi-" "semi ")) 
            (set! text (string-replace text "Mi-" "mi "))   
            (set! text (string-replace text "mi-" "mi "))   
            (set! text (string-replace text "mini-" "mini "))   
            (set! text (string-replace text "mille-" "mille "))
            (set! text (string-replace text "mini-" "mini "))
            (set! text (string-replace text "Mille-" "mini "))

            (set! text (string-replace text "ENA" "éna"))  ; voir autre sigle commençant par  E se lisant é

            ; tentation mais fausse bonne idée, on perd un feature
            ; (set! text (string-replace text "'" "_"))
  
            ;pis-aller : ce n'est plus de la typo ! mais un problème de poslex
           ; (set! text (string-replace text "ons-en" "on z_en")) pris en charge par QTpos2
           ;  (set! text (string-replace text "ez-en" "é z_en")) ; pris en charge par QTpos2
           ; (set! text (string-replace text "ons-y" "on z_y")) pris en charge par QTpos2
;            (set! text (string-replace text "ez-y" "é z_y")); pris en charge par QTpos2
            (set! text (string-replace text "eux-" "eux "))
            (set! text (string-replace text "t'il " "t_il "))
            (set! text (string-replace text "t'ils " "t_ils "))
            (set! text (string-replace text "t'elle " "t_elle "))
            (set! text (string-replace text "t'elles " "t_elles "))
            (set! text (string-replace text "t'on " "t_on "))            
            
            (if (and verbose_norm (not (string-equal text texte)))
                 (format t "verbose_norm %s gives %s\n" texte text))
            
          text))
    ))
;; pistes pour V1
; en cours pattermach ..à reprendre
; ou ...
(require 'INST_LANG_patternmatch)
; the Scheme-variable named #1, #2 ... is generated and the part of
; string that matches this expression is bound to this variable
; they should be used with caution to avoid overwriting 


; # surnumerary_spaces
; "start_of_paragraph":          [("^[  ]+", "")],
; "end_of_paragraph":            [("[  ]+$", "")],
; "between_words":               [("  |  ", " "),  # espace + espace insécable -> espace
;                                 ("  +", " "),    # espaces surnuméraires
;                                 ("  +", " ")],   # espaces insécables surnuméraires
; "before_punctuation":          [(" +(?=[.,…])", "")],
; "within_parenthesis":          [("\\([  ]+", "("),
;                                 ("[  ]+\\)", ")")],
; "within_square_brackets":      [("\\[[  ]+", "["),
;                                 ("[  ]+\\]", "]")],
; "within_quotation_marks":      [("“[  ]+", "“"),
;                                 ("[  ]”", "”")]
; ## non-breaking spaces
; # espaces insécables
; "nbsp_before_punctuation":     [("(?<=[]\\w…)»}])([:;?!])[   …]", " \\1 "),
;                                 ("(?<=[]\\w…)»}])([:;?!])$", " \\1"),
;                                 ("[  ]+([:;?!])", " \\1")],
; "nbsp_within_quotation_marks": [("«(?=\\w)", "« "),
;                                 ("«[  ]+", "« "),
;                                 ("(?<=[\\w.!?])»", " »"),
;                                 ("[  ]+»", " »")],
; "nbsp_within_numbers":         [("(\\d)[  ](?=\\d)", "\\1 ")],
; # espaces insécables fines 
; "nnbsp_before_punctuation":    [("(?<=[]\\w…)»}])([;?!])[   …]", " \\1 "),
;                                 ("(?<=[]\\w…)»}])([;?!])$", " \\1"),
;                                 ("[  ]+([;?!])", " \\1"),
;                                 ("(?<=[]\\w…)»}]):", " :"),
;                                 ("[  ]+:", " :")],
; "nnbsp_within_quotation_marks":[("«(?=\\w)", "« "),
;                                 ("«[  ]+", "« "),
;                                 ("(?<=[\\w.!?])»", " »"),
;                                 ("[  ]+»", " »")],
; "nnbsp_within_numbers":        [("(\\d)[  ](\\d)", "\\1 \\2")],


(set! punctuation_tab   '(
                                 (" +(?=[.,…])" . "") ; before_punctuation
                                 ("\\([  ]+" . "(" ) ; within_parenthesis 1
                                 
                                 ))
(set! before_punctuation_m " +(?=[.,…])")
(set! beforepunctuation_r "" )

(define (norm_punctuation texte)
  (let (results)
    (if (pattern-matches texte before_punctuation_m)
      (begin
        (set! h1 #1)(set! h2 #2)(set! h3 #3)
        (format t "h1 %s\n" h1)
        (format t "h2 %s\n" h2)            
        (format t "h3 %s\n" h3)
      ))))

;;; à commenter pendant séance de mise au point
(provide 'INST_LANG_norm) 

