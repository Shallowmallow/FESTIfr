
(defvar lexdebuglevel 0)
(require 'INST_LANG_util)
; lisp_onset_stop voir festvox/src/duration/logdurn.scm
; lisp_onset_fric
; lisp_onset_nasal
; lisp_onset_glide
; lisp_coda_stop
; lisp_coda_fric
; lisp_coda_nasal
; lisp_coda_glide
(defvar verbose_phoneutils t)
(define (?pois phone feature)
  "voir phoneutils:  Return the feature for given phone in current phone set, or 0 if it doesn't exist."
  ; phone_feature
  ; Return the feature for given phone in current phone set, or 0 if it doesn't exist."
  (set! res (cond 
    ((and (string-equal feature "vowel") (string-equal "+" (phone_feature phone "vc"))) t) ;   "i e eh a o ae eu y u oe oh ah ehn oen ohn ahn"
    ; gloups !
 ;;   ((and (string-equal feature "semivowel") (string-equal "s" (phone_feature phone "vlng")))  t) ;   "hw w j"
     ((and (string-equal feature "semivowel") (member_string phone (list "hw" "w" "j"))) t)
    ((and (string-equal feature "liquid") (string-equal "l" (phone_feature phone "ctype")))  t) ; "rh l"
    ((and (string-equal feature "nasal") (string-equal "n" (phone_feature phone "ctype")))  t) ; n m ng jg
    ((and (string-equal feature "fricative") (string-equal "f" (phone_feature phone "ctype")))  t) ; f v z zh s

    ((and (string-equal feature "stop") (string-equal "s" (phone_feature phone "ctype")))  t) ;   "g k b p d t"
 ;;   ((and (string-equal feature "consonnant") (string-equal "0" (phone_feature phone "vlng")))  t) 

  (t nil)))
    ;(format stderr "phone %l\n feature\t %s : %s\n " phone feature res)
    res)

(define (?polistcontains poslist type)
  " "
  (let (q)
  (set! q nil)
  (dolist (var poslist) 
     (set! q (or q (?pois var type)))
     ;(format stderr "now %s ? %l\n" type q)
     ) q))

(define list_pho_vow (list "a" "ah" "ahn" "ae"  "e" "eh" "ehn" "eu" "i" "o" "oh" "ohn" "oe" "oen" "u" "y")) 

;; INST_LANG_syl_boundary de flite
;; on ne sert que de (?polistcontains poslist "vowel") au final

(define (INST_LANG_lex_sylbreak currentsyl rest)
  "(INST_LANG_lex_sylbreak currentsyl rest)
    t if this is a syl break, nil otherwise."
    ; TODO buggy si - ex: ouvre-bouteille obsolete ?
    ; parer par entrée "ouvre bouteille" nil
    (cond
      ; ((format t "no rest?\n" )  nil) ;     ; plus rien on arrete
      ; ((null? rest) (format t "\t!!no rest \n")t)

      ((and (> lexdebuglevel 10100)(null? currentsyl)) 
        (format t "\t!!P1 no currentsyl\n" )nil) 

      ((and (> lexdebuglevel 10100)(format t "P2 currentsyl sans voyelle ????\n" )  nil))
      ((not(?polistcontains currentsyl "vowel")) 
         (lexdebug 10000 (format nil "\tP2\n" )) nil)

      
      ((and (> lexdebuglevel 10100)(format t "P3 rest sans voyelle ????\n" )  nil))
      ((not (?polistcontains rest "vowel")) 
        (lexdebug 10000 (format nil "\tP3 s t o ? p\n")) 
         nil) 

      ((and (> lexdebuglevel 10100)(format t "P4 double en vue\n" )  nil))
      ((string-equal (car rest) (cadr rest)) ;; like the double m in homme-machine
        (lexdebug 10000(format t "\tP4\n")); oh ? m m
        nil)

      ((and (> lexdebuglevel 10100)(format t "P5 a-j non suivi voyelle\n" )  nil))
      ((and 
        (member_string (first currentsyl) list_pho_vow)
        (member_string (first rest) (list "j"))
        (not (member_string (second rest) list_pho_vow))
        )
    ;;; TODO et jg et ng ???
        (lexdebug 100000(format t "\tP5 m u j ? "))
      nil)


      ((and (> lexdebuglevel 10100)(format t "P6 t-? impo\n" )  nil))
      ((and 
        (member_string (first rest) (list "g" "k" "b" "d" "t" )) ; stop  "p" ; p demon-tpneu
        (member_string (second rest) (list "b" "k" "d" "f" "g"  "jg" "m" "n" "ng" "p" "s" "t" "v"  "sh" )) 
        ); sauf "l"  tla,  "rh",  "sh" bin | tje sco | tcher, "z":mezzo  t z o mais eh g | z a k t     "zh"  blackjack)
        (lexdebug 10000 (format nil "\tP6 t-d impo"))
        nil); s w a s ahn t d i, (s eh p t ahn t s i s)) ; +2r sh ? (g a rh d sh i j u rh m))

      ((and (> lexdebuglevel 10100)(format t "P6-1 g-? impo\n" )  nil))
      ((and 
        (member_string (first rest) (list "g" "k" )) ;
        (member_string (second rest) (list "z"))
        )
        (lexdebug 10000 (format nil "\tP6-1 g-z impo"))
        nil)

      ((and (> lexdebuglevel 10100)(format t "P6-3 p-? impo\n" )  nil))
      ((and 
        (member_string (first rest) (list "p")) ;
        (member_string (second rest) (list "d" "p" "sh" "m")) ;  ; blackjack (k ahn p m ahn))
        )
        (lexdebug 10000 (format nil "\tP6-3 p-d impo"))
        nil)



      ((and (> lexdebuglevel 10100)(format t "P6-4 p-? impo\n" )  nil))
      ((and 
        (member_string (first currentsyl) list_pho_vow)

        (member_string (first rest) (list "p")) ;
        (member_string (second rest) (list "n")) ; n(a t rh a p n i g o)) 
        )
          (lexdebug 10000 (format nil "\tP6-3 p-d impo"))
          nil)


      ((and (> lexdebuglevel 10100)(format t "P6-5 V b l-? impo\n" )  nil))
      ((and 
        (member_string (first currentsyl) list_pho_vow)

        (member_string (first rest) (list "b" "t" "d" "f")) ;
        (member_string (second rest) (list "l" "rh")) ; 
        (not   (member_string (third rest) list_pho_vow))

        )
          (lexdebug 10000 (format nil "\tP6-5 V b l")) ; ("double-cliquer" nil (d u b l k l i k e ))
          nil)
      ; ((format t "P6-2 d-? impo\n" )  nil)
      ; ((and 
      ;   (member_string (first rest) (list "d" )) ;
      ;   (member_string (second rest) (list "l"))
      ;   )
      ; (format t "\tP6-2 d-l impo") ; acceptable ...
      ; nil);(d oh d l i n ahn)

      ((and (> lexdebuglevel 10100)(format t "P7 m-? impo\n" )  nil))
      ((and 
        (member_string (first rest) (list "m" "n" "jg" "ng" )); nasal?
        ;; TODO pas voyelle si vrai
        (member_string (second rest) (list "b" "k" "d" "f" "g"  "jg" "l" "m" "n" "ng" "p"  "rh" "s" "sh" "t" "v" "z" "zh"))
        ); sauf ??
          (lexdebug 10000 (format nil "\tP7 m-d impo"))
          nil); 
      ; TODO regroup cas précédent
      ((and (> lexdebuglevel 10100)(format t "P8 l-? impo\n" )  nil))
      ((and 
        (member_string (first rest) (list "l" "rh")); ; liquid 
        (member_string (second rest) (list "b" "k" "d" "f" "g"  "jg" "l" "m" "n" "ng" "p"  "rh" "s" "sh" "t" "v" "z" "zh"))
        ); sauf 
          (lexdebug 10000 (format nil "\tP8 l-d impo"))
          nil); 


      ((and (> lexdebuglevel 10100)(format t "P9 f-? impo\n" )  nil)) 
      ((and 
        (member_string (first rest) (list "f" "v" "z" "zh" "s" "sh")); ; fricative ? sauf s?
        (member_string (second rest) (list "b" "k" "d" "f" "g"  "jg" "m" "n" "ng" "p"  "s" "sh" "t" "v" "z" "zh"))
        ); sauf "l"   "rh"
         (lexdebug 10000 (format nil "\tP9 f-d impo\n"))
          nil);  (g oh l f   k l oh b))


      ; ((format t "RP3 3C ? \n" )  nil) 
      ; (
      ;   (member_string (list->string (list (first rest) (second rest)(third rest) )) 
      ;      (list "spk" "strh" "spl" "sprh" "skl" "skrh"))
      ;   ; sauf "l"   "rh"
      ; (format t "\tR3%s %s %s\n" (first rest) (second rest) (third rest))
      ; nil)

      ((and (> lexdebuglevel 10100)(format t "R1 t ? \n" )  nil)) 
      ((and 
        (member_string (first rest) (list "t" )); ;
        (member_string (second rest) (list "b" "k" "d" "f" "g"  "jg" "m" "n" "ng" "p"  "s" "sh" "t" "v" "z" "zh"))
        ); sauf "l"   "rh"
          (lexdebug 10000 (format nil "\tR1\n"))
           t)



      ((and (> lexdebuglevel 10100)(format t "R2 t ? \n" )  nil))
      ((and 
        (member_string (first currentsyl) (list "k"  )); ; blackjack (g a rh d sh i j u rh m))
        (member_string (first rest) (list "b" "k" "d" "f" "g"  "jg" "m" "n" "ng" "p"  "s" "sh" "t" "v" "z" "zh"))
        ); sauf "l"   "rh"
      (lexdebug 10000 (format nil "\tR2\n"))
      t)





      (t 
         (lexdebug 10000 (format nil "\t\trupture other  currentsyl:%l rest:%l\n" currentsyl rest  ))

      t));; Break otherwise.
    )



