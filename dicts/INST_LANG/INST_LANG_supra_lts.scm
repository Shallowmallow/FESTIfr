
(defvar verbose_supra_lts nil)
(defvar lexdebug 0)
(defvar correction_lts nil)
; (if correction_lts (require 'correction_lts))
(require 'util)
(require 'INST_LANG_patternmatch); for pattern-matches
(require 'fileio)

; TODO_check autorise une INST_LANG_lts_rules externe si chargée avant .. pour test cummulate
(if (not (boundp 'INST_LANG_lts_rules))
      (require 'INST_LANG_lts_rules))
(require 'INST_LANG_phoneutils)
(require 'INST_LANG_lts)
(require 'INST_LANG_patternmatch)



(define (lts_brut word features)
  "TODO blabla"
  (let (entry (my_strict_lex.lookup word features) results)
    (if (not (null? entry))
      (begin
        (set! syls (car (cdr (cdr entry))))
        (set! results (list (string-append word "_" features)  features syls))
        (if verbose_supra_lts (format t "results taken from my_strict_lex.lookup %l" results)))
      (begin
          ; lexicon.cc will change features to -1
          ; assuming there is -1 is never in the pos field...
          (set! syls (slice_word word features))
          (set! results (list word features syls))
          (if verbose_supra_lts (format t "supra_lts: no strict result %l expect -1 \n" results))
          (if t ;(probe_file "stats")
              (write2-file "stats_tests" (format nil "%l\n" results))
          )
          ))
    results))


; TODO ??? location ici cause correction lts
; phoneutils correction netlex_sy..
(define (modify_listphones phones)
  (let (result str_phones)
    (if (not (null? phones))
      (begin 
        ;(format t "debug modify_listphones phones: %l\n" phones)
        ;(format t "nth 0 phones: %l\n" (nth 0 phones))
        ;(format t "nth 1 phones: %l\n" (nth 1 phones))
        ;(format t "last phones: %l\n" (last phones))
        ;(format t "butlast phones: %l\n" (butlast phones))
        ; pas les 2 derniers  :()
        ; utiliser pattern-matches une fois au point
        ; éventuellement revoir INST_LANG_lex_syllabify_phstress grosse consonne ex 'b-rh' grosse voyelle "a-j"
        ; plus ou moins réglable selon le niveau de langue ? autre phoneme à la place de ae ?
        (set! str_phones (list->-string phones)) ; "-ahn-t-rh-m-eh-l"
        (set! result (split-string (string-cdr  (if correction_lts (correct str_phones)  str_phones)) "-"))

        result))))
            
 
 ; TODO deplacer ? tools
  
(define (slice_word word features) ; return stressed syls 
  "given a word and its features give the list of the syllables of a possible pronunciation"
  ; exemple est -> ("est" "VER" (((eh) 0)))
  ; (slice_word "Á" nil) -> nil    
  ; festival> (slice_word "À" nil)) -> (("a") 0))
  ; (slice_word "ouvre-bouteille" nil) -> ((("u") 0) (("v" "rh" "ae") 0) (("b" "u") 0) (("t" "eh" "j") 0))
  ; on ne sliçait pas bien  "ouvre_bouteille" -> ((("u") 0) (("v" "rh" "b" "u") 0) (("t" "eh" "j") 0))
  ; DONE
  (lexdebug 1000 (format nil "slice_word word: %s feature: %s\n" word features))
  (let (syls phones word1)      
    (cond
      (t
        ; failed to find tree for T
        (set! phones (lts_predict_utf8 (french_downcase_string word) INST_LANG_lts_rules))
        ; tempo old lts 20210816
        (changepho_ah->a phones)

        (set! phones (modify_listphones phones))
        ;(format t "tempo: phones %l" phones)
        ; "s" dans  s'il y a 
        (set! last_phone (if (not(null? phones))(car (last phones)) ""))
        (set! butlast_phone (remove_last phones))
        (set! penlast_phone (if (not(null? butlast_phone)) (car (last butlast_phone)) ""))
        (if (and (member_string last_phone (list "rh"))(member_string penlast_phone (list "t")))
            (set! phones (append phones (list "ae"))))
        (set! syls (INST_LANG_lex_syllabify_phstress phones))
        
        syls))))




(define (list_phones-1 r1)
  ; r1 prefixe dans un sens vraiment large : truc qui se met avant le mot et qui n'en change pas le POS
  ; quoiqu'* est vu comme quoiqu CON muet suivi de quoiqu_* avec le POS de * 
  (let (r2  result)
    (set! r2 (french_downcase_string r1))
    ;(format t "r2 %s \n" r2)
  (cond 
        ; pas les locutions ...     gérées dans token_fr
        ; voir si on ne peut pas faire plus simple pour les non locutions
        ; avec une simple entrée dans le dico ! avec la même gestion que les locutions 
        ; nécessitera soin changt des entrées existantes 
        ; ;; jusqu__nil avec 2 _  pourrait faire l'affaire
        
        ((string-equal r2 "jusqu")  (list "zh" "y" "s" "k") )
        ((string-equal r2 "lorsqu") (list "l" "oh" "rh" "s" "k"))
        ((string-equal r2 "puisqu") (list "p" "hw" "i" "s" "k"))
        ((string-equal r2 "quelqu") (list "k" "eh" "l" "k"))
        ((string-equal r2 "quoiqu") (list "k" "w" "a" "k"))
        ((string-equal r2 "qu") (list "k"))
        ((string-equal r2 "c") (list "s"))
        ((string-equal r2 "j") (list "zh"))
        ((string-equal r2 "s") (list "s"))
        ; ((member_string r2 (list "d" "l" "m" "n" "s" "t")); 
        ;  (list r2))
        
        ; ((string-equal r1 "tout_") (list "t" "u" "t")) ; locutions
        ; ((string-equal r1 "aéro") (list "a" "e" "rh" "o"))
        
        ; ((string-equal r1 "auto") (list "o" "t" "o"))
        ; liste (hopefully) exhaustive  réduite maintenant à list_before_apo 
        ; d'où pas de t
       
        )) )
  
 
(define (list_phones-2 r2 features)
     "liste des phonèmes"
     ; (set! flata   (flatten (car (cdr (cdr (lex.lookup "albinos" "NOM"))))))
     (let (entry)
     (set! entry (or (my_strict_lex.lookup r2 features) (lts_brut r2 features)))
           (set! flata   (flatten (car (cdr (cdr entry)))))
           (car (cons (remove* 0 flata) '()))))
     
                        
(define (fusion r1 r2 features)
  ; collage de syllabes simple sauf quoiqu, quelqu, recomposition des syllabes
  ;(format t "!!!!!!!!!!!!!! r1 %l, r2 %l" r1 r2 )
  (INST_LANG_lex_syllabify_phstress (append (list_phones-1 r1)(list_phones-2 r2 features))))

(define (fusion2 r1 r2 features)
  ; s l
  (let (syls s2 result)
  ;(format t "!!!!!!!!!!!!!! r1 %l, r2 %l" r1 r2 )
                ; (set! word "s_entretuent")
              ; (set! features "VER")
              ; (pattern-matches word "s{[_]+}{.*}")
              ; (set! word2 #2) ; entretuent
              ; (format t "\t\t\t word2 _%s_ _%s_\n" #2 features)
              ;(format t "\t\t\t(netlex_lts :%l\n)" (INST_LANG_lts_function (wordroot word2 features) features))
  (set! syls (last (INST_LANG_lts_function (wordroot r2 features) features)))
  ;(format t "syls %l\n" syls)
  (set! s2 (append (list (append (list r1) (car (car (car syls))))) (list 0)))
  ;(format t "s2 %l\n" s2)
  (set! result (append s2 (cdr (car syls))))
        result)) 
  
                    

(provide 'INST_LANG_supra_lts)
