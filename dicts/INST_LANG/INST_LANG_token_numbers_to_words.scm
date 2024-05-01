(set! debugfrom "from INST_LANG_token_numbers_to_words\n")
(require 'INST_LANG_patternmatch); for pattern-matches

;  (memv 'no (check_pronunciation h2) ?
(define memv
  (lambda (x ls)
    (cond
      ((null? ls)
        nil)
      ((eqv? (car ls) x)
        ls)
      (t
        (memv x (cdr ls))))))
 
;  Ier : 
; tokenizer externe XIXème siècle -> le XIXe siècle

(define (marktokendebug liste)
  (format t "tokendebug %l" liste))

(define (french_numbers_to_words token name)
  "(french_numbers_to_words token name) this function deals (hopefully) 
   with tokens beginning with a number. It returns a list of words.
   (blocks of three, compositions of digits and letters, years, dates, 
   clock time, numbers with comma, numbers with period, ordinal numbers, 
   cardinals with leading zeros, numbers in blocks of three with periods, 
   no currencies.)"
  (let (h1 h2 h3) 
    (cond
      ; numbers with comma separator
      ((and (> tokendebuglevel -1)(format t "QN1?\tcomma separator ?\n")  nil))
      (
        (pattern-matches name "{[1-9][0-9]*},{[0-9]+}")

          (tokendebug -1 (format nil "### Kommazahl comma separator _%s_ \n" name)) 
          (item.set_feat token "token_pos" "dezimalbruch") ; nombre décimal
          (set! h1 #1)
          (set! h2 #2)

          (append (french_parse_cardinal h1)
                  (list "virgule")
                  (french_parse_cardinal h2)))
; ))))
      ((and (> tokendebuglevel -1)(format t "QN1?\tcomma separator 0,XXX ?\n")  nil))
      ((pattern-matches name "{0},{[0-9]+}")
        (tokendebug -1 (format nil "### Kommazahl mit Null vor Komma _%s_ \n" name)) 

        (item.set_feat token "token_pos" "dezimalbruch")
        (append (french_parse_cardinal #1)
                (list "virgule")
                (french_parse_charlist (symbol->string #2) 0)))

      ((and (> tokendebuglevel -1)(format t "QN1_1?\t Kommazahl mit Null vor Komma ?\n")  nil))
      ((and (string-matches name "[0-9][0-9][0-9]")
            (string-equal (item.feat token "p.token_pos") "dezimalbruch"))
            (tokendebug -1 (format nil "### Kommazahl mit Null vor Komma, spaeterer Block %s\n" name)) 

            (item.set_feat token "token_pos" "dezimalbruch")
            (french_parse_charlist name 0))

      ;--------------------------------------------------------------------------
      ; if numbers are written in 3 blocks with single space -> combine them
      ; null token if last tokens were already numbers
      ((and (> tokendebuglevel -1)(format t "QN1_1?\t Kommazahl mit Null vor Komma ?\n")  nil))

      ((and (string-matches name "[0-9][0-9][0-9]")
            (or (string-equal (item.feat token "p.token_pos") "card_struc")
                (and
                 (string-equal (item.feat token "pp.token_pos") "card_struc")
                 (string-matches (item.feat token "p.name") "[0-9][0-9][0-9]"))
                (and
                 (not (null (item.prev token)))
                 (string-equal (item.feat (item.prev token) "pp.token_pos")
                   "card_struc")
                 (string-matches (item.feat token "p.name") "[0-9][0-9][0-9]")
                 (string-matches (item.feat token "pp.name") "[0-9][0-9][0-9]"))))
              (tokendebug -1 (format nil "### nicht-initialer Block already %s \n" name)) 
              nil)
; ))))
      ; four blocks
      ((and (string-matches name "[1-9][0-9]?[0-9]?")
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
              
              (tokendebug -1 (format nil "### erster von 4 Blöcken %s\n" name)) 

              (item.set_feat token "token_pos" "card_struc")
              (french_parse_cardinal
                (string-append
                  name
                  (item.feat token "n.name")
                  (item.feat token "nn.name")
                  (item.feat (item.next token) "nn.name"))))

      ; three blocks
      ((and (string-matches name "[1-9][0-9]?[0-9]?")
            (string-matches (item.feat token "n.name") "[0-9][0-9][0-9]")
            (string-matches (item.feat token "nn.name") "[0-9][0-9][0-9]")
            (equal? (item.feat token "punc") 0)
            (equal? (item.feat token "n.punc") 0)
            (not (string-equal (item.feat token "token_pos") "phonenumber"))
            (not (string-equal (item.feat token "token_pos") "dezimalbruch"))
            (string-equal (item.feat token "n.prepunctuation") "")
            (string-equal (item.feat token "nn.prepunctuation") "")
            ;(not (and (string-matches (item.feat token "p.name")
            ;             "[0-9][0-9][0-9]")
            ;          (string-matches (item.feat token "p.punc") ")")))
            ;(not (and (string-matches (item.feat token "nnn.name")
            ;             "[0-9][0-9][0-9]")
            ;          (string-matches (item.feat token "nnn.punc") ")")))
            (string-equal (item.feat token "n.whitespace") " ")
            (string-equal (item.feat token "nn.whitespace") " "))
       
              (tokendebug -1 (format nil "### erster von 3 Blöcken %s\n" name)) 
              (item.set_feat token "token_pos" "card_struc")
              (french_parse_cardinal
                (string-append
                  name
                  (item.feat token "n.name")
                  (item.feat token "nn.name"))))

; ))))
      ; two blocks
      ((and (string-matches name "[1-9][0-9]?[0-9]?")
            (string-matches (item.feat token "n.name") "[0-9][0-9][0-9]")
            (equal? (item.feat token "punc") 0)
            (not (string-equal (item.feat token "token_pos") "phonenumber"))
            (not (string-equal (item.feat token "token_pos") "dezimalbruch"))
            (not (string-equal (item.feat token "token_pos") "Bankleitzahl"))
            (equal? (string-matches (item.feat token "n.prepunctuation") 0))
            ;(not (and (string-matches (item.feat token "p.name")
            ;            "[0-9][0-9][0-9]")
            ;          (string-matches (item.feat token "p.punc") ")")))
            ;(not (and (string-matches (item.feat token "nn.name")
            ;             "[0-9][0-9][0-9]")
            ;          (string-matches (item.feat token "nn.punc") ")")))
            (string-equal (item.feat token "n.whitespace") " "))
              (tokendebug -1 (format nil "### erster von 2 Blöcken %s\n" name)) 

              (item.set_feat token "token_pos" "card_struc")
              (french_parse_cardinal
                (string-append name (item.feat token "n.name")))
            )

; ))))
      ;--------------------------------------------------------------------------
      ; alles was mit null beginnt sollte ziffernweise gesprochen werden.
      ; wieder raus, sollte jetzt in french_numbers_to_words erledigt sein
      ;((string-matches name "0[0-9]*")
      ;  (tokendebug -1 (format nil "### Null vorne %s\n" name)) 
      ;  (french_parse_charlist name 0)
      ;)

      ; ((and (> tokendebuglevel -1)(format t "QT_1?\t Zusammensetzung disabled ?\n")  nil))

      ; ((and (pattern-matches name "{[0-9]+}{[A-Za-züöäß]+}")  (string-equal #1 "") (string-equal #2 "")) ; etc...
      ;   (tokendebug -1 (format nil "### Zusammensetzung %s\n" name)) 

      ;  (item.set_feat token "token_pos" "cardinal")
      ;   (let ((h1 #1)
      ;         (h2 #2))
      ;     (cond
      ;       ((pattern-matches h2 fre_unite_mesure_teststring)
      ;         (set! h2 (append (fre_abbr_lookup h1 fre_abbr_unite_mesure_dim_tab)
      ;                          (fre_abbr_lookup h2 fre_abbr_unite_mesure_tab)))
      ;         (item.set_feat token "token_pos" "masseinheit")
      ;         (append (french_numbers_to_words token h1) h2)
      ;       )
      ;       ((and (string-matches h2 fre_unite_mesure_teststring2)
      ;             ; Hausnummern u.ä.
      ;             (not (string-matches h2 "[a-cA-C]")))
      ;         (set! h2 (fre_abbr_lookup h2 fre_abbr_unite_mesure_tab))
      ;         (item.set_feat token "token_pos" "masseinheit")
      ;         (append (french_numbers_to_words token h1) h2)
      ;       )
      ;       ((string-matches h2 "\\(er.*\\|ig.*\\|jährig.*\\)")
      ;         (let ((part1 (french_numbers_to_words token h1)))
      ;           (let ((part2 (last part1)))
      ;             (append (reverse (difference part1 part2))
      ;                     (list (string-append (list->string part2) h2)))))
      ;       )
      ;       ((not (memv 'no (check_pronunciation h2)))
      ;         (append (french_numbers_to_words token h1) (list h2))
      ;       )
      ;       (t
      ;         (append (french_numbers_to_words token h1)
      ;           (french_parse_charlist h2 0))))))
    

      ;--------------------------------------------------------------------------
      ; on préfére 13 cents à mille 300 pas seulement  pourles années ..
      ; mais il faut éviter les douze cents zéros
      ; ((and (pattern-matches name "{1[1-9]}00")
      ;       (member_string (item.feat token "token_pos") '("year" "cardinal")))
      ;   (tokendebug -1 (format nil "### 1100 ...1900 mit 00  years1 %s" name))

      ;   (item.set_feat token 'token_pos 'year)
      ;   (append (french_parse_cardinal #1) (list "cent"))
      ; )
; ))))
      ((and (member_string (item.feat token "token_pos")
              '("year" "cardinal" "ordinal"))
             (pattern-matches name "{1[1-9]}{[0-9][0-9]}")
             (not(string-equal #1 ""))(not(string-equal #2 "")))
                (tokendebug -1 (format nil "###1100-1999 Jahr years2 %s #1%s #2%s\n" name #1 #2)) 
                (item.set_feat token 'token_pos 'year)
                (append (french_parse_cardinal #1)
                        (list "cent")
                        (french_parse_cardinal #2)))

      ((and (string-matches name "20[0-9][0-9]")
            (member_string (item.feat token "token_pos")
              '("year" "cardinal" "ordinal")))
           (tokendebug -1 (format nil "### 2000er Jahr years2 %s\n" name)) 

            (item.set_feat token 'token_pos 'year)
            (french_parse_cardinal name))
      ; TODO
      ; ;--------------------------------------------------------------------------
      ; ; Date
      ; ; 11.12.97 ...
      ; ((pattern-matches name
      ;     "{[0-3]?[0-9]}{\\.\\|-}{[0-1]?[0-9]}{\\.\\|-}{[0-9][0-9]}")
      ;   (tokendebug -1 (format nil "### DD.MM.JJ %s\n" name)) 
      ;   (marktokendebug (list "date1" name))

      ;   (item.set_feat token "token_pos" "date")
      ;   (append (french_parse_ordinal #1
      ;             (car (wagon token french_ordinal_prediction_tree)))
      ;           (french_parse_ordinal #3
      ;             (car (wagon token french_ordinal_prediction_tree)))
      ;           (let ((jahr #5))
      ;             (if (string-matches jahr "0[0-9]")
      ;               (french_parse_charlfrench_parse_charlistist jahr 1)
      ;               (french_parse_cardinal jahr 1))))
      ; )

      ; 13/04/95 DDMMYY
      ; ((or (string-matches name "[0-2][0-9]/1[0-2]/[0-9][0-9]")
      ;      (string-matches name "[0-2][0-9]/0[1-9]/[0-9][0-9]")
      ;      (string-matches name "3[0-1]/0[1-9]/[0-9][0-9]")
      ;      (string-matches name "3[0-1]/1[0-2]/[0-9][0-9]")) et 31 juin :)

      ((and (pattern-matches name "{[0-3][0-9]}{/}{[0-1][0-9]}{/}{[0-9][0-9]}")
        (not(string-equal #1 ""))(not(string-equal #3 ""))(not(string-equal #5 "")))

        (tokendebug -1 (format nil "### DD/MM/JJ %s\n" name)) 
        (set! h1 #1)
        (set! h2 #2)
        (set! h3 #3)
        (set! h4 #4)
        (set! h5 #5)
        (item.set_feat token "token_pos" "date")
        (append (french_parse_cardinal h1)
                (french_parse_cardinal h3)
                (let ((jahr h5))
                  (if (string-matches jahr "0[0-9]")
                    (french_parse_charlist jahr 1)
                    (french_parse_cardinal jahr 1)))))
; ))))
      ; 95/04/13 YYMMDD, only with years in the nineties
      ((or (string-matches name "9[0-9]/1[0-2]/[0-2][0-9]")
           (string-matches name "9[0-9]/0[0-9]/[0-2][0-9]")
           (string-matches name "9[0-9]/0[0-9]/3[0-1]")
           (string-matches name "9[0-9]/1[0-2]/3[0-1]"))
            (tokendebug -1 (format nil "### JJ/MM/DD %s\n" name)) 

            (item.set_feat token "token_pos" "date")
            (pattern-matches name "{[0-9][0-9]}{/}{[0-1][0-9]}{/}{[0-3][0-9]}")
            (append (french_parse_cardinal #5)
                    (french_parse_cardinal #3)
                    (let ((jahr #1))
                      (if (string-matches jahr "0[0-9]")
                        (french_parse_charlist jahr 1)
                        (french_parse_cardinal jahr 1)))))

      


      ; 13.04. 15.7. ...
      ((and (pattern-matches name "{[0-3]?[0-9]}.{[0-1]?[0-9]}")
            (string-matches (item.feat token "punc") "\\..*"))
            (tokendebug -1 (format nil "### TT.MM. date2%s\n" name)) 

            (item.set_feat token "token_pos" "date")
            (if (not (satzende token))
              (remove_punc token))
            (append (french_parse_cardinal #1)
                    (french_parse_cardinal #2)))

      ; 12.30Uhr ni pnt ni Uhr ..
      ; 12:30h ...
      ((and (pattern-matches name "{[0-2]?[0-9]}{:}{[0-6][0-9]}{h\\|H}")
        (not(string-equal #1 "")) (not(string-equal #2 ""))(not(string-equal #3 ""))(not(string-equal #3 "")))
        (tokendebug -1 (format nil "### HH:MM time2 %s\n" name)) 

        (item.set_feat token "token_pos" "time")
        (append (INST_LANG_number #1 "1") ;  (INST_LANG_number name kind) heure féminin
                '("heure")
                 (if (not (equal? #3 "00"))
                  (french_parse_cardinal #3))))
; ))))
      ; numbers in three-blocks with "." - separator
      ((string-matches name
        "[0-9]?[0-9]?[0-9]\\.\\([0-9][0-9][0-9]\\.\\)*[0-9][0-9][0-9]")
        (tokendebug -1 (format nil "### Kardinalzahl, Gruppierung m. Punkten %s\n" name)) 

        (item.set_feat token "token_pos" "cardinal")
        (french_parse_cardinal (splice_string name ".")))

      ; numbers in three-blocks with "." - separator and ","
      ((pattern-matches name
        "{[0-9]?[0-9]?[0-9]\\.\\([0-9][0-9][0-9]\\.\\)*[0-9][0-9][0-9]},{[0-9]+}")
        (tokendebug -1 (format nil "### Kommazahl, Gruppierung m. Punkten %s\n" name)) 

        (item.set_feat token "token_pos" "cardinal")
        (append (french_parse_cardinal (splice_string #1 "."))
                (list "virgule")
                (french_parse_charlist (symbol->string #2) 0)))
      

      ; numbers with punkt separator
      ((pattern-matches name "{[0-9]+}.{[0-9]+}")
        (tokendebug -1 (format nil "### Kommazahl, m. Punkt statt Komma %s\n" name)) 

        (item.set_feat token "token_pos" "dezimalbruch")
        (append (french_parse_cardinal #1)
                (list "point")
                (french_parse_charlist (symbol->string #2) 0)))
      

      ; numbers without a comma
      ; numbers with a "." -> OrdnungsZahl?
      ; Ordnungszahlen:
      ;   Masc/Fem . Nom/Akk/Dat/Gen . Sg/Pl?
      ((and (string-matches name "[1-9][0-9]?[0-9]?")
            (string-equal (item.feat token "punc") ".")
            (not (equal? 1 (item.feat token "split")))
            (or
              ; no sentence end, so this must be an ordinal
              ; the test for following N is because
              (and (not (satzende token))
                   (not (member_string
                          (cadr (lex.lookup (item.feat token 'R:Token.n.name)))
                          '("N" "NN" "NE" "lts"))))
              (member_string
                (item.feat token 'R:Token.p.name)
                '("am" "zum" "die" "der" "den" "dem" "das" "des" "vom"))
              (null (item.prev (item.relation token 'Token)))
              (satzende (item.prev (item.relation token 'Token)))))
                (tokendebug -1 (format nil "### sehr sicher Ordinalzahl %s\n" name))

                (item.set_feat token "token_pos" "ordinal")
                (item.set_feat token "punc" (string-after (item.feat token "punc") "."))
                (french_parse_ordinal name
                  (car (wagon token french_ordinal_prediction_tree)))
              )
; ))))
      ((and (string-matches name "1?[0-9]?[0-9]")
            (string-equal (item.feat token 'prepunctuation) "(")
            (or
             (and (symbol-bound? 'current_domain)
                  (not (null current_domain))
                  (string-equal "soccer" current_domain))
             (or (string-matches (item.feat token 'punc) "\\.).*")
                 (and (string-matches (item.feat token 'n.punc) ").*")
                      (string-matches (item.feat token 'n.name) ".*[eE]lfmeter")))
             (or (string-matches (item.feat token 'pp.name) ".*:.*")
                 (and (not (null (item.prev token)))
                      (string-matches (item.feat (item.prev token) 'pp.name)
                        ".*:.*")))))
                  (tokendebug -1 (format nil "### Zeitangabe für Tor %s\n" name)) 

                  (item.set_feat token "token_pos" "ordinal")
                  (item.set_feat token "punc" (string-after (item.feat token "punc") "."))
                  (french_parse_ordinal name "e"))
        

      ((and (string-matches name "[1-9][0-9]?[0-9]?")
            (string-matches (item.feat token "punc") "\\..*")
            (not (equal? 1 (item.feat token "split")))
            (string-equal (item.feat token "token_pos") "ordinal"))
            (tokendebug -1 (format nil "### Ordinalzahl, ohne Keyword %s\n" name)) 
            (marktokendebug (list "ordnungszahl" name))

            (if (not (satzende token))
              (begin
                (remove_punc token)
                (french_parse_ordinal name
                  (car (wagon token french_ordinal_prediction_tree))))
              (french_parse_cardinal name)))


      ((string-matches name "1") ; TODO pas vraiment possible en français :)
        (tokendebug -1 (format nil "### Eins! %s\n" name)) 

        (cond
          ((satzende token)
            (list "un")
          )
          ((and (string-matches (item.feat token 'punc) "\\([,!:;]\\|\\?\\|-\\)")
                (string-matches (item.name token) (string-append ".*" name '$)))
            (list "un")
          )
          ; ((string-matches (item.feat token 'n.name) numberwords)
          ;   (list "eine")
          ; )
          ((string-matches (car (cdr (lex.lookup "eine"))) "ADJ.*")
            (cond
              ((string-matches (item.feat token 'n.name) ".*[rs]")
                (list "un")
              )
              ((string-matches (item.feat token 'n.name) ".*[e]")
                (list "une")
              )
              ((string-matches (item.feat token 'n.name) ".*[n]")
                ; könnte auch "eines" sein... Genitiv
                (list "einen")
              )
              ((string-matches (item.feat token 'n.name) ".*[m]")
                (list "einem")
              )
              (t
                (list "un")))
          )
          ((string-matches (item.feat token 'p.token_pos) "acronym")
            (list "un")
          )
          ((or (string-matches (item.feat token 'n.name) "[A-Za-z]")
               (string-matches (item.feat token 'name) "1[A-Za-z]"))
            (list "un")
          )
          (t
            (list "un"))))
; ))))
      ((string-matches name "[0-9]+")
        (marktokendebug (list "cardinal" name))
        (tokendebug -1 (format nil "### Kardinalzahl %s\n" name)) 

        (french_parse_cardinal name))

      ; name contains symbols that where spoken
      ; additional symbols has to be added in ger_symbols_tab too (pas ger_symbol_tab)
      ((pattern-matches name
         "{[^!@#$%^&*=~:?h><\/|+_:£]*}{[!@#$%^&*=~:?h><\/|+_:£]}{.*}")
       ; sinon hecto ? ou boucle ? 20 h 30
          (tokendebug -1 (format nil "### Zahl mit Sonderzeichen: splitten %s\n" name)) 

          (item.set_feat token 'split 1)
          (let ((h1 #1)
                (h2 #2)
                (h3 #3)) ; pattern-match-variable sichern
(tokendebug -1 (format nil "### Zahl mit Sonderzeichen: splitten |%s| h1 |%s| h2 |%s| h3 |%s| \n" name h1 h2 h3 )) ; TOK_!!!!!!!!level:-1 ### Zahl mit Sonderzeichen: splitten |h| h1 || h2 |h| h3 ||  pour 21 h

                
            (append
              ; Die Abfrage auf '(nil) ist umstaendlich und aufwendig aber noetig!?
              (let ((erg (INST_LANG_token_to_words token #1)))
                (if (or (equal? erg '(nil))
                        (string-equal #1 ""))
                  nil
                  erg))
              (if (string-equal h2 "h") (list "heure") (french_parse_1char h2 1) )
    
              
              (let ((erg (INST_LANG_token_to_words token h3)))
                (if (or (equal? erg '(nil))
                        (string-equal h3 ""))
                  nil
                  erg)))))

      ((pattern-matches name "{[^/]*}{[/]}{.*}")
        ; kommt man hier jemals rein???
        (tokendebug -1 (format nil "### Zahl mit Slash: splitten %s\n" name)) 

        (item.set_feat token 'split 1)

        (let ((h2 #2)
              (h3 #3))  ; pattern-match-variable sichern
          (append       ; Abfrage auf '(nil) ist umstaendlich und aufwendig aber
                        ; noetig!?
            (let ((erg (INST_LANG_token_to_words token #1)))
              (if (or (equal? erg '(nil))
                      (string-equal #1 ""))
                nil
                erg))
            (let ((erg (INST_LANG_token_to_words token h3)))
              (if (or (equal? erg '(nil))
                      (string-equal h3 ""))
                nil
                erg)))))

      ; the same but at end of token (".*" doesn't match "" !)
      ; name contains symbols that where not spoken
      ((pattern-matches name "{[^-():;,]*}{[-():;,]}")
        ;; bug utf8 match £ avec #1 £ et #2 ""
        (let ((h2 #2))  ; pattern-match-variable sichern
          (append
            ; Die Abfrage auf '(nil) ist umstaendlich und aufwendig aber noetig!?
            (let ((erg (INST_LANG_token_to_words token #1)))
              (if (or (equal? erg '(nil))
                      (string-equal #1 ""))
                nil
                erg)))))

      (t
        (marktokendebug (list "true" name))
        (tokendebug -1 (format nil "### letzte Klausel %s\n" name)) 

        (append
          (let ((x (item.feat token "prepunctuation")))
            (if (member_string x '("" "0"))
              nil
              (french_parse_charlist x 0)))
          (french_parse_charlist name 0)
          (let ((x (item.feat token "punc")))
            (if (member_string x '("" "0"))
              nil
              (french_parse_charlist x) 0))))
    )
))


(provide 'INST_LANG_token_numbers_to_words)

