;; dépendance aux noms de phonemes
;; expliciter docu_XXX
;; /home/dop7/MyDevelop/Voices/french_EXP2/LANGandDICT/lang_INST_LANG/INST_LANG_postlex.scm
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                                                                       ;;
;;;                Centre for Speech Technology Research                  ;;
;;;                     University of Edinburgh, UK                       ;;
;;;                         Copyright (c) 1997                            ;;
;;;                        All Rights Reserved.                           ;;
;;;                                                                       ;;
;;;  Permission is hereby granted, free of charge, to use and distribute  ;;
;;;  this software and its documentation without restriction, including   ;;
;;;  without limitation the rights to use, copy, modify, merge, publish,  ;;
;;;  distribute, sublicense, and/or sell copies of this work, and to      ;;
;;;  permit persons to whom this work is furnished to do so, subject to   ;;
;;;  the following conditions:                                            ;;
;;;   1. The code must retain the above copyright notice, this list of    ;;
;;;      conditions and the following disclaimer.                         ;;
;;;   2. Any modifications must be clearly marked as such.                ;;
;;;   3. Original authors' names are not deleted.                         ;;
;;;   4. The authors' names are not used to endorse or promote products   ;;
;;;      derived from this software without specific prior written        ;;
;;;      permission.                                                      ;;
;;;                                                                       ;;
;;;  THE UNIVERSITY OF EDINBURGH AND THE CONTRIBUTORS TO THIS WORK        ;;
;;;  DISCLAIM ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING      ;;
;;;  ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT   ;;
;;;  SHALL THE UNIVERSITY OF EDINBURGH NOR THE CONTRIBUTORS BE LIABLE     ;;
;;;  FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES    ;;
;;;  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN   ;;
;;;  AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION,          ;;
;;;  ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF       ;;
;;;  THIS SOFTWARE.                                                       ;;
;;;                                                                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;  Postlexical rules
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;           Modifed for CSTR HTS Voice Library                           ;;
;;                 Author :  Junichi Yamagishi (jyamagis@inf.ed.ac.uk)    ;;
;;                 Date   :  Sept 2008                                    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar verbose_postlex nil)
; nom temporaire
(defvar modeaddenda nil)
; pourquoi pas INST_LANG::addenda_stage ?

