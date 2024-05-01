;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                                                                       ;;
;;;                Centre for Speech Technology Research                  ;;
;;;                     University of Edinburgh, UK                       ;;
;;;                         Copyright (c) 1998                            ;;
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
;;;  Functions specific to supporting a trained LTS rules
;;;
(defvar verbose_INST_LANG_lts)
; (if verbose_INST_LANG_lts (format t "INST_LANG_lts\n")

(define (lts_predict_utf8 word rules)
  "(ex: lts_predict_utf8 word INST_LANG_lts_rules, the name of the rules is set in the scheme file)
   Return list of phones related to word using CART trees.
   Deals with utf8."
  (let ((utt (make_let_utt (enworden (utf8explode word)))))
        ; (utt.relationnames utt)  (LTS LETTER PHONE)
        ;(format stderr "enworden letters lts_fr %l\n" (enworden (utf8explode word)) ); lts_debug
        ;     (utt.relation.print utt 'LETTER)
        ; ()
        ; id _1 ; pos "[Val scheme]" ; name # ; 
        ; id _2 ; pos "[Val scheme]" ; name p ; 
        ; id _3 ; pos "[Val scheme]" ; name o ; 
        ; id _4 ; pos "[Val scheme]" ; name r ; 
        ; id _5 ; pos "[Val scheme]" ; name t ; 
        ; id _6 ; pos "[Val scheme]" ; name a ; 
        ; id _7 ; pos "[Val scheme]" ; name - ; 
        ; id _8 ; pos "[Val scheme]" ; name n ; 
        ; id _9 ; pos "[Val scheme]" ; name e ; 
        ; id _10 ; pos "[Val scheme]" ; name r ; 
        ; id _11 ; pos "[Val scheme]" ; name f ; 
        ; id _12 ; pos "[Val scheme]" ; name # ; 
      (predict_phones utt rules)
      ;(format t "relationnames %l\n" (utt.relationnames utt))
      (cdr (reverse (cdr (reverse ;; remove #'s
        (mapcar item.name (utt.relation.items utt 'PHONE))))))))
;;;          
(define (word-is-content word guess_pos)
  (cond
    ((null guess_pos) t)
    ((member_string word (cdr (car guess_pos))) nil)
    (t
        (word-is-content word (cdr guess_pos)))))
;;;     
(defvar lts_pos nil)
;;;

(define (make_let_utt letters)
  "(make_let_utt letters)
  Build an utterance from list of letters."
  ; example  (make_let_utt (string->list "À"))
  (require 'INST_LANG_utils)
  (if verbose_INST_LANG_lts (format t "%s\n"  (list->string letters)))

  (set! letters (string->list  (french_downcase_string (list->string letters)))) ; tODO
  (let ((utt (Utterance Text "")))
    (utt.relation.create utt 'LTS)
    (utt.relation.create utt 'LETTER)
    (utt.relation.create utt 'PHONE)
    ;; Create letter stream
    (if verbose_INST_LANG_lts (format t "create letter stream make_let_utt\n"))
    (mapcar
      (lambda (l)
        ;(format t "letter l_%s_\n" l)
        (let ((lsi (utt.relation.append utt 'LETTER)))
        (item.set_feat lsi "pos" lts_pos)
        ; (item.set_feat lsi "ph_vc" ph_vc)
        (item.set_name lsi l)))
      letters)
    utt))

;;;
;vanilla /§\  - (tiret) n'est pas considéré comme un caractère "normal" ...
(define (predict_phones utt rules)
  "(predict_phones utt rules)
  Predict phones using CART."
  ;d  (format stderr "(predict_phones utt rules)\n")
  ;d  (make_let_utt (enworden (utf8explode word)))
  ;d  (set! utt !)  
  ;d  (set! rules INST_LANG_lts_rules)

  ;d   (predict_phones utt rules)
  ;d  predict a a
  ;d  predict - _epsilon_
  ;d  predict n n
  ;d  predict e eh
  ;d  predict r rh
  ;d  predict f f


  (add_new_phone utt (utt.relation.first utt 'LETTER) '#)
  (mapcar
    (lambda (lsi)
      (let ((tree (car (cdr (assoc_string (item.name lsi) rules)))))
        (if (not tree)
          (begin
            (ltsdebug 1 (format nil "predict_phones lts_fr: failed to find tree for %s\n" (item.name lsi)))
            nil)
          (begin 
            ; wagon_predict predicts with given ITEM and CART tree and return the prediction
            ; (the last item) rather than whole probability distribution.
            (let ((p (wagon_predict lsi tree)))
              ;d (format t "predict_phones: %s %s\n" (item.name lsi) p)
              (cond
                ((string-matches p ".*-.*-.*-.*") ; a quad one
                  (add_new_phone utt lsi (string-before p "-"))
                  (add_new_phone utt lsi (string-before (string-after p "-") "-"))
                  (add_new_phone utt lsi (string-before (string-after (string-after p "-") "-") "-"))
                  (add_new_phone utt lsi (string-after (string-after (string-after p "-") "-") "-")))
                ((string-matches p ".*-.*-.*") ; a triple one
                  (add_new_phone utt lsi (string-before p "-"))
                  (add_new_phone utt lsi (string-before (string-after p "-") "-"))
                  (add_new_phone utt lsi (string-after (string-after p "-") "-")))
                ((string-matches p ".*-.*");; a double one si p ="-" (string-matches p ".*-.*") t !!
                  (add_new_phone utt lsi (string-before p "-"))
                  (add_new_phone utt lsi (string-after p "-")))
                  ; ((not (string-equal (item.name lsi) "-"))
                  ;   (add_new_phone utt lsi "hh")
                  ;   )
                (t
                  (add_new_phone utt lsi p))))))))
    (reverse (cdr (reverse (cdr (utt.relation.items utt 'LETTER)))))); end mapcar
  (add_new_phone utt (utt.relation.last utt 'LETTER) '#)
  utt)


;;;
(define (add_new_phone utt lsi p)
  "(add_new_phone utt lsi p)
    Add new phone linking to letter, ignoring it if its _epsilon_."
  ;(format t "add_new_phone lsi%l\n" (na lsi) )
  (if (not (equal? p '_epsilon_))
      (let ((psi (utt.relation.append utt 'PHONE)))
        (item.set_name psi p)
        (item.relation.append_daughter
          (utt.relation.append utt 'LTS lsi)
        'LTS psi))))
;;;
(define (enworden lets)
  " "
  (cons '# (reverse (cons '# (reverse lets)))))
  ;;;
  ;;; Lexical stress assignment
  ;;;
(define (add_lex_stress word pos phones tree)
  "(add_lex_stress word syls)
    Predict lexical stress by decision tree."
  (let ((utt (Utterance Text ""))
  (si)
  (nphones))
    (utt.relation.create utt 'Letter)
    (set! si (utt.relation.append utt 'Letter))
    (item.set_feat si 'pos pos)
    (item.set_feat si 'numsyls (count_syls phones))
    (item.set_feat si 'sylpos 1)
    (set! nphones (add_lex_stress_syl phones si tree))
    ;(format t "%l\n" phones)
    ;(format t "%l\n" nphones)
    nphones))
;;;
(define (count_syls phones)
  "TODO vowel phones"
  (cond
  ((null phones) 0)
  ((string-matches (car phones) "[aeiouy].*")
    (+ 1 (count_syls (cdr phones))))
  (t (count_syls (cdr phones)))))
;;;
(define (add_lex_stress_syl phones si tree)
  "TODO vowel phones
  (add_lex_stress_syl phones si tree)
    Add lexical stressing."
  (cond
    ((null phones) nil)
    ((string-matches (car phones) "[aeiouy].*")
      (item.set_feat si 'phone (car phones))
      (item.set_feat si 'name (car phones))
      (item.set_feat si 'num2end 
        (- (+ 1 (item.feat si 'numsyls))
          (item.feat si 'sylpos)))
      (set! stress (wagon_predict si tree))
      (item.set_feat si 'sylpos
        (+ 1 (item.feat si 'sylpos)))
      (cons
        (if (not (string-equal stress "0"))
          (string-append (car phones) stress)
            (car phones))
          (add_lex_stress_syl (cdr phones) si tree)))
    (t 
      (cons
        (car phones)
        (add_lex_stress_syl (cdr phones) si tree)))))
;;; 
;;; Morphological analysis


;(define (wfst_stemmer)
;  (wfst.load 'stemmer "/home/awb/projects/morpho/engstemmer.wfst")
;  (wfst.load 'stemmerL "/home/awb/projects/morpho/engstemmerL.wfst")
;  t)

;(define (stem word)
;  (wfst.transduce 'stemmer (enworden (symbolexplode word))))

;(define (stemL word)
;  (wfst.transduce 'stemmerL (enworden (symbolexplode word))))

(provide 'INST_LANG_lts)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (require 'pos)


;; (defvar ph_vc nil)
;; ; in the actual lts_rules ...
;; ; festival> (lts_predict_utf8 "c" INST_LANG_lts_rules) 
;; ; ("k") pas grave juste pour c seul ci, ce , cy ... bon
;; ; festival> (lts_predict_utf8 "x" INST_LANG_lts_rules)
;; ; ("k" "s")
;; ; pas bon pour oix ex: soixante 




;; (define (lts_predict_utf8* word rules)
;;   "(ex lts_predict_utf8 word INST_LANG_lts_rules, the name of the rules is set in the scheme file)
;;     Return list of phones related to word using CART trees.
;;     Deals with utf8."
;;     (set! results (lts_predict_utf8 word rules))
;;     ;d (format t "999 lts tempo2 word %l %l\n" word results)
;;   results)


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (if (getenv "INST_LANG")

;;     ;;       (set-car! (cdr (nth (- (length syls) 2) syls)) 1))
;;     ;;    ((word-is-content word english_guess_pos)
;;     ;;       (set-car! (cdr (car syls)) 1)))
;;     ;;   syls)








;; ;;; Morphological analysis
;; ;(define (wfst_stemmer)
;; ;  (wfst.load 'stemmer "/home/awb/projects/morpho/engstemmer.wfst")
;; ;  (wfst.load 'stemmerL "/home/awb/projects/morpho/engstemmerL.wfst")
;; ;  t)

;; ;(define (stem word)
;; ;  (wfst.transduce 'stemmer (enworden (symbolexplode word))))

;; ;(define (stemL word)
;; ;  (wfst.transduce 'stemmerL (enworden (symbolexplode word))))

;; (provide 'lts)


