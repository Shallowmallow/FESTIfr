(defvar futuresampa nil)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                                                                       ;;
;;;                Centre for Speech Technology Research                  ;;
;;;                     University of Edinburgh, UK                       ;;
;;;                       Copyright (c) 1996,1997                         ;;
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
;;;  Various tokenizing functions and customization 
;/*=======================================================================*/
; we are on our own; ref token.cc
;/* Tokenizing                                                            */
;/*                                                                       */
;/* This provides tokenizing methods for tokens into words.  All that     */
;/* special rules stuff for analysizing numbers, dates, acronyms etc.     */
;/* Much of this is still too specific and although easy to add to it     */
;/* be better if the rules could be specified externally                  */
;/*                                                                       */
;/* Note only English tokenization has any substance at present           */
(defvar verbose_INST_LANG_token)
(defvar cg::debug)

(if cg::debug
    (defvar tokendebuglevel 1000)
    (defvar tokendebuglevel 0))

; as for the English tokenizing, one day we will allow
; the user to (sic may) specify their own addition;a token to word rules
;through a variable (sic the variable user_token_to_word_func)
; until now 3 modes  full test unset
; but they are debug oriented ..

(define (word_it token name)
  ""
  (let (result)
    (if verbose_INST_LANG_token (format t "word_it %s\n" name))
    (set! result (list name))
    result))

; the modes
(defvar mode_token "autre"); TODO full

(define (INST_LANG_token_to_words_unset token name)
    (word_it token name))

