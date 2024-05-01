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
;;;  Predicting pause insertion
(require 'INST_LANG_phrase)

; from lib/pauses.scm
; mais que veut dire fpunc ?
; fpunc ? 
; on a dans pos.scm
; sous le $ wp22
;(lex.add.entry '("." ((punc -1.1101)) () ))
; tandis que sous wp18 on a 
; (lex.add.entry '("." ((fpunc -0.012) ) () ))
; avec setq english_pos_map_wp39_to_wp20
  ;     '(
  ; (( vbd vb vbn vbz vbp vbg ) v)
  ; (( nn nnp nns nnps fw sym ls ) n)
  ; (( dt ) dt)
  ; (( punc fpunc ) punc)...
  ; pas notre pb nous on a 
  (begin
    (define (Pauses utt)
      "(Pauses utt)                                
      Insert pauses where required."
      (let ((rval (apply_method 'Pause_Method utt)))
        (cond
        (rval rval) ;; new style
        (t
          (Classic_Pauses utt))))
      utt)
    ;;;
    (define (Classic_Pauses utt); see suopuhe_add_break
      "(Pauses UTT)
      Predict pause insertion."
      ;(format t "999 !!! essai no pause à voir\n")
      ; in case we need something special ??
      ; éliminer les côté predict, respecter le ponctuation ?
      (pausedebug 100 (format nil "Pause adding begin"))
      ; converts punctuation marks into pauses
      (let ((words (utt.relation.items utt 'Word)) lastword tpname)
        (if words
          (begin
            (insert_initial_pause utt)   ;; always have a start pause
            (set! lastword (car (last words)))
            (mapcar
              (lambda (w)
                (pausedebug 100 (format nil "Pauses features %l"  (item.features w)))
                (pausedebug 100 (format nil "Pauses w punc p.p.lisp_INST_LANG_token_end_punc %l\t" (item.feat w "p.p.lisp_INST_LANG_token_end_punc")))
                (cond
                  ((equal? w lastword)
                    (insert_pause utt w))))
              words)
            ;; The embarrassing bit.  Remove any words labelled as punc or fpunc
            (mapcar
              (lambda (w)
                (let (pos)
                  (set! pos (item.feat w "pos"))
                    (if (string-equal "punc" pos)
                      (let ((wp (item.relation w 'Phrase)))
                        (item.relation.remove w 'Word)
                          ;; can't refer to w as we've just deleted it
                        (item.relation.remove wp 'Phrase)))
                    (pausedebug 100 (format nil "Pauses fpunc ? _%s_ _%s_" pos (na w)))))
              words)
              ;; 12/01/2006 V.Strom: Even more embarrasing: Delete all silences
              ;; that are followed by a silence.  These silence sequences 
              ;; emerge if 'punc of phrase-final words consists of more than one 
              ;; character, e.g. period+quote.  That in turn causes problems in 
              ;; build_utts: the 2nd silence ends up with no features but its name, 
              ;; because there is no corresponding 2nd silence in the phone 
              ;; segmentation to align with.
              ;; This should be fixed in the functions below, but it is easier for
              ;; me to clean up at the end:
              (set! sil (car (car (cdr (car (PhoneSet.description '(silences)))))))
              (set! seg (item.next(utt.relation.first utt 'Segment)))
              (while seg
                (if (and(equal? sil (item.name seg))
                        (equal? sil (item.name (item.prev seg))))
                  (item.delete (item.prev seg)))
                (set! seg (item.next seg)))))
        (format t "\n")
      utt))
    ;;;
    (define (insert_pause utt word)
      "(insert_pause UTT WORDITEM)
      Insert a silence segment after the last segment in WORDITEM in UTT."
      (let ((lastseg (find_last_seg word))
            (silence "pau"))
          (if lastseg
            (item.relation.insert 
              lastseg 'Segment (list silence) 'after))))

    ;;;
    (define (insert_initial_pause utt)
      "(insert_initial_pause UTT)
      Always have an initial silence if the utterance is non-empty.
      Insert a silence segment after the last segment in WORDITEM in UTT."
      (let ((firstseg (car (utt.relation.items utt 'Segment)))
             (silence "pau"))
          (if firstseg
            (begin
              ;(format t "firstseg is %l\n" (item.name firstseg))
              (item.relation.insert firstseg 'Segment (list silence) 'before)))))
    ;;;
    (define (insert_final_pause utt)
      "(insert_final_pause UTT)
      Always have a final silence if the utterance is non-empty."
      (let ((lastseg (utt.relation.last utt 'Segment))
              (silence (car (car (cdr (car (PhoneSet.description '(silences))))))))
          (set! silence (format nil "%l" silence)) ; to make the symbol a string
          ;(format t "silence is %l\n" silence)
          ;(format t "lastseg is %l\n" (item.name lastseg))
          (if lastseg
          (if (not(equal? (item.name lastseg) silence))
              (begin
                  (format t "iserted final pause %s\n" silence)
                  (item.relation.insert lastseg 'Segment (list silence) 'after))))))

    ;;;
    (define (find_last_seg word)
      "Find the segment that is immediately at this end of word"
      ;;; If this word is punctuation it might not have any segments
      ;;; so we have to check back until we find a word with a segment in it
      (cond
      ((null word)
        nil)  ;; there are no segs (don't think this can happen)
      (t
        (let ((lsyl (item.relation.daughtern word 'SylStructure)))
        (if lsyl
          (item.relation.daughtern lsyl 'SylStructure)
          (find_last_seg (item.relation.prev word 'Word)))))))
    ;;;
    (provide 'INST_LANG_pauses))