(require 'INST_LANG_utils)
(require 'util) ; for debug rules assoc-set
(require 'INST_LANG_patternmatch); for pattern-matches

(define (INST_LANG_lex::postlex_corr utt)
  "postlex runtime"
  (let (
        (n 0); avec décompte pour débogage
        (word (firstword utt))
        na_word prev_word pos_word after_phone next_word na_next_word
        last_phone; dernière lettre du mot appartenant ou non à la liste des finales pouvant donner lieu à une liaison
        (list_finale_int (list "i" "l" "c" "d" "f" "g" "k" "n" "p" "q" "r" "s" "t" "x" "z" "_" "y")); TODO déplacer ?
        _l_ ; nil ou finale d'intérêt
        listdenat
        liaisonlike
        _p_
        a
        (avant (utt.flat_repr utt))
         apres)
    ; collecte prévue
    (unwind-protect
      (set! ofd (fopen fileidA "w")))
    (while word
      (set! na_word (na word))
      (set! pos_word (item.feat word 'pos))
      ;;; actions sur word 
      ; préalable lexical
      ; sauf exceptions un VER *tions se prononce s j ohn, un NOM * tions se prononce t j ohn 
      (if (string-matches na_word ".*tions$")
          ; prévoir erreur Postlex fiabilité pb VER/AUX sûr ??
          (begin 
              (if (member_string pos_word (list "VER" "AUX"))
                  (if (not (is_exc_vertions na_word)) (sjohn->tjohn word))
                  (if (not (is_exc_nomtions na_word)) (tjohn->sjohn word)))))
      ; (if (string-matches na_word ".*tions-nou$") abandon tempo ? vu peu fiabilité pb VER/AUX cas traité par lts
      ; alors que ".*tions-nous" nécessairement un VER (ou étions-nous mis dans le dico)

      ; liaisons
      (if verbose_postlex (format t  "verbose_postlex \t\t\t\ton s'occupe de %s, word n°: %s\n:" na_word  n))
      (set! next_word (item.next word)) ; possibly nil avec sortie boucle
      (set! na_next_word (na next_word))
      (set! last_phone (lastphone word)); pour le cas 1 des denat
      (if verbose_postlex
        (if lastphone  
             (if verbose_postlex (format t "verbose_postlex last_phone %l\n" (na last_phone)))
             (if verbose_postlex (format t "verbose_postlex no last_phone !\n"))))
      ; mémorise aussi pour lecture suivant, pas seulement utile pour le mot courant : bon donne p.e -> b oh + n
      ; mais aussi un ami  -> oen + n a altération prévue du mot suivant
      (set! _l_ (car (member_string (string-last na_word) list_finale_int)))
      (set! _p_ (lieavec _l_))
      ; en général           (set! _p_   (string-last na_word)) mais .. ex f -> v  dans neuf ans 
      (if verbose_postlex (format t "question punc %s\n" (item.feat word 'R:Token.parent.punc)) )
      (if verbose_postlex (format t "si liaison, la liaison sera %s\n" _p_))
      (if verbose_postlex (format t "INST_LANG_lex::postlex_corr: w_peut_se_denat? %s\n" (if (w_peut_se_denat? word) "oui" "non")))

      ; conditions de liaison:
       ; 1: pas de gêne de ponctuation et preponctuation
       ; 2: compatibilité des pos de mots liant et lié
     ; (format t "pos_word: %l\n" pos_word) ;  pos_word: "PRO:dem"
     ; (format t "item.feat next_word 'pos:%l\n" (item.feat next_word 'pos) ); item.feat next_word 'pos:"PRO:rel"
     ; (format t "na_word %l\n" na_word); na_word "ce"
     ; (if next_word (format t "na_next_word %l\n" na_next_word)); na_next_word "qui"
      


     

      (if (and next_word
           (equal? (item.feat word 'R:Token.parent.punc) 0); 0 si pas de ponctuation après word
           (equal? (item.feat next_word 'R:Token.parent.prepunctuation) ""); pa de préponctuation du mot suivant
           (is_exception pos_word (item.feat next_word 'pos) na_word na_next_word)
           )
        (begin
          (if (w_peut_se_denat? word)
            ; chgts éventuels viendront du mot suivant
            ; les changements sont à anticiper puisque la lecture se fait de gauche vers droite, sans retour !
            ; coup d'oeil à droite, mémorisation, lecture du mot actuel
            ; ex cas de  "bon" pas de phoneme voyellique à droite -> ohn , sinon :oh
            (begin
              (set! after_phone (firstphone next_word))
              ; XXXX critère vowel pas suffisant exceptions ! bon haricot -> passage au phonème
              ; mais pas seulement les h ululement, etc XXXx next word
              ; doit "leftliable"
              (if verbose_postlex (format t  "verbose_postlex \t\t\t\tafter_phone de %s, %s\n:" na_word  (na after_phone)))
              (if (?pois (na after_phone) "vowel")
                (begin 
                    (if verbose_postlex (format t "%l:\n est une voyelle" (na after_phone )))
                    (set! listdenat (list (denatphon (na last_phone) na_word)))
                    (if verbose_postlex (format t "listdenat %l\n" listdenat))
                    (if verbose_postlex (format t "after_phone %l\n" (na after_phone)))
                    (item.relation.insert last_phone 'Segment listdenat 'before);  ohn -> b oh ohn / oe v f 
                    (if verbose_postlex (format t "insert lastphone %l\n" last_phone))
                    (item.insert last_phone listdenat 'before) 
                    (if verbose_postlex (format t "relation insert lastphone %l\n" last_phone))
                    (item.relation.insert last_phone 'Segment (list _p_) 'before); b oh n ohn / oe v f " "
                    (if verbose_postlex (format t "delete lastphone %l\n" last_phone))
                    (item.delete last_phone)
                    (if verbose_postlex (format t "insert after_phone %l\n" after_phone))
                    (if verbose_postlex (format t " so far %l\n" (utt.flat_repr utt)))
                    ; hmm altération conjointe
                    ; les chgts éventuels viennent du mot précédent (donc déjà lu)
                    ; on a mémorisé l'éventuelle consonne qui construit la liaison potentielle
                    ; 2 pour rappeler que la lecture est influencée ppr le mot 1 précédent, hmm
                    (set! syl2 (item.relation.daughter1 (item.next word) 'SylStructure)); first -> bon
                    (if verbose_postlex (format t "on travaille sur %s et liaison %s\n" na_word _p_))
                    (if verbose_postlex (format t "verbose_postlex debug baptize syl2: %s\n" (baptize_ng syl2)))
                    (if verbose_postlex (format t "on travaille sur %s et liaison %s\n" na_word _p_))
                    (if verbose_postlex (format t "daughter1 syl2\n"))
                    ; (set! a (item.relation.daughter1 syl2 'SylStructure ))
                    (set! a (item.daughter1 syl2))
                    (if verbose_postlex (format t "XXX 1st %s\n" (na a)))
                      ; par chance notation nasale  ! ...ahn donne a qui est tout autant voyelle 
                      ; TODO pas tout compris ! surtout la description d'un item c'est fait comment
                      ; Insert ITEM2 in ITEM1's relation with respect to DIRECTION.  If DIRECTION is
                      ; unspecified, after, is assumed.  Valid DIRECTIONS as before, after, above and
                      ; below.  Use the functions item.insert_parent and item.append_daughter for
                      ; specific tree adjoining.  If ITEM2 is of type item then it is added directly,
                      ; otherwise it is treated as a description of an item and new one is created.

                    (if verbose_postlex (format t "insert a \n"))
                    (if verbose_postlex (format t "_p_%l\n" _p_))
                    (item.insert a (list _p_) "before")
                    (if verbose_postlex (format t "sofar %s\n" (utt.flat_repr utt))))
                (begin 
                  (set! _p_ nil))
                  )
            )
            (begin ; cas simple
              (if _p_
                (begin
                  (set! syl2 (item.relation.daughter1 (item.next word) 'SylStructure))
                  (if verbose_postlex (format t "INST_LANG_lex::postlex_corr XXX start2\n"))
                    (set! a (item.daughter1 syl2))
                    (if verbose_postlex (format t "XXX 1st %s\n" (na a)))
                  ; 20/11
                  ; (set! a (item.relation.daughter1 syl2 'SylStructure ))
                  ; (format t "a:%l" a)
                  ; (format t "na a:%s" (na a))
                  (if (?pois (na a) "vowel")
                      (begin
                        (if verbose_postlex (format t "999 XXX start3\n"))
                        (item.insert a (list _p_) "before")
                        (if verbose_postlex (format t "999 XXX start4\n"))
                        (if (lastphone word)
                            (item.relation.insert (lastphone word) 'Segment (list _p_) 'after))
                        (if verbose_postlex (format t "999 XXX start5\n"))
                        ))))))
          )
        (begin  ; d'emblée pas d'altération possible
            ;   (format t "pas d'altération\n")
            ;   ; dans les 2 cas restants : on ne fait rien
            ;   (if (null? next_word) 
            ;     (begin 
            ;         (if verbose_postlex (format t "verbose_postlex rien derrière %s\n" (na word)))
            ;          )
            ;     (begin 
            ;          (if verbose_postlex (format t "verbose_postlex on a une ponctuation derrière %s ?\n" (na word))))))
        )
      )
      (if verbose_postlex (format t  "verbose_postlex \t\t\t\tXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\n"))
      ; passage au mot suivant 
      (set! prev_word word)
      (set! word next_word)
      (set! n (+ 1 n))

    ); while finished 
    (unwind-protect (fclose ofd))
    utt))


; TODO weird names 
(defvar INST_LANG_lex::postlex_default INST_LANG_lex::postlex_corr)

(if modeaddenda
    (begin 
      (require 'INST_LANG_postlex_addenda)
      (set! postlex_rules_hooks (list INST_LANG_lex::postlex_adde)))
    (begin    
      (set! postlex_rules_hooks (list INST_LANG_lex::postlex_default))))

(define (INST_LANG_PostLex utt)
  "(PostLex utt)
  INST_LANG Apply post lexical rules to segment stream.  These may be almost
  arbitrary rules as specified by the particular voice, through the
  postlex_hooks variable.  A number of standard post lexical rules
  sets may be  provided including reduction, posessives etc.  These
  rules may also been used to mark standard segments with their cluster
  information used in creating diphone names."
  (let ((rval (apply_method 'PostLex_Method utt)))
    (cond
      (rval rval) ;; new style 
      (t   ;; should only really need this one
          (error "erreur provoquée PostLex")
          (apply_hooks postlex_rules_hooks utt)))
    utt))
;;;
; (define (Classic_PostLex utt)
;   "(Classic_PostLex utt)
;     Apply post lexical rules (both builtin and those specified in 
;     postlex_rules_hooks)."
;   (Builtin_PostLex utt)  ;; haven't translated all the rules yet
;   (apply_hooks postlex_rules_hooks utt)
;   utt)  
;;; until we choose our postlex_rules, we don't want the americanenglish ones.
; ; pas set !!
; (defvar postlex_rules_hooks nil
;   "postlex_rules_hooks
;   A function or list of functions which encode post lexical rules.
;   This will be voice specific, though some rules will be shared across
;   languages.")
;;;
(define (seg_word_final seg)
  "Is this segment word final?"
  (let ((this_seg_word (item.parent (item.relation.parent  seg 'SylStructure)))
        (silence (car (cadr (car (PhoneSet.description '(silences))))))
        next_seg_word)
    (if (item.next seg)
      (set! next_seg_word (item.parent (item.relation.parent (item.next seg) 'SylStructure))))
    (if (or (equal? this_seg_word next_seg_word)
          (string-equal (item.feat seg "name") silence))
      nil
      t)))
;;;
(defvar  debugliaison t) ; tempo mise au point
;;;
(define (w_peut_se_denat? word)
  "blabla todo"
  (peut_se_denat? (na word)))
;;;
; (defvar exclus (complement identity))
; relancer la voix avec  (set! fileidA "ADDENDA/D") pour check_addenda
(defvar fileidA nil "")

;;;
;; (defvar (INST_LANG_lex::postlex_rule0 utt)
;;   ;;(postlexdebug -1 (format nil "... INST_LANG_lex::postlex_rule0 utt\n" ))
  
;;   (postlexdebug 1 (format nil "no postlex_rule"))
;;   "no postlex rules")
;;;  TODO?
;; (defvar (INST_LANG_lex::remove_empty_syllabes utt)
;;   (postlexdebug -1 (format nil "666 TODO bidon INST_LANG_lex::remove_empty_syllabes\n" ))
;;   (mapcar 
;;     (lambda (syll)
;;       (if (not null? syll)
;;         (unwind-protect (postlexdebug -1 (format nil "666 %s\n"  (na (baptize syll)))))))
;;     (utt.relation.items utt 'Syllable))
;;     "juste pour info pas effectif TODO ?")
;;;
(define (replace_pen_phone word liste_phone)
  "insertion + suppression ex: liste_phone (list \"s\")  member of PhoneSet \"INST_LANG\", no check"
  ;;(postlexdebug -1 (format nil "... replace_pen_phone word liste_phone\n" ))
  ;remplacement du phone  précédant le dernier ohn par le phone t 
  (let (ohn_phone  s_phone)
    (set! ohn_phone (lastphone word))
    (set! s_phone (item.prev (item.prev ohn_phone )))
    (if (not (null? s_phone))
      (begin 
          (item.relation.insert s_phone 'Segment liste_phone 'after)
          (item.delete s_phone)
          (set! syl (item.relation.daughtern word 'SylStructure))
          (set! j (item.relation.daughter1 syl 'SylStructure ))
          (item.insert j liste_phone "before")))))
;;;
(define (tjohn->sjohn word)
  (postlexdebug -1 (format nil "... tjohn->sjohn word\n" ))
  "refactoring ..."
  (replace_pen_phone word  (list "s")))
;;;
(define (sjohn->tjohn word)
  (postlexdebug -1 (format nil "... sjohn->tjohn word\n" ))
  "refactoring ..."
  (replace_pen_phone word  (list "t")))
;;;
; TODO liste ex objectif intéressant t i . f ehn t
; reprendre du même coup denat
;; /douteux
;;       ((member_string _l_ (list "i"))
;;      "j")
;; douteux comme liaison, et douteux comme code si suppression totale comment ne pas provoquer
;; d'erreur
;;
;; douteux\
;; /douteux_douteux
;;       ((member_string _l_ (list "_"))
;;      "")
;; on parle phoneme non "" ou nil ou pau
;; cas "_" ?
;; cas error ne devrait pas se produire
;; douteux_douteux\
(define (lieavec _l_)
  ;;(postlexdebug -1 (format nil "... lieavec _l_\n" ))
  "bémol ..f  g -> Bourg-en-Bresse n possible nasalisation"
  ; (list "c" "d" "f" "g" "k" "n" "p" "q" "r" "s" "t" "x" "z")
  ;(format t "tempo lettre |%s|\n" _l_)
  (postlexdebug -1 (format nil "lieavec lettre |%s|" _l_))
  (cond
      ((member_string _l_ (list "c" "q" "k" "g"))
          "k")
      ((member_string _l_ (list "d" "t"))
          "t")
      ((member_string _l_ (list "x" "s" "z"))
          "z")
      ((member_string _l_ (list "n"))
          "n")
      ((member_string _l_ (list "r"))
          "rh")
      ((member_string _l_ (list "p"))
          "p")
      ((member_string _l_ (list "y"))
          "j")
       ((member_string _l_ (list "i"))
          nil)
      ((member_string _l_ (list "f"))
          "f"); neuf ans, neuf heures gérés par french_multiple_word_expressions 
      ((member_string _l_ (list "l"))
          "l") 
      ((member_string _l_ (list "_"))
          "pau")
      ((null? _l_) nil) ;
      (t
          (error "lieavec" _l_)) ;
      ))
;;;
;  nécessité 2 paramètres cas divin 
; permettre liste
(define (denatphon naphone naword)
  "blabla"
  ;;(postlexdebug -1 (format nil "... denatphon naphone\n" ))

  (let (result)
      (cond 
          ((string-equal naphone "ehn")
              (if (string-equal naword "divin")
                  (set! result "i") ; divin enfant
                  (set! result "eh"))) ; plein ex: plein air moyen-âge

          ((string-equal naphone "ohn") (set! result "oh")) ; ex bon enfant, bon au  porteur, bon à rien, bons à rien
          ((string-equal naphone "ahn") (set! result "a")) ; ex TODO 
          ((string-equal naphone "oen") (set! result "oen")) ; ex un enfant
          ((string-equal naphone "e") (set! result "eh")) ; ex: premier enfant
          ;((string-equal naphone "f") ; seuls cas devant ans et heures; dix-neuf ans, neuf heures
          ; maintenant french_multiple_word_expressions
          ((string-equal naphone "i") (set! result "j"))
          (t (set! result naphone))
      )result))

;;;
(define (leftliable mot)

  ;;(postlexdebug -1 (format nil "... leftliable mot\n" ))
  "low case"
  ; on ne lie pas des mots d'origine étrangère .. 
  ; la lettre à s'exclurait d'elle-même car à le seul mot avec un à est une CON
  ; mais il peut y avoir des erreurs de postlex 
  
  ; ex "bon à rien" PLUS d'actualité postlex donne le bon résultat
  ; id _4 ; name bon ; pos_index 0 ; pos_index_score 0 ; pos ADJ ; pbreak NB ; 
  ; id _5 ; name à ; pos_index 13 ; pos_index_score 0 ; pos NOM ; pbreak NB ; 
  ; id _6 ; name rien ; pos_index 17 ; pos_index_score 0 ; pos PRO:ind ; pbreak BB ;
  
  ;.bon peut aussi être un NOM : bon au porteur
  ; pas vu non plus PLUS d'actualité postlex donne le bon résultat bon NOM
  ; id _4 ; name bon ; pos_index 0 ; pos_index_score 0 ; pos ADJ ; pbreak NB ; 
  ; id _5 ; name au ; pos_index 7 ; pos_index_score 0 ; pos ART:def ; pbreak NB ; 
  ; id _6 ; name porteur ; pos_index 13 ; pos_index_score 0 ; pos NOM ; pbreak BB 
  ; ou un adverbe 
  ; bon est un cas qui mériterait un traitement spécial homographie  
  ; dans les Token

  ; les cas du genre "quant à " peuvent se résoudre par *locution*

  ; TODO rename the liste

  ; traiter à comme un cas spécial, ne pas l'exclure
  ; quant à, tabac à, six à  OK 

  (and ; blabla
      (or  (member_string (french_downcase_string (string-car mot)) (list "a" "â" "e" "é" "è" "ê" "i" "î" "o" "u" "à" "ô" "y" ))
          ;(member_string mot mots_y->liables)
          ) ; voeu pieu liste vide !?
      (not (member_string mot (list "adv:pos_plus_")))))


;;;    
; TODO
; Rappelons d’abord qu’une liaison est la prononciation en une syllabe de
; la consonne finale d’un mot, habituellement non prononcée, avec la
; voyelle initiale du mot suivant.
; http://bdl.oqlf.gouv.qc.ca
; au sens large ex bon enfant ...
(define (isvocalicrightliable word debugliaison)
    (postlexdebug -1 (format nil "... isvocalicrightliable word debugliaison de ok0 à ok10  %s\n"  (na word)))
    "word in low case"
    ; aptitude d'un word à être liée à droite indépendamment de considération de POS
    ; et même d'exclusion ciblée
    (let (na_word next_word na_next_word na_after_phone mot resultat)
          (set! next_word (item.next word))
          (set! resultat nil)
          (cond
          ; existe et a un suivant ! 
          ((or (null? word)
              (null? next_word)) 
                  (set! resultat nil))
          ((and ; blabla
              (set! na_word (na word))
              (set! next_word (item.next word))
              ; ici on a toujours un vrai suivant 
              (set! na_after_phone (na (firstphone (item.next word))))
              (set! na_next_word (na next_word))
              ;;;(or (format t "na_nextword |%s|\n" na_next_word) t)
              (postlexdebug -1 (format nil "isvocalicrightliable ok1\n" ))
              ;;;(or (format t "poncc: %s  %l\n" (na word) (item.feat word 'R:Token.parent.punc)) t)
              ; pas de ponctuation ni preponctuation empêchant la liaison 
              ; ex rejette mot dans mot. A
              (equal? (item.feat word 'R:Token.parent.punc) 0) ; any of token.punctuation  forbidden   
              (postlexdebug -1 (format nil "isvocalicrightliable ok2\n" ))
              ;ex rejette  abruptis dans \"abruptis\" est une injure
              (equal? (item.feat next_word 'R:Token.parent.prepunctuation) "") ; any of token.prepunctuation  
              (postlexdebug -1 (format nil "isvocalicrightliable ok3\n" ))
              ; un vrai mot quand même 
              (not (member_string (item.feat next_word 'pos) (list "LIA")))
              ; PAS ICI TODO
              ; (or
              ;    ; condition sur word 
              ;    (not (member_string (item.feat next_word 'pos) (list "CON" "LIA")))
              ;    ; condition sur next_word
              ;    (and (string-equal na_next_word "à") (not (w_is_exception_*->a word ))))
              
              (postlexdebug -1 (format nil "isvocalicrightliable ok4\n" ))
              ; pas de hh ou hs au début du suivant
              ; ex rejette un dans un hérisson
              (not (member_string na_after_phone (list "hh" "hs")))
              
              
              ; les h initiaux sont surement muets et sont d'aucun intérêt, enlevons-les 
              (and  (pattern-matches na_next_word "{h}{.*}")
                      (set! mot #2)
                      (leftliable mot))
              
              ; (or (postlexdebug -1 (format nil "isvocalicrightliable ok7\n" ) t))
              ;   ; TODO généraliser à type de fin de mot liant pour intégrer le "cas" almanach
              ;   ; 2 lettres pas 1 , pas un pb de phoneme lettres muettes libérées par liaison 
              ;   ; pas si bien nommé du coup ben si reprendre vocabulaire des atomes               
              ; (member_string (string-last na_word) (list "c" "d" "f" "g" "k" "n" "p" "q" "r" "s" "t" "n" "x" "z" "y"))     
              ;                                   (or (postlexdebug -1 (format nil "isvocalicrightliable ok10\n" ) t))          
              )
                  ; Rq: pas de respect systématique des noms propres ex en  .. en Allemagne
                  (item.set_feat word "liaisonvocalic" "yes")
                  (set! resultat t))
          (t 
              (set! resultat nil)
              (item.set_feat word "liaisonvocalic" "no" ))
                          
          )
      ;;;(format t "RESULT isvocalicrightliable %s\n" resultat)        
      resultat))
;;
(provide 'INST_LANG_postlex)
