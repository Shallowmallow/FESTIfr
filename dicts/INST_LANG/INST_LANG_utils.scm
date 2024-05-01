; INST_LANG_utils
(require "INST_LANG_patternmatch")
(defvar debugfrom "")
; à écrémer tout ne sert pas !!! mais pourrait 
; et tout n'a pas été testé !

;TODO  1 procedure Debug paramètre de plus
(defvar debuglevel -1)
(defvar phonedebuglevel -1)
(defvar tokendebuglevel -1)
(defvar posdebuglevel -1)
(defvar phonedebuglevel -1)

(defvar lexdebuglevel -1)
(defvar postlexdebuglevel -1)
(defvar ltsdebuglevel -1)
(defvar pausedebuglevel -1)

(define (is_made_with name liste)
  "from INST_LANG_utils the name is a string made with letters in the list liste"
  ; (is_made_with (string-cdr name) (append minuscule_with_accent_letter_list (list "a-z" "_" "\-")))
  ; Tout-Paris -> nil
  (string-matches name (string-append "[" (list->string liste) "\\]+"))) 


(define (debug level msgStr)
  "(debug LEVEL MSGSTR)
   Prints the (simple) string MSGSTR, if the global variable debuglevel
   is higher than LEVEL."

  (if (and debuglevel (> debuglevel level))
    (format t "debug!!!!!!!!level:%s %s\n" level msgStr))t)

(define (tokendebug level msgStr)
  "(tokendebug LEVEL MSGSTR)
   Prints the (simple) string MSGSTR, if the global variable tokendebuglevel
   is higher than LEVEL."

  (if (and tokendebuglevel (> tokendebuglevel level))
    (format t "TOK_!!!!!!!!level:%s %s %s\n" level msgStr debugfrom)))


(define (pausedebug level msgStr)
  "(pausedebug LEVEL MSGSTR)
   Prints the (simple) string MSGSTR, if the global variable pausedebuglevel
   is higher than LEVEL."

  (if (and pausedebuglevel (> pausedebuglevel level))
    (format t "PAUS!!!!!!!!level:%s %s\n" level msgStr))t)


(define (lexdebug level msgStr)
  "(lexdebug LEVEL MSGSTR)
   Prints the (simple) string MSGSTR, if the global variable lexdebuglevel
   is higher than LEVEL."

  (if (and  lexdebuglevel (> lexdebuglevel level) msgStr)
    (format t "LEX_========level:%s %s\n" level msgStr))t)


(define (postlexdebug level msgStr)
  "(postlexdebug LEVEL MSGSTR)
   Prints the (simple) string MSGSTR, if the global variable postlexdebuglevel
   is higher than LEVEL."

  (if (and postlexdebuglevel (> postlexdebuglevel level))
    (format t "POST========level:%s %s\n" level msgStr))t)

(define (ltsdebug level msgStr)
  "(ltsdebug LEVEL MSGSTR)
   Prints the (simple) string MSGSTR, if the global variable ltsdebuglevel
   is higher than LEVEL."

  (if (and ltsdebuglevel (> ltsdebuglevel level))
    (format t "LTS_========level:%s %s\n" level msgStr))t)



 (define (posdebug level msgStr)
  "(posdebug LEVEL MSGSTR)
   Prints the (simple) string MSGSTR, if the global variable posdebuglevel
   is higher than LEVEL."

  (if (and posdebuglevel (> posdebuglevel level))
    (format t "POS_========level:%s %s\n" level msgStr))t)

 
  (define (phonedebug level msgStr)
  "(phonedebug LEVEL MSGSTR)
   Prints the (simple) string MSGSTR, if the global variable phonedebuglevel
   is higher than LEVEL."

  (if (and phonedebuglevel (> phonedebuglevel level))
    (format t "PHO_========level:%s %s\n" level msgStr))t)


(define (string-length_utf8 str )
  ; (set! nom "Æ"))  
  ; (string-length_utf8 nom) -> 1
  ; (string-length nom) -> 2
  (length (utf8explode str)))



(define (warnings str)
  ;(set! str "¢€¥#$%&'*+,-./@\"\\^_`~¢§©«°¸»){}][…")
  ; en résumé   
  ; $ & longueur 1
  ; accentué longueur ->2 
  ; € … -> 3
  (let ((tl  0) )
    (mapcar
      (lambda (l)
        (set! tl (string-length l))
        (if (not(equal? 1 tl))
            ;(debug 100 (format nil "%s : length%s\n" l tl))))
            (format nil "%s : length%s\n" l tl)))
      (utf8explode str))
    ))

