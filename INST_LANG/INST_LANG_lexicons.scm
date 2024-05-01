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
;;;  Definition of various lexicons
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar verbose_lexicons)

;;;  If there exists a sudirectory of the lib-path called dicts then that 
;;;  is used as the lexicon directory by default.  If it doesn't exist 
;;;  we set lexdir to the directory in CSTR where our lexicons are.  
;;;  In non-CSTR installations where lexicons are not in lib/dicts, 
;;;  you should set lexdir in sitevars.scm

(defvar lexdir 
  (if (probe_file (path-append libdir "dicts"))
      (path-append libdir "dicts/")))

;;(require 'pos)        ;; for part of speech mapping 



(define (setup_INST_LANG_lex) 
  "setup_INST_LANG_lex"
  (if (not (member_string "INST_LANG_lex" (lex.list)))
    (begin
      (load (path-append lexdir "INST_LANG/INST_LANG_lex.scm")))))


;;;
(define (lex_user_unknown_word word feats)
  "(lex_user_unknown_word WORD FEATS)
  Function called by lexicon when 'function type letter to sound rules
  is defined.  It is the user's responsibility to defined this function
  themselves when they want to deal with unknown words themselves."
  (error "lex_user_unknown_word: has not been defined by user"))



(define (find_oovs vocab oovs)
  (let ((fd (fopen vocab "r"))
        (ofd (fopen oovs "w"))
        (e 0)
        (oov 0)
        (entry))

    (while (not (equal? (set! entry (readfp fd)) (eof-val)))
       (set! e (+ 1 e))
       (if (not (lex.lookup_all entry))
           (begin
             (set! oov (+ 1 oov))
             (format ofd "%l\n" (lex.lookup entry nil))))
       )
    (format t ";; %d words %d oov %2.2f oov_rate\n"
            e oov (/ (* oov 100.0) e))
    ))

(define (lex_user_unknown_word word feats)
    "(lex_user_unknown_word WORD FEATS)
    Function called by lexicon when 'function type letter to sound rules
    is defined.  It is the user's responsibility to defined this function
    themselves when they want to deal with unknown words themselves."
    (error "lex_user_unknown_word: has not been defined by user"))

(define (Word utt)
  "(Word utt)
  Build the syllable/segment/SylStructure from the given words using the
  Lexicon.  using current lexicon and specific module."
  (if verbose_lexicons (format t "info INST_LANG_lexicons def Word\n"))
  (let ((rval (apply_method 'Word_Method utt)))
    (cond
     (rval rval) ;; new style
     (t
      (Classic_Word utt)))))
;;;

(provide 'INST_LANG_lexicons)

 