(if (equal? mode_token "autre")
  (begin
    (require 'INST_LANG_token_to_words_autre)
    (set! INST_LANG_token_to_words INST_LANG_token_to_words)))
        
(if (equal? mode_token "full")
  (begin
    (require 'INST_LANG_token_to_words_full)
    (set! INST_LANG_token_to_words INST_LANG_token_to_words)))

(if (equal? mode_token "test")
  (begin
    (require 'INST_LANG_token_to_words_test)
    (set! INST_LANG_token_to_words INST_LANG_token_to_words_test)))

(if (equal? mode_token "unset")
  (begin
    (set! INST_LANG_token_to_words INST_LANG_token_to_words_unset)))
    
;; RECUP  why ?
;(require 'INST_LANG_token_to_words_test)

(require  'INST_LANG_words_exceptions)
(require  'INST_LANG_token_to_words_lists)
(require  'INST_LANG_token_to_words_tools)
(require  'INST_LANG_numbers)

(require 'INST_LANG_tokenpos)
        ;;;
        ;;;  Token pos are gross level part of speech tags which help decide
        ;;;  pronunciation of tokens (particular expansion of Tokens into words)
        ;;;  The most obvious example is identifying number types (ordinals,
        ;;;  years, digits or numbers).
        ;;;  
(set! token_pos_cart_trees INST_LANG_token_pos_cart_trees)

; dans les faits, inutile de surcharger, appel direct dans INST_LANG_synthetize
; surcharge de la documentation, pour afficher dans le terminal notre main-mise 
; moyennant l'utilisation de ALT +H
(define (Token utt)
  "ah bon: Build a Word stream from the Token stream, analyzing compound words
  numbers etc as tokens into words. Respects the Parameter Language
  to choose the appropriate token to word module."
    (Token_INST_LANG utt))
  ; The basic model in Festival is that each token will be mapped a list of
  ; words by a call to a token_to_word function. This function will be called on
  ; each token and it should return a list of words. It may check the tokens to
  ; context (within the current utterance) too if necessary. The default action
  ; should (for most languages) simply be returning the token itself as a list
  ; of own word (itself). 
  ; This function should be set in your voice selection function as the
  ; function for token analysis
  ; ref: http://festvox.org/festvox-1.2/festvox_13.html
  ;;;

(define (is_in_poslex name)
  "return the list of cands (candidates) with rprobs, nil if there is no entry  name in poslex"
  (let (result)
    (lex.select "INST_LANG_poslex")
    ; pourquoi seulement le feature nil
    (set! result (cadr (lex.lookup name) nil))
    ; back to our lexical, before we forget
    (lex.select "INST_LANG_lex")
    (if (null? result)
      (if verbose_INST_LANG_token(begin (format t "is_in_poslex check info: %s\n" name))))
    result))
;;;
 
(set! token.punctuation ".,;:?!)}]\"" 
  "A string of characters which are to be treated as punctuation when
  tokenizing text.  Punctuation symbols will be removed from the text
  of the token and made available through the \"punctuation\" feature.
  [see Tokenizing]")
  ; TODO ps clair
  ; ' nous sert pour l'élision: pb
  ; pour les mot-composés ce ne sont pas de signes typographiques
  ; we use norm text 

(set! token.prepunctuation "\"({[") ;
; sans l'apostrophe


(set! token.whitespace " \t\n\r'"
  "A string of characters which are to be treated as whitespace when
  tokenizing text.  Whitespace is treated as a separator and removed
  from the text of a token and made available through the \"whitespace\"
  feature.  [see Tokenizing]")
; attention ; le whitespace est porté par le 2e élément
; c'est aussi bien pour notre usage dans l'élision
; mais peut surprendre dans le cas de blancs insécables par exemple
  
(defvar token.singlecharsymbols "<>=%"
  "token.singlecharsymbols
  Characters which have always to be split as tokens.  This would be
  usual is standard text, but is useful in parsing some types of
  file. [see Tokenizing]") ; £$€
  ; "£$€<>=%" comme kal, mais pourquoi pas @ et pourquoi seulement $ et £ 
  ; pour freesoft in spellmode
  ; (set! token.singlecharsymbols "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþ")
  ; pour € utf8 pb   

;; à revoir
(set! token.letter_pos "NOM"
  "The part of speech tag (valid for your part of speech tagger) for
  individual letters.  When the tokenizer decide to pronounce a token
  as a list of letters this tag is added to each letter in the list.
  Note this should be from the part of speech set used in your tagger 
  which may not be the same one that appears in the actual lexical 
  entry (if you map them afterwards).  This specifically allows \"y\"
  to come out as i grec rather than i.")


(defvar token.unknown_word_name ""
  "token.unknown_word_name
  When all else fails and a pronunciation for a word or character can't
  be found this word will be said instead.  If you make this \"\" them
  the unknown word will simple be omitted.  This will only
  really be called when there is a bug in the lexicon and characters
  are missing from the lexicon.  Note this word should be in the lexicon.")

(if cg::debug (set! token.unknown_word_name "inconnu"))

; see festival.scm
; the features are just values on the feature list.
; The function def_feature_docstring gives them a documentation string

(def_feature_docstring 'Token.punctuation
  "Token.punctuation
  Succeeding punctuation symbol found after token in original 
  string/file. ma sauce")

(def_feature_docstring 'Token.whitespace
  "Token.whitespace
  Whitespace found before token in original string/file.")

(def_feature_docstring 'Token.prepunctuation
  "Token.prepunctuation
  Preceeding puctuation symbol found before token in original string/file.")


;; using a lisp function instead of C++ to do the INST_LANG Token Module
;; ref ims_german_token.scm
(define (Token_INST_LANG utt)
    "(Token_INST_LANG UTT)
    analyzing compound words, numbers, etc. as tokens into words."
    (if verbose_INST_LANG_token (format t "main_mise Token_INST_LANG \n"))
    ; create Word relation in any case
    ; this is necessary because text2wave generates empty utterances
    ; for these, we still need a Word relation so Phrasify will not fail
    ; AS 19.3.2012
    (if (not (utt.relation.present utt 'Word))
        (begin  
          (utt.relation.create utt 'Word)))
    (mapcar
      (lambda (tok)
        (tokendebug tokendebuglevel (format nil "Das ist Token_INST_LANG tok: %s\n" (item.name tok)))
        (if (item.name tok)
            (LANG_fill_tokenrelation utt tok
              (INST_LANG_token_to_words tok (item.name tok))))) 
      (utt.relation.items utt 'Token))
  utt)

;;;
(Parameter.set 'Token_Method 'Token_INST_LANG)
;;;
(define (LANG_fill_tokenrelation utt token wordlist)
    "(LANG_fill_tokenrelation UTT TOKEN WORDLIST)
    Adds the words from WORDLIST as item to the Word relation of
    utterance UTT, relating the new Word to the Token TOKEN."
    ; (tokendebug tokendebuglevel (format nil "trace LANG_fill_tokenrelation utt\n\t\t\ttoken:%s\n\t\t\ttype wordlist:%s\n\t\t\twordlist:%l\n"
    ;                       (na token) (typeof wordlist) wordlist))
    ; (length LIST)
    ; Return length of LIST, or 0 if LIST is not a list. ; pas si vrai
    ; SIOD ERROR: wrong type of argument to length : t
    ; debug grossier shouldn't happend !!
    ; (not (eq? (typeof wordlist)) 'unknown)
    ; (eq? (typeof wordlist) 'cons)

    ; create Word relation in any case
    ; this is necessary because text2wave generates empty utterances
    ; for these, we still need a Word relation so Phrasify will not fail
    ; AS 19.3.2012
  (cond
    ((and (not (null? wordlist)) t)
         ; (eq? (typeof wordlist) 'cons))
         
      (if (not (utt.relation.present utt 'Word))
        (utt.relation.create utt 'Word))

      (utt.relation.append utt 'Word)
      (let ((wrd (utt.relation.last utt 'Word)))
        (item.set_name wrd (car wordlist))
        (item.append_daughter token wrd)
      )
      (LANG_fill_tokenrelation utt token (cdr wordlist))
    )
    ; (t 
    ;   (format t "gloups1\n")
    ;   (utt.relation.create utt 'Word)
    ;   (format t "gloups2\n")
    ;   (utt.relation.append utt 'Word)
    ;   (format t "gloups3\n")
    ;   (format t "info content %l\n" (utt.relation.print utt (quote Word))); expect nil
    ;   (format t "gloups4\n")
    ;   (format t "info %l wordlist\n" wordlist)
    ;   (format t "gloups5\n")
    ;   (format t "typeof %l\n" (typeof wordlist))
    ;   (format t "gloups6\n")
      
    ;   (format t "car %l" (car wordlist))                    
    ;   )
  )
)           
      
; 

    
;;;
(set! special_slice_char "_") ; tiret hors "grammatical" composition mots

;;;
(define (is_normal name)
  "normal simple word  written with letters, at least 2 letters
  without internal capital letter, currencies excluded
  currencies are excluded because they may have to be moved
  within the utterance such as in $23,40 -> 23,40 dollars, a normal 
  word doesn't contain an apostrophe (apostrophe is seen as a whitespace)
  units are excluded... entre autres
  "
  (and 
    (not (string-equal (string-last name) "-")); le mot ne se termine pas par un tiret
    (or (is_made_with (string-car name) letter_list) (equal? (string-car name) "_")) ; initiale, on rajoute qqs mots construits dans norm comme _pounds, _yen

        ; 2 letters otherwhise   (string-cdr name) is nil and is_made_with is not t
    (or (is_made_with (string-cdr name) (append minuscule_with_accent_letter_list (list "a-z" "_" "\-")))
        (and 
          (let (name1)
            (set! name1 (string-cdr (string-before name "-"))) 
            (is_made_with name1 (append minuscule_with_accent_letter_list (list "a-z" "_" "\-")))
            (is_made_with (string-cdr (string-after name "-")) (append minuscule_with_accent_letter_list (list "a-z" "_" "\-")))))
        ); letters but  without internal capital letter  n'exclut plus exclut Tout-Paris
    (not (is_currency name)); currencies excluded special treatment
    ; units excluded
    (not (is_unit name))))
    
  ;;;        
(set! INST_LANG_homographs
  ; sort "réglé" "dans LANG_token_pos_cart_trees de tokenpos

  ; TODO vis: tu confonds clous et vis 
  ; convient et ils convient
  ; cinq six huit dix pour les liaisons sur pause
  ; -
  ; rendez-vous
  '("fils" "convient" ))
  ; van marc, jean pos NAM ou NOM "résolu" par fre_NAM_homo_tab 
  ; "chat" 
  ; antre par locutions ...
  ; "six" "huit" "dix"
  ; fils hétérophones homographes hétérosèmes

;;;
(set! INST_LANG_homographs1
  ; résolution pb changement de POS        
  ; si pb avec postlex 
  ; sort "réglé" "partiellement
  ; dans LANG_token_pos_cart_trees de tokenpos_fr.scm
  ; du, de, plus , tout 
  ; pour ne pas oublier 
  ; "dix""Paris" "maintenant" "en"  "que" "s"   "six" "huit"
  ;(append list_PRE_ADV (list "rendez-vous" "part" "tombe")))
  ;  "part" provoque un dump pour "ma part" et non
  ; "c'était ridicule de la part d'un garçon de dix ans bientôt accomplis"
  (list "rendez-vous"  "tombe"))
  ; tombe .. neut_parl_s01_0209  tombe vu comme un NOM not in INST_LANG_homographs1 si non name  tombe_VER avec pos NOM

  ; sort "réglé" "dans LANG_token_pos_cart_trees de tokenpos
      ; ***using a lisp function instead of C++ for the Token_INST_LANG Module***
      ; opposite Token_English
      ; ref ims_german_token.scm
  ;;;    

(defvar QT "-1")
(set! QT18_patt "{[^-]+}-{.*}")
(set! QT17_patt "{[^-]+}-{[^-]+}{.*}")
;;;
(provide 'INST_LANG_token)


