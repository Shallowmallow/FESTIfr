(defvar tobi_support_yn_questions t
  "tobi_support_yn_questions
  If set a crude final rise will be added at utterance that are judged
  to be yesy/no questions.  Namely ending in a ? and not starting with
  a wh-for word.")

(define (first_word syl)
  (let ((w (item.relation.parent syl 'SylStructure)))
    (item.relation.first w 'Word)))


(define (syl_yn_question syl)
"(syl_yn_question utt syl)
Return 1 if this is the last syllable in a yes-no question.  Basically
if it ends in question mark and doesn't start with a wh-woerd.  This
isn't right but it depends on how much you want rising intonation."
  (if (and 
       tobi_support_yn_questions
       (member_string (item.feat syl "syl_break") '("4" "3"))
       (not (member_string 
         (downcase (item.name (first_word syl)))
         '("que" "comment" "qui" "quel" "quand" "pourquoi" "où" "qu" "lequel" "lesquels" "laquelle" "lesquelles")))
       (string-matches 
    (item.feat syl "R:SylStructure.parent.R:Token.parent.punc")
               ".*\\?.*"))
      "1"
      "0"))      

(provide 'net_tobi)      