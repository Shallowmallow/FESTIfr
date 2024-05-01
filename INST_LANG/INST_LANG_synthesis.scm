 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;;                                                                       ;;
 ;;                Centre for Speech Technology Research                  ;;
 ;;                     University of Edinburgh, UK                       ;;
 ;;                       Copyright (c) 1996,1997                         ;;
 ;;                        All Rights Reserved.                           ;;
 ;;                                                                       ;;
 ;;  Permission is hereby granted, free of charge, to use and distribute  ;;
 ;;  this software and its documentation without restriction, including   ;;
 ;;  without limitation the rights to use, copy, modify, merge, publish,  ;;
 ;;  distribute, sublicense, and/or sell copies of this work, and to      ;;
 ;;  permit persons to whom this work is furnished to do so, subject to   ;;
 ;;  the following conditions:                                            ;;
 ;;   1. The code must retain the above copyright notice, this list of    ;;
 ;;      conditions and the following disclaimer.                         ;;
 ;;   2. Any modifications must be clearly marked as such.                ;;
 ;;   3. Original authors' names are not deleted.                         ;;
 ;;   4. The authors' names are not used to endorse or promote products   ;;
 ;;      derived from this software without specific prior written        ;;
 ;;      permission.                                                      ;;
 ;;                                                                       ;;
 ;;  THE UNIVERSITY OF EDINBURGH AND THE CONTRIBUTORS TO THIS WORK        ;;
 ;;  DISCLAIM ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING      ;;
 ;;  ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT   ;;
 ;;  SHALL THE UNIVERSITY OF EDINBURGH NOR THE CONTRIBUTORS BE LIABLE     ;;
 ;;  FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES    ;;
 ;;  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN   ;;
 ;;  AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION,          ;;
 ;;  ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF       ;;
 ;;  THIS SOFTWARE.                                                       ;;
 ;;                                                                       ;;
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;;                                                                       ;;
 ;;                 Author: Richard Caley (rjc@cstr.ed.ac.uk)             ;;
 ;;                   Date: Fri Aug 15 1997                               ;;
 ;; -------------------------------------------------------------------   ;;
 ;; New synthesis mainline.                                               ;;
 ;;                                                                       ;;
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;;                                                                       ;;
 ;; Hooks to add to the synthesis process.                                ;;
 ;;                                                                       ;;
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar verbose_INST_LANG_synthesis)
(require 'INST_LANG_norm)

; pour Token_INST_LANG
; our Token
(require 'INST_LANG_token)

; pour (define (Word utt)
; == vanilla now
(require 'INST_LANG_lexicons)

(define (Text_LANG utt)
 "our Text"
    ; le fameux iform qu'on retrouve dns les premières ligne des fichiers .utt de prompt-utt
    (set! txt (utt.feat utt "iform"))
    (set! txtn (norm txt))
    (if verbose_INST_LANG_synthesis (format t "info txtn: %s\n" txtn ))
    ; mise au point
    ;(set! utt1 (Utterance Text))
    ;(utt.set_feat utt1 "iform" txtn)
    ;(set! utt utt1)(Text utt1))    
    (utt.set_feat utt "iform" txtn)
    (Text utt))


(defvar default_before_synth_hooks nil
  "default_before_synth_hooks
  The default list of functions to be run on all synthesized utterances
  before synthesis starts.")

(defvar before_synth_hooks default_before_synth_hooks
  "before_synth_hooks
  List of functions to be run on synthesised utterances before synthesis
  starts.")

(defvar default_after_analysis_hooks nil
  "default_after_analysis_hooks
  The default list of functions to be run on all synthesized utterances
  after analysis but before synthesis.")

(defvar after_analysis_hooks default_after_analysis_hooks
  "after_analysis_hooks
  List of functions to be applied after analysis and before synthesis.")

(defvar default_after_synth_hooks nil
  "default_after_synth_hooks
  The default list of functions to be run on all synthesized utterances
  after Wave_Synth.  This will normally be nil but if for some reason you
  need to change the gain or rescale *all* waveforms you could set the
  function here, in your siteinit.scm.")

(defvar after_synth_hooks default_after_synth_hooks
  "after_synth_hooks
  List of functions to be applied after all synthesis modules have been
  applied.  This is primarily designed to allow waveform manipulation,
  particularly resampling and volume changes.")

(defvar default_access_strategy 'ondemand
  "default_access_strategy
  How to access units from databases.")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                       ;;
;; Macro to define utterance types.                                      ;;
;;                                                                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmac (defUttType form)
  (list 'defUttType_real 
  (list 'quote (cadr form))
  (list 'quote (cddr form))))

; nous ne voulons pas de UttTypes venus d' "ailleurs"
; expérience mettez defvar et reparaît le type Concept
(set! UttTypes nil
  "UttTypes
  List of types and functions used by the utt.synth function to call 
  appropriate methods.")

(define (defUttType_real type form)
  "(defUttType TYPE . BODY)
  Define a new utterance type.  TYPE is an atomic type that is specified
  as the first argument to the function Utterance.  BODY is evaluated
  with argument utt, when utt.synth is called with an utterance of type
  TYPE.  You almost always require the function Initialize first.
  [see Utterance types]"
  ;;; Yes I am cheating a bit with the macro/function name.
  ;;; should check about redefining and the syntax of the forms
  (set! UttTypes
    (cons 
      (cons type form)
      UttTypes))
  type)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                       ;;
;; Macro to define synthesis types.                                      ;;
;;                                                                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmac (defSynthType form)
  (list 'defSynthType_real 
  (list 'quote (cadr form))
  (list 'quote (cddr form))))

(defvar SynthTypes nil
  "SynthTypes
  List of synthesis types and functions used by the utt.synth function to
  call appropriate methods for wave synthesis.")

(define (defSynthType_real type form)
  "(defSynthType TYPE . BODY)
  Define a new wave synthesis type.  TYPE is an atomic type that
  identifies the type of synthesis. BODY is evaluated with argument
  utt, when utt.synth is called with an utterance of type TYPE.
  [see Utterance types]"

(set! SynthTypes
  (cons 
    (cons type form)
    SynthTypes))
  type)

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;;
  ;;;  Some actual Utterance type definitions
  ;;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defUttType Words
  (Initialize utt)
  (POS utt)
  (Phrasify utt)
  (Word utt)
  (Pauses utt)
  (Intonation utt)
  (PostLex utt)
  (Duration utt)
  (Int_Targets utt)
  (Wave_Synth utt)
  )
; voir festival-it/festival/lib/italian_scm/italian_module_flush.scm
;;; Sequenza dei moduli da utilizzare per l'Italiano     
; (Token_punct utt);FA
; (Function_Word utt);FA         
(defUttType Text
  (Initialize utt)
  (Text_LANG utt)
  (Token_POS utt); vanilla
  (Token_INST_LANG utt)
  (POS utt); vanilla : Apply part of speech tagging (and possible parsing too) to Word; #<SUBR(5) Classic_POS>

  (Phrasify utt)
  (Word utt)
  (Pauses utt)
  (Intonation utt)
  ; It is the lexicon's job to produce a pronunciation of a given word.
  ; However in most languages the most natural pronunciation of a word
  ; cannot be found in isolation from the context in which it is to be
  ; spoken.  

  ; This includes such phenomena as 
  ; * reduction, 
  ; * phrase final devoicing and
  ; * r-insertion.

  ; In Festival this is done by post-lexical rules.
  ;  PostLex is a module which is run after accent assignment but before
  ;  duration and F0 generation.
  ; Apply post lexical rules to segment stream.  These may be almost
  ; arbitrary rules as specified by the particular voice
  (PostLex utt)
  (Duration utt)
  (Int_Targets utt)
  (Wave_Synth utt)
  )

(defUttType Tokens   ;; This is used in tts_file, Tokens will be preloaded
  (Token_POS utt)    ;; when utt.synth is called
  (Token utt)        
  (POS utt)
  (Phrasify utt)
  (Word utt)
  (Pauses utt)
  (Intonation utt)
  (PostLex utt)
  (Duration utt)
  (Int_Targets utt)
  (Wave_Synth utt)
  )

(defUttType Phrase
  (Initialize utt)
  (Token_POS utt)
  (Token utt)
  (POS utt)
  (Phrasify utt)
  (Word utt)
  (Pauses utt)
  (Intonation utt)
  (PostLex utt)
  (Duration utt)
  (Int_Targets utt)
  (Wave_Synth utt)
  )

(defUttType Segments
  (Initialize utt)
  (Wave_Synth utt)
  )

(defUttType Phones
  (Initialize utt)
  (Fixed_Prosody utt)
  (Wave_Synth utt)
  )

(defUttType SegF0
  (Wave_Synth utt)
  )

(defUttType Wave
  (Initialize utt))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                       ;;
;; And some synthesis types.                                             ;;
;;                                                                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defSynthType None
  ;; do nothing
  utt)
;;; we keep these types in case
;;; but we  removed Concept Taylor et UniSyn
(defSynthType Standard
  (print "synth method: Standard")
  (let ((select (Parameter.get 'SelectionMethod)))
    (if select
      (progn
        (print "select")
        (apply select (list utt)))))
  (let ((join (Parameter.get 'JoiningMethod)))
    (if join
      (progn
        (print "join")
        (apply join (list utt)))))
  (let ((impose (Parameter.get 'ImposeMethod)))
    (if impose
      (progn
        (print "impose")
        (apply impose (list utt)))))
  (let ((power (Parameter.get 'PowerSmoothMethod)))
    (if power
      (progn
        (print "power")
        (apply power (list utt)))))
  (let ((wavesynthesis (Parameter.get 'WaveSynthesisMethod)))
    (if wavesynthesis
      (progn
        (print "synthesis")
        (apply wavesynthesis (list utt))))))
;;;

(defSynthType Minimal
  (print "synth method: Minimal")
  (let ((select (Parameter.get 'SelectionMethod)))
    (if select
      (progn
        (print "select")
        (apply select (list utt)))))
  (let ((wavesynthesis (Parameter.get 'WaveSynthesisMethod)))
    (if wavesynthesis
  (progn
  (print "synthesis")
  (apply wavesynthesis (list utt "Unit" "Join" "Wave"))))))
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                       ;;
;; Finally the actual driver function.                                   ;;
;;                                                                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (utt.synth utt)
  "(utt.synth UTT) 
    The main synthesis function.  Given UTT it will apply the
    functions specified for UTT's type, as defined with deffUttType
    and then those demanded by the voice.  After modules have been
    applied synth_hooks are applied to allow extra manipulation.
    [see Utterance types]"
  (let ((uttr))
    (set! uttr (apply_hooks before_synth_hooks utt))

    (let ((type (utt.type uttr)))
      (let ((definition (assoc type UttTypes)))
        (if (null? definition)
            (error "Unknown utterance type" type)
            (let ((body (eval (cons 'lambda 
                                    (list '(utt) 
                                          (utttype_recursify 
                                          (reverse (cdr definition))))))))
              (set! uttr (body uttr)))))

      (apply_hooks after_synth_hooks uttr))))
;;;
(define (utttype_recursify definition)
  "(utttype_recursify definition)
  Change the linear list of module names into a recursive list so you can
  truly modify the utterance within the synthesis process."
  (cond 
  ((null definition) nil)
  ((null (cdr definition)) (car definition))
  (t
    ;(format t "definition %l\n" definition)
    (list (caar definition) (utttype_recursify (cdr definition))))))
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                       ;;
;; And a couple of utility expressions.                                  ;;
;;                                                                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (SayText text)
  "(SayText TEXT)
  TEXT, a string, is rendered as speech."
  (if (boundp 'RU) (set! RU nil))
  (utt.play (utt.synth (eval (list 'Utterance 'Text text)))))

; quicker en debug time
(define (say text)
  "(SayText TEXT"
   (set! utt (SayText text))
    (format t "%s" (utt.flat_repr utt)))


    

(define (dSayText text)
  (let (result)
    (cond
      ((and (boundp 'INST_LANG_VOX::clunits_prompting_stage) INST_LANG_VOX::clunits_prompting_stage)
        (if verbose_INST_LANG_synthesis (format t "worst than mute"))
        (set! result nil))
      (t 
        (set! result (SayText text))
        (if verbose_INST_LANG_synthesis (format t "dSayText :%l\n" (utt.flat_repr result)))
        )
    result)))
        
;; (define (dprompt fileid)
;;   (set! addenda  (path-append "ADDENDA" fileid))
;;   (load addenda))

;; (if (and (boundp
;;       'net_fr::addenda_stage)(null? net_fr::addenda_stage))
;;     (set! dSayText null?)) 

;; needed in clustergen_build pour cg_test
(define (SynthText text)
  "(SynthText TEXT)
  TEXT, a string, is rendered as speech."
  (if t (format t "SynthText from token_fr:\n"))
    (utt.synth (eval (list 'Utterance 'Text text))))

(define (SynthText_norm text)
  "(SynthText TEXT)
  TEXT, a string, is rendered as speech."
  (if t (format t "SynthText from token_fr:\n"))
    (utt.synth (eval (list 'Utterance 'Text (norm text)))))        
;;;
(define (SayPhones phones)
  "(SayPhones PHONES)
  PHONES is a list of phonemes.  This uses the Phones type utterance
  to synthesize and play the given phones.  Fixed duration specified in
  FP_duration and fixed monotone duration (FP_F0) are used to generate
  prosody."
  (utt.play (utt.synth (eval (list 'Utterance 'Phones phones)))))
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                       ;;
;; This is the standard synthesis function.  The Wave Synthesis may be   ;;
;; more than a simple module                                             ;;
;;                                                                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(define (Wave_Synth utt)
  "(Wave_Synth UTT)
  Generate waveform from information in UTT, at least a Segment stream
  must exist.  The actual form of synthesis used depends on the Parameter
  Synth_Method.   If it is a function that is applied.  If it is atom it
  should be a SynthType as defined by defSynthType
  [see Utterance types]"
  (apply_hooks after_analysis_hooks utt)
  (let ((method_val (Parameter.get 'Synth_Method)))
    (cond
    ((null method_val)
      (error "Undefined Synth_Method"))
    ((and (symbol? method_val) (symbol-bound? method_val))
      ;; Wish there was a function? 
      (apply (symbol-value method_val) (list utt)))
    ((member (typeof method_val) '(subr closure))
      (apply method_val (list utt)))
    (t  ;; its a defined synthesis type
      (let ((synthesis_modules (assoc_string method_val SynthTypes)))
      (if (null? synthesis_modules)
          (error (format nil "Undefined SynthType %s\n" method_val))
          (let ((body (eval (cons 'lambda 
                (cons '(utt) (cdr synthesis_modules))))))
            (body utt)))))))
  utt)
;;;
(provide 'INST_LANG_synthesis)