; laborieux ..
(define (changepho_jg->nj phones)
  ; ("jg" "o")-> ("n" "j" "o")
  (set! new_phones nil)
  (mapcar 
    (lambda (p)
      ;(format t "ph %s\n" p)
      (if (equal? p "jg")
        (set! new_phones (append (list "j" "n") new_phones))
        (set! new_phones (append (list p) new_phones))
      ))
    phones)
  (reverse new_phones))

(define (changepho_ah->a phones)
  ; ("jg" "o")-> ("n" "j" "o")
  (set! new_phones nil)
  (mapcar
    (lambda (p)
      ;(format t "ph %s\n" p)
      (if (equal? p "ah")
        (set! new_phones (append (list "a") new_phones))
        (set! new_phones (append (list p) new_phones))
      ))
    phones)
  (reverse new_phones))




(define (amend phones)
    ; hw i -> hw ?
    (changepho_jg->nj phones))






; see lexicon.cc 
; "(lex.syllabify.phstress PHONELIST)\n\
; Syllabify the given phone list (if current phone set).  Vowels may have\n\
; the numerals 0, 1, or 2 as suffixes, if so these are taken to be stress\n\
; for the syllable they are in.  This format is similar to the entry format\n\
; in the CMU and BEEP lexicons. [see Defining lexicons]"


