future
(require 'INST_LANG_phrase)
; TODOpour une autre italian_phrase_cart_tree voir italian_phrase_cart_tree
(define (Simbolic_word_end_punct word)
  "(Simbolic_word_end_punct WORD)
    Categorie di punctuation at end of related WORD, otherwise 0."
  (let (p)
    (set! p  (INST_LANG_token_end_punc word))
    ;(format t "999 p _%s_" p)
    (cond 
     ((string-equal p "0") "0")
     ((or (string-equal p ".") (string-equal p ").") (string-equal p ".»") (string-equal p ".\"") (string-equal p ".-")) 'A)   
     ((or (string-equal p ";") (string-equal p ");") (string-equal p ";»") (string-equal p ";\"") (string-equal p ";-")) 'B)   
     ((or (string-equal p ",") (string-equal p "),") (string-equal p ",»") (string-equal p ",\"") (string-equal p ",-")) 'C)   
     ((or (string-equal p ":") (string-equal p "):") (string-equal p ":»") (string-equal p ":\"") (string-equal p ":-")) 'D)   
     ((or (string-equal p "!") (string-equal p ")!") (string-equal p "!»") (string-equal p "!\"") (string-equal p "!-")) 'E)   
     ((or (string-equal p "?") (string-equal p ")?") (string-equal p "?»") (string-equal p "?\"") (string-equal p "?-") (string-equal p "?).")  (string-equal p "...?»") (string-equal p "...?\"") ) 'interrogative)
     ((or (string-equal p "..") (string-equal p "...") (string-equal p "...»") (string-equal p "...\"") ) 'G)
     ((or (string-equal p "-") (string-equal p "\"") (string-equal p "»") (string-equal p "\"") (string-equal p "\)") (string-equal p "\]") (string-equal p "\}")    ) 'H)   
     (t 'BHO))
    ))


(define (Phrase_Type utt)
 (let (lastword)
    (set! lastword (utt.relation.last utt (quote Word)))
    (format t "9999 lastword |%s|" (na word))
    (if lastword 
        (Simbolic_word_end_punct lastword))))

(provide 'phrase_type)

