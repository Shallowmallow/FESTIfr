; praat.scm
; exemple 
; Praat is running 
; (set! utt (SayText "ça marche assez bien"))
; (utt.praat utt)

(defvar timeout 20)
 

(define (utt.save.praat.pitchtier utt fn)
  (let ((fd (fopen fn "w"))
  (i 1))
    (format fd "File type = \"ooTextFile\"\n")
    (format fd "Object class = \"PitchTier\"\n\n")
    (format fd "xmin = 0\n")
    (format fd "xmax = %f\n" 
      (item.feat (utt.relation.last utt 'Segment) 'end))
    (format fd "points: size = %d\n"
      (length (utt.relation.leafs utt 'Target)))
    (mapcar
     (lambda (target)
       (format fd "points [%d]:\n" i)
       (format fd "    time = %f\n" 
         (item.feat target 'pos))
       (format fd "    value = %f\n" 
         (item.feat target 'f0))
       (set! i (+ i 1)))
     (utt.relation.leafs utt 'Target))
  (fclose fd)))


(define (utt.save.praat.texttier utt fn)
  (let ((fd (fopen fn "w"))
  (x 0)
  (xmax 
   (item.feat (utt.relation.last utt 'Segment) 'end))
  (i 1))
    (format fd "File type = \"ooTextFile\"\n")
    (format fd "Object class = \"TextGrid\"\n\n")
    (format fd "xmin = 0\n")
    (format fd "xmax = %f\n" xmax)
    (format fd "tiers? <exists>\n")
    (format fd "size = 1\n")
    (format fd "item []:\n")
    (format fd "    item [1]\n")
    (format fd "        class = \"IntervalTier\"\n")
    (format fd "        name = \"Segments\"\n")
    (format fd "        xmin = 0\n")
    (format fd "        xmax = %f\n" xmax)
    (format fd "        intervals: size = %d\n"
      (length (utt.relation.items utt 'Segment)))
    (mapcar 
     (lambda (item)
       (format fd "        intervals [%d]:\n" i)
       (format fd "            xmin = %f\n" x)
       (set! x (item.feat item 'end))
       (format fd "            xmax = %f\n" x)
       (format fd "            text = \"%s\"\n" 
         (item.feat item 'name))
       (set! i (+ i 1)))
     (utt.relation.items utt 'Segment))
    (fclose fd))
  
  
  )

(define (sendpraat messages)
  "
  \(sendpraat MESSAGES\)
  
  Send MESSAGES to Praat using the separately running sendpraat program,
  where MESSAGES is a list of Praat command strings.
  Used as an alternative for no compilation.
  see man sendpraat
  "
  (let (command)
    (set! command (format nil "sendpraat %s praat " timeout))
    (mapcar
     (lambda (message)
       (set! command
       (string-append command
          (format nil " \"%s\"" message))))
     messages)
    (set! command (string-append command "\n"))
    (format t command)
    (system command)
    ))

(define (utt.praat utt)
  "
  \(utt.praat UTT\)
  
  Draw UTT's signal, segment labels, and pitch contour in Praat.
  "
  (let 
    (fn
      bn
      wav_fn
      text_fn
      pitch_fn)
    (set! fn (make_tmp_filename))
    (set! bn (basename fn))
    (set! wav_fn (string-append fn ".Wav"))
    (set! text_fn (string-append fn ".TextGrid"))
    (set! pitch_fn (string-append fn ".PitchTier"))
    (utt.save.wave utt wav_fn 'wav) 
    (utt.save.praat.texttier utt text_fn)
    (utt.save.praat.pitchtier utt pitch_fn)
    ;; needs to be done asynchronously, 
    ;; otherwise files are deleted before Praat has read them
    (set! messages  
      (append 
        (list (format nil "Read from file... %s\n" wav_fn))
        (list (format nil "Read from file... %s\n" pitch_fn))
        (list (format nil "Read from file... %s\n" pitch_fn))
        (list (format nil "Read from file... %s\n" text_fn))
        (list (format nil "select Sound %s\n" bn))
        (list (format nil "To Manipulation... 0.01 75 300\n"))  
        (list (format nil "select PitchTier %s\n" bn))
        (list (format nil "plus Manipulation %s\n" bn))
        (list (format nil "Replace pitch tier\n")) 
        (list (format nil "select Manipulation %s\n" bn))
        (list (format nil "Edit\n"))   
        (list (format nil "select Sound %s\n" bn))
        (list (format nil "plus TextGrid %s\n" bn))
        (list (format nil "Edit\n"))))
    
    (sendpraat messages)
    ;; tempo debug
    ;(delete-file wav_fn)
    ; (delete-file text_fn)
    ; (delete-file pitch_fn)
    ))
    
(define (quit_prat)
  (sendpraat (list ("Quit"))))

(provide 'praat)