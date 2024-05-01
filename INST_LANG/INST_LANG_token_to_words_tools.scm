;/* ims_german_token_to_words_tools
;/*             Author :  Mark Breitenbuecher  
;/*                                                                       */
;/* This file contains auxiliary functions to deal with abbreviations,    */
;/* numbers, currencies, titles, months, and the definitions of           */
;/* ``french_currency'' from ``fre_abbr_currency_tab'',                   */
;/* ``french_months'' from ``fre_abbr_months_tab'' and                    */
;/* ``french_days'' from ``fre_abbr_days_tab''.                           */
;/*                                                                       */
(format t "pas le bon !???????????????????????????????\n"
(require 'utils_fr)
(require 'INST_LANG_token_to_words_lists)

(set! tempo t)

(define (?sym name)
  ; ?? apostrop 
  ; ne sert qu'à fr_token_pos_guess qui ne sert pour l'instant à rien ...
  ; probablement faux avec des majuscules accentuée dans une regex
   "Does name contains at least one non alphanumeric character?"
 (string-matches name ".*[^A-ZÀÁÂÄÅÇÈÉÊËÌÍÎÏÒÓÔÖÙÚÛÜa-zàáâäåçèéêëìíîïòóôöùúûüß0-9].*"))

;; letters
(define (can_be_single_letter name)
    " "
    ; token.letter_pos nn by default we can't keep it, it's not freeling compatible
    (member name (list "a" "à" "y" "A" "À" "Y" "Ô" "l" "L" "c" "C" "d" "D" "m" "M" "n" "j" "J" "s" "S" "t" "T")))

(define (french_parse_1char char_name typ)
  "(french_parse_1char NAME typ ...)
   Returns a string containing the french word for the single char NAME
   e.g. (french_parse_1char \":\" À -> à minuscule)"
  ; example (french_parse_1char "@")->arobase
  ; TODO avec ou sans majuscule/minuscule avec 1 without 0
  (let (majuscule minuscule  (expansion (fre_abbr_lookup (french_downcase_string char_name) fre_char_tab)))
    (if (equal? typ 1)
      (begin
        (format t "typ %s\n" typ)
        (set! majuscule (list "majuscule"))
        (set! minuscule (list "minuscule"))
      ))
    (if (null expansion) 
      (set! expansion (list (french_downcase_string char_name))))
    (cond  
      ((or(string-matches char_name "[A-Z]")(member_string char_name majuscule_with_accent_letter_list))
       ; [A-Z] not in the fre_char_tab to avoid redondance ..:(
        (set! expansion (append expansion majuscule))) ;
      ((or (string-matches char_name "[a-z]")(member_string char_name minuscule_with_accent_letter_list))
        (set! expansion (append expansion minuscule))) ;
      ((null? expansion)
        (set! expansion (list "symbole" "inconnu"))))
  (append (list ".") expansion (list ".")))) ; TODO check plus de liaison et petite pause
; rapport avec speller ?

(define (french_parse_charlist name typ)
  "(french_parse_charlist NAME typ ..1 describes case )
   Returns a list of words with the spoken sequence of chars."

  (cond
    ((eq? (string-length name) 0)
      (list nil))
    ((eq? (string-length name) 1)
      (french_parse_1char(string-car name) typ))
    (t
      (append (french_parse_1char(string-car name) typ)
        ; cdr all characters from the string besides the first
        (french_parse_charlist(string-cdr name) typ )))))




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; the following functions have all to do with abbreviations!
;
; XXX: for bigger tables we need hash-table-functionality.  Most
; lisp-dialects support them but SIOD doesn't. These functions have to
; be rewritten and the above assoc lists have to be converted to
; hash-tables if in future-versions we want work to be done by
; hashtables.

(define (fre_abbr_lookup abbr tab)
  "(fre_abbr_lookup ABBR TAB)
   Looks up an ABBR in a assoc-list TAB.
   For bigger tabs we should use hash-tables!"

  (cdr (assoc abbr tab)))

; TODO renommer trop restrictif mettre dans utils.fr
; cons_getkeys ?
(define (fre_abbr_getkeys tab)
  "(fre_abbr_getkeys TAB)
   Returns a list of all keys in the assoc-list TAB."

  (if (eq tab nil)
    nil
    (cons (caar tab) (fre_abbr_getkeys (cdr tab)))))

; TODO renommer trop restrictif mettre dans utils.fr
(define (fre_abbr_getvals tab)
  "(fre_abbr_getvals TAB)
   Returns a list of all values in the assoc-list TAB."
  (if (eq tab nil)
    nil
    (append (cdar tab) (fre_abbr_getvals (cdr tab)))))


; TODO franciser ! et ...simplifier renommer
(define (spell_acronym name)
 "should be spelled ?"
  (tokendebug 3000 (format nil "french_downcase_string in spell_acronym\n"))
  (let ((n (french_downcase_string name)))
    ; The string-length_utf8 conditions below are because many "acronyms" are
    ; really out-of-vocabulary words and should not be spelled.
    ; Assume that anything longer than 4 or 5 chars is such an OOV word.
    (cond
      ((null? name))
      ((string-equal name ""))
      ; too short -> spell
      ; ex PV,  Xex CAF
      ; non bac boc bic cap TODO Buc  
       ((and(< (string-length_utf8 n) 4) (is_cap (string-car name))) t)

      ; no vowels -> spell
      ; ex SNCF
      ((string-matches n "[bcdfghjklmnpqrstvwxz]*") t)

      ;; no vowels for 4 graphemes
      ; ex EBCDIC
      (
        (string-matches n ".*[^aeiouàáâäåçèéêëìíîïòóôöùúûü][^aeiouàáâäåçèéêëìíîïòóôöùúûü][^aeiouàáâäåçèéêëìíîïòóôöùúûü][^aeiouàáâäåçèéêëìíîïòóôöùúûü].*") t)
      
      ; too many vowels -> spell (i + other vowel allowed)
      ;INSEE
      ((and (string-matches n ".*[aeouàáâäåçèéêëìíîïòóôöùúûüy][aeiouàáâäåçèéêëìíîïòóôöùúûüy].*")
            (< (string-length_utf8 n) 5))
            ;(not (string-matches n ".*\\(au\\|eu\\|ie\\|ai\\|ei\\).*")))
        t)

      ; but i+vowel not at beginning
      ((and (string-matches n "i[aeiouàáâäåçèéêëìíîïòóôöùúûüy].*")
            (< (string-length_utf8 n) 5))
        t
      )

      ; Auslautverhärtung would create inconsistent pronunciation -> spell
      ((and (string-matches n ".*[dbg]$")
            (< (string-length_utf8 n) 4))
        t
      )

      ; following lines don't work well because of interference with English
      ; words
      ; final c/v could be mistaken as k/f -> spell
      ((and (string-matches n ".*[cvw]$")
            (< (string-length_utf8 n) 5))
        t
      )

      ; initial c could be mistaken as s by lts -> spell
      ((and (string-matches n "^c.*")
            (< (string-length_utf8 n) 5))
        t
      )

      ; terminal devoicing (Auslautverhärtung), as above
      ((and (string-matches n ".*[dbg]s$")
            (< (string-length_utf8 n) 5))
        t
      )

      ; onset too complex for acronym -> spell ; should be more elaborate:
      ; syllable model in orthographic form
      ((and (string-matches n "[bcdfghjklmnpqrstvwxz][bcdfghjklmnpqrstvwxz].*") ; dommage PROM
            (< (string-length_utf8 n) 5))
        t
      )

      ; ; coda pronouncable -> don't spell
      ; ((and (string-matches n ".*\\(ch\\|ph\\|ck\\|ft\\)")
      ;       (< (string-length_utf8 n) 5))
      ;   nil
      ; )

      ;; coda pronounceable -> don't spell
      ;((and (string-matches n ".*[nm][fst]")
      ;      (< (string-length_utf8 n) 5))
      ;  nil
      ;)

      ; ; coda pronounceable -> don't spell
      ; ((and (string-matches n ".*[lr][fklmnpstz]")
      ;       (< (string-length_utf8 n) 5))
      ;   nil
      ; )

      ; ; coda pronounceable -> don't spell
      ; ((and (string-matches n ".*[aeiou]h[mnrl]")
      ;       (< (string-length_utf8 n) 5))
      ;   nil
      ; )

      ; ; coda pronounceable -> don't spell
      ; ((and (string-matches n ".*\\(ff\\|mm\\|pp\\|ss\\|tt\\)")
      ;       (< (string-length_utf8 n) 5))
      ;   nil
      ; )

      ; ; coda pronouncable -> don't spell
      ; ((and (string-matches n ".*\\(ng\\|nk\\|mp\\)")
      ;       (< (string-length_utf8 n) 5))
      ;   nil
      ; )

      ; coda too complex for acronym -> spell
      ((and (string-matches n ".*[bcdfghjkmpqstvwxz][bcdfghjklmnpqrstvwxz]")
            (< (string-length_utf8 n) 5))
        t
      )

      (t
        nil
      )
    )
  ))


;; currency
(defvar french_currency
  (fre_abbr_getkeys fre_abbr_currency_tab)
  "A list of currency units created from fre_abbr_currency_tab.")

(define (french_fetch_currency token name)
  "(french_fetch_currency TOKEN NAME)
   Returns the currency of the money-unit following NAME: If it is an
   abbreviation stored in fre_abbr_currency_tab."

  (let ((curr (item.feat token "n.name")))
    (let ((expand (fre_abbr_lookup curr fre_abbr_currency_tab)))
      (if expand
        expand
        (list curr)))))
 
(define (french_fetch_currency2 name)
  "(french_fetch_currency2 NAME)
   Returns the currency of the money-unit following NAME: If it is an
   abbreviation stored in fre_abbr_currency_tab."

  (let ((expand (fre_abbr_lookup name fre_abbr_currency_tab)))
    (if expand
      expand
      (list name))))

; days, months, year

(defvar french_months
  (append (fre_abbr_getkeys fre_abbr_months_tab)
          (fre_abbr_getvals fre_abbr_months_tab))
  "A list of french month names created from fre_abbr_months_tab.")


(defvar french_days
  (append (fre_abbr_getkeys fre_abbr_days_tab)
          (fre_abbr_getvals fre_abbr_days_tab))
  "A list of french day-names created from fre_abbr_days_tab.")

;---[ url->list(_german) ]

(define (url->list_french url)
  "(url->list_french URL)
   Calls url->list and inserts 'ät', 'Doppelpunkt' etc.
   That is, it converts the string URL
    (e.g. \"http://www.abc.de/fgh\" or \"myname@ims.uni-stuttgart.de\")
   to a list
    ((\"http\" \"Doppelpunkt\" \"Doppelsläsch\" \"www\" \"abc\" \"de\" \"fgh\")
     or (\"myname\" \"ät\" \"ims\" \"uni-stuttgart\" \"de\"))."

  (let ((ulist '())
        (strbs '())
        (sep   ""))
    ; URL (://) or EMAIL (@)?
    (if (string-matches url ".*@.*")
      (set! sep "@")
      (if (string-matches url ".*://.*")
        (set! sep "://"))
    )

    ; process part before separator (including sep.)
    ; if separator exists
    (if (not (string-equal sep ""))
      (begin
        (set! ulist
          (replace_url_chars (separate_partial_url (string-before url sep))))

        (if (string-equal sep "@")
          (set! ulist (append ulist (list "arobase")))
          (set! ulist (append ulist (list "deux" "points" "deux" "slash")))
        )
      )
    )

    ; process part after separator
    (set! ulist
      (append ulist
        (replace_url_chars (separate_partial_url (string-after url sep)))))

    ulist))

(define (replace_url_chars url)
  "(replace_url_chars URL)
   Replaces the following elements of the list URL
   by their respective german textual representations.
    '.' (point),        '/' (slash),       '\\' (antislash),
    '_' (tiret bas),  '-' (tiret),  ':' (deux points)
   e.g.:
    (\"www\" \".\" \"gmx\" \".\" \"de\") -->
    (\"www\" \"Punkt\" \"gmx\" \"Punkt\" \"de\")"
  (format t "8888 url %l\n" url)
  (let ((ulist '()))
    ; modify the list (and return it to caller)
    (mapcar
      (lambda (elem)
        (if (string-equal elem ".")
          (set! ulist (append ulist (list "point")))
          (if (string-equal elem "/")
            (set! ulist (append ulist (list "slash")))
            (if (string-equal elem "\\")
              (set! ulist (append ulist (list "antislash")))
              (if (string-equal elem "_")
                (set! ulist (append ulist (list "tiret bas")))
                (if (string-equal elem "-")
                  (set! ulist (append ulist (list "tiret")))
                  (if (string-equal elem ":")
                    (set! ulist (append ulist (list "deux points")))
                    (set! ulist (append ulist (list elem))))))))))
        url)
      (format t "replace_url_chars %l\n" ulist)
   
    ulist))

(define (separate_partial_url url)
  "(separate_partial_url URL)
   Separates the string URL
    (e.g. \"www.abc.de/fgh\" or \"ims.uni-stuttgart.de\")
   to a list
    ((\"www\" \".\" \"abc\" \".\" \"de\" \"/\" \"fgh\")
     or (\"ims\" \".\" \"uni\" \"-\" \"stuttgart\" \".\" \"de\")).
   (URL has to be the part before/after '://' or '@'.)
   It simply separates URL at '/', '\\', '-', '_', ':'  and '.'."

  (let ((ulist '())
        (str ""))
    (mapcar
      (lambda (elem)
        (if (or (string-equal elem "/") (string-equal elem "\\")
                (string-equal elem ".") (string-equal elem "-")
                (string-equal elem "_") (string-equal elem ":"))
          (begin
            (if (string-equal str "")
              (set! ulist (append ulist (list     (string-append "" elem))))
              (set! ulist (append ulist (list str (string-append "" elem))))
            )
            (set! str "")
          )
          (set! str (string-append str elem))
        )
      )
      (string->list url)
    )

    (if (not (string-equal str ""))
      (set! ulist (append ulist (list str))))

    ulist))

(define (url->list url)
  "(url->list URL)
   Converts the string URL
    (e.g. \"http://www.abc.de/fgh\" or \"myname@ims.uni-stuttgart.de\")
   to a list
    ((\"http\" \"www\" \"abc\" \"de\" \"fgh\")
     or (\"myname\" \"ims\" \"uni-stuttgart\" \"de\")).
   It separates URL at '@', ':', '/', '\\' and '.'."

  (let ((ulist)
        (str ""))
    ; make the list, separate by '.', ':', '\' and '/'
    (mapcar
      (lambda (elem)
        (if (or (string-equal elem ".")  (string-equal elem ":")
                (string-equal elem "\\") (string-equal elem "/")
                (string-equal elem "-")  (string-equal elem "_")
                (string-equal elem "@"))
                (begin
                  (if (not (string-equal str ""))
                    (set! ulist (append ulist (list str))))
                    (set! str ""))
                (set! str (string-append str elem))))

      (string->list (string-append url ".")))
    (format t "99999 ulist %l" ulist)
    ulist))

; romans
(define (fre_tok_roman_to_numstring roman)
  "(fre_tok_roman_to_numstring ROMAN)
   Takes a string of roman numerals and converts it to a number and
   then returns the printed string of that."
  ; no zero !
  (let ((val   0)
        (chars (symbolexplode roman)))
    (while chars
      (cond
        ((equal? (car chars) 'M)
          (set! val (+ 1000 val))
        )
        ((equal? (car chars) 'D)
          (set! val (+ 500 val))
        )
        ((equal? (car chars) 'C)
          (cond
            ((equal? (car (cdr chars)) 'D)
              (set! val (+ 400 val))
              (set! chars (cdr chars))
            )
            ((equal? (car (cdr chars)) 'M)
              (set! val (+ 900 val))
              (set! chars (cdr chars))
            )
            (t
              (set! val (+ 100 val))
            )
          )
        )
        ((equal? (car chars) 'L)
          (cond
            ((equal? (car (cdr chars)) 'D)
              (set! val (+ 450 val))
              (set! chars (cdr chars))
            )
            ((equal? (car (cdr chars)) 'M)
              (set! val (+ 950 val))
              (set! chars (cdr chars))
            )
            (t
              (set! val (+ 50 val))
            )
          )
        )
        ((equal? (car chars) 'X)
          (cond
            ((equal? (car (cdr chars)) 'L)
              (set! val (+ 40 val))
              (set! chars (cdr chars))
            )
            ((equal? (car (cdr chars)) 'C)
              (set! val (+ 90 val))
              (set! chars (cdr chars))
            )
            ((equal? (car (cdr chars)) 'D)
              (set! val (+ 490 val))
              (set! chars (cdr chars))
            )
            ((equal? (car (cdr chars)) 'M)
              (set! val (+ 990 val))
              (set! chars (cdr chars))
            )
            (t
              (set! val (+ 10 val))
            )
          )
        )
        ((equal? (car chars) 'V)
          (cond
            ((equal? (car (cdr chars)) 'L)
              (set! val (+ 45 val))
              (set! chars (cdr chars))
            )
            ((equal? (car (cdr chars)) 'C)
              (set! val (+ 95 val))
              (set! chars (cdr chars))
            )
            ((equal? (car (cdr chars)) 'D)
              (set! val (+ 495 val))
              (set! chars (cdr chars))
            )
            ((equal? (car (cdr chars)) 'M)
              (set! val (+ 995 val))
              (set! chars (cdr chars))
            )
            (t
              (set! val (+ 5 val))
            )
          )
        )
        ((equal? (car chars) 'I)
          (cond
            ((equal? (car (cdr chars)) 'V)
              (set! val (+ 4 val))
              (set! chars (cdr chars))
            )
            ((equal? (car (cdr chars)) 'X)
              (set! val (+ 9 val))
              (set! chars (cdr chars))
            )
            ((equal? (car (cdr chars)) 'L)
              (set! val (+ 49 val))
              (set! chars (cdr chars))
            )
            ((equal? (car (cdr chars)) 'C)
              (set! val (+ 99 val))
              (set! chars (cdr chars))
            )
            ((equal? (car (cdr chars)) 'D)
              (set! val (+ 499 val))
              (set! chars (cdr chars))
            )
            ((equal? (car (cdr chars)) 'M)
              (set! val (+ 999 val))
              (set! chars (cdr chars))
            )
            (t
              (set! val (+ 1 val))
            )
          )
        )
      )
      (set! chars (cdr chars))
    )

    (format nil "%d" val)
   (symbol->string val)))

;;numeric

(define (?numeric name)
  "Does name contains only digits?"
 (string-matches name "[0-9]+"))
;
(define (?number name)
  "Does the name represents a number for sure? integer or decimal"  
  (or (string-matches name "[0-9]+\\.[0-9]+")
      (string-matches name
         "[0-9][0-9]?[0-9]?,\\([0-9][0-9][0-9],\\)*[0-9][0-9][0-9]")))

;; ordinal

(define (french_words_ordinals_ms sc)
  "(french_words_ordinals_ms sc )
  Returns 1 if a list's word is within 1 token before or 1 after. 
  ms=male & Sing words"

  (let ((words '(article acte livre anniversaire chapitre volume siècle mois jour numéro)))
    (if (member_string (french_downcase_string (item.feat sc "R:Token.p.name"))
         words)
      
    "1"
        (if (member_string (french_downcase_string (item.feat sc "R:Token.n.name"))
         words)
            "1"
        "0"))))

(define (french_words_ordinals_fs sc)
  "(french_words_ordinals_ms sc )
    Returns 1 if a list's word is within 1 token before or 1 after. 
    Sing. & Female words "

  (let ((words '(section semaine partie phrase scène édition
  position guerre assemblée journée)))
    (if (member_string (french_downcase_string (item.feat sc "R:Token.p.name"))
        words)
      
    "1"
        (if (member_string (french_downcase_string (item.feat sc "R:Token.n.name"))
         words)
            "1"
        "0"))))

(define (french_words_ordinals_mp sc)
  "(french_words_ordinals_ms sc )
  Returns 1 if a list's word is within 1 token before or 1 after. Pl. & Male words "

  (let ((words '())) ;; I don't know any word now :P
    (if (member_string (french_downcase_string (item.feat sc "R:Token.p.name"))
         words)
      
    "1"
        (if (member_string (french_downcase_string (item.feat sc "R:Token.n.name"))
         words)
            "1"
        "0"))))

(define (french_words_ordinals_fp sc)
  "(french_words_ordinals_ms sc )"
  
   (let ((words '(journées éditions)))
    (if (member_string (french_downcase_string (item.feat sc "R:Token.p.name"))
         words)
      
    "1"
        (if (member_string (french_downcase_string (item.feat sc "R:Token.n.name"))
         words)
            "1"
        "0"))))

(define (french_parse_ordinal numberstring suffix)
  "(french_parse_ordinal NUMBERSTRING SUFFIX)
   Returns a list of strings containing the french words for the
   ordinal NUMBERSTRING
     (french_parse_ordinal 21 \"e\") -> vingt-et-unième
      /!\ pour 1 donne première à bricoler au cas par cas"
  ; TODO sufixe sans intérêt !  rajouter à la main pour l'adverbe
  (let ((res_list (french_parse_cardinal numberstring)))
    (if (equal? res_list '(unknown))
      '(unknown)
      (let ((nr (car (last res_list))))
        (cond
          ((string-matches nr "zéro"      ) (set! nr "zéroième"      ))
          ((string-matches nr "un"      ) (set! nr "unième"       ))



          ((string-matches nr "deux"      ) (set! nr "deuxième"      ))
          ((string-matches nr "trois"      ) (set! nr "troisième"      ))
          ((string-matches nr "quatre"      ) (set! nr "quatrième"      ))
          ((string-matches nr "cinq"      ) (set! nr "cinquième"      ))
          ((string-matches nr "six"     ) (set! nr "sixième"     ))
          ((string-matches nr "sept"    ) (set! nr "septième"      ))
          ((string-matches nr "huit"      ) (set! nr "huitième"       ))
          ((string-matches nr "neuf"      ) (set! nr "neuvième"      ))
          ((string-matches nr "dix"      ) (set! nr "dixième"      ))
          ((string-matches nr "onze"       ) (set! nr "onzième"       ))
          ((string-matches nr "douze"     ) (set! nr "douzième"     ))
          ((string-matches nr "treize"  ) (set! nr "treizième"  ))
          ((string-matches nr "quatorze"  ) (set! nr "quatorzième"  ))
          ((string-matches nr "quinze"  ) (set! nr "quinzième"  ))
          ((string-matches nr "seize"  ) (set! nr "seizième"  ))
          ((string-matches nr "dix-sept"  ) (set! nr "dix-septième"  ))
          ((string-matches nr "dix-huit"  ) (set! nr "dix-huitième"  ))
          ((string-matches nr "dix-neuf"  ) (set! nr "dix-neuvième"  ))
          ((string-matches nr "vingt"   ) (set! nr "vingtième"  ))
          ((string-matches nr "vingt-et-un"   ) (set! nr "vingt-et-unième"  ))
          ((string-matches nr "trente"   ) (set! nr "trentième"  ))
          ((string-matches nr "trente-et-un"   ) (set! nr "trente-et-unième"  ))
          ((string-matches nr "quarante"   ) (set! nr "quarantième"  ))
          ((string-matches nr "quarante-et-un"   ) (set! nr "quarante-et-unième"  ))
          ((string-matches nr "cinquante"   ) (set! nr "cinquantième"  ))
          ((string-matches nr "cinquante-et-un"   ) (set! nr "cinquante-et-unième"  ))
          ((string-matches nr "soixante"   ) (set! nr "soixantième"  )) ; /!\ france versus suisse,caadienne, belge ..
          ((string-matches nr "soixante-et-un"   ) (set! nr "soixante-et-unième"  )) ; /!\ france versus suisse,caadienne, belge ..
          ((string-matches nr "soixante-dix"   ) (set! nr "soixante-dixième"  ))
          ((string-matches nr "quatre-vingt"   ) (set! nr "quatre-vingtième"  ))
          ((string-matches nr "quatre-vingt-dix"   ) (set! nr "quatre-vingt-dixième"  ))
          ((string-matches nr "cent"   ) (set! nr "centième"  ))
          ((string-matches nr "mille"   ) (set! nr "millième"  ))
          ((string-matches nr "million"   ) (set! nr "millionième"  ))
          ((string-matches nr "milliarden") (set! nr "milliardième" ))
          ((string-matches nr "billion"   ) (set! nr "billionième"  ))
          ((string-matches nr "billiard") (set! nr "billiardième" ))
          ((string-matches nr "trillion") (set! nr "trillionième"))
          (t nil)
        )
     ;   (set! nr (string-append nr "_" suffix)) ; approx
        ;(print nr)
        (if (string-equal numberstring "1")
          (list "première")
          (append (remove_last res_list) (list (intern nr))))
      )
    )
  ))

;; cardinal
(define (french_parse_cardinal_with_0 name) 
  (if (pattern-matches name "{0+}{[1-9][0-9]*}")
    (append
      (if (not (string-equal #1 "")) (french_parse_charlist #1 0))
      (french_parse_cardinal name))))

(define (french_parse_cardinal name)
  (if (not (string-equal name ""))
     (INST_LANG_number (parse-number name) "0")))

;; king, queen, pope
(define (fre_tok_king sc)
  "(fre_tok_king sc)
   Returns 1 if King like title is within 3 tokens before or 2 after."

  (if (or (member_string (downcase (item.feat sc "p.p.name"))
                         french_king_title)
          (member_string (downcase (item.feat sc "p.p.p.name"))
                         french_king_title)
          (member_string (downcase (item.feat sc "n.name"))
                         french_king_title)
          (member_string (downcase (item.feat sc "n.n.name"))
                         french_king_title))
    "1"
    "0"))

(define (fre_tok_king_names sc)
  "(fre_tok_king_names sc)
   Returns 1 if one token after is a King-like name."
  (format t "%s : p.name\n" (item.feat sc 'p.name))
  (if (or (member_string (downcase (item.feat sc 'p.name))
                         french_king_name)
          (member_string (downcase (item.feat sc 'p.p.name))
                         french_king_name))
    "1"
    "0"))

(define (fre_tok_queen sc)
  "(fre_tok_queen sc)
   Returns 1 if King like title is within 3 tokens before or 2 after."

  (if (or (member_string (downcase (item.feat sc "p.p.name"))
                         french_queen_title)
          (member_string (downcase (item.feat sc "p.p.p.name"))
                         french_queen_title)
          (member_string (downcase (item.feat sc "n.name"))
                         french_queen_title)
          (member_string (downcase (item.feat sc "n.n.name"))
                         french_queen_title))
    "1"
    "0"))
 
(define (fre_tok_queeen_names sc)
  "(fre_tok_queeen_names sc)
   Returns 1 if one token before is a Koenigin-like name."

  (if (or (member_string (downcase (item.feat sc 'p.name))
                         french_queen_name)
          (member_string (downcase (item.feat sc 'p.p.name))
                         french_queen_name))
    "1"
    "0"))



; punctuation, end of phrase, position

(define (remove_punc token)
  (if (and (not tempo)(string-matches (item.feat token "punc") "\\..*")
    (item.set_feat token "punc" (string-after (item.feat token "punc") ".")))))

; #followed by a period (and an upper-case word), does NOT indicate an end-of-sentence marker.
; eos marker
; #Special cases are included for prefixes that ONLY appear before 0-9 numbers.
; #any single upper case letter  followed by a period is not a sentence ender
; #usually upper case letters are initials in a name
; #no French words end in single lower-case letters, so we throw those in too?


(define (satzende token)
  "is  sentence end token ?"
  (let (result)
  (if (or ; next word is not capitalized -> no sentence end
      ;    (and (not is_cap(string-car (item.next token))) (not (null (item.next (item.relation token 'Token)))))
          ;(debug 1000 (format nil "\t\tsatzende token ??  _%s_\n" (item.feat token 'n.name)) t); or !

          (string-matches (item.feat token 'n.name) "[a-zäöü1-9-].*")


          ; next word is capitalized, but that's because it's a noun etc.
          ; (compare to lexicon entry) -> no sentence end
          (and 

               ; make sure that there IS a next item, otherwise above condition
               ; matches because the feature is 0 in both cases
               (not (null (item.next (item.relation token 'Token))))


              (string-equal ; TODO see Maud
                 (car (lex.lookup (item.feat token 'R:Token.n.name)))
                 (item.feat token 'R:Token.n.name))
                ; ??? TODO lts generatedœ
               ; lts generated words are often names; so are onomastica entries
               (not (string-matches
                      (cadr (lex.lookup (item.feat token 'R:Token.n.name)))
                      "\\(lts\\|.*ONO.*\\)")))

            (string-matches (item.feat token 'punc) "\\.,")) ; ..
  (begin 
    (debug 1000 (format nil " nil satzende  _%s_\n" (item.feat token 'n.name)))

    (set! result nil))
  (begin 
    (set! result t )
    (debug 1000 (format nil "true satzende  _%s_\n" result))

    ))

  result))

(define (token_prox word sc)
  "(returns 1 if word is within 3 tokens before or 2 after sc."

  (if (or (member_string (downcase (item.feat sc "p.p.name"))
                          word)
          (member_string (downcase (item.feat sc "p.p.p.name"))
                          word)
          (member_string (downcase (item.feat sc "n.name"))
                          word)
          (member_string (downcase (item.feat sc "n.n.name"))
                          word))
    "1"
    "0"))

; TODO vérifiez et voir les avantages sur la version ..
(define (kontext-matches item feature direction number string)
  "argument direction must be p (previous) or n (next)"
  (if (not (string-matches direction "^\\(p\\|n\\)$"))
    (format stderr "4. Argument muss p oder n sein\n"))

  (if (string-matches (item.feat item feature) string)
    t
    (if (< number 1)
      nil
      (cond
        ((string-equal "p" direction)
          (if (null (item.prev item))
            nil
            (kontext-matches (item.prev item)
              feature direction (- number 1) string)
          ))
        ((string-equal "n" direction)
          (if (null (item.next item))
            nil
            (kontext-matches (item.next item)
              feature direction (- number 1) string)
          ))))))

(provide 'INST_LANG_token_to_words_tools)