(define (INST_LANG_lex_syllabify_phstress phones) ; 
  " syllabify list of phones (buggy)"
  ; (list "k" "a"  "t" "rh" "m" "ehn"))
  ; BUG-> (((\"k\" \"a\") 0) ((\"t\" \"rh\" \"m\" \"ehn\") 0))
   
  ; ne pas travailler sur tout le rest 
  ; sur 3 + 1 premiers phones  s t rh o 
  ; reprendre mon algo perl 
  ; faux pour 
    ; INST_LANG_lex_sylbreak currentsyl: nil
    ; INST_LANG_lex_sylbreak currentsyl: ("ahn")
    ; INST_LANG_lex_sylbreak currentsyl: nil
    ; INST_LANG_lex_sylbreak currentsyl: ("t")
    ; INST_LANG_lex_sylbreak currentsyl: ("rh" "t")
    ; INST_LANG_lex_sylbreak currentsyl: ("m" "rh" "t")
    ; INST_LANG_lex_sylbreak currentsyl: ("eh" "m" "rh" "t")
    ; INST_LANG_lex_syllabify_phstress ("ahn" "t" "rh" "m" "eh" "l"):  ((("ahn") 0) (("t" "rh" "m" "eh" "l") 0))


  (let (result (syl nil) (syls nil) (p phones) (stress 0))
    (while p
           (set! syl nil)
           ;(format stderr "looking for a syllabe\n")
           (while 
             (and p (not (INST_LANG_lex_sylbreak syl p)))
             (if (> lexdebuglevel 1000)
                 (format t "phone: %l\n" (first p)))
             (set! stress 0); (whatever_you_do_to_identify_stress p syl))
             (set! syl (cons (first p) syl))
             ;(format stderr "syl syllabe en cours %l avec %l \n" syl p)
             (set! p (cdr p)); au suivant
             )
           (set! syls (cons (list (reverse syl) stress) syls))
           ;(format t "syls syllabify: %l\n" syls)
           )
    (set! result (reverse syls))

    (if verbose_phoneutils (format t "\nINST_LANG_lex_syllabify_phstress %l: \n \(lex.add.entry '\( \"XXX\" nil %l\)\)\n" phones result))
    result))



(define (whatever_you_do_to_identify_stress  phone syl)
  "now stress set to 0"
   0)



; pour calquer cmulex 
(define (netlex_has_vowel p)
  ; (cond
  ;  ((null p) nil)
  ;  ((string-matches (first p) "[aeiouy].*")  ;; a vowel PAS @ mais y
  ;   t)
  ;  (t
  ;   (netlex_has_vowel (cdr p)))))
  (?polistcontains p "vowel"))


