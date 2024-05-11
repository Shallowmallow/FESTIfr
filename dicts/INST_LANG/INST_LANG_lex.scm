; /home/dop7/MyDevelop/Voices/french_EXP2_70/LANGandDICT/dicts_INST_LANG/INST_LANG/INST_LANG_lex.scm
(defvar name_ref "")
(defvar verbose_INST_LANG_lex nil)
(defvar mode_lts_function_error nil)
(defvar mode_prehook t)
(defvar futuresampa nil)
; utile pendant mise au point des ADDENDA/*, par ex pour traquer l'addenda qui provoque l'erreur
; (lex.lookup_all "mot")
; restera le dico lui-même 
(defvar addenda_main t)
(defvar addenda_locutions t)
; mots ayant peu de raison de se plier à une quelconque lts
(defvar addenda_foreign t)
(defvar addenda_refractaire t)

; but fournir exemples pour nouvelle lts
(defvar addenda_fautif t)
; pour faire des tests
(defvar addenda_test t)

(defvar INST_LANG_lexdir (path-append lexdir "INST_LANG")
 "INST_LANG_lexdir default lexicon's path")    

(require 'INST_LANG_patternmatch); for pattern-matches
(require 'INST_LANG_supra_lts)
; à écrémer ou faire passer par la moulinette lts : INST_LANG_addenda

; locutions  INST_LANG_addenda_locutions    

; mots aynt peu de raison de se plier à une quelconque lts
; INST_LANG_addenda_foreign

; INST_LANG_addenda_refractaire : les récalcitrants, rentabilité
; à intégrer dans prochain dico, exemple flagrant : parasol 
; à corriger : INST_LANG_addenda_fautif
; pour test : INST_LANG_addenda_test
; sous cette forme on peut introduier un addenda "local"
; ie non situé dans INST_LANG_DIR
; 


(defvar  all_addenda
    (list 
        (if addenda_main (path-append lexdir "INST_LANG/INST_LANG_addenda.scm" ))
        (if addenda_locutions (path-append lexdir "INST_LANG/INST_LANG_addenda_locutions.scm"))
        (if addenda_foreign  (path-append lexdir "INST_LANG/INST_LANG_addenda_foreign.scm"))
        (if addenda_refractaire  (path-append lexdir "INST_LANG/INST_LANG_addenda_refractaire.scm"))
        (if addenda_fautif  (path-append lexdir "INST_LANG/INST_LANG_addenda_fautif.scm"))
        (if addenda_test  (path-append lexdir "INST_LANG/INST_LANG_addenda_test.scm"))
    ))


(defvar lexdebuglevel -1)
(require 'INST_LANG_utils)
(if futuresampa (require 'INST_LANG_xsampa))
(require 'INST_LANG_pos)

(require 'INST_LANG_lts)
; (require 'INST_LANG_supra_lts)



; hypothèses/considérations 

; HYPOTHÈSE1: les mots avec s/x final non muets sont dans le dico
; les mots ADJ, NOM, etc. dont la prononciation est exceptionnelle (ie. n'obéissant pas à la lts
; devront être accompagnés de leur forme plurielle si elle est existe (ou non prévoir les fautes )
 

; HYPOTHÈSE 2 : sur les VER:  la recherche d'un radical dans (wordroot est d'autant moins fiable que 
; que le radical est court exemple :prendre rendre prenait rendait 
; à moins que la lts ne soit peut-être entrainée spécialement sur le POS=VER,
; les formes conjuguées comme enivr*aient* a-eh i,e,n,t ->nil épuisent les
; n.n.n.n sans parler des manq uaient  et mang eaient
; 
; Partant de l'hypothèse que si les verbes ont un radical court, c'est parce qu'ils ont
; été très usités, déformés, usés, qu'ils ne se plient pas facilement à une lts,
; on prend soin de les mentionner dans le dico

; HYPOTHÈSE 3: le choix de "-" comme lettre de l'alphabet permet que des mots composés
; ouvre-bouteille, porc-épic sont bien lus lts dans le sens où elle a été
; entraînée pour cela, alors que l'entraînement de la lts s'est fait et se fera
; sans mot contenant une apostrophe, d'ailleurs contrairement à "-",
; l'apostrophe n'est pas considéré comme une lettre mais un "whitespace"
; (choix notamment fait parce que l'apostrophe ne modifie pas la liste des
; phonèmes contrairement au  tiret avec des liaisons possibles.

; HYPOTHÈSE 4 : les mots avec apostrophe interne quatr'saison, aujourd'hui,prud'homme entr'acte
; sont dans le dictionnaire (

;HYPOTHÈSE 4: mots composés et préfixes

; Token_INST_LANG prend en commpte, outre des mots "normaux", ie dans le dictionnaire ou 
; devinables par la lts, des mots de la forme r1_r2 où r1 est dans [c,d,l,m,n,qu,s,t] et à un 
; POS  connu et r2 est un mot normal de POS connu exemple c_est, qu_alors
; en quelque sorte *t'aime"  est vu comme un verbe composé 
; *c'est* aussi, plus contestable (gloups= vu le bug, obligation mettre dans le dico ???)

; un mot normal peut avoir un préfixe connu auto, brachy, neuro, etc.
; on a abandonné l'idée de détecter des préfixes, pas très rentable ...

; (defvar list_prefix (list "auto" "neuro" "anti" "arché" "broncho" "brachy" "schizo"))
; la lts pourvoira  code trop compliqué ex s'autoalimentent
;  et existence d'exceptions même dans les cas simples comme auto et neuro ex autour, automne, 
; neurone
; s'il est vrai que certains mots composés défient la lts, ce n'est le cas 
; que dans le cas où l'Académie s'attend à un tiret ( il y a bien sûr des exceptions
; oubli de la part des Académiciens ? ... parasol, aérosol, primesautier
; dans "autosatisfaction" "osa" on entendra oza
; s'il existe assez d'exemples et que le laisser-aller est autorisé :)
; TODO ? on pourra faire un ajout de tirets au niveau de la fonction "norm".


; questions code :
; //  If no features have a match the first headword match is returned
; //  as that pronunciation is probably still better than letter to 
; //  sound rules
; ;HYPOTHÈSE 5
; => pas sûr d'être d'accord => idée de passer par my_strict_lex.lookup

; pas sûr de l'intéret de s'obstiner à respecter la casse de l'initial d'un mot
; voir modules/Lexicon lts.cc ou  lex_ff.cc (ffeatures functions
; word = downcase(s->name())
; dommage pour la reconnaissnce des nomms propres
 

; TODO XXXX essai
(define (INST_LANG_lts_function_default word features)
  "(INST_LANG_lts_function WORD FEATURES)
    Function called when word is not found in lexicon, returns pronunciation
    of word (with the detected POS ) using our lts prediction rules
    (trained or otherwise)"
    (let ()
      (if verbose_INST_LANG_lex (format t "call INST_LANG_lts_function: WORD NOT IN LEXICON ?? : %s %s \n" word features))
      (lts_brut word features)
      ))

(define (INST_LANG_lts_function_error word features)
  "(INST_LANG_lts_function WORD FEATURES)
    Function called when word is not found in lexicon, returns error "
    (error "word missing in the dictionary and addenda" (list word features)))


(if mode_lts_function_error 
  (set! INST_LANG_lts_function INST_LANG_lts_function_error)
  (set! INST_LANG_lts_function INST_LANG_lts_function_default))
  


(define (my_strict_lex.lookup WORD features)
    ; we use lex.lookup_all, not lex.lookup in order to avoid "unknown word function"
    ; to sound rules (or whatever method specified by the  current lexicon's lts.method )
    ; si on ne trouve pas le mot on obtient nil
    ; we obtain a list, we take the first one if any -> (car u) as (car nil) is nil
    ; there could be several, normally the ones in the addendas have the preferences
    ; which one ? that depends on the order of the introduction of the addenda
    ; in  (INST_LANG_addenda_load)

    ; exemple
    ; (my_strict_lex.lookup "est" "AUX")
         ;("est_AUX" AUX (((eh) 0)))
    ;  (my_strict_lex.lookup "est" "NOM")
        ;("est_NOM" NOM (((eh s t) 0)))
    ; TODO
    ; 2 caveats
    ; 1. ne regarde pas dans le dictionnaire !!
    ; 2. pour un feature avec : PRO:rel, ART:def, etc. donne nil !!!
     (car (lex.lookup_all (string-append WORD "_" features) features)))
     
;; les changements d'addenda sont pris en compte à tout moment en faisant (INST_LANG_addenda_load)
(define (INST_LANG_addenda_load)
  "(INST_LANG_addenda_load)
  Add entries to the current lexicon.  These are basically
  words that are not yet in the lexicon.
  It may be prefered to put words when they are very common
  *and* there is no big hope for a newer lts to be well dealt
  such as the \"grammatical\" words."
  ; and by the way, the lts could be simpler, if they are not 
  ; in the training set

  ; load is enough, the parent INST_LANG_lex has a provide stanza 
  (mapcar
    (lambda (addendapath)
      (if verbose_INST_LANG_lex (format t "addendapath: %l\n" addendapath))
      (if (probe_file addendapath)
          (begin
            (if verbose_INST_LANG_lex (format t "INST_LANG_lex < addendapath: %l" addendapath))
            (load addendapath)))
)
      all_addenda))   

;;;


;ref  Optional pre- and post-lookup hooks can be specified for a lexicon. As a single
;ref  (or list of) Lisp functions. The pre-hooks will be called with two arguments
;ref  (word and features) and should return a pair (word and features). The post-hooks
;ref  will be given a lexical entry and should return a lexical entry. The pre- and
;ref  post-hooks do nothing by default. 


;; voir example italien
;; define (irst_pre_lex_function word feats)
;; "(pre_lex_function word feats): Funzione di Pre-lessico per mappare tutti i caratteri in quelli giusti, 
;; in piש tratta le parole con l'apostrofo, unendo la sillabazione ma mantenendo la trascrizione delle singole parole."

; ex il trompait: prehook fait chercher trompè dans le dictionnaire
; pre_hook cherche trompè_VER VER, s'il y est c'est bon
; sinon on cherche trompè VER
; s'il n'y est pas on fait appel à la lts
; tandis que  

; to be use via  (lex.set.pre_hooks 'INST_LANG_lex_pre_hook_function)

(define (INST_LANG_lex_unset_pre_hook_function word features)
   (list word features))

(define (INST_LANG_lex_pre_hook_default_function word features)
    "The pre-hooks will be called with two arguments word and features and
    should return a pair (word and features). The pre-hook do nothing by
    default."
    (format t "\t\t\tprehook %s %s\n" word features)
    (let (results wordd featuresd)
      (cond 
        ; la 1ere condition n'est jamais remplie, elle  affiche ou non une indication .. de notre passage, une trace

        ; ((and (lexdebug 1 (format nil "INST_LANG_lex_pre_hook_function QL20 mot du dico ?: |%s| features %s" word features)) nil)) 
        ; (; bien redondant
        ;  ; rappel docu_my_strict_lex  pour word Pourquoi et features PRO:int
        ;  ; si on a (lex.add.entry '("Pourquoi_PRO:int" PRO:int (((p u rh)0)((k w a)0))))
        ;  ; > (my_strict_lex.lookup "Pourquoi" "PRO:int")       
        ;  ; festival>("Pourquoi_PRO:int" PRO:int (((p u rh) 0) ((k w a) 0)))  
        ;   (if (my_strict_lex.lookup word features) 
        ;     (begin 
        ;       ; (format t "strict and accurate")
        ;       ; (set!  dontsearchanymore t)
        ;       (set! featuresd features)
        ;       t)
        ;     (begin
        ;       nil))
        ; gloups XXX
        ((and nil (boundp 'addenda_hook)(set! results (addenda_hook word features)))
          results)
        ((my_strict_lex.lookup word features)
          (lexdebug -1 (format nil "INST_LANG_lex_pre_hook_function QL20 mot du dico ?: |%s| features %s" word features))
          (set! wordd (string-append  word "_" features))
          (set! results (list wordd featuresd))) 
              
        
        ((and (lexdebug 1 (format nil "INST_LANG_lex_pre_hook_function QL30?: |%s| features %s" word features)) nil)) 
        
          
        ;  à revisiter ! TODO
        ((and (lexdebug 1 (format nil "QL40 sampa ?|%s|\n" word)) nil))
        ((and (string-equal features "SENT"))
          ;
          (set! results  (list "." "SENT")))

        ((and (lexdebug 1 (format nil "QL10 sampa ?|%s|\n" word)) nil))
        ((and futuresampa (sampa? word))
          ;
          (set! syls  (INST_LANG_lex_sampa word))
          (format t "debug2 ajout au dictionnaire !")
          (lex.add.entry (list word "samp" syls))
          (list word "samp"))                
        
        (t 
          (lexdebug 1 (format nil "QL cas général ?|%s|\n" word))
          (set! results (list (wordroot word features) features))   
          ))  
        results)) 
     
(if mode_prehook 
   (set! INST_LANG_lex_pre_hook_function INST_LANG_lex_pre_hook_default_function)
   (set! INST_LANG_lex_pre_hook_function INST_LANG_lex_unset_pre_hook_function)
   )



; TODO renommer wordroot, plus mot (simplifié) de "référence"
; moins intéressant depuis abandon confirmé de l'idée du radical ?
; la lts s'en trouve-t'elle si simplifiée ?
; et si le seul intérêt était de supprimer les *ent finaux d'un VER 

; pour les distinguer des ADV excellent VER => excelle VER <> excellent ADV 
; 6 formes ent$ pour placer, 4 ai[s|t|ent

; on pourrait distinguer 2 types de "radicaux" 
; radical présent, imparfait (indicatif, impératif ou subjonctif) passé simple, participe présent et un 
; "radical" futur, conditionnel égal ou basé sur l'indicatif
; appell r1 / appel r2 ; appeller  ;; harceler harcelle / harcel ; harceller |p harcèler ;; révèl / révél; révéler
; achèt r1 / achet r2 ; achèter
; pèl  r1 / pel r2 ; peler
; dissèqu r1 disséqu r2 ; dissèquer

; r2 é pour disséquer/el[^l] pour appeler; pel pour peler
; juste pour nous, vous au présent de l'indicatif, l'impératif ou du subjonctif ,pour tout l'imparfait
; r2 le passé simple, les participe passé, le participe présent SI VER en er ?
; pour peler
; radicaux pèl et pel
; r1 déç / décev r2 /déçoiv r3 ; décevr 
; les r1 pour le passé simple et passé simple avec terminaison en çoi ou çu
; pour devoir ça se gâte d doi dev devr ça commence à faire beaucoup de radicaux 
; ....
; mais on ne cherche pas à conjuguer un verbe donné
; on nous  une forme verbale, on veut la prononcer
; pour reconnaître une forme verbale, il faut qu'on puisse la reconnaitre avec ce qu'on a 
; dans le dico 
; si on peut "assimiler" aimé aimée aimées aimés aimez et aimai d'une part
; et d'autre part aimait, aimaient comme aime, aiment 
; on facilite au moins la maintenance du dico poslex
; ça revient à multiplier le nombre de "radicaux" mais à diminuer le nombre de terminaisons
; aient -> è ça ne peut que simplifier l'apprentissage de la lecture .. et donc la lts


; utilité des verbes_: verbes_ient, verbes_eent??? on peut passer par 
; (lex.add.entry '("redevient_VER" "VER" (((rh ae)0)((d ae)0)((v j ehn)0))))
; si wordroot est trompeur ...

(define (wordroot name features) ; TODO mal-nommé refword ?en cours
  "name_ref"
  ; ex: *marchent* VER se réfère à *marche* VER
  ;     *excellent* VER à *excelle" VER
  ; ne doit se calculer que si le name n'a pas d'entrée exacte
  
  (lexdebug 1004 (format nil "wordroot name: %s\n features: %s\n" name features))
    
  (let (name_ref name_letters last_letter)
    (set! name_letters (utf8explode name))
    (set! last_letter (car (last name_letters)))
    (set! name_ref name)
    
    (cond 
      ((member_string features (list "VER" "AUX"))
       ; radical pas trop court, ni  trop tordu
       (cond 
         (; *aient / ; *oient -> même qu'au singulier ! 
           (or (string-matches name ".*aient$")
               (string-matches name ".*oient$"))
            (set! name_ref  
                  (wordroot (string-append (substring name 0 (-(length name) 3)) "t") features)))
            ;(set! name_ref  (string-append (substring name 0 (-(length name) 3)) "t"))); 
        ((and (string-matches name ".*ent$") ; lisent
              (not (member_string name verbes_ient)
                   (not (member_string name verbes_eent))))  ; créent versus aim:ent aim:èrent
             ;(string-matches name ".*ouent$") (string-matches name ".*uient$")); TODO à vérifier pour les autres *ent que aient
             ; avant de regrouper dans 1 case VER
             (set! name_ref  (substring name 0 (-(length name) 2)))); lis: 

         ;utile ou non suivant lts 
         ((or (string-matches name ".*er$")(string-matches name ".*ez$"))
              (set! name_ref  (string-append (substring name 0 (-(length name) 2)) "é")))
          ; place aux exceptions prenait, comprenait ... venait, advenait dans le dico
          ((or (string-matches name ".*ait$")  (string-matches name ".*ais$"))
           (cond  
            ((string-matches name ".*erait$") ; tempo  manquerait)
              (set! name_ref  (string-append (substring name 0 (-(length name) 4)) "rè")))
            (t 
              (set! name_ref  (string-append (substring name 0 (-(length name) 3)) "è")))))
          ((string-matches name ".*ai$") 
           (cond  
            ((string-matches name ".*erai$") ; tempo  manquerait)
              (set! name_ref  (string-append (substring name 0 (-(length name) 3)) "ré")))
            (t 
              (set! name_ref  (string-append (substring name 0 (-(length name) 2)) "é")))))
              
          ((string-matches name ".*aits$") ; il nous a satisfaits
           (cond  
            (t 
              (set! name_ref  (string-append (substring name 0 (-(length name) 4)) "è")))))              
          ; moultes exceptions dans dico doit
          ((string-matches name ".*oit$")
           (cond  
            ((string-matches name ".*eroit$") ; tempo  manqueroit)
              (set! name_ref  (string-append (substring name 0 (-(length name) 4)) "roi")))
            (t 
              (set! name_ref  (string-append (substring name 0 (-(length name) 3)) "oi")))))  
          
          
          ((or (string-matches name ".*ont$")  (string-matches name ".*ons$"))
           (cond  
            ((string-matches name ".*eront$")
              (set! name_ref  (string-append (substring name 0 (-(length name) 4)) "ron")))
            (t 
              (set! name_ref  (string-append (substring name 0 (-(length name) 3)) "on")))))          
      
           ; TODO *ut subjonctif + exceptions dico veut, peut, promeut, , faut chaut ou lts fut,
           ; moins de 500
           ; distinguer *out absout , sinon y

         ((or (string-matches name ".*us$")  (string-matches name ".*ut$") (string-matches name ".*ût$") (string-matches name ".*ûs$")
              (string-matches name ".*as$")  (string-matches name ".*at$") (string-matches name ".*ât$") (string-matches name ".*âs$")
              ; ici .. donc ne concerne pas *aies ou autre
              (string-matches name ".*es$") (string-matches name ".*at$")
              )
             (set! name_ref  (substring name 0 (-(length name) 1))))
        ; en i 3cas enfouis, enduis, souris/traduisis + exceptions ... mis 
        ((or (string-matches name ".*is$")  (string-matches name ".*it$"))
             (set! name_ref  (substring name 0 (-(length name) 1))))
        ))
    
      ((and (lexdebug 1 (format nil "non verbe |%s|\n" name)) nil))
      
      ((and (pattern-matches name "{[^-]*}-{.*}") (not (string-equal #2 "")))
        ; on pense à ouvre-bouteille, moyen-orient, locution ad-hoc 
        (set! h1 #1)(set! h2 #2)
        (cond 
          ((and nil (peut_se_denat? h1) (lex.lookup h2))
            ; h2 gouverne en général le POS du mot composé, mais seulement en général
            ; en plus il peut y a voir des homophones avant-garde garde NOM ou VER ?
            ; que faire si pas bien détecté par lts 
            ; pb (lex.lookup h2) pas constant ex un moyen moyen-orient XXX
            ;; vaudrait pe si les locutions étaient correctement détectées dans norm !
            ; ça reviendrait à enlever le signe - pour le remplacer par special_slice_char ...
            (set! name_ref (string-append h1 " " h2)))
          (t 
            (set! name_ref (string-replace name "-" special_slice_char))))
        (format t "INST_LANG_lex wordroot: name_ref %s\n" name_ref)
         name_ref)
      
      (t 
        (lexdebug -1 (format nil "999 cas général wordroot _%s_ \n"  name))
           (if (or (is_sx_exist_and_not_mute name) (not (member_string (string-last name) (list "s" "x"))))
               (begin
                (set! name_ref name)
                (format t "info: name_ref %s\n" name_ref))
               (begin 

                 (set! name_ref  (string-but-last name))
                 (format t "info: name_ref %s" name_ref)))
              
              
              )
    )
   ; le jeu en vaut-il la chandelle ? non   
   ; suppose pas de s/x finaux pour name_ref  
   ; whatabout the always not mute ex : index
   ; => nécessité de mettre toutes les entrées des POS possibles
   ; dans le dico si le mot se termine par s ou x 
   ; (if (is_sx_exist_and_not_mute name_ref)
   ;     name_ref
   ;     (string-but-last name_ref)
   ;  ) 
   name_ref))

; pour cmulex 
; (set! lex_syllabification (list cmulex_mosyl_phstress))

; (lex.create "cmu")
; (lex.set.compile.file (path-append cmulexdir "cmudict-0.4.out"))
; (lex.set.phoneset "radio")
; (lex.set.lts.method 'cmu_lts_function)
; (lex.set.pos.map english_pos_map_wp39_to_wp20)
; (cmulex_addenda)





(lex.create "INST_LANG_lex")
(lex.set.compile.file (path-append lexdir "INST_LANG/INST_LANG_dict_0.1.out"))
(lex.select "INST_LANG_lex")


;; (lex.add.entry '("où_PRO:rel" "PRO:rel" (((u)0))))
;; (lex.add.entry '("jusqu_où_PRO:rel" "PRO:rel" (((zh y s)0)((k a)0))))
;; (lex.add.entry '("jusqu_à_PRE" "PRE" (((zh y s)0)((k a)0))))
; (format t "debug: selection lexicon: addenda added\n")

(set! lastlex (lex.select "INST_LANG_lex")); lastlex is the lex before the select
;ref   Set the current lexicon's letter-to-sound method to METHOD.  METHOD
;ref   can take any of the following values: Error (the default) signal a
;ref   festival error if a word is not found in the lexicon; lts_rules use the
;ref   letter to sound rule set named by lts_ruleset; none return
;ref   simply nil in the pronunciation field; 
;ref   function use call the two argument
;ref   function lex_user_unknown_word (as set by the user) with the word and
;ref   features to provide an entry. 
(lex.set.lts.method "INST_LANG_lts_function")  
(lex.set.pre_hooks 'INST_LANG_lex_pre_hook_function)
;; TODO 
(lex.set.phoneset "INST_LANG")


; TODO
; éviter les appels multiples
;;; Flag to allow new lexical items to be added only once
;;(defvar INST_LANG_added_extra_lex_items nil)
;;; /!\ à remettre à nil si reset fb
;;; éviter : 
; festival> (lex.lookup_all "cette")
; (("cette" ADJ:dem (((s eh t) 0)))
;  ("cette" ADJ:dem (((s eh t) 0)))
;  ("cette" ADJ:dem (((s eh t) 0)))
;  ("cette" ADJ:dem (((s eh t) 0))))

(INST_LANG_addenda_load)


(provide 'INST_LANG_lex)
