;/*************************************************************************/
;/*                                                                       */
;/*                Institut für Maschinelle Sprachverarbeitung            */
;/*                     University of Stuttgart, Germany                  */
;/*                         Copyright (c) 1998                            */
;/*                        All Rights Reserved.                           */
;/*                                                                       */
;/*  Permission to use, copy, modify, distribute this software and its    */
;/*  documentation for research, educational and individual use only, is  */
;/*  hereby granted without fee, subject to the following conditions:     */
;/*   1. The code must retain the above copyright notice, this list of    */
;/*      conditions and the following disclaimer.                         */
;/*   2. Any modifications must be clearly marked as such.                */
;/*   3. Original authors' names are not deleted.                         */
;/*   4. It may not be redistributed in a modified version or within      */
;/*      another distribution                                             */
;/*  This software may not be used for commercial purposes without        */
;/*  specific prior written permission from the authors.                  */
;/*                                                                       */
;/*  THE UNIVERSITY OF STUTTGART AND THE CONTRIBUTORS TO THIS WORK        */
;/*  DISCLAIM ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING      */
;/*  ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT   */
;/*  SHALL THE UNIVERSITY OF STUTTGART NOR THE CONTRIBUTORS BE LIABLE     */
;/*  FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES    */
;/*  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN   */
;/*  AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION,          */
;/*  ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF       */
;/*  THIS SOFTWARE.                                                       */
;/*                                                                       */
;/*************************************************************************/
;/*             Author :  Mark Breitenbuecher                             */
;/*             Date   :  September 1997                                  */
;/*-----------------------------------------------------------------------*/
;/*                                                                       */
;/* ims_pattermatch.scm: Contains a function to match patterns.           */
;/*                                                                       */
;/*=======================================================================*/

(define (pattern-matches string pattern)
  "(pattern-matches string pattern)
   Matches string against pattern and returns a list of
   bindings.  It only finds the longest match of regex and there is no backtracking!  
   Regular expression must be put  in {}-parentheses
   and   { and } shouldn't occur in string or pattern ! 
   For each expression in {}, a Scheme-variable named #1, #2 ... is generated and the part of
   string that matches this expression is bound to this variable
   (similar to patternmatching in PERL).
   If match succeeds, pattern-matches returns t, nil otherwise.
   Example: (string-match3  \"123.234\" \"{[0-9]+}.{[0-9]+}\") 
   returns t and the variable-bindings
   pattern-matches should be used with caution!:
   *all* /!\ Variables named #1, #2 ... will be overwritten!"

  (define (string-match3 string pattern)
   
    (if (string-equal string pattern)  ; string=pattern => success
      (begin
        (resetvars)
        t  ; succeed
      )
      (if (string-equal (string-car pattern) "{")
        (let ((patbefore  (string-cdr (string-before pattern "}")))
              (restpat    (string-after pattern "}"))
              (reststring "")
              (varval     nil))

          (set! varval (mark-string-match string patbefore))

          (if (eq? varval nil)
            (begin
              (resetvars)
              nil  ; fail
            )
            (begin
              (set! newnamevar (newvar) )
              ;(format t "NEW %s\n" newnamevar)
              (set-symbol-value! newnamevar (symbol->string varval))  ; return a
                                                                    ; string?!
                                                                    ; Change 1
              (set! reststring (mark-string-rest string patbefore))
              (string-match3 reststring restpat))))

        (if (string-equal (string-car pattern) (string-car string))
          (string-match3 (string-cdr string) (string-cdr pattern))
          (begin
            (resetvars)
            nil ; fail. Could be there is another match, but only  the longest is tried, no backtracking
          ))
        (format t "%l\n" newvarlist))))

  (define newvar
    (let ((x 0))
      (lambda ()
        (set! x (+ x 1))
        ;symbolconc   Form new symbol by concatenation of the print forms of each of SYMBOL1
        ; SYMBOL2 etc.
        ; symbolexplode  Returns list of atoms one for each character in the print name of SYMBOL.
        ; ascii
        ;(set! newvarlist (append newvarlist (symbol->string  x)))
        ;(format t "%l\n" x)
        (symbolconc '# (list->symbol (symbolexplode x))))))

  (define (resetvars) t)

  (string-match3 string pattern))



(define (mark-string-match ATOM REGEX)
  "Returns the substring of ATOM's Printname that matches REGEX longest 
  match from the beginning), nil if it doesn't match."

  ; (substring STRING START LENGTH)
  ;   Return a substring of STRING starting at START of length LENGTH
  ;(format t "ATOM %l \n" ATOM)
  (set! nok_match t)
  (set! len (string-length_utf8 ATOM))
  (set! sub_string ATOM)
  ;(format t "mark-string-match ATOM %s\n" ATOM)
  ;(format t "len %s\n" len)
  (while (and nok_match (> len 0))
  ;(format t "len %s\n" len)
  (if (not (string-matches sub_string REGEX))
    (begin
      (set! len (- len 1))
      (set! sub_string (substring ATOM 0 len)))
    (set! nok_match nil)
   )
   )
  sub_string)


(define (mark-string-rest ATOM REGEX)
  "Returns all but the beginning part of ATOM's Printname that
   matches REGEX (The Part that mark-string-match doesn't return"
   (string-after ATOM  (mark-string-match ATOM REGEX)))

 
(provide 'INST_LANG_patternmatch)



   ; init_subr_2("mark-string-match", ims_german_text::mark_l_matches_match,
   ;     "(mark-string-match ATOM REGEX)\n"              matches REGEX (The Part that mark-string-match doesn't return")                    \
   ;     "  Returns the substring of ATOM's Printname that matches REGEX\n" \
   ;     "  (longest match from the beginning), nil if it dosen't match.");

   ; init_subr_2("mark-string-rest", ims_german_text::mark_l_matches_rest,
   ;     "(mark-string-rest ATOM REGEX)\n"                                 \
   ;     "  Returns all but the beginning part of ATOM's Printname that\n" \
   ;     "  matches REGEX (The Part that mark-strin matches REGEX (The Part that mark-string-match doesn't return")g-match doesn't return");

   ; init_subr_1("german_parse_cardinal", ims_german_text::german_parse_cardinal,
   ;     "(german_parse_cardinal numberstr)\n"                                \
   ;     "  Returns a list of words, representing the value of the integer\n" \
   ;     "  stored in numberstr. \"unknown\" if the integer is bigger than "  \
   ;     "\"999999999999999999999999\"");