(define (INST_LANG_phone_list)
  ; i e eh a oe ae eu y u o oh ah ehn oen ohn ahn 
  ; w j hw n jg ng g k m b p v f d t sh zh z s rh l h hh pau
  (set! fnames (second (assoc (quote phones) (PhoneSet.description))))
  (mapcar (lambda  (t) (first t)) fnames))

(define (is_phone name)
  (member_string name (INST_LANG_phone_list)))





;; not used 
;; 
;;  (define (ph_sonority phone)
;;     "voir phoneutils"
;;     ; phone_feature
;;     ; Return the feature for given phone in current phone set, or 0 if it doesn't exist."
;;     (set! res (cond 
;;       ((string-equal "+" (phone_feature phone "vc")) 5) ;   "i e eh a o ae eu y u oe oh ah ehn oen ohn ahn"
;;       ((string-equal "+" (phone_feature phone "cvox")) 2) ;   "g b v d zh z rh"
;;       ((string-equal "l" (phone_feature phone "ctype"))  4) ; "rh l" // || glide
;;       ((string-equal "n" (phone_feature phone "ctype"))  3) ; n m jg ng
;;       (t 1)))
;;       res)

  ; Les syllabes sont habituellement décrites comme étant composées d’une *attaque* (les consonnes qui la
  ; débute),et d’une rime (la voyelle et les consonnes qui la suivent).
  ; Dans «crac»,l’attaque est« cr» et la rime« ac».
  ; La *rime* se décompose elle-même en un noyau (la voyelle) et un *coda* (la ou les consonnes qui terminent éventuellement la
  ; syllabe).
  
(provide 'INST_LANG_phoneutils)
