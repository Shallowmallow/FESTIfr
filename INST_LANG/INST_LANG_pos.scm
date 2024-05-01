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
;;;   A part of speech tagger

(set_backtrace t)

; 
(defvar freeling t)


;;;; TODO uniformiser les écritures privilègier p.name pour simplifier le débogage
; rappel vu dans la 1e ligne de 
;  ADJ ADJ:dem
;  ADJ:ind ADJ:int ADJ:num ADJ:pos ADV ART:def ART:ind AUX CON LIA NAM NOM ONO PRE PRO:dem PRO:ind PRO:int PRO:per PRO:pos PRO:rel VER SENT !OOV !ENTER 
(defvar verbose_INST_LANG_pos nil)
(if verbose_INST_LANG_pos (format t "INST_LANG_pos de lib/MY\n"))
(require  'INST_LANG_utils)
; (require 'phrase_type)
; (require 'except_freeling)
(defvar prevposmethod)
(defvar namedebug nil)
(defvar posdebug nil)
(defvar cas nil)
(defvar build_prompt nil) ; TODO expl
(defvar pos_supported t)

(set! INST_LANG_guess_pos
  '(
    (ONO ah allo bravo  clac  da  dame  diantre eh  euh  fichtre hein  hop  "hélas"   las  na  oh  ouais  ouf  oui  "ô"   )
    ;(ADV ne)
    (ART le la les un une des )
    ; articles + prépositions
    (P_ART du des au aux )

    (DET 
      ;; demonstratifs
      ce cet cette ces
      ;; possesifs
      mon ma mes ton ta tes ses sa ses leurs leur nos notre votre vos)
    
    (PRO je tu elle il on nous vous ils elles aucun eux en tous aucun)

    
    (INT qui que quoi quand combien quel lequel lesquels laquelle lesquelles )
    
    (VAUX a as avais avait avaient aurai auras aura aurais aurait auraient aurez auriez avons avions aurons auront aurions ai aie aies aient ont 
        eus eut "eûmes" "eûtes" eurent 
        suis es est sommes "êtes" sont "étais" "était" "étaient" "étiez" "étions" fus fut fusse fusses fussiez fussions "fûmes" furent  )


    (PRE "à" contre sur selon sous envers "malgré" en avec pour par vers jusque "jusqu_à" "jusqu_au" "jusqu_aux")
    
    (CON mais "où" et donc or ni car sans cependant )
    
    (PONC "/." "," "!" "¡" "?" "¿" "\'" "{" "}" "[" "]" "+" "=" "-" ":" ";" )))

     
    
; if not define, english_guess_pos would prevail
; docu_XXX preuve
; docu_XXX closed class words
(set! guess_pos INST_LANG_guess_pos
   "guess_pos: an assoc-list of simple part of speech tag to list of
    words in that class.  This basically only contains closed class
    words all other words may be assumed to be content words. In
    English it is built from the f2b database and used by the ffeature
    gpos.")
  
  ;;; docu_XXX 
  ;;;  A more elaborate part of speech tagger using ngrams works but
  ;;;  at present requires a large list of a priori probabilities
  ;;;  to work.  If that file exists on your system we'll use it otherwise
  ;;;  POS is guessed by the lexicon
; devrait pe être un choix de VOX ?
; attention defvar de vanilla festival par défaut lexdir
 (set! pos_model_dir (string-append lexdir "INST_LANG")
  "pos_model_dir
  The directory contains the various models for the POS module.  By
  default this is the same directory as lexdir.  The directory should
  contain two models: a part of speech lexicon with reverse log probabilities
  and an ngram model for the same part of speech tag set.")
 
  ;;; docu_XXX
  (defvar pos_p_start_tag "punc"
    "pos_p_start_tag
    This variable's value is the tag most likely to appear before
    the start of a sentence.  It is used when looking for pos context
    before an utterance.  Typically it should be some type of punctuation
    tag.")

;;; docu_XXX   
(defvar pos_pp_start_tag "NOM"
  "pos_pp_start_tag
  This variable's value is the tag most likely to appear before
  pos_p_start_tag and any position preceding that.  It is typically
  some type of noun tag.  This is used to provide pos context for
  early words in an utterance.")  
  ; The name of the most likely tag two before the start of an utterance.
  ; For English the is typically a simple noun, but for other languages it
  ; might be a verb. If the ngram model is bigger than three this tag is
  ; effectively repeated for the previous left contexts. 
  ; https://www.cstr.ed.ac.uk/projects/festival/manual//festival_16.html
  ; docu_XXX the ngram model is bigger than three

; docu_XXX if nil just get pos information from the lexicon.  
; 
(defvar pos_supported nil
  "pos_supported
   If set to non-nil use part of speech prediction, if nil just get
   pos information from the lexicon.")

;;;
(defvar pos_ngram_name nil
  "pos_ngram_name
  The name of a loaded ngram containing the a-posteriori ngram model for 
  predicting part of speech.  The a-priori model is held as a 
  lexicon call poslex.")
;;;
;;; docu_XXX pos_map
(defvar pos_map nil
  "pos_map
  If set this should be a reverse assoc-list mapping on part of speech
  tag set to another.  It is used after using the defined POS models to
  map the pos feature on each word to a new tagset.")
  ;;  A reverse assoc list of predicted pos tags to some other tag set.  Note
  ;; using this changes the pos tag loosing the actual predicted value.  Rather
  ;; than map here you may find it more appropriate to map tags sets locally
  ;; in the modules that use them (e.g. phrasing and lexicons).

(if (and  
      freeling
      (probe_file(path-append pos_model_dir "INST_LANG_freeling.poslex")))
    (begin 
      (lex.create "INST_LANG_poslex")
      (lex.set.compile.file (path-append pos_model_dir "INST_LANG_freeling.poslex"))
      (lex.set.phoneset "INST_LANG")
      (lex.set.lts.method nil); "poslex_function"); indispensable ! why 2706 999666
      
      ;;  The name of a "lexicon" holding reverse probabilities of words given a tag 
      ;;  (indexed by word).
      ;;  If this is unset or has the value nil no part of speech tagging takes place.
      (set! pos_lex_name "INST_LANG_poslex")
      ;; ref catalan

      ;; pos_map
      ;; If set this should be a reverse assoc-list mapping on part of speech
      ;; tag set to another.  It is used after using the defined POS models to
      ;; map the pos feature on each word to a new tagset.")
      ; pas vraiment compris catalan :(
      (set! pos_map '((( SENT ) punc))) 
      (set! pos_p_start_tag "punc")
      (set! pos_pp_start_tag "NOM")  
    
      ;;
      ; (lex.add.entry '("." ((SENT 0)) () ))  ; no segmentation fault if SENT is in the vocab list
      ; (lex.add.entry '("?" ((SENT 0)) () ))
      ; (lex.add.entry '("'" ((SENT 0)) () ))
      ; (lex.add.entry '("," ((SENT 0)) () ))          

      ; from pos.cc 
      ; e = lex_lookup_word("_OOV_",NIL); // I *know* there is an entry
      (lex.add.entry '("_OOV_"(
        (ADJ:dem -1.234) (ADJ:ind -1.234) (ADJ:int -1.234)
        (ADJ:num -1.234) (ADJ:pos -1.234) (ADV -1.234)
        (ART:def -1.234) (ART:ind -1.234) (AUX -1.234)
        (CON -1.234) (LIA -1.234) (NAM -1.234) (NOM -1.234)
        (ONO -1.234) (PRE -1.234) (PRO:dem -1.234)
        (PRO:ind -1.234) (PRO:int -1.234) (PRO:per -1.234)
        (PRO:pos -1.234) (PRO:rel -1.234) (VER -1.234) )()))
      
      ; voir aussi _number_ lié 
      ; e = lex_lookup_word("_number_",NIL); // I *know* there is an entry
      ; pour wp10 on a dans lib/pos.scm
      ; (lex.add.entry '("_number_" 
      ;      ((cd -0.35202) (jj -4.1083) (nns -6.4488) (nnp -7.3595))
      ;      () ))
      ; et pour upc
      ; ("__number__" ((AO -2.612)(DN -3.068)(NC -4.475)(NP -3.918)(W -0.668)(Z -0.135)(Zp -0.279) ) () )

      (load  (path-append pos_model_dir "INST_LANG_freeling_addenda.scm")) 
      (load  (path-append pos_model_dir "INST_LANG_freeling_addenda_locutions.scm")) 

      ; Load an ngram from FILENAME and store it named NAME for later access
      (set! pos_ngram_filename 
        (path-append pos_model_dir "INST_LANG_freeling.tri.ngrambin"))
      (ngram.load 'INST_LANG_pos_ngram pos_ngram_filename)
      (set! pos_supported t)))
;;; gloups RECUP
;;;    (begin ; as the lexicon INST_LANG_poslex is not defined
;;;     (set! pos_lex_name  nil) ;; reset? to avoid english english_poslex check lex.list
;;;;      (set! pos_supported nil)))      
      
      

;;(setq pos_map_remap
;;      '(
;;  (( fpunc ) punc)
;;  (( of ) in)))   
(setq INST_LANG::lex_to_tagger
  '(
    (( VER AUX) v)
    (( NAM NOM ) n);;
    (( ADJ:dem ADJ:ind ADJ:pos ART:def ADJ:int ART:ind PRO:pos) dt)
    (( ADJ:num ) j)
    (( CON ONO PRE PRO:dem PRO:ind PRO:int PRO:per  PRO:rel ) o)))      


; pos_map:  We have found that it is often better to use a rich tagset for
; prediction of part of speech tags but that in later use (phrase breaks and
; dictionary lookup) a much more constrained tagset is better. Thus mapping of
; the predicted tagset to a different tagset is supported. pos_map should be a
; a list of pairs consisting of a list of tags to be mapped and the new tag
; they are to be mapped to.
; https://www.cstr.ed.ac.uk/projects/festival/manual//festival_16.html
; docu_XXX Thus               
(defvar pos_map nil
  "pos_map
  A reverse assoc list of predicted pos tags to some other tag set.  Note
  using this changes the pos tag loosing the actual predicted value.  Rather
  than map here you may find it more appropriate to map tags sets locally
  in the modules that use them (e.g. phrasing and lexicons).")


(def_feature_docstring 'Word.pos
  "Word.pos
  Part of speech tag value returned by the POS tagger module.")

(def_feature_docstring 'Word.pos_score
  "Word.pos_score
  Part of speech tag log likelihood from Viterbi search.")

;;; docu_XXX gloups
(defvar nilP6 nil)
;;;
(defvar classic nil)
;;;



      (provide 'INST_LANG_pos)    

      ; Lexicon/lex_ff.cc 

        ;    /* Part of speech by guessing, returns, prep, det, aux, content */
        ;    /* from simple lookup list   


































 





