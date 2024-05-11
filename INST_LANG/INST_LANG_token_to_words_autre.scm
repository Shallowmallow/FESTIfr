; TODO heure, "23:54:12 h" 
; TODO date
; TODO guillemets crochets
; TODO perte ponctuation dans une phrase entre parenthèse
; TODO  1)  2) premièrement ou plus simple  1 pau 

(set! result t )
(defvar tokendebuglevel 20000)
(require 'INST_LANG_patternmatch); for pattern-matches

(defvar verbose_INST_LANG_token_to_word t)

; pour entre autre INST_LANG_homographs, INST_LANG_homographs1
; is_normal
;(require 'INST_LANG_token); commenté sinon ça boucle TODO
(require 'INST_LANG_numbers)

; for french_numbers_to_words 
(require 'INST_LANG_token_numbers_to_words)

; for french_parse* is_currency, french_parse_ordinal, etc.
(require 'INST_LANG_token_to_words_tools)
; for fre_abbr_* ; fre_unit_time_name; 
(require 'INST_LANG_token_to_words_lists)
(defvar cg::debug); could be clunits_debug !

(if cg::debug
    (defvar tokendebuglevel 1000)
    (defvar tokendebuglevel 0))
(set! debugQT t) ; pour débugger une QT en particulier
(defvar tokendebuglevel -1)

(defvar QT24 t)
(defvar QTpos1 t); fre_NAM_homo_tab ex: Marguerite |Duras|
(defvar QTpos2 t); |recherche|-moi -> recherche VER
(defvar QTpos3 t); tentative homo VER NOM par ex après adverbe de quantité, peu de ferment
(defvar QTpos2_pattern "{[^-]+}-{.*}")
(defvar QTpos2_suite t)
(defvar QTtim t)
(defvar QTtim_pattern "{[0-2]?[0-9]}{[.|:]}{[0-5][0-9]}"); (set!  QTtim_pattern "{[0-2]?[0-9]}{[:|.]}{[0-5][0-9]}")
(defvar QTono t)
(defvar QTtrad1 t); avant QT24
(defvar QTquoi t); sans bcp d'intérêt
(defvar QTletter t); lié à can_be_single_letter après QTloc3m, QTloc2m (pour éviter les a minuscules dans les locutions !) mais avant QT24
(defvar QTdel t); attention à l'ordre
(defvar QTdelp t); nécessaire suppression répétition occasionée par QTloc2m
(defvar QTdelp.p nil)
(defvar QTdelp.n t)
(defvar QTdelp.p.n t)
(defvar QTloc3m t) ; avant QTloc2m et donc avant .. QT24; :french_multiple_word_expressions2 2 tirets
(defvar QTloc2m t); avant QT24; :french_multiple_word_expressions (à renommer! TODO) ex "quelques_uns"; "quoi_que"; "red_river";  "roast_beef"; pe après QTrad1 si abréviation sous forme de locution TODO
(defvar QTbefapo t)
(defvar QTchefd )
(defvar QTparentho1 t)
(defvar QTparenthf1 t)
(defvar QTrom t); romains
(defvar QTrom_pattern "{[IVXLCM]+}")
(defvar QTromo t); romains ordinaux
(defvar QTromo_pattern1 "{[IVXLCM]+}{e}")
(defvar QTromo_pattern2 "{[IVXLCM]+}{ème}") ; TODO combiner
(defvar QTromo1) ; not QTromo not finished
(defvar QTdiglist t) ; liste de digits
(defvar QTdiglist_pattern "{[0]+}{[1-9][0-9]*}")
(defvar QTsplit t); ex pp.4 -> pp 4 pour pages 4 
(defvar QTsplit_pattern "{[A-Za-z]+}{\\.}{.*}")
(defvar QTsplit2 t); 33°
(defvar QTsplit2_pattern "{[0-9]+}{_o}{.*}")
(defvar QTnotinitblock t) 
(defvar QTstruc4 nil); erreur
(defvar QTstruc4-1 t); "499 121 456 790")
(defvar QTstruc3 t); first of 3 blocks |121| 456 790 ou 499 |121| 456 790 ?
(defvar QTstruc2 t)
(defvar QTacron t)
(defvar QTcurr t); avant QTletter
(defvar QTl1 t); lettre isolée non mot (après QTletter) après currency 1 £, après fre_abbr_with_point_tab ?  Rq 10 A après fre_unite_mesure_teststring2 ex 10 A ; après Rest Zahlen
; nécessite ex QT20? TODO QTcurr	 isoliert currencies ? |_pound sinon  
(defvar QTtypo1 t) ; bad typo ex 10kg; 10US$ ?
(defvar QTtypo1_pattern "{[0-9]+}{[A-Za-zÀÁÂÂÄÅÆÇÈÉÊËÌÍÍÎÏÑÒÒÔÖÙÚÜĀŒāàáâäåçeèéêëiìíñîïœòóôöuùúûü$]+}");
(defvar QTtim_pattern "{[0-2]?[0-9]}{[:|.]}{[0-5][0-9]}") 
(defvar QTb12 t) ; "QT43?\t épil.l... 
(defvar QTb12_pattern "{[A-Za-zÀÁÂÂÄÅÆÇÈÉÊËÌÍÍÎÏÑÒÒÔÖÙÚÜĀŒāàáâäåçeèéêëiìíñîïœòóôöuùúûü]+}{[0-9]+}")
(defvar QTurl t)
(set! QT)
(defvar RU) ; pas set sinon entre 2 appels successifs on perd la liste RU ? 
; à mettre à nil au niveau de notre SayText TODO


(define (INST_LANG_token_to_words token name)
  "Returns a list of words for NAME from TOKEN.  This allows the
  user to customize various non-local, multi-word, context dependent
  translations of tokens into words.  If this function is unset only
  the builtin translation rules are used, if this is set the builtin
  rules are not used unless explicitly called. [see Token to word rules]
  A few simple ad hoc solutions for the most common simple T2W-problems."
    ; It would be much nicer to use an external Perl text normalizer ?" ... pas sûr
    ; handles abbreviations,  numeral expressions such as phone numbers,
    ; ratios, dates, currencies, compounds of letters and digits, roman
    ; numbers, lines, scale units.
    ; on distingue les unités de temps et de devise pour une question d'ordre de lecture
    ; ou d'écriture 20 h 30 ; 30,50 Euros
 
    ; The TokenToWords UtteranceProcessor creates a word Relation from the
    ; token Relation by iterating through the token Relation Item list and
    ; creating one or more words for each token. 
    ; For most tokens there is a one to one relationship between words and
    ; tokens, in which case a single word Item is generated for the token item.

    ;  Other tokens, such as "2001" generate multiple words "two thousand one".
    ;  Each word is created as an Item and **added** to the word Relation.
    ;  **Additionally**, each word Item is added as a daughter to the corresponding token in
    ;  the token Relation. ref FreeTTS

    ; The main role of TokenToWords is to look for various forms of numbers
    ; and convert them into the corresponding (sic English) words. TokenToWords
    ; looks for simple digit strings, comma separated numerals (such as
    ; 1,234,567), ordinal values, years, floating point values, and
    ; exponential notation. TokenToWords uses the JDK 1.4 regular expression
    ; API to perform some classification. In addition a CART (Classification
    ; and Regression Tree) is used to classify numbers as one of: year,
    ; ordinal, cardinal, digits. (FreeTTs case  ?..)

  ; TODO pas de correction typo 12h 30  ni 12h (-> hecto ...)
  ; 21 h ; 21:30 h ; "20:30 h à 21 h"; 20:30 h à 21:30 h; 
  ; 23:54 min 
  ; NON pour 20:30 ou  20:30 à 21 h; 
  ; pb interference fre_abbr_unite_mesure_dim_tab  "23h 34min 52s"
  (tokendebug -1 (format nil "PREVIOUS TOKEN %s\n" (if (not (null? (item.prev token))) (begin (print (item.features (item.prev token) ))))))
  (tokendebug -1 (format nil "\t ACTUAL TOKEN: |%s|\n |%l|\n" name (item.features token)))
  (tokendebug -1 (format nil "<\t ===================\n\n"))
   (format t "parent %s" (item.feat token 'R:Token.parent.token_pos))
  
  (let 
    
    (word1 result fdnaw pos h1 h2 h3 h4 etat  suf1-1 suf1-2 n_name p_name l king queen ponc units cas tkp) ; /!\ best way to spoil everything  put (let (#1 #2 #3 #4) preventing to create them with pattern-matches ...
    (set! fdnaw (french_downcase_string name))
    (set! ponct (item.feat token 'punc ))
    (set! etat nil); -1 non vu; 0 vu non traité, 1 traité
    (set! cas nil)

    (cond 
    
     ((and
        QTtim ;  "{[0-2]?[0-9]}{[.|:]}{[0-5][0-9]")
        (pattern-matches name QTtim_pattern)
        (or (format t "QTtim: ok1: name %s\n" name) t)
        (set! h1 #1)
        (set! h2 #2)
        (set! h3 #3)
        (or (format t "QTtim: ok2 h1 %s h2 %s h3 %s\n" h1 h2 h3) t)
        (not (null? (item.next token)))
        (set! units (french_downcase_string (item.feat token "n.name")))
        (or (format t "QTtim units |%s|\n" units) t)
        
        (member_string (item.feat token "n.name") fre_unit_time_name)
        )
                
            (set! QT "QTtim")
            (set! RU (append RU (list QT )))
            
            (item.set_feat token "delete" "next")  ; AS don't say Uhr again
            (set! result
                        (append
                        (INST_LANG_number_point h1 1) ; heure minute féminin
                            (if  (string-matches units "heures\\|heure\\|h") '("heure")) ; pluriel identiques 23h 34min 52s
                            (if  (string-matches units "minutes\\|minute\\|min") '("minute")) ; pluriel identiques 23h 34min 52s
                            (if  (string-matches units "secondes\\|seconde\\|s") '("seconde")) ; pluriel identiques 23h 34min 52s
                            (if (not (equal? h3 "00")) (INST_LANG_number_point h3 1)'("zéro" "zéro"))
                            ;(if (member_string (item.feat token "nn.name") '("à" "-") ));
                            )))
    
       ((and 
            QTdelp.p.n
            (string-equal (item.feat token 'p.p.n_delete) "next"))
            
                (set! QT "QTdelp.p.n" )
                (set! RU (append RU (list QT )))
                (tokendebug -1 "QTdelp.p.n\n")
                (set! result))
      ((and 
            QTdelp.n
            (string-equal (item.feat token 'p.n_delete) "next"))
            
                (set! QT "QTdelp.n" )
                (set! RU (append RU (list QT )))
                (tokendebug -1 "QTdelp.n\n")
                (set! result)) 
                    
    
      ((and 
            QTdel
            (string-equal (item.feat token 'delete) "next"))
            
                (set! QT "QTdel" )
                (set! RU (append RU (list QT )))
                (tokendebug -1 "QTdel\n")
                (set! result))
                
      ((and (> tokendebuglevel -1)(format t "QTdelp ?\t |%s|\n" name)  nil))  
      ((and 
            QTdelp
            (string-equal (item.feat token 'p.delete) "next"))
            
                (set! QT "QTdelp" )
                (set! RU (append RU (list QT )))
                (tokendebug -1 "QTdelp\n")
                (set! result))

    
    
    

                
      ((and 
            QTdelp.p
            (string-equal (item.feat token 'p.p.delete) "next"))
            
                (set! QT "QTdelp.p" )
                (set! RU (append RU (list QT )))
                (tokendebug -1 "QTdelp.p\n")
                (set! result))                
      

              
           
              
     ; exemple de changement de POS

      ((and (> tokendebuglevel -1)(format t "QTpos3 ?\t |%s|\n" name)  nil)) 
      ((and ;
            QTpos3
            (not (null? (item.prev token))); peu de |ferment|
            (or (format t "QTpos3: ok1: name %s\n" name) t)
            ; (not (null? (item.prev (item.prev token))))
            ; TODO punc 
           ;; NON (equal? (item.feat token 'p.punc) 0);
            (or (format t "QTpos3: ok1_1: (item.feat token 'p.punc)  %l\n" (item.feat token 'p.punc)) t)
            (or (format t "prepunctuation %l\n" (item.feat token 'prepunctuation)) t);
            (equal?  (item.feat token 'prepunctuation) "")
             (or (format t "QTpos3: ok1_2 \n" ) t)
            (or (set! p.name (item.feat (item.prev token) "name")) t)
             (or (format t "QTpos3: ok2: p.name %s\n" p.name) t)
            (member_string p.name (list "de" "pour" "sans"))
            (or (format t "QTpos3: ok3: p.name %s\n" p.name) t)
            (member_string name list_homo_VER_NOM); vrai assez de ferment faux de vrais amis
            (or (format t "QTpos3: ok4: name %s\n" name) t)
            )
                (set! QT "QTpos3" )
                (set! RU (append RU (list QT )))
                (item.set_feat token 'pos "NOM");
                (set! result (list name)))
     
     ((and (> tokendebuglevel -1)(format t "QTpos1 ?\t |%s|\n" name)  nil)) 
      ((and ; fre_NAM_homo_tab homo non en tête de phrase avec typographie correcte sinon pas de correction :(
            QTpos1
            (not (null? (item.prev token))); ex: ; ex: M |Cheval|, Marguerite |Duras|
            (not (member_string (item.feat (item.prev token) 'punc ) (list "." "?" "!")))
            (is_cap (string-car name))
            (fre_abbr_lookup fdnaw fre_NAM_homo_tab))

                (set! QT "QTpos1" )
                (set! RU (append RU (list QT )))
                (item.set_feat token 'pos "NAM")
                (set! result (list name)))
                
      ((and (> tokendebuglevel -1)(format t "(lex.add.entry  ?\t |%s|\n" name)  nil)) 
      ((and ; 
            QTpos2
            (pattern-matches fdnaw QTpos2_pattern); {[^-]+}-{.*}; ne commence pas par un tiret mais en contient 1
            ;(set! pvars (list #1 #2)
            (and (set! h1 #1)(set! h2 #2))
            (not (equal? h1 ""))
                        (or ( format t "QTpos2 h1 3 _%s_, h2 _%s_\n" h1 h2) t) ; ex h1 _n_est_, h2 _ce_
            (member_string h2 list_after_tiret)
                        (or ( format t "QTpos2 h1 4 _%s_, h2 _%s_\n" h1 h2) t)
            
                ) 

                (set! QT "QTpos2" )
                (set! RU (append RU (list QT )))
                (set! suf1-1 (string-last h1)) 
               ; (item.set_feat (item.next token) 'token_pos "PRO:per")
             ;;  (format t "liste %l \n" (item.relation.leafs token 'Token)); (#<item 0x55c329c93bc0>) 
             ;; (item.first_leaf ITEM)   Returns he left most leaf in the tree dominated by ITEM. ..
           ;; (format t "leaf %s"  (na (item.first_leaf token))); n_est-ce
               ;; (format t "liste %l" (item.relations token)); Token
               (item.set_feat token "token_pos" "QTpos2")
                (if (and (member_string suf1-1 (list "t" "s"))
                         (member_string (string-car h2 ) (list "e" "i" "o" "y"))); ex: vous-y reviendrez / elles-même
                      (begin 
                        (set! result (append (INST_LANG_token_to_words token h1) 
                                             (INST_LANG_token_to_words token (if (string-equal suf1-1 "t")(string-append "t_" h2 )(string-append "z_" h2 ))))))
                      (begin ; ex ; ex h1_n_est_, h2 _ce_
                        (set! result (append (INST_LANG_token_to_words token h1)(INST_LANG_token_to_words token h2) )))))


      ((and (> tokendebuglevel -1)(format t "QTpos2_suite ?\t |%s|\n" name)  nil)) 
      ((and ; 
            QTpos2
            QTpos2_suite
                   (item.prev token)
                   (or (format t "QTpos2_suite ok1\n") t)
                   (item.set_feat (item.prev token) "token_pos" "QTpos2")
                   )
                   
                (set! QT "QTpos2_suite" )
                (set! RU (append RU (list QT )))
                (if (member_string name (list "le" "la" "les"))
                    (item.set_feat token 'pos "ART:def")
                    (if (member_string name (list "de" "des"))
                        (item.set_feat token 'pos "ART:ind")))
                (set! result (list name))
                )  
                        
       ((and (> tokendebuglevel -1)(format t "QTtrad1 ?\t |%s|\n" name)  nil))
       ((and ; fre_abbr_with_point_tab ex  ("apr" "après")  ("apr._J.-C" "après" "jésus" "christ") ("arch" "archives") ("archéol" "archéologie")
              QTtrad1
              (string-equal ponct ".")
              (set! uebersetzung (fre_abbr_lookup name fre_abbr_with_point_tab))); ex archéol. -> archéologie archeol->nil
                   (set! QT "QTtrad1" )
                   (set! RU (append RU (list QT )))
                   (set! result uebersetzung))
                   
        ((and (> tokendebuglevel -1)(format t "QTtypo1?\t bad typo 10kg and alike ?\t %s\n" name)  nil)); ex QT38
        ( ;  bad typo 10kg  Question TODO  10L Lire ou litre ? ou L majuscule ?
         (and 
            QTtypo1
            (pattern-matches name QTtypo1_pattern)
          
            (set! h1 #1)
            (set! h2 #2)
            (not (string-equal h1 "")); non on traite aussi $US seul
            (or (format t "_h1_: _%s_ _h2_: _%s_\n" h1 h2) t)
            (not (string-equal h2 ""))

            )

            
                (set! QT "QTtypo1" )
                (set! RU (append RU (list QT )))
                (item.set_feat token "token_pos" "cardinal")
                (cond
                    ((member_string h2 french_currency)
                      (set! h2 (fre_abbr_lookup h2 fre_abbr_currency_tab))
                      (if (string-equal h1 "")
                          (set! result h2)
                          (set! result (append (french_numbers_to_words token h1) h2))))
                    ((pattern-matches h2 fre_unite_mesure_teststring)
                          (set! h2 (append (fre_abbr_lookup #1 fre_abbr_unite_mesure_dim_tab)
                                          (fre_abbr_lookup #2 fre_abbr_unite_mesure_tab)))
                          ;(item.set_feat token "token_pos" "masseinheit")
                          (set! result (append (french_numbers_to_words token h1) h2)))
                    ((and (string-matches h2 fre_unite_mesure_teststring2)
                          ; Hausnummern u.ä.
                          ; (not (string-matches h2 "[a-cA-C]"))) Angström, Coulomb
                          (set! h2 (fre_abbr_lookup #2 fre_abbr_unite_mesure_tab))
                          (item.set_feat token "token_pos" "masseinheit")
                          (set! result (append (french_numbers_to_words token h1) h2))))
                    (t
                    (format t "FRENCH NUMBERS")
                    (set! result  (append (french_numbers_to_words token h1) (french_parse_charlist h2 1))) )))                   

                    
        ((and (> tokendebuglevel -1)(format t "QTnotinitblock?\t ?\t %s\n" name)  nil))
        ((and
             QTnotinitblock
            (string-matches name "[0-9][0-9][0-9]")
            (or (string-equal (item.feat token "p.token_pos") "card_struc")
                 (and
                   (string-equal (item.feat token "pp.token_pos") "card_struc")
                   (string-matches (item.feat token "p.name") "[0-9][0-9][0-9]"))
                  (and
                   (not (null (item.prev token)))
                   (string-equal (item.feat (item.prev token) "pp.token_pos")"card_struc")
                   (string-matches (item.feat token "p.name") "[0-9][0-9][0-9]")
                   (string-matches (item.feat token "pp.name") "[0-9][0-9][0-9]"))))

                (set! QT "QTnotinitblock" )
                (set! RU (append RU (list QT )))
                (tokendebug -1 "### nicht-initialer Block\n")
                nil)

      ((and (> tokendebuglevel -1)(format t "QTstruc4?\t four blocks ? |%s|\n" name)  nil))
      
          ; four blocks
    ((and 
          QTstruc4-1
          (string-matches name "[1-9][0-9]?[0-9]")
          (string-matches (item.feat token "n.name") "[0-9][0-9][0-9]")
          (string-matches (item.feat token "nn.name") "[0-9][0-9][0-9]")
          (and (not (null (item.next token)))
               (string-matches (item.feat (item.next token) "nn.name")
                 "[0-9][0-9][0-9]"))
          (equal? (item.feat token "punc") 0)
          (equal? (item.feat token "n.punc") 0)
          (equal? (item.feat token "nn.punc") 0)
          (not (string-equal (item.feat token "token_pos") "phonenumber"))
          (not (string-equal (item.feat token "token_pos") "dezimalbruch"))
          (string-equal (item.feat token "n.prepunctuation") "")
          (string-equal (item.feat token "nn.prepunctuation") "")
          (string-equal (item.feat (item.next token) "nn.prepunctuation") "")
          (string-equal (item.feat token "n.whitespace") " ")
          (string-equal (item.feat token "nn.whitespace") " ")
          (string-equal (item.feat (item.next token) "nn.whitespace") " "))
               (set! QT "QTstruc4-1")
                (set! RU (append RU (list QT )))
                (tokendebug 1 "### erster von 4 Blöcken\n")
                (item.set_feat token "token_pos" "card_struc")
                (french_parse_cardinal
                    (string-append
                      name
                      (item.feat token "n.name")
                      (item.feat token "nn.name")
                      (item.feat (item.next token) "nn.name"))))
      
      
      ((and QTstruc4
            (string-matches name "[1-9][0-9]?[0-9]")
            (string-matches (item.feat token "n.name") "[0-9][0-9][0-9]")
            (string-matches (item.feat token "nn.name") "[0-9][0-9][0-9]")
            (and (not (null? (item.next token)))
                (string-matches (item.feat (item.next token) "nn.name")
                  "[0-9][0-9][0-9]"))
            (equal? (item.feat token "punc") 0)
            (equal? (item.feat token "n.punc") 0)
            (equal? (item.feat token "nn.punc") 0)
            (not (string-equal (item.feat token "token_pos") "phonenumber"))
            (not (string-equal (item.feat token "token_pos") "dezimalbruch"))
            (string-equal (item.feat token "n.prepunctuation") "")
            (string-equal (item.feat token "nn.prepunctuation") "")
            (string-equal (item.feat (item.next token) "nn.prepunctuation") "")
            (string-equal (item.feat token "n.whitespace") " ")
            (string-equal (item.feat token "nn.whitespace") " ")
            (string-equal (item.feat (item.next token) "nn.whitespace") " "))
            
                (set! QT "QTstruc4")
                (set! RU (append RU (list QT )))
                (tokendebug 3 "### erster von 4 Blöcken\n")
                (item.set_feat token "token_pos" "card_struc")
                (item.set_feat token 'delete  "next")
                (set! result (french_parse_cardinal 
                    (string-append
                      name
                      (item.feat token "n.name")
                      (item.feat token "nn.name")
                      (item.feat (item.next token) "nn.name")))))
      ; ))))
      ((and (> tokendebuglevel -1)(format t "QTstruc3 ? ex QT10?\t first of 3 blocks 152 367 ? |%s|\n" name)  nil)) 
      ((and QTstruc3
            (string-matches name "[1-9][0-9]?[0-9]?") 
            (string-matches (item.feat token "n.name") "[0-9][0-9][0-9]")
            (string-matches (item.feat token "nn.name") "[0-9][0-9][0-9]")
            (equal? (item.feat token "punc") 0)
            (equal? (item.feat token "n.punc") 0)
            (not (string-equal (item.feat token "token_pos") "phonenumber"))
            (not (string-equal (item.feat token "token_pos") "dezimalbruch"))
            (string-equal (item.feat token "n.prepunctuation") "")
            (string-equal (item.feat token "nn.prepunctuation") "")

            (string-equal (item.feat token "n.whitespace") " ")
            (string-equal (item.feat token "nn.whitespace") " "))
        
                (tokendebug -1 "### erster von 3 Blöcken\n")
                (set! QT "QTstruc3")
                (set! RU (append RU (list QT )))
                (item.set_feat token "token_pos" "card_struc")
                (item.set_feat token 'delete  "next")
                (set! result (french_parse_cardinal
                    (string-append
                        name
                        (item.feat token "n.name")
                        (item.feat token "nn.name")))))

      ((and (> tokendebuglevel -1)(format t "QT11?\t first of 2 blocks ? |%s|\n" name)  nil)) 
      ((and QTstruc2
            (string-matches name "[1-9][0-9]?[0-9]?")
            (string-matches (item.feat token "n.name") "[0-9][0-9][0-9]")
            (equal? (item.feat token "punc") 0)
            (not (string-equal (item.feat token "token_pos") "phonenumber"))
            (not (string-equal (item.feat token "token_pos") "dezimalbruch"))
            (not (string-equal (item.feat token "token_pos") "Bankleitzahl"))
            (equal? (string-matches (item.feat token "n.prepunctuation") 0))
            (string-equal (item.feat token "n.whitespace") " "))

                (set! QT "QTstruc2")
                (set! RU (append RU (list QT )))
                (tokendebug -1 "### erster von 2 Blöcken\n")
                (item.set_feat token "token_pos" "card_struc")
                (format t "n.name _%s_" (item.feat token "n.name"))
                (item.set_feat token 'delete  "next")
                (set! result (french_parse_cardinal (string-append name (item.feat token "n.name")))))


      ; ))))

  

      ((and (> tokendebuglevel -1)(format t "QTdiglist?\t digits list ? |%s|\n" name)  nil))
      ((and 
        QTdiglist
        ;(not (string-equal name ""))
         (pattern-matches name QTdiglist_pattern))

              (set! QT "QTdiglist" )
              (set! RU (append RU (list QT )))
              (set! h1 #1)(set! h2 #2); ex 00 56; ex 3
              ;(not (equal? (item.feat token 'punc) ",")) ; hyp
              (format t "QTdiglist !!! \t  h1 |%s| h2 |%s| ?\n" h1 h2);  h1 |00| h2 |56| ?; ex h1 "" h2 "3" ou  h1 || h2 |61| ? 61 années
              (set! n_name  (na (item.next token))); 
              (format t "QTdiglist !! n_name %l" n_name)
              (item.set_feat token "token_pos" "cardinal")
              (if (and  (string-equal h1 "")(is_quantifiable_fem n_name))(set! fem 1)(set! fem 0))
              (if (not (string-equal h1 "")); leading zeros
                      (set! result 
                          (append
                             (french_parse_charlist h1 0); alle nullen werden ausgesprochen ("zéro" "zéro" "zéro")
                             (french_parse_cardinal h2 )
                             (if (string-equal (item.feat token 'punc) ",") (list "virgule"))))
                      (set! result 
                          (append
                             (INST_LANG_number h2 fem)
                             (if (string-equal (item.feat token 'punc) ",") (list "virgule"))
                             ;(not (string-equal (na (item.feat (item.next token))) 'whitespace) " ")
                             ))))

     ((and (> tokendebuglevel -1)(format t "QTrom?\t simple roman numeral... ? |%s|\n" name  )  nil))
      ; Rq avant length_utf8 pour Napoléon I
      ; Rq avant normal pour xxvi
      ; Rq Roman numerals before acronyms ... ?
      ; sans se soucier  XXVIV ->29 XXMIV-> 1019  

      ; TODO taille XXL ...extra large XML 
      ; roman ; Rq avant élision pour une question de whitespace
      ; ))))      
      ((and
          QTrom
          ; (string-matches name "[ivxlcm]+") trop de pbs est *il ici*
          (or  (string-matches name "[IVXLCML]+") nil)
          (not (string-matches (item.feat token "whitespace") " *'"))
          ; (not (null? (item.prev token))) punc

          (equal? (item.feat token 'p.punc) 0) ; Xex scène, aborde-t-il ?
          (and  
              (or (null? (item.next token)) 
                  ;(not (equal? (item.feat (item.next token) 'pos) "NAM")))) ; L'
                 
               ; pas seulement (not (string-equal (item.feat (item.next token) 'pos)) "NAM")))
                (not (string-equal (item.feat token 'n.whitespace) "'")) ; L'histoire dit .
               ))
          (or 
              (set! p_name  (na (item.prev token))) 
              (set! king (member_string (french_downcase_string p_name) french_king_name))
              (set! queen (member_string (french_downcase_string p_name) french_queen_name))
              (or (member_string (french_downcase_string p_name) tok_section_name_cardinal))))
            
                (tokendebug -1 "---Roemische Zahl\n")
                (set! QT "QTrom" )
                (set! RU (append RU (list QT )))
                ;(format t "king %s" (not (null? king)))
                (cond
                    ((and (string-equal name "I")
                    (if king (set! result (list "premier")) (if queen (set! result (list "première")) (set! result (list "un"))))))
                    (t
                      (tokendebug -1 (format nil "roman cas général %s %s\n" name (na token)))
                      (set! result (french_parse_cardinal(fre_tok_roman_to_numstring (upcase name)))))
                    ))            
       
       ((and (> tokendebuglevel -1)(format t "QTromo?\t pis aller ordinal roman? whitespace |%s|\n n.prepunctuation |%s|\n equal %s\n" (item.feat token 'whitespace) (item.feat token "n.prepunctuation") (not (string-matches (item.feat token 'whitespace) " *")))  nil))
       ( ; ordinal roman
        ; Rq avant élision pour une question de whitespace Le 
        (and 
          ; non Ce serviteur (or (pattern-matches name QTromo_pattern1) (pattern-matches name QTromo_pattern2))
            (or (format t "ok1") t)
            (set! h1 #1)
            (set! h2 #2);

            (not (string-equal h1 ""))
            (or (format t "ok11") t)

            (not (string-equal h2 ""))
            (not (string-equal (item.feat token 'prepunctuation) "(")) ; Xex: (Le Monde)
            ;(not null? (item.next token))
            (or 
                (format t "ok12")
                (null? (item.next token))
                (and (item.next token)
                    (not (is_cap (string-car  (item.feat (item.next token) 'name) )))); Xex le Peletier
                (format t "ok13")
                (and    (not (null? (item.next token)))
                        (or (equal? (item.feat token 'punc) 0); XXe arrondissement /dans le XXe. /le XXe (bla bla)
                          (equal? (item.feat token 'n.prepunctuation) 0))
                        (not (equal? name "Ce"))  ; TODO
                        (not (equal? name "Le"))  ; TODO pe. une condition en NAM ou obligation de déclarer Le_Peletier en expression ?
                          )
                (format t "ok14")                        
                (or (and QTromo1 
                        (null? (item.prev token)); Xex : Le
                        (equal? (item.feat token 'p.punc) 0)
                        (or (set! RU (append RU (list "QTromo1"))) t)
                        ))  
                (format t "ok15")                        
                (and (not (null? (item.prev token)))  (not (equal? name "Le"))   ) ; approx.
                (format t "ok2")
            ))
                
                (set! QT "QTromo1" )
                (set! RU (append RU (list QT )))
                (tokendebug -1 (format nil "%s pattern:%s %s" name h1 h2))
                    ; to make it simple in fact Xe is the correct form quick and very dirty !
                (set! result (french_parse_ordinal (fre_tok_roman_to_numstring h1) 1)))
       
                   
       ((and (> tokendebuglevel -1)(format t "QTono ?\t |%s|\n" name)  nil))
       ((and ; Oust ! Gloups !; TODO doublon blabla blabla ! , ah ah ! un seul point d'exclamation (good typo)
            QTono
            (string-equal ponct "!")
            (member_string (french_downcase_string name) fre_ONO_homo))
                (set! QT "QTono" )
                (set! RU (append RU (list QT )))
                (item.set_feat token 'pos "ONO")
                (set! result (list name)))
                
       ((and (> tokendebuglevel -1)(format t "QTquoi ?\t |%s|\n" name)  nil))
        ((and
            QTquoi  
            (string-equal ponct "?")
            (member_string fdnaw (list "quoi" "qui" "comment")))
                (set! QT "QTquoi" )
                (set! RU (append RU (list QT )))
                (item.set_feat token 'pos "PRO:int")
                (set! result (list name)))

         ((and (> tokendebuglevel -1)(format t "QT16-1?\t locution 3 ? |%s|\n" name)  nil))  
         (( ; locution pour l'instant 2 ou 3 mots listes dans INST_LANG_token_to_words_lists
             ; on commence par 3 french_multiple_word_expressions2
             ; (pour la mise au point de la prononciation (s'entend avant introduction dans LE dico, si possible on utilisera de préférence 
             ; addenda_locutions.scm et addenda_foreign.scm mias .;. , la prononciation n'est pas le pb ici
             ; même si on peut introduire une locution pour une raison de prononciation ex nuit et jour
            and ; locution
              QTloc3m
              (or (format nil "locution QTloc3m: ok00\n") t)
              (set! n_name (na (item.next token))) ; au pire nil & out
              (set! n_n_name (na (item.next (item.next token)))) ; au pire nil & out
              (or (format t "locution QTloc3m: ok0\n") t)

              (equal? (item.feat token 'punc) 0); TODO quid des preponctuations ?
             (equal? (item.feat (item.next token) 'punc) 0); en moins, de 
             (equal?  (item.feat (item.next token) "prepunctuation") "")
             
              
              

              (or (format t "locution QTloc3m: ok1\n") t)
              (set! name1 (string-append name "_" n_name "_" n_n_name))
              (or (format t "locution QTloc3m: ok2 name1 |%s| \n" name1) t)
              (member_string (french_downcase_string name1) french_multiple_word_expressions2)

              )

                (set! QT "QTloc3m" )
                (set! RU (append RU (list QT )))
                (set! result (list name1))
                (item.set_feat token 'punc (item.feat (item.next (item.next token)) 'punc ) ); transfert de ponctuation du dernier vers le premier
                (item.set_feat token 'delete  "next"); marquage pour suppression du suivant: on y cherchera p.delete
                (item.set_feat (item.next token) 'delete  "next")
                
                )

      ((and (> tokendebuglevel -1)(format t "QTloc2m ex QT16-2?\t locution 2 ? |%s|\n" name)  nil))  
      ( ; locution 2 mots 
        ; liste dans INST_LANG_token_to_words_lists :french_multiple_word_expressions
        ; "vingt_cinq"  "wait_and_see" "way_of_life" à jeun
        ; ex à jeun : à_jeun POS ADV dans freeling 
        ; et éventuellement prononciation de à_jeun  dans dico
      
        (and ; locution
          QTloc2m
          (or (format t "locution: ok0\n") t)
          (equal? (item.feat token 'punc) 0); pas de ponctuation entre le premier et le suivant TODO prepunctuation !
          
          (or (format t "locution: ok1\n") t)
          (set! n_name (na (item.next token))) ; au pire nil & out

          (or (format t "locution: ok2 n_name |%s|\n" n_name) t)
          
          ; (set! n_n_name (na (item.next (item.next token)))) ; au pire nil & out
          ;(or (if verbose_INST_LANG_token (format t "locution: ok3 n_name |%s|\n" n_n_name)) t)

          (set! name1 (string-append (string-replace name "-" special_slice_char) "_" n_name)); chef-d passe à chef_

          (member_string (french_downcase_string name1) french_multiple_word_expressions))

                (set! QT "QTloc2m" )
                (set! RU (append RU (list QT )))
                            (format t "vérif locution: ok3 name1 |%s|\n" name1)
                (item.set_feat token 'punc (item.feat (item.next token) 'punc ) ); transfert de ponctuation du dernier vers le premier
                (item.set_feat token 'delete  "next"); marquage pour suppression du suivant: on y cherchera p.delete
                (set! result (list name1))) 

      ((and (> tokendebuglevel -1)(format t "QTbefapo?\t essai élision à venir ? |%s|\n" name)  nil))  
      (
       (and QTbefapo
          (member_string (french_downcase_string name) list_before_apo )
          ; (equal? (item.feat token 'punc) 0)
          (not (null? (item.next token)))
          (set! n_name (na (item.next token)))
          (or (format t "QTbefapo n_name %s\n" n_name) t)
          
          (string-equal (item.feat token 'n.whitespace) "'"))

            (set! QT "QTbefapo")   ; le |m| de mintéresse pas à l'as
            (set! RU (append RU (list QT )))
            (set! name1 (string-append name "_" n_name))
            (item.set_feat (item.next token) 'name name1)
            (if (is_in_poslex n_name)
              (item.set_feat (item.next token) 'pos (symbol->string (caar (is_in_poslex n_name)))  )); suppose de l'ordre ! 
            (item.set_feat (item.next token) 'whitespace ""))

         ( ; currencies
            (and  
                QTcurr
                (is_currency name)
                (not (null? (item.prev token))); Xex: L'
                ; (not (string-equal (item.feat token "n.whitespace") "'"))
                (string-equal (item.feat (item.prev token) 'token_pos) "cardinal")
                (or (format t "4 %s\n" (and (not null? (item.next token)) (not (string-equal (item.feat (item.next token) 'pos) "NAM")))) t)
                )
                    (set! QT "QTcurr" )
                    (set! RU (append RU (list QT )))
                    (tokendebug -1 "---devise seule\n")
                    (item.set_feat token "token_pos" "curry")
                    ; (item.set_feat token 'pos "NOM") ; pour L de Lire aussi ART:def
                    (set! QT "QTcurr" )
                    (set! result (french_fetch_currency2 name)))

          ((and (> tokendebuglevel -1)(format t "QTletter?\t  word can_be_single_letter?\t %s\n" name)  nil))
          ((and
            QTletter
           (can_be_single_letter (french_downcase_string name))
            (not (string-equal (item.feat token 'punc ".") ".")) ; excluant M.
            (if (null? (item.next token)) t (not (string-equal (item.feat token 'n.whitespace) "'")); QT 36 avant !!
            ; excluant l de l'autre (puisque c'est *autre* porte la preponctuation)
            ))
                (set! QT "QTletter" )
                (set! RU (append RU (list QT )))
                (if (not (string-equal (item.feat token 'n.whitespace) "'"))
                    (set! result (list name))
                    (set! result (list "zut"))
                    ))

      ((and (> tokendebuglevel -1)(format t "QT23?\t suite acronym ? ANTEN'J\n")  nil))
      ((and
            QTacron
            (string-matches name "[A-Z]+")
           
           ; (equal? (item.feat token 'p.token_pos) "acronym")
           )
            
                (set! QT "QTacron" )
                (set! RU (append RU (list QT )))
                (set! result (if (spell_acronym name)(french_parse_charlist name 0)(list (french_downcase_string name)))))

 ((and (> tokendebuglevel -1)(format t "QT47?\t b12 |%s|\n" name)  nil))
      ( (and
            QTb12
            (pattern-matches name QTb12_pattern)
            (set! h1 #1)(set! h2 #2)
            (not (string-equal h1 "")) 
            (not (string-equal h2 "")))
                (set! QT "QTB12")
                (set! RU (append RU (list QT )))
                (if (equal? (string-length_utf8 name) 1)
                    (begin 
                        (item.set_feat token 'pos "NOM")
                        (set! result (append (list name)  (french_parse_cardinal_with_0 h2)))
                    )

                    (set! result (append (INST_LANG_token_to_words token h1)  (french_parse_cardinal_with_0 h2)))))


((and (> tokendebuglevel -1)(format t "QTurl ex QT41? \t url... ?\n")  nil))
        ;     // substituting into a string based on a regular expression
        ; EST_String source("http://www.cstr.ed.ac.uk/speech_tools");
        ; EST_Regex url_re("\\([a-z]*\\)://\\([^/]*\\)\\(.*\\)");
        ; EST_String target("protocol=\\1 host=\\2 path=\\3 dummy=\\6");
      ((or (string-matches name ".*tp://.*")
            (string-matches name ".*tps://.*")
            (string-matches name ".*www\\..*")
            (string-matches name ".*ftp\\..*")
            (string-matches name ".*ftps\\..*"))

                (set! QT "QTurl")
                (set! RU (append RU (list QT )))
                (item.set_feat token "token_pos" "URL")
                (let ((help_list nil))
                    (mapcar
                      (lambda (x)
                        (set! help_list (append help_list (INST_LANG_token_to_words token x))))
                        (url->list_french name))
                    (set! result help_list)))
                    
                    
                                                    
      ((and (> tokendebuglevel -1)(format t "QT24?\t normal ?: |%s|\n" name)  nil) nil); condition jamais remplie 
      ((and 
          QT24
          (set! fdnaw (french_downcase_string name))
          (is_normal fdnaw))

         (set! QT "QT24")
         (set! RU (append RU (list QT )))
         (set! ponct (item.feat token 'punc ))
         (if (not (null?  (item.prev token)))
              (if verbose_INST_LANG_token_to_word (format t "prev %s\n" (item.feat (item.prev token) 'name))))
         (cond 
            ; pour régler le pb de où va-t'on qui donne actuellement va_t on et non va_t_on chef d'ilôt
            ((and
                QTchefd
                (string-equal (item.feat token 'n.whitespace) "'"))
                    (set! QT "QTchefd")
                    (set! RU (append RU (list QT )))
                    (set! name1 (string-append (string-replace name "-" special_slice_char) "_" n_name)); chef-d passe à chef_
                    (item.set_feat token 'delete  "next"); sinon au final va_t_il il 
                    (set! result (list name1)))
            ((and ; ex de petite \( mais ancienne\) noblesse"
                 QTparentho1
                 ;(string-equal (item.feat token 'prepunctuation) "("))
                 (set! preponc (item.feat token 'prepunctuation))
                 (or (format t "ok") t)
                 (member_string preponc (list "(" "\\\"" "|" )))
                     (set! QT "QTparentho1")
                     (set! RU (append RU (list QT )))
                     (set! ponc (item.feat token 'punc) )
                     (if (string-equal preponc "(" )
                         (if (string-equal ponc ")")
                             (set! result (append (fre_abbr_lookup "(" fre_symbols_tab_default  ) (list name ) (fre_abbr_lookup ")" fre_symbols_tab_default )))
                             (set! result (append (fre_abbr_lookup "(" fre_symbols_tab_default  ) (list name ))))
                         (if (string-equal preponc "[" )
                             (if (string-equal ponc "]")
                                 (set! result (append (fre_abbr_lookup "[" fre_symbols_tab_default  ) (list name ) (fre_abbr_lookup "]" fre_symbols_tab_default )))
                                 (set! result (append (fre_abbr_lookup "[" fre_symbols_tab_default  ) (list name ))))
                             (if (string-equal preponc "\\\"" )
                                 (if (string-equal ponc "\\\"")
                                     (set! result (append (fre_abbr_lookup "\\\"" fre_symbols_tab_default  ) (list name ) (fre_abbr_lookup "\\\"" fre_symbols_tab_default )))
                                     (set! result (append (fre_abbr_lookup "\\\"" fre_symbols_tab_default  ) (list name )))))
                                 
                                 ))
                     )
            ((and (> tokendebuglevel -1)(format t "QTparenthf1?\t normal ?: |%s| %s\n" name (item.feat token 'punc))  nil) nil);     
            ((and ; ex de petite \( mais ancienne\) noblesse"
                 QTparenthf1
                 (string-equal (item.feat token 'punc) ")")); |ancienne| porteur de la ponctuation punc ")" 
                     (set! QT "QTparenthf1")
                     (set! RU (append RU (list QT )))
                     (set! result (append (list name) (fre_abbr_lookup ")" fre_symbols_tab_default  ) ))
                 )
         
           

            
            (t  
              (tokendebug -1 (format nil "ok5 normal no punc point %s\n" name))
              ; récalcitrant
              (if (string-equal fdnaw "n_en")
                  (item.set_feat token 'pos "PRO:per"))
              ; (if (and ; aigrefeuille-d'aunis
              ;          nil
              ;          (pattern-matches name "{[^-]+}-{d}")
              ;          (set! nt (item.next token)) ; not nil
              ;          ;(member_string (item.feat token 'n.pos) (list "NOM"))
              ;          ;(or (format t "3333 |%s|"(item.feat nt 'whitespace)) t)
              ;          (equal? (item.feat nt 'whitespace) "'"))
              ;     (begin 
              ;       (set! name (string-append name "_" (na nt)))
              ;       (item.set_feat nt "name" "")
              ;       ))
              (set! QT "QT24" )(set! result (list (string-replace name "-" special_slice_char)))) ; hmm
            ))    ; 20/04

; ))))


      ; point intérieur
      ; avec interprétation de la faute de typographie pp.4 au lieu de  pp. 4; pas plus
      ; ex projet.En revanche 
      ((and (> tokendebuglevel -1)(format t "QTsplit to be split ?\t |%s|\n" name)  nil))
      (( and 
            QTsplit
            ; le cas ; et , sont gérés par norm
             (or (set! h3) t); on prévoit blabla? ou regarde punc ou on place la règle en dernier 
             (pattern-matches name QTsplit_pattern)
             (set! h1 #1)
             ; (not (string-equal h1 ""))
             (or (format t "h1 %s\n" h1) t)
             (set! h2 #2)
             (not (string-equal h2 ""))
             (or (format t "h1 %s h2 %s\n" h1 h2) t))
                (set! QT "QTsplit")
                (set! RU (append RU (list QT )))
                (set! h3 #3)
                (format t "h3 %s\n" h3)
                ;(set! poncsupp (string-car h2))
                    (begin 
                      (item.set_feat token 'name h1)
                      (item.set_feat token 'punc ".")
                      (set! result (append (INST_LANG_token_to_words token h1) (append (INST_LANG_token_to_words token (string-cdr h2))) (append (INST_LANG_token_to_words token h3))))
                      )
                    )
     ((and (> tokendebuglevel -1)(format t "QTsplit2 to be split ?\t |%s|\n" name)  nil))
      (( and 
            QTsplit2
            ; ° -> norm _o ; £ -> _pound ;  33°
             (or (set! h3) t); on prévoit blabla? ou regarde punc ou on place la règle en dernier 
             (pattern-matches name QTsplit2_pattern)
             (set! h1 #1)
             ; (not (string-equal h1 ""))
             (or (format t "h1 %s\n" h1) t)
             (set! h2 #2)
             (not (string-equal h2 ""))
             (or (format t "h1 %s h2 %s\n" h1 h2) t))
                (set! QT "QTsplit2")
                (set! RU (append RU (list QT )))
                (set! h3 #3)
                (format t "h3 %s\n" h3)
                (set! poncsupp (string-car h2))
                    (begin 
                      (item.set_feat token 'name h1)
                     ; (item.set_feat token 'punc ".")
                      (set! result (append (INST_LANG_token_to_words token h1) (append (INST_LANG_token_to_words token h2)) ))
                      )
                    )
                    
                    
                    
                    
       ; redondance partielle avec missed  ° french_parse_charlist 
       ; après fre_abbr_with_point_tab
        ((and 
            QTl1
            (equal? (string-length_utf8 name) 1)
            (not (string-equal (item.feat token "prepunctuation") ""))
        (not (equal? (item.feat token 'R:Token.parent.token_pos) "curry"))  ; pas de Lire
        ;(not (string-matches name "[0-9]")) ; no digit
            (null? (item.feat token 'punc)) ; l. M. 
        (not (equal? (item.feat token 'n.whitespace) "'")) ; pas de n' d'
        );  
            (set! QT "QTl1")
             (item.set_feat token 'pos "NOM")
              (set! QT "QTl1" )(set! result (list name)))
                        
                      
                             
      ((and (> tokendebuglevel -1)(format t "missed ?\t |%s|\n" name)  nil))
        (t ; missed
            (or (format t "missed %s\n" name) t)
            ;(set! missed t)
            (set! QT "QTmis")
            (set! RU (append RU (list QT )))
            (if (and (not (string-equal name "")) (not (equal? (item.feat token 'pos) "LIA")))
                  (begin 
                    (set! QT "QT100" )
                    (set! result (remove_last (french_parse_charlist name 1))); essai pb nil . SENT Copyright NOM . SENT nil NAM

            )))
            )

        result))


(provide 'INST_LANG_token_to_words)
