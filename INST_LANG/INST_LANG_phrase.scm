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
;;;   Phrase boundary prediction.
;;;   
;;;   Two methods supported, if POS is enabled we use ngrams for that
;;;   otherwise we use a CART tree
;;;
;;;   Models trained from the IBM/Lancaster Spoken English Corpus and 
;;;   Boston University's FM Radio Corpus.
;###########################################################################
;##                                                                       ##
;##  Prosodic Phrasing with support for Syntactic Phrasing Model          ##
;##  TODO New phrase break statistical model                                                                     ##
;###########################################################################





    ; To make a better phrasing model requires more information. As the basic 
    ; punctuation model underpredicts we need information that will find 
    ; reasonable boundaries within strings of words. In English/*French, boundaries 
    ; are more likely between content words and function words
    ; The whole tree using these features , *INST_LANG::phrase_cart_tree, will insert a break at 
    ; punctuation or between content and function words more than 
    ; 5 words from a punctuation symbol


    ; /* The lisp_* feature will call a lisp function (the name following      */
    ; /* the lisp_) with two arguments the utterance and the stream item.      */
    ; /* this allows arbitrary new features without recompilation              */
    ; /* 

    ; BB big break break_tags
    ; Borrowed from JuntaDeAndalucia_es_phrase_cart_tree bsv.pdf
    ; TODO voir aussi   ((lisp_german_end_punc matches ".*[:;!?].*")

   ; ;  ((R:Token.parent.token_pos is ordinal)
    (set! INST_LANG_phrase_cart_tree
      '((lisp_INST_LANG_token_end_punc in ("?" "!" "." ":" ";" "?." "?:" "?;" "?\"" "!." "!:" "!;" "!\"" ")." "):" ");" "]." "}." "\"." "\":" "\";"    "..." ",..." "...,"))
          ((BB))
        ((lisp_INST_LANG_token_end_punc in ("," ")" "]" "}" "\","  ")," ")\"" "]," "}," "..." ",..." "...,"))
          ((B))
        ((n.name is 0) ;; end of utterance
          ((BB))
          ((lisp_INST_LANG_since_punctuation > 5)
            ((lisp_french_until_punctuation > 5)
                ((pos in ("NOM" "NAM" "VER" "ADJ"))
                ((n.pos in ("NOM" "NAM" "VER" "ADJ"))
                  ((NB))
                  ((B)))   ;; not content so a function word
            ((NB)))   ;; this is a function word
              ((NB)))    ;; to close to punctuation
            ((NB)))     ;; to soon after punctuation
        ((NB))))))
    ;;;

    ;; if one token can be related to more than one word, we have to check 
    ;; for phrase breaks prediction if a word is last word in Token
    ;; ...
    ;; from vanilla phrase.scm
    ;; or in ims_german german_end_punc de phrasify.scm
    (define (INST_LANG_token_end_punc word)
      "(token_end_punc UTT WORD)
      If punctuation at end of related Token and if WORD is last word
      in Token return the punctuation, otherwise 0."
      ; (item.relation.next item relname)
      ; Return the next item in this relation.
      (if (item.relation.next word "Token")
          "0"
          (item.feat word "R:Token.parent.punc")))
    ;;;
    (define (INST_LANG_since_punctuation word)
      "(since_punctuation word)
      Number of words since last punctuation or beginning of utterance."
      (cond
      ;; from prosody.sgml
      ((null word) 0) ;; beginning or utterance
      ((string-equal "0" (item.feat word "p.lisp_INST_LANG_token_end_punc")) 0)
      (t
        (+ 1 (INST_LANG_since_punctuation (item.prev word))))))

      
          
    ;;;
    (define (INST_LANG_until_punctuation word)
      "(until_punctuation word)
      Number of words until next punctuation or end of utterance."
      (cond
      ; ((null (item.next word)) 0) ;; ending or utterance
      ; ((not (string-equal "0" (INST_LANG_token_end_punc word))) 0)
      ((null word) 0) ;; beginning or utterance
      ((string-equal "0" (INST_LANG_token_end_punc word)) 0)
      (t
        (+ 1 (INST_LANG_since_punctuation (item.prev word))))))
    ;;;
    (define (INST_LANG_token_next_punc word)
      ;(format t "... INST_LANG_token_next_punc word\n")
      "next interesting ponctuation ! ? ;  "
      (cond
      ((null (item.next word))
        (item.feat word "R:Token.parent.punc" "0"))

      ((member_string (item.feat word "R:Token.parent.punc") (list "!" "?" ";" ".")) 
          (item.feat word "R:Token.parent.punc"))
      (t 
        (INST_LANG_token_next_punc (item.next word)))))
    
    
    
    ;     
    ; A much better method for predicting phrase breaks is using a full 
    ; statistical model trained from data. The problem is that you need a lot 
    ; of data to train phrase break models. ... For English we used the MARSEC database 
    ; (around 37,000 words). Finding such a database for your language 
    ; will not be easy and you may need to fall back on a purely hand written rule system

    ; ... it should be noted that without a good intonation and duration 
    ; model spending time on producing good phrasing is probably not worth it. 
    ; The quality of all these three prosodic components is closely related 
    ; such that if one is much better than there may not be 
    ; any real benefit. 
    ;;;
    ;;; Declaration of some features 
    ;;; 
    ;;;
    (def_feature_docstring 
      'Word.pbreak
      "Word.pbreak
      Result from statistical phrasing module, may be B or NB denoting
      phrase break or non-phrase break after the word.")
    ;;;
    (def_feature_docstring 
      'Word.pbreak_score
      "Word.pbreak_score
      Log likelihood score from statistical phrasing module, for pbreak
      value.")
    ;;;
    (def_feature_docstring 
      'Word.blevel
      "Word.blevel
      A crude translation of phrase break into ToBI like phrase level.
      Values may be 0,1,2,3,4.")
    ;;;


    (Parameter.set 'Phrase_Method 'cart_tree)
    (set! phrase_cart_tree INST_LANG_phrase_cart_tree)   

    (define (Phrasify utt)
      "(Phrasify utt)                                
      Construct phrasify over Words module."
      (let ((rval (apply_method 'Phrasify_Method utt)))
        (cond
        (rval rval) ;; new style
        (t
          (Classic_Phrasify utt))))) 

       
    (provide 'INST_LANG_phrase)



;; (require 'pos)   ;; for part of speech map
;; ;;;
;; (defvar pbreak_ngram_dir libdir
;;   "pbreak_ngram_dir
;;   The directory containing the ngram models for predicting phrase
;;   breaks.  By default this is the standard library directory.")
;; ;;;
;; (defvar phr_break_params nil
;;   "phr_break_params
;;   Parameters for phrase break statistical model.  This is typcal set by
;;   a voice selection function to the parameters for a particular model.")
