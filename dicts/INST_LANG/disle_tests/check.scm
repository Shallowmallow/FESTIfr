(define (check fil)
  "(check file)"
 (voice_INST_LANG_VOX_cg)
 
 (set! outdir (dirname fil))
    (format t "fil: %s " fil)
    (set! p (load fil t))
    (mapcar
     (lambda (l)
        (set! utt (SayText (cadr l)))
        (utt.save.relation utt 'Word (path-append outdir (string-append (car l) ".out")))
        (format t "check n°%l\n" (car l))
        (format t "check %l\n" (cadr l))
        ; pas le propos mais bon 
        (format t "%s" (utt.flat_repr utt))
       t)
     p))