;; (unwind-protect 
;;  (require 'fileio)
;;  error)
; ABCDFGHJKLMNPQRSTVWXZabcdfghjklmnpqrstvwxz
; ÀÁÂÄÅÇÈÉÊËÌÍÎÏÒÓÔÖÙÚÛÜàáâäåçèéêëìíîïòóôöùúûü 

;  versus re-define (SynthText text) ?
(define (french_string_cleanup token)
  ;;ensures name has characters with are either in the French unicode range,
  ;;ascii punctuation or represent a known symbol
  ;; example
 (debug 100 (format nil "999 cleanup possible %s\n" token))
   (if (equal? (string-car token) "-"); wrong typography rather annoying  
    (set! token (string-cdr token))) 
   token
 )

(define (french_table_lookup abbr lst)
 ; (assoc_string key alist)
; Look up key in alist using string-equal.  This allow indexing by
; string rather than just symbols.
(assoc_string abbr lst))

(defvar french_no_of_days_in_month
  '( (1 31) (2 29)(3 31) (4 30)
     (5 31) (6 31) (7 31) (8 31)
     (9 30) (10 31) (11 30) (12 31)))

; part of festival-te Copyright (c) 2005, Chaitanya Kamisetty <chaitanya@atc.tcs.co.in>
(define (french_string_matches_date input_string)
  ;;returns true is the input string is in DD/MM(/YY/YYYY) format,
  (let ((date_segment1 (parse-number (string-before input_string "/"))) date_segment2 date_segment3 days_in_month)
  (cond
    ((not (string-matches input_string "[0-9][0-9]?/[0-9][0-9]?\\(/[0-9][0-9]\\([0-9][0-9]\\)?\\)?")) nil)
    (t
    (set! input_string (string-after input_string "/"))
    (set! date_segment2 (string-before input_string "/"))
    (if (string-equal date_segment2 "") (set! date_segment2 (parse-number input_string))
                (set! date_segment2 (parse-number date_segment2)))
    (set! date_segment3 (string-after input_string "/"))
    ;;checking for DD,MM to be in valid TODO
    ; (set! days_in_month (car (french_table_lookup date_segment2 french_no_of_days_in_month)))
    ; (if (and days_in_month (> date_segment1 0) (<= date_segment1 days_in_month)) 
    (if t
              (list date_segment1 date_segment2 date_segment3) nil))
)))

(defvar minuscule_without_accent_letter_list nil)

(set! minuscule_without_accent_letter_list 
  (list  "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z" ))

(defvar minuscule_with_accent_letter_list 
   (list "à" "á" "â" "â" "ä" "å" "æ" "ç" "è" "é" "ê" "ë" "ì" "í" "í" "î" "ï" "ñ" "ò" "ò" "ô" "ö" "û" "ù" "ú" "ü" "ā" "œ"))
(defvar majuscule_without_accent_letter_list
  (list "A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z" ))
;[A-Z] LANG=C

(defvar majuscule_with_accent_letter_list
  (list "À" "Á" "Â" "Â" "Ä" "Å" "Æ" "Ç" "È" "É" "Ê" "Ë" "Ì" "Í" "Í" "Î" "Ï" "Ñ" "Ò" "Ò" "Ô" "Ö" "Ù" "Ú" "Ü" "Ā" "Œ"))

(defvar symbol_list)
  (list "“" )
(defvar letter_list
  (list "A" "B" "C" "D" "E" "F" "G" "I" "H" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z" 
        "À" "Á" "Â" "Â" "Ä" "Å" "Æ" "Ç" "È" "É" "Ê" "Ë" "Ì" "Í" "Í" "Î" "Ï" "Ñ" "Ò" "Ò" "Ô" "Ö" "Ù" "Ú" "Ü" "Ā" "Œ"        
        "b" "c" "d" "f" "g" "h" "j" "k" "l" "m" "n" "p" "q" "r" "s" "t" "v" "w" "x" "y" "z" 
        "a" "à" "á" "â" "ä" "å" "ç" "e" "è" "é" "ê" "ë" "i" "ì" "í" "ñ" "î" "ï" "o" "ò" "ó" "ô" "ö" "u" "ù" "ú" "û" "ü"
        "à" "á" "â" "â" "ä" "å" "æ" "ā" "œ" 
        )) ; pour les locutions

(define (is_cap s)
  (member_string s (append majuscule_with_accent_letter_list majuscule_without_accent_letter_list)))






(define (nature-verb-na mot)
  (let (result root list_letters rlist_letters)
    ;(format t "3333 %s" mot)
    (set! list_letters (utf8explode mot))
     (set! rlist_letters (reverse list_letters))
   
    (cond    
            ; TODO xxx(e|es|s) 
            ((member_string mot (list 
                        "bu"
                        "bue"
                        "bus"
                        "entouré"
                        "aimé"
                        "redouté"
                        "redoutés"
                        "redoutées"
                        "passée"
                        "passé"
                        "passés"
                        "perdu"
                        "perdues"
                        "perdu"
            ))  (set! result "parpasseadj"))
            ((member_string mot (list "ai" "aie" "ait" "es" "est" "ont" "dis" "dit" "fis" "fît" "fit" "git" "lis" "lit" "mis" "mit" "pue" "tue" "tut" "ris" "rit" "vis" "vit" ))
             (set! result "divers court"))
            ((< (string-length_utf8 mot) 4)(set! result nil)) ; mer
            ((and (member_string (string-last mot) (list "r" "e"))
                (member_string (string-last (string-but-last mot)) (list "r" "i" "e"))
                ; *ure seul *lure
                (not (member_string (nth 2 rlist_letters)  (list "è"))); rivière
                  (not (member_string (nth 1 rlist_letters)  (list "t"))) ; poste
                (or (not (string-matches mot ".*ure") ) (string-equal (nth 3  rlist_letters ) "l"))
                (not (string-matches mot ".*è.re") )

                (not (string-matches mot ".*rre"))
                (not (string-matches mot ".*ie") )
                )
              (set! result "infinitif"))

            ((string-matches mot ".*ant")
              (set! result "gerondif"))

            ((string-matches mot ".*ât"); /!\ string-equal er utf8 (string-before  "baissât" "ât") -> baissa" !
            (set! result "subjonctif_3e"))
            
            ((string-matches mot ".*it"); vit, reçoit, aimait
            (set! result "3e"))
            
            ((string-matches mot ".*ez"); 
            (set! result "2e pl"))

            ((string-matches mot ".*âmes")
             (set! result "subjonctif_2e"))

            ((string-matches mot "[^ao]*[eo]nt") ; essuient, puent, (sent exception)s
              (set! result "3e p"))
            
            ((string-matches mot "[^e]*nt") ; vint, plaint, joint
              (set! result "3e"))
            (( and (member_string (string-last mot) (list "s" "z"))
                    (not (member_string (last2char mot) (list "os" "és" "oz" "uz" "iz" "az")))
                    (not (member_string  mot (list "elles"))) ; pour distinction détermination pos après qu'
                    (not (not (string-matches mot ".*lors")))) ; enfait seult *sors *dors sur *ors
              
              (set! result "2e")) ; sauf impératif ! mais bon 

            ((and (member_string (string-last mot) (list "e" "i"))(not (member_string  mot (list "elle"))))
              (set! result "1e")) ; sauf impératif ! mais bon 

            ((member_string mot (list 
                        "entouré"
                        "aimé"
                        "redouté"
                        "redoutés"
                        "redoutées"
                        "passée"
                        "passé"
                        "passés"
                        "perdu"
                        "perdues"
                        "perdu"
            ))  (set! result "parpasseadj"))
          )
         (format t "999 nature %s %s\n" mot result)
        result))

(define (nature-verb word)
  (nature-verb-na (na word)))



(define (write2-file filename string)
  "write2-file filename string) :cat string >> filename"
  (with-open-file (f filename "a")
    (fwrite (if (symbol? string) (format nil "%s" string) string) f)))


; 
(define (move filename_s filename_t)
    "mv filename_s filename_t"
    (if (not (null? filename_s))
      ; to be sure it exits so that it can be moved 
      (set! command (format nil "mv %s %s" filename_s filename_t))
                (system command))
    (if (and (not (null? filename_s))(not (null? filename_s)))
      (begin
        (set! command (format nil "touch --time=access %s" filename_s))
        (format t command)
        (unwind-protect(system command)))
      (format stderr "no move possible %s to %s\n" filename_s filename_t)))


;---[ list/string/symbol conversions ]------------------------------------------
; IMS_german

(define (list->string l)
  "(list->string L)
   Converts the list L into a string by using ``string-append''."

  (if (equal? (car l) nil)
    (set! str '"")
    (string-append (car l) (list->string (cdr l)))
  )
)


(define (list->-string l)
  "(list->-string L )
   Converts the list L into a string by using ``string-append''-"
   ; ("ahn" "t" "rh" "m" "eh" "l") -> "-ahn-t-rh-"

  (if (equal? (car l) nil)
    (set! str '"")
    (string-append "-" (car l)  (list->-string (cdr l)))
  )
)

      




(define (string->list s)
  "(string->list S)
   Converts the string S into a list by using ``utf8explode''.
   Each character in S becomes an atom in this list."
   ; check (debug 100 (format nil (string->list s) )  (string-length_utf8 (string->list s)))
   ; utf8explode SYMBOL  Returns list of atoms one for each character in the print name of SYMBOL
  (utf8explode s))

(define (split-string string separator)
  "(split-string string separator) -> list attention cas séparateur à une extrémité.."
  ; use regex?? We have to convert the weird XML attribute value type to string ??
  (if (or (string-matches string (string-append ".+" (char-quote separator) ".+"))
          (equal? (string-last string) separator)) ; 2403
    (cons (string-before string separator)
          (split-string (string-after string separator) separator))
    (list (string-append string ""))))

(define (char-quote string)
  (if (member string '("*" "+" "?" "[" "]" "."))
    (string-append "[" string "]")
    string))


(define (list->symbol l)
  "(list->symbol L)
   Returns the symbol derived from the concatenation
   of the printnames of the members of L."
  (if (equal? (cdr l) nil)
    (car l)
    ; Form new symbol by concatenation of the print forms of each of SYMBOL1
    ;s SYMBOL2 etc.
    (symbolconc (car l) (list->symbol (cdr l)))))

(define (symbol->string s)
  "(symbol->string S)
   Converts the symbol S into a string by using ``string-append''."
  (string-append s))

(define (remove_last l)
  "Removes the last element of a list and returns that shortened list."
  (reverse (cdr (reverse l))))

(define (remove* item list)
  "(remove* ITEM LIST)
   (Non-destructively) remove ITEM recursively from LIST."

  (cond
    ((null list)
      nil
    )
    ((eq? item (car list))
      (remove* item (cdr list))
    )
    (t
      (cons (car list) (remove* item (cdr list)))
    )
  )
)


; alist

; (define (sublis l exp)
;   "(sublis L EXP)
;    E.g. (sublis '((a . b)) exp)
;    returns exp where all a's are substituted with b's."

;   (if (cons? exp)
;     (cons (sublis l (car exp))
;           (sublis l (cdr exp)))
;     (let ((cell (assq exp l)))
;       (if cell
;         (cdr cell)
;         exp))))

;---[ cons? ]-------------------------------------------------------------------

; (define (cons? x)
;   "(cons? X)
;    Checks, whether X is an atom (-> f) or (-> t)."

;   (not (atom x))
; )


(define (add_to_list i lst)
  "add to list not set non destructive!"
  (cond
   ((member_string i lst)
    lst)
   (t
    (cons i lst))))

;;; mots

(define (string-car s)
  "Returns the first character of the string S as a string."
  (string-append (car (utf8explode s))))

(define (string-last s)
  "Returns the last character of the string S as a string if any,
  "" if none."
  (let (liste result)
    (set! liste (utf8explode s))
    (if (not (null? liste))
      (set! result (car(last liste)))
      (set! result ""))
    result))

(define (string-cdr s)
  "(string-cdr S)
   Returns all characters from the string S besides the first.
   without extraneaous blank !!"
   (list->string(cdr (utf8explode s))))

(define (string-but-last s)
  ""
  (list->string(remove_last(utf8explode s))))


(define (element-at lista n)
  "position à partir de 0"
  (if (equal? n 0)
      (first lista)
      (element-at (cdr lista) (- n 1))
    )
  )

;  Upper/Lower case conversion
; ---------------------------------
; GNU 'sed''s substitute command ('s') supports upper/lower case
; conversions using '\U','\L' codes.  These conversions support multibyte
; characters:
(define (french_downcase_string name)
  "(french_downcase_string name)
    Downcase a word and output it as a string"

    (if (not (null? name))
      (begin
        ;(debug 100 (format nil "french_downcase_string %s\n" name))
        (set! name (string-replace name "À" "à"))
        (set! name (string-replace name "Á" "á"))
        (set! name (string-replace name "Â" "â"))
        (set! name (string-replace name "Ä" "ä"))
        (set! name (string-replace name "Å" "å"))
        (set! name (string-replace name "Æ" "æ" )) ; ou ae
        (set! name (string-replace name "Ç" "ç"))
        (set! name (string-replace name "È" "è"))
        (set! name (string-replace name "É" "é"))
        (set! name (string-replace name "Ê" "ê"))
        (set! name (string-replace name "Ë" "ë"))
        (set! name (string-replace name "Ì" "ì"))
        (set! name (string-replace name "Í" "í"))
        (set! name (string-replace name "Î" "î"))
        (set! name (string-replace name "Ï" "ï"))
        (set! name (string-replace name "Œ" "œ" )); ou oe
        (set! name (string-replace name "Ò" "ò"))
        (set! name (string-replace name "Ó" "ó"))
        (set! name (string-replace name "Ô" "ô"))
        (set! name (string-replace name "Ö" "ö"))
        (set! name (string-replace name "Ù" "ù"))
        (set! name (string-replace name "Ú" "ú"))
        (set! name (string-replace name "Û" "û"))
        (set! name (string-replace name "Ü" "ü"))
        (set! name  (downcase name))
      )
      ""
    ))
(define (french_upcase_string name)
   (if (not (null? name))
        (begin
        ;(debug 100 (format nil "french_upcase_string %s\n" name))
        (set! name (string-replace name "à" "À"))
        (set! name (string-replace name "á" "Á"))
        (set! name (string-replace name "â" "Â"))
        (set! name (string-replace name "ä" "Ä"))
        (set! name (string-replace name "å" "Å"))
        (set! name (string-replace name "æ" "Æ" )) ; ou ae
        
        
        (set! name (string-replace name "ç" "Ç"))
        (set! name (string-replace name "è" "È"))
        (set! name (string-replace name "é" "É"))
        (set! name (string-replace name "ê" "Ê"))
        (set! name (string-replace name "ë" "Ë"))
        (set! name (string-replace name "ì" "Ì"))
        (set! name (string-replace name "í" "Í"))
        (set! name (string-replace name "î" "Î"))
        (set! name (string-replace name "ï" "Ï"))
        (set! name (string-replace name "œ" "Œ" )); ou oe
        (set! name (string-replace name "ò" "Ò"))
        (set! name (string-replace name "ó" "Ó"))
        (set! name (string-replace name "ô" "Ô"))
        (set! name (string-replace name "ö" "Ö"))
        (set! name (string-replace name "ù" "Ù"))
        (set! name (string-replace name "ú" "Ú"))
        (set! name (string-replace name "û" "Û"))
        (set! name (string-replace name "ü" "Ü"))
        ; (debug 100 (format nil "until now %s\n" name))
        (set! name  (upcase name)))
        

      ""
    ))
(define (french_downcase_initial name)
  (string-append (french_downcase_string (string-car name)) (string-cdr name)))
  

;
;; Utility to show the output of the tagger

;;;
(define (word_gpos tag word)
  "word_gpos \"ONO\" \"clac\""
  (member_string word (cdr (assoc_string tag INST_LANG_guess_pos))))

;;; docu_XXX ref 
(define (output-pos-tag utt)
  "Output the word/pos for each word in utt"
  (utt.flat_repr utt)
  (mapcar 
   (lambda (posinfo)
    (format nil "WORD:%l\tPOS=%l\tGPOS=%l\n" (car posinfo) (car (cdr posinfo)) (car (cdr (cdr posinfo)))))
   (utt.features utt 'Word '(name pos gpos))))
;;;
(define (tp utt )
  "alias utt.relation.print.utt. 'Token"
    (format nil "%l" (utt.relation.print utt 'Token)))
;;;
(define (wp utt )
    "alias utt.relation.print.utt. 'Word"
    (format nil "%l" (utt.relation.print utt 'Word)))

(define (sp utt )
    "alias utt.relation.print.utt. 'Segment"
    (format nil "%l" (utt.relation.print utt 'Segment)))

(define (ip utt ); TODO renommer trop restrictif
    "alias utt.relation.print.utt. 'Intonation"
    (format nil "%l" (utt.relation.print utt 'Intonation)))

; instead of item.name from lib/festival.scm
; surcharge comme lex.lookup ?? TODO
; (define (item.name s)
; "(item.name ITEM)
;   Returns the name of ITEM. [see Accessing an utterance]"
;   (item.feat s "name"))
(define (na ITEM)
  "na as the beginning of the word *name* use instead of the vanilla item.name, it doesn't raise a SIOD ERROR if name is nil, as its vanilla counterpart does SIOD ERROR: wrong type of argument to get_c_val"
  (if (not (null? ITEM))
    (unwind-protect 
      (item.name ITEM)
      (begin 
        ;(format stderr "strange DATA\n")
          nil))
      nil)) ; to be explicit

(define (pos ITEM)
  "from INST_LANG_utils"
  (if (not (null? ITEM))
    (item.feat 'pos ITEM)
    (format nil "pos na called with nil DATA")))


(define (OLDfirst_token utt)
    (format t "first_token obsolete use firsttoken")
    (firsttoken utt))

(define (firsttoken utt)
  "just a little bit safer"
  (if (and (not (null? utt)) (utt.relation.present utt 'Token))
    (utt.relation.first utt 'Token))
    (begin 
      (format nil "firsttoken called with no utt containing a Token  relation")
        ))


(define (test_segments text)
  "(test_segments TEXT)
  prints TEXT, Synthesizes TEXT and outputs the segments in it."
  (set! utt (utt.synth (eval (list 'Utterance 'Text text))))
  (mapcar
   (lambda (word) (debug 100 (format nil "%s " (car word))))
    (utt.features utt 'Segment '(name)))
  (debug 100 (format nil "\n"))     )

; from pauses
(define (find_last_seg word)
;;; Find the segment that is immediately at this end of this word
;;; If this word is punctuation it might not have any segments
;;; so we have to check back until we find a word with a segment in it
  (cond
   ((null word)
    ;(format stderr "wrong, it can happen 999 utils")
    nil)  ;; there are no segs (don't think this can happen) it does if  say "'"
   (t
    (let ((lsyl (item.relation.daughtern word 'SylStructure)))
      (if lsyl
        (item.relation.daughtern lsyl 'SylStructure)
        (find_last_seg (item.relation.prev word 'Word)))))))
;;;
(define (tpt_after_pause syl)
  "(tpt_after_pause syl)
  Returns t if segment immediately before this is a pause (or utterance
  start).  nil otherwise."
  (let ((pseg (item.relation.prev (item.relation.daughter1 syl 'SylStructure)
          'Segment)))
    (if (or (not pseg)
            (member_string
              (item.name pseg)
              (car (cdr (car (PhoneSet.description '(silences)))))))
        t
        nil)))

(define (tpt_find_syl_vowel syl)
  "(tpt_find_syl_vowel syl)
  Find the item that is the vowel in syl."
  (let ((v (item.relation.daughtern syl 'SylStructure)))
    (mapcar
      (lambda (s)
        (if (string-equal "+" (item.feat s "ph_vc"))
          (set! v s)))
      (item.relation.daughters syl 'SylStructure))
     v))     

(define (firstword utt)
  "utt's first word"
  (if (utt.relation.present utt 'Word)
    (utt.relation.first utt 'Word)))

(define (lastword utt)
  (if (utt.relation.present utt 'Word)
    (utt.relation.last utt 'Word)))
;;;

(define (firstphone word)
  (let (d result)
    (if (null? word)
      (begin 
        (set! result nil))
      (begin  
        (if (not (null? (item.relation word 'SylStructure)))
          (begin
            (set! d (item.daughter1
                    (item.relation word 'SylStructure)))
            (if (not (null? d))  
              (set! result (item.daughter1
                 (item.daughter1
                    (item.relation word 'SylStructure)))))
            ;(format t "firstphone word %s %s\n" (na word) (na result))
            ))))   
      result)) ; ;SIOD ERROR: wrong type of argument to get_c_val  !!


 

; the SyllStructure is a list of trees. This links the Word, syllable and
; segment. last phone  is the last segment
; daughtern=the last daughter
(define (lastphone word)
  "last phone of the word or nil"
  (let (result)
    (if (not (null? word))
      (begin 
        (set! result (item.daughtern (item.daughtern(item.relation word 'SylStructure)))))
      (begin 
        (format t "lastphone of null word ?") 
        (set! result nil)))
     result))
    

(define (afterphone word)
  "phone of the next word if any, nil otherwise"
  (if (null? (item.next word))
      nil
      (firstphone (item.next word))))


(define (baptize syl)
  "(baptize SYL)
  Baptizes the given syllable by concatenating together the names
  of it's daughters (phones). Useful in debugging."
  ;; ref finnish_mv_int
  (item.set_name syl 
     (let ((str ""))
       (mapcar 
        (lambda (x) 
          (set! str (string-append str (item.feat x "name"))))
        (item.daughters (item.relation syl 'SylStructure)))
       str)))

(define (baptize_ng syl)
  "(baptize SYL)
  Baptizes the given syllable by concatenating together the names
  of it's daughters (phones). Useful in debugging."
  ;; finnish_mv_int
  ; (item.daughters parent)
  ; Return a list of all daughters of parent.
  (set! str "-")
  (set! list_daughters (item.daughters (item.relation syl 'SylStructure)))
  (mapcar 
    (lambda (x) 
      (set! str (string-append str (item.feat x "name") "-")))
    list_daughters)
  str)

;;; WITH TEST

(define (is_with_unique_tiret name)
  "it could be at one extremity"
  (and (pattern-matches name "{[^-]+}-{[^-]+}{.*}") (equal? #3 "")))

(define (last2char name)
  (substring name (- (string-length_utf8 name) 2) 2))


(define (firstchar2-< name )
  (substring name 0 (-(string-length_utf8 name)2)))






;; docu rappel 
; (define (member ITEM LIST)
;   "Returns subset of LIST whose car is ITEM if it exists, nil otherwise." 
;   (if (consp list) (if (equal? item (car list)) list (member item (cdr list))) nil))


; (define (require fname)
; "(require FILENAME)
;   Checks if FNAME is already provided (member of variable provided) if not
;   loads it, appending \".scm\" to FILENAME.  Uses load_library to find
;   the file."
;  (let ((bname (intern (basename fname))))
;   (if (null? (member bname provided))
;       (format  stderr "\t%s required for the first time\n" fname)
;       (progn
;         ;;; Compiled files aren't faster, so we don't do this
;         ; (fasload_library (string-append fname ".bin"))
;        (load_library (string-append fname ".scm"))
;         't)
;     (format  stderr "%s already provided" fname))))


; (define (provide fname)
; "(provide FILENAME)
;   Adds FNAME to the variable provided (if not already there).  This means
;   that future calls to (require FILENAME) will not cause FILENAME to
;   be re-loaded."
;   (if (null? (member fname provided))
;       (begin 
;         (format stderr "from %s\n" fname)
;         (set! provided (cons fname provided)))))

;   (if (null? (member fname provided))
;       (begin 
;         (format stderr "from %s\n" fname)
;         (set! provided (cons fname provided)))))


(define (sqr number)
  "(sqr NUM)
NUM ** 2."
  (* number number))

(define (neg number)
  "(neg number)
Negates a number -- Festival SIOD doesn't understand (- number), but
requires TWO arguments to the '-' operator"
  (* -1 number))


(define (min num1 num2)
  "(min num1 num2)
Returns the smaller of the two."
  (cond ((<= num1 num2)
        num1)
        (t num2)))

(define (max num1 num2)
  "(max num1 num2)
Returns the greater of the two."
  (cond ((<= num1 num2)
        num2)
        (t num1)))

;---[ insert quote in list ]----------------------------------------------------
;  ("%s %l" "test" (a b)) becomes ("%s %l" "test" (quote (a b)))
(define (insert_quote param_list)
  "(insert_quote PARAM_LIST)
   Inserts a quote in front of each element that is a list.
   (\"%s %l\" \"test\" (a b)) becomes (\"%s %l\" \"test\" (quote (a b)))"

  (set! param_list
    (apply append
      (mapcar
        (lambda (elem)
          (if (and (pair? elem)
                   (or (pair? (car elem))
                       (not (string-equal (car elem) "quote"))))
            (set! elem (append '(quote) (list elem)))
          )
          (list elem)
        )
        param_list
      )
    )
  )

  param_list
)

(define (string-mybefore ATOM BEFORE)
  (let (result)
  (set! result (string-before ATOM BEFORE))  
  (format t "vanilla |%s|\n" result)  
  (if (string-equal result "")
      (begin 
        (set! result ATOM)
        (format t "mon |%s|\n" result)))
  result ))

(provide 'INST_LANG_utils)
