; INST_LANG_words_exceptions.scm
(require 'util)

(defvar verbose_words_exceptions)


;On sentira comme une erreur de prononciation (et non comme une liberté prise
;par rapport à la norme) l'omission d'une telle liaison, quel que soit le
;registre de langue (de la langue soutenue à la langue vulgaire). La liaison
;est obligatoire :

;** entre le déterminant et son nom, 
; un enfant, les enfants

;** le nom et l'adjectif qui le précède : 
;(disle " petits enfants, grand arbre, tout homme, deux ours, vingt euros " 1)

;** entre le pronom personnel et son verbe, ainsi que l'inverse :
; nous avons, elles aiment, on ouvre, ont-ils,  

;** entre  en ainsi que  y avec le verbe
; prends-en, allons-y; en avez-vous 


; /!\ pensez aux mots "fabriqués" ex rations-nous
; is_exc_vertions concernent les verbe *tions ne se prononçant "s j ohn"
; si pas plus de cas ... ne pas faire intervenir dans la fonction INST_LANG_lex::postlex_corr !
 
(define (is_exc_vertions mot)
     (member_string mot (list "xxxtions")))

(define (is_exc_nomtions mot)
     (member_string mot (list "questions")))

; liste des mots dont le s final ne se lie pas par la droite
; triés : vraiment à proscrire = faute,  des autres

; chgt de logique :( par rapport à la liste s_ne_se_lie_pas ?
; ou gloups ? TODO ACF
; La liaison est interdite après un nom singulier.
; ici on inscrit le nom au singulier.
; puisque c'est le singulier qui sert dans le lexique
; voir wordroot 
; on dit bien  tant et plus !
; ++++++++++++++++++++++++++++++++


;(defvar peut_se_denat? (complement identity))
; nécessité de les signaler comme non exception
; dans 
(define (peut_se_denat? mot)
   (member_string (french_downcase_string mot)(list
        "bon"
        "divin"
        "premier"
        "plein"
        "moyen"
        ; faux "neuf" neuf enfants de neuf ans 
        ; faire passer neuf ans en locution !
        ;"adv:pos_plus_"
        "plus"
        ;"de_plus"
       ; non !! "un"
        ;  "y"
        "un"
        ""
        ))) ; assoc cas spéciaux divin in -> i n 

; list_exclus*->_default  permet utilisation de add_to_list dans
; addenda_stage (accompagné d'un ;
; (netlex::reset-lexical)
; (set! list_exclus*->(append (list "expliquez" "contentieux") list_exclus*->_default)) 


; la liaison est interdite après un nom singulier se terminant par s
; pour simplfier on interdit aussi les pluriels corps, repas, repos etc..
; plus les mots étrangers particulièrement latins
; ce n'est pas le cas de x exemple Littré 
; Cet x final se lie et prend le son de z : Baux à longues années, bô-z à.... Un choix heureux, choi-z heureux ; une paix inattendue, pê-z inattendue.
        
(defvar list_exclus->*_default 
   (list
        ; si VER ou ADV c'est à cause postlex ex: maintenant au boulot ! maintenant vu comme VER
        "maintenant"  ; maintenant * au boulot
        ; usage .. et pb d'abréviations ?
        "monsieur" ; monsieur *Aignan
        ; exceptions en locution cinq à sept, quant à passent en locutions
        "demain"
        "et" ; il chantait * et /!\ d'ores et déjà, ceux et celles  passent en locutions
        "enfin" ; enfin * il 
        "eux" ; eux * aussi, eux * ont  SAFE
        "fils" ; fils * 
        "fils_fis"
        "tabac"; tabac * à rouler  SAFE
        "hamac" ; SAFE
        "pour" ; car r est sonore SAFE :  sinon {(0 p  u  rh )}{(0 rh oh  g )(0 m  ahn )(0 t  e )}>
        "leur" ; car r est sonore SAFE
        "Tous"
        "cep" ; SAFE
        "tantôt"; SAFE
        "aussitôt"
        "néanmoins"
        "plutôt"; SAFE plutôt * au 
        "tôt"
        "bientôt"; SAFE
        ;"depuis"; SAFE
        "autant";SAFE 
        ; se terminant par t  (tous les mots *at)
        "abricot"
        "acabit"
        "acquit" ; NOM
        "acquêt"
        "apostat"
        "apostolat"
        "apprêt"
        "appât"
        "appétit"
        "arrêt" ;  SAFE arrêt au stop; sf soutenu
        "art"
        "artichaut"
        "assignat"
        "attentat"
        "attribut" ; sf soutenu
        "avocat" ; ""
        "aérostat"
        "bahut"; ""
        "ballet" ; ""
        "bandit" ;""
        "banquet" ;" "
        "castrat"
        "cerf"
        "doctorat"
        "drap"
        "point"
        ;"tant" ; safe tant t'effrayer,  non tant_elle est ok
        "projet" ; projet * initial
        "trébuchet"
        "verset"
        "vérat"
        ; nez
        "tours"; siwi tours aux ailes    SAFE
        "ailleurs"; sing. ou plur. OBLG
        "alors"
        ; "fils_ﬂ_fis" ; fils ... TODO
        "ans" ; les ans ont passé SAFE
        ; "années" ; safe plusieurs années après
        "arts" ; ;les arts américains  SAFE
        ; "bavards"
        ; "bavardes"
        ; "béquillards"
        ; "bêtes" ; siwi
        "pieds" ; siwi siw pieds environ SAFE
        "bézoards" ; SAFE
        ; "blafards"
        ; "blafardes"
        ; "boucs"
        ; "boulevards"
        ; "boulevarts"
        ; "bourgs"
        ; "brancards"
        ; "brassards"
        ; "brocards"
        ; "brocarts"
        ; "brouillards"
        "cadenas"; sing. ou plur.
        ; "cafards"
        ; "cafardes"
        ; "camisards"
        ; "campagnards"
        ; "campagnardes"
        "camus"; sing. ou plur.
        "camuses" ; SAFE
        ; "canards"
        "canevas"; sing. ou plur.
        ; "canifs"
        ; "captifs"
        ; "captives"
        ; "cerfs"
        ; "chars"
        "châssis"; sing. ou plur.
        ; "chefs"
        ; "civils"
        ; "civiles"
        ; "clercs"
        ; "concerts"
        "concours"; sing. ou plur.
        ; "conforts"
        "consorts"; sing. ou plur.
        ; "corbillards"
        ; "cornards"
        "cinq"
        "corps"; sing. ou plur. ; mais corps et biens locution
        "cours"; sing. ou plur.
        ;; "contentieux" ; des contentieux ont, hmm choix perso ?
        ; "couverts"
        ; "cuissards"
        ; "dards"
        ; "déconforts"
        "débat" ; TODO homo VER
        "décours"; sing. ou plur.
        "dehors"; sing. ou plur.
        ; "déports"
        ; "désaccords"
        ; "déserts"
        ; "desquels"
        ; "desserts"
        "devers"; sing. ou plur.
        ; "discords"
        "discours"; sing. ou plur.
        "dos"; sing. ou plur.
        ; "dots"
        ; "écarts"
        ; "échecs"
        ; "efforts"
        ; égards" ; SAFE vu que à tous égards locution
        "envers"; sing. ou plur.
        ; "épinards"
        ; "entassés"; siwi
        ; "étendards"
        "erectus"
        "extremis"
        ; "fards"
        ; "faubourgs"
        ; "fils"
        "fois" ; une fois adv
        ; "forts"
        ; "fortes"
        ; "foulards"
        ; "frocards"
        "fusils" ; fusils avaient été Z SAFE
        ; "gadouards"
        ; "gaillards"
        ; "gords"
        ; "gueusards"
        "habilis" ; OBLG
        "hachis"; sing. ou plur.
        ; "hamacs"
        ; "hasards"
        ; "hauberts"
        "heures" ; évite 2 heures après-midi Z Z SAFE
        ; "homards"
        "hors"; sing. ou plur.
        ; "huards"
        ; "hussards"
        ; "infects"
        ; "infectes"
        ; "instants" ; siwi
        ; "jougs"
        ; "jours"
        "justaucorps"; sing. ou plur.
        ; "lacs"
        ; "laquelles"
        ; "lards"
        ; "léopards"
        ; "lesquels"
        ; "lézards"
        ; "liards"
        ; "lords"
        ; "logis"
        ; "marcs"
        ; "mélodies"; siwi
        ; "milliards"
        "milords"
        "moeurs" ; sing. ou plur.
        ; "mœurs"; 
        ; "molles" ; siwi
        ; "morts"
        ; "mouchards"
        ; "nautilius"
        ; "nerfs"
        ; "neufs"
        ; "neuves"
        "parcours"; sing. ou plur.
        "propos" ; propos en propos SAFE
        ; "pêcheurs" ; SIWI
        ; "pans" ; siwi
        ; "parts"
        ; "périls"
        ; "permis" ; siwi
        ; "pétards"
        ; "pirates" ; siwi
        ; "placards"
        ; "poignards"
        ; "porcs"
        ; "ports"
        "pouls"; sing. ou plur. OBLG
        ; "puisards"
        ; "rapports"
        ; "regards"
        ; "remparts"
        "repas"
        "repos"
        ; "renards"
        ; "renforts"
        ; "ressorts"
        ; "retards"
        "repris" ; repris espoir
        "secours"; sing. ou plur. OBLG
        ; "serfs"
        ; "serves"
        ; "sorts"
        ; "souches" ; siwi
        "souris"; sing. ou plur. OBLG
        ; "supports"
        ; "transportés" ; siwi
        ; "torts"
        "toujours"; sing. ou plur.
        "tous" ; ACF
        ; "traînards"
        ; "transports"
        "travers"; sing. ou plur.
        "treillis"; sing. ou plur.
        "univers"; sing. ou plur.
        "verjus"; sing. ou plur.
        "vers"; sing. ou plur.
        "voix"; sing et pluriel SAFE
        ; "veufs"
        ; "veuves"
        ; "vieillards"
        ;; PRO_rel
        "auxquelles"; SAFE
        "desquelles"; SAFE
        "desquels"; SAFE
        "lesquelles"; SAFE
        "lesquels"; SAFE
        ;;
        "uns" ; SAFE les uns * ont
        ;; adverbes longs : faire une règle
        "alternativement"
        "apparemment"
        "attentivement"; SAFE
        "complètement" ; SAFE
        "convenablement"
        "électriquement"
        "essentiellement"
        "fortement"
        "formidablement"
        "magnifiquement"
        "moyennant"; SAFE
        "nonobstant"; SAFE
        "obliquement"
        "particulièrement"; SAFE
        "précisément"; SAFE
        "probablement"; ; SAFE
        "solidement"; SAFE
        "volontairement"
        "yves"
        ;; CON ou 
        "combien"
        "comment"; SAFE
        "z_en"
        "hameçon"
        "devin"
         ))     

(defvar list_exclus*->_default 
    (list 
        "avec" ; chous * avec de la crème
        ;  "dix_dis"; dix à douze 
        "onze" ; un * onze !
        "orange" ; couleur
        "onzes"
        ;   "avril" ; un * avril
        ;  "aout" ; un * aout pluvieux 
        ;   "aout" ; un * aout
        ;   "octobre" ; 
        "onzième" ; 
        "onzièmes" ; deux * onzièmes
        "ou" ; il chantait * ou 
        "où" ;  ; cas où, bien où
        ;    "et" ; républicain * et /!\ mais d'ores et déjà
        ;     "en" ; lois * en vigueur mai nous * en
        ; "eux" ;  NON chez eux
        ; "un" ; quatre-vingt * un ?? mais dans un  
        ;; mot d'origine étrangère avec semi-voyelle
        "whiski" ; deux * whiski
        "ouie" 
        "oui"
        "ululement"
        "hasards"
        "hausse" ; en * hausse
        ;"hausses"
        "hasard" 
        "hunier" 
        "héros"
        "hibou"
        "houles"
        "hameçon"
               ))
(defvar list_exclus*-> list_exclus*->_default)
(define (is_exclus*-> mot)
  (member_string (french_downcase_string mot) list_exclus*->))

(defvar list_exclus->* list_exclus->*_default)
(define (is_exclus->* mot)
    (member_string (french_downcase_string mot) list_exclus->*)) 

; liaison non pausic nouveauté 2 paramètres
;(define (is_exception_PRO:ind->PRE_tab mot next_mot)
; règle elle-même conttournable par usage de locution ex "un à un" 

; ok même si les alist d'exceptions ne sont pas encore explicitées ...
; si elles ne sont pas appelées ...
; pour neuf ans et la demande de denat de neuf
; (defvar is_exception_ADJ:num->NOM (complement identity))
; ainsi d'ailleurs par erreur de POSLEX ?
; (defvar is_exception_NOM->NOM (complement identity))

; utiliser un unwind-protect

; définition dynamique des fonctions is_exception_POS1_POS2 mo
(define (is_exception pos_na_word pos_na_next_word na_word na_next_word)
    (if verbose_words_exceptions (format t "verbose_words_exceptions cherche exception: na_word: %s na_next_word: %s\n"  na_word na_next_word))  
    (if (and na_word na_next_word)
        (let (r rr functl)
          (set! r (string-append "is_exception_" pos_na_word "->" pos_na_next_word)) ; string  "is_exception_PRO:ind->PRE"
          (if  verbose_words_exceptions (format t "verbose_words_exceptions r %s\n" r))
      (if r 
          (begin 
             (set! rr (read-from-string r)); symbol is_exception_PRO:ind->PRE
             (if verbose_words_exceptions (format t "verbose_words_exceptions rr %s\n" rr))
             (if (boundp rr)
                 (begin 
                    (set! functl (symbol-value rr)); #<CLOSURE (word next_word) (if (member_string next_word (fre_abbr_lookup word is_exception_PRO:ind->PRE_tab)) t nil)>
                    (functl na_word na_next_word)
                    )
                 (begin 
                   (format t "verbose_words_exceptions rr:%s\n" rr)
                   ;(error)
                   )   
                    ))))))

; rajout de test tokenizer
; Ce qu'il est bête qu_il  PRO:per
(defvar exception_PRO:dem->PRO:per (complement identity))

(define (exception_PRO:dem->PRO:rel na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))
; quel que soit le registre de langue (de la langue soutenue à la langue
; vulgaire). La liaison est obligatoire :;  ** entre le déterminant et son nom,
; Déterminants définis
; Déterminants indéfinis
; Déterminants numéraux
; Déterminants possessifs

(defvar is_exception_NOM->VER (complement identity))

(define (is_exception_ART:ind->NOM na_word na_next_word)
  (if (or (is_exclus->* na_next_word)
          (and (string-equal (french_downcase_string na_word) "un")
               (or 
                (is_exclus*-> na_next_word)
                (member_string (french_downcase_string na_next_word) (list "avril" "août" "aout" "octobre"))))
               )
   nil
   t))

;(defvar is_exception_ADJ:pos->NOM (complement identity))
(define is_exception_ADJ:pos->NOM identity)


(define (is_exception_ADJ:dem->NOM na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))
; à [tout[ âge, |tout| intérêt        
(define (is_exception_ADJ:ind->NOM na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))

; used when making addenda
(defvar never_exception_list_default) 
;(set! never_exception_list_default (list "dans" "très" "Sans" "sans"))
; AVOIR(set! never_exception_list_default (list "versus" "avocat" "maintenant" "onze"))
(set! never_exception_list_default (list "z_y"))
(define never_exception_list never_exception_list_default) 



(define (is_exception_ADJ->NOM na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))

;(define (is_exception_ADJ->PRE na_word na_next_word);
;   ; cause favorable à
;   )


(define (is_exception_ADJ:num->NOM na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))

(define (is_exception_ADJ:num->PRE na_word na_next_word)
  (member_string na_word (list "un" "six_sixs" "neuf" "dix_dixs")))


(define (is_exception_ADJ:num->ADJ:num na_word na_next_word)
  ; on ne peut plus explicite
  (if (member_string na_next_word (list "un"))
       t
       nil))
; je pense |également| à la création
; |à jeun| aujourd'hui ;  (is_exception_ADV->PRE "à_jeun" "aujourd_hui") nil
(define (is_exception_ADV->PRE na_word na_next_word)
   (if (member_string na_word (list "à_jeun" "loin" "z_y" "également")); |loin| avec, |z_y| en courant:  probablement tous serait safe
       nil
       t))

(define (is_exception_ADV->PRO:per na_word na_next_word)
  ; ex tant elle neut_parl_s01_0147
   (if (member_string na_word never_exception_list)
       nil
       t))

(define (is_exception_ADV->VER na_word na_next_word)
   (if (member_string na_word never_exception_list)
       nil
       t))
(defvar is_exception_NAM->ADJ identity)
(defvar is_exception_NAM->ADJ:dem identity)
(defvar is_exception_NAM->ADJ:ind identity)
(defvar is_exception_NAM->ADJ:int identity)
(defvar is_exception_NAM->ADJ:num identity)
(defvar is_exception_NAM->ADJ:pos identity)
(defvar is_exception_NAM->ADV identity)
; TODO Les Alsaciens 
(defvar is_exception_NAM->ART:def identity)
(defvar is_exception_NAM->ART:ind identity)
(defvar is_exception_NAM->AUX (complement identity))
(defvar is_exception_NAM->CON identity)
(defvar is_exception_NAM->LIA identity)
(defvar is_exception_NAM->NAM (complement identity)); Benoît Hamon
(defvar is_exception_NAM->NOM identity)
(defvar is_exception_NAM->ONO identity)
(defvar is_exception_NAM->PRE identity)
(defvar is_exception_NAM->PRO:dem identity)
(defvar is_exception_NAM->PRO:ind identity)
(defvar is_exception_NAM->PRO:int identity)
(defvar is_exception_NAM->PRO:per identity)
(defvar is_exception_NAM->PRO:pos identity)
(defvar is_exception_NAM->PRO:rel identity)
(defvar is_exception_NAM->VER (complement identity))

(define (is_exception_NOM->ADJ na_word na_next_word)
  ; portes oranges sauf que ..portes est vu comme VER; abricots oranges sauf que oranges est vu comme NOM... TODO
   nil)

 
; évite au moins jeu de cartes z a
(define (is_exception_NOM->AUX na_word na_next_word)
  (if (or (member_string na_next_word (list "est" "a"))
          (not (is_prob_pluriel na_word))
          (is_exclus*-> na_next_word)
          (is_exclus->* na_word))
       nil
       t ))

(define (is_exception_NOM->AUX na_word na_next_word)
  (if (or (member_string na_next_word (list "est" "a"))
          (not (is_prob_pluriel na_word))
          (is_exclus*-> na_next_word)
          (is_exclus->* na_word)
          )
       nil
       t ))


(define (is_exception_PRO:dem->CON na_word na_next_word)
  ; Q never neut_parl_s01_0460 ceux et celles possible locution
       nil)

; liaisons dites optionnelles       
(defvar is_exception_PRO:ind->PRE_tab
  '( ; un à trois ans ; compter de un en un: to be safe
	 ; je n'ai rien à vous reprocher
    ("un" . ("à" "en") )
    ("rien" . ("à") )
   ))

(define (is_exception_PRO:ind->PRE na_word na_next_word)
  ; on ne peut plus explicite 
  (if (member_string na_next_word (fre_abbr_lookup na_word is_exception_PRO:ind->PRE_tab ))
       t
       nil))

(define (is_exception_PRO:ind->ADV na_word na_next_word)
  ; to be safe chacun y est
  (if (member_string (french_downcase_string na_word) (list "chacun"))) t)

(define (is_exception_PRO:ind->ART:def na_word na_next_word)
        (if (member_string na_word (list "chacun"))) nil)


; chacun_a un  ; il en a ; il s'en ait pris

(define (is_exception_PRO:ind->VER na_word na_next_word)
    (if (and 
            (member_string (french_downcase_string na_word) (list "en" "d_en" "m_en" "j_en" "s_en" "t_en"))
            (not (is_exclus*-> na_next_word))
            (not (is_exclus->* na_word))) t))
          

(set! is_exception_PRO:ind->AUX is_exception_PRO:ind->VER)

(define (is_exception_PRO:per->PRE na_word na_next_word)
        (if (member_string na_next_word (list "en"))
            t
            nil)) ; nous en  sommes; vous en doutez ?


; oubli ??? perte
(define (is_exception_PRO:pos->AUX na_word na_next_word)
        (if (member_string na_word (list "chacun"))) nil)

(define (is_exception_PRO:pos->VER na_word na_next_word)
        (if (member_string na_word (list "chacun"))) nil)

(define (is_exception_ADJ:int->ADJ na_word na_next_word)
        (if (member_string na_word (list "chacun"))) nil)

(define (is_exception_PRO:dem->ART:ind na_word na_next_word)
        (if (member_string na_word (list "chacun"))) nil)

(define (is_exception_ADJ:dem->ADJ na_word na_next_word)
        (if (member_string na_word (list "chacun"))) nil)

(define (is_exception_PRO:pos->VER na_word na_next_word)
        (if (member_string na_word (list "chacun"))) nil)

(define (is_exception_PRO:pos->VER na_word na_next_word)
        (if (member_string na_word (list "chacun"))) nil)


(define (is_exception_PRO:per->VER na_word na_next_word)
   (and (not (is_exclus->* na_next_word))
        (member_string (french_downcase_string na_word) (list "on" "l_on" "qu_on" "qu_ils" "qu_elles" "les" "en" "n_en" "j_en" "s_en" "t_en" "ils" "elles" "nous" "vous")))
    )
        
(define (is_exception_PRO:per->AUX na_word na_next_word)
   (and (not (is_exclus->* na_next_word))
        (member_string (french_downcase_string na_word) (list "on" "l_on" "qu_on" "qu_ils" "qu_elles" "les" "en" "n_en" "ils" "elles" "nous" "vous")))
    )

(define (is_exception_VER->NOM na_word na_next_word)
        (if (member_string na_word never_exception_list) nil  t))

; |profitez| en  on veut (is_exception_VER->PRE "profitez" "en" ) -> t car il arrive que en soit pris pour PRE "bien"
(define (is_exception_VER->PRE na_word na_next_word)
    (if (member_string na_word never_exception_list)
        nil
        t))


; livre |blanc| européen    nil        
(define (is_exception_ADJ->ADJ na_word na_next_word)
    (if (or (is_exclus*-> na_next_word) (is_exclus->* na_word))
            
	nil
	(begin
	(if (member_string (french_downcase_string na_word) (list "tout"))
	t))))
            
            
            
(define (is_exception_ADJ->ADJ:dem na_word na_next_word))

(define (is_exception_ADJ->ADJ:ind na_word na_next_word))

(define (is_exception_ADJ->ADJ:int na_word na_next_word))

(define (is_exception_ADJ->ADJ:num na_word na_next_word))

(define (is_exception_ADJ->ADJ:pos na_word na_next_word))

(define (is_exception_ADJ->ADV na_word na_next_word))

(define (is_exception_ADJ->ART:def na_word na_next_word))

(define (is_exception_ADJ->ART:ind na_word na_next_word))

(define (is_exception_ADJ->AUX na_word na_next_word))

(define (is_exception_ADJ->CON na_word na_next_word))

(define (is_exception_ADJ->NAM na_word na_next_word))

;(define (is_exception_ADJ->NOM na_word na_next_word));


(define (is_exception_ADJ->ONO na_word na_next_word))

(define (is_exception_ADJ->PRE na_word na_next_word))

(define (is_exception_ADJ->PRO:dem na_word na_next_word))

(define (is_exception_ADJ->PRO:ind na_word na_next_word))

(define (is_exception_ADJ->PRO:int na_word na_next_word))

(define (is_exception_ADJ->PRO:per na_word na_next_word))

(define (is_exception_ADJ->PRO:pos na_word na_next_word))

(define (is_exception_ADJ->PRO:rel na_word na_next_word))

(define (is_exception_ADJ->VER na_word na_next_word))

(define (is_exception_ADJ:dem->ADJ:int na_word na_next_word))

(define (is_exception_ADJ:dem->ADJ:num na_word na_next_word))

(define (is_exception_ADJ:dem->ADJ:pos na_word na_next_word))

(define (is_exception_ADJ:dem->ADV na_word na_next_word))

(define (is_exception_ADJ:dem->ART:def na_word na_next_word))

(define (is_exception_ADJ:dem->ART:ind na_word na_next_word))

(define (is_exception_ADJ:dem->AUX na_word na_next_word))

(define (is_exception_ADJ:dem->CON na_word na_next_word))

(define (is_exception_ADJ:dem->NAM na_word na_next_word))  

;(define (is_exception_ADJ:dem->NOM na_word na_next_word)
;        (complement identity))

(define (is_exception_ADJ:dem->ONO na_word na_next_word))

(define (is_exception_ADJ:dem->PRE na_word na_next_word))

(define (is_exception_ADJ:dem->PRO:dem na_word na_next_word))

(define (is_exception_ADJ:dem->PRO:ind na_word na_next_word))

(define (is_exception_ADJ:dem->PRO:int na_word na_next_word))

(define (is_exception_ADJ:dem->PRO:per na_word na_next_word))

(define (is_exception_ADJ:dem->PRO:pos na_word na_next_word))

(define (is_exception_ADJ:dem->PRO:rel na_word na_next_word))

(define (is_exception_ADJ:dem->VER na_word na_next_word))  

(define (is_exception_ADJ:ind->ADJ na_word na_next_word)
  (if (or (member_string na_next_word list_exclus*->)
          (member_string na_word list_exclus->*)
          )
     (begin nil)
     (begin 
         (if (member_string na_word (list "tout"))
            t
            nil))))

(define (is_exception_ADJ:ind->ADJ:ind na_word na_next_word))

(define (is_exception_ADJ:ind->ADJ:ind:dem na_word na_next_word))

(define (is_exception_ADJ:ind->ADJ:ind:ind na_word na_next_word))

(define (is_exception_ADJ:ind->ADJ:ind:int na_word na_next_word))

(define (is_exception_ADJ:ind->ADJ:ind:num na_word na_next_word))

(define (is_exception_ADJ:ind->ADJ:ind:pos na_word na_next_word))

(define (is_exception_ADJ:ind->ADV na_word na_next_word))

(define (is_exception_ADJ:ind->ART:def na_word na_next_word))

(define (is_exception_ADJ:ind->ART:ind na_word na_next_word))

(define (is_exception_ADJ:ind->AUX na_word na_next_word))

(define (is_exception_ADJ:ind->CON na_word na_next_word))

(define (is_exception_ADJ:ind->NAM na_word na_next_word))
;(define (is_exception_ADJ:ind->NOM na_word na_next_word)
;        (complement identity))

(define (is_exception_ADJ:ind->ONO na_word na_next_word))

(define (is_exception_ADJ:ind->PRE na_word na_next_word))

(define (is_exception_ADJ:ind->PRO:dem na_word na_next_word))

(define (is_exception_ADJ:ind->PRO:ind na_word na_next_word))

(define (is_exception_ADJ:ind->PRO:int na_word na_next_word))

(define (is_exception_ADJ:ind->PRO:per na_word na_next_word))

(define (is_exception_ADJ:ind->PRO:pos na_word na_next_word))

(define (is_exception_ADJ:ind->PRO:rel na_word na_next_word))

(define (is_exception_ADJ:ind->VER na_word na_next_word))

(define (is_exception_ADJ:int->ADJ:ind na_word na_next_word))

(define (is_exception_ADJ:int->ADJ:ind:dem na_word na_next_word))

(define (is_exception_ADJ:int->ADJ:ind:ind na_word na_next_word))

(define (is_exception_ADJ:int->ADJ:ind:int na_word na_next_word))

(define (is_exception_ADJ:int->ADJ:ind:num na_word na_next_word))

(define (is_exception_ADJ:int->ADJ:ind:pos na_word na_next_word))

(define (is_exception_ADJ:int->ADV na_word na_next_word))

(define (is_exception_ADJ:int->ART:def na_word na_next_word))

(define (is_exception_ADJ:int->ART:ind na_word na_next_word))

(define (is_exception_ADJ:int->AUX na_word na_next_word))

(define (is_exception_ADJ:int->CON na_word na_next_word))

(define (is_exception_ADJ:int->NAM na_word na_next_word))
;(define (is_exception_ADJ:int->NOM na_word na_next_word)
;        (complement identity))

(define (is_exception_ADJ:int->ONO na_word na_next_word))

(define (is_exception_ADJ:int->PRE na_word na_next_word))

(define (is_exception_ADJ:int->PRO:dem na_word na_next_word))

(define (is_exception_ADJ:int->PRO:ind na_word na_next_word))

(define (is_exception_ADJ:int->PRO:int na_word na_next_word))

(define (is_exception_ADJ:int->PRO:per na_word na_next_word))

(define (is_exception_ADJ:int->PRO:pos na_word na_next_word))

(define (is_exception_ADJ:int->PRO:rel na_word na_next_word))

(define (is_exception_ADJ:int->VER na_word na_next_word))

(define (is_exception_ADJ:num->ADJ na_word na_next_word)  
  (if (member_string na_word never_exception_list)
      nil
      (if (member_string (french_downcase_string na_next_word) (list "autres"))
          nil
       t)))

(define (is_exception_ADJ:num->ADJ:dem na_word na_next_word))

(define (is_exception_ADJ:num->ADJ:ind na_word na_next_word))

(define (is_exception_ADJ:num->ADJ:int na_word na_next_word))

;(define (is_exception_ADJ:num->ADJ:num na_word na_next_word)
;        (complement identity))

(define (is_exception_ADJ:num->ADJ:pos na_word na_next_word))

(define (is_exception_ADJ:num->ADV na_word na_next_word))

(define (is_exception_ADJ:num->ART:def na_word na_next_word))

(define (is_exception_ADJ:num->ART:ind na_word na_next_word))

(define (is_exception_ADJ:num->AUX na_word na_next_word))

(define (is_exception_ADJ:num->CON na_word na_next_word))

(define (is_exception_ADJ:num->NAM na_word na_next_word))

;(define (is_exception_ADJ:num->NOM na_word na_next_word)
;        (complement identity))

(define (is_exception_ADJ:num->ONO na_word na_next_word))

;(define (is_exception_ADJ:num->PRE na_word na_next_word)
;        (complement identity))

(define (is_exception_ADJ:num->PRO:dem na_word na_next_word))

(define (is_exception_ADJ:num->PRO:ind na_word na_next_word))

(define (is_exception_ADJ:num->PRO:int na_word na_next_word))

(define (is_exception_ADJ:num->PRO:per na_word na_next_word))

(define (is_exception_ADJ:num->PRO:pos na_word na_next_word))

(define (is_exception_ADJ:num->PRO:rel na_word na_next_word))

(define (is_exception_ADJ:num->VER na_word na_next_word))

;;;
(define (is_exception_ADJ:pos->ADJ na_word na_next_word))

(define (is_exception_ADJ:pos->ADJ:dem na_word na_next_word))

(define (is_exception_ADJ:pos->ADJ:ind na_word na_next_word))

(define (is_exception_ADJ:pos->ADJ:int na_word na_next_word))

(define (is_exception_ADJ:pos->ADJ:num na_word na_next_word))

(define (is_exception_ADJ:pos->ADJ:pos na_word na_next_word))

(define (is_exception_ADJ:pos->ADV na_word na_next_word))

(define (is_exception_ADJ:pos->ART:def na_word na_next_word))

(define (is_exception_ADJ:pos->ART:ind na_word na_next_word))

(define (is_exception_ADJ:pos->AUX na_word na_next_word))

(define (is_exception_ADJ:pos->CON na_word na_next_word))

(define (is_exception_ADJ:pos->NAM na_word na_next_word))

;(define (is_exception_ADJ:pos->NOM na_word na_next_word)
;        (complement identity))

(define (is_exception_ADJ:pos->ONO na_word na_next_word))

(define (is_exception_ADJ:pos->PRE na_word na_next_word))

(define (is_exception_ADJ:pos->PRO:dem na_word na_next_word))

(define (is_exception_ADJ:pos->PRO:ind na_word na_next_word))

(define (is_exception_ADJ:pos->PRO:int na_word na_next_word))

(define (is_exception_ADJ:pos->PRO:per na_word na_next_word))

(define (is_exception_ADJ:pos->PRO:pos na_word na_next_word))

(define (is_exception_ADJ:pos->PRO:rel na_word na_next_word))

(define (is_exception_ADJ:pos->VER na_word na_next_word))
;;

(define (is_exception_ADV->ADJ na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))

(define (is_exception_ADV->ADJ:dem na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))

(define (is_exception_ADV->ADJ:ind na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))

(define (is_exception_ADV->ADJ:int na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))

(define (is_exception_ADV->ADJ:num na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))

(define (is_exception_ADV->ADJ:pos na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))
; |également|  à jeun ; à jeun locution ADV; (is_exception_ADV->PRE "également" "à_jeun")    nil
; |très| amicalement ; (is_exception_ADV->ADV "très" "amicalement") t
(define (is_exception_ADV->ADV na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word)
            (member_string na_next_word (list "à_jeun")))
        nil
        t))


; bien au contraire; bien au lit, bien au milieu; (is_exception_ADV->ART:def "bien" "au")  t
; maintenant au fond ; (is_exception_ADV->ART:def "maintenant" "au") nil
(define (is_exception_ADV->ART:def na_word na_next_word) 
    (if (or (is_exclus*-> na_next_word) (is_exclus->* na_word))
            
	nil
	(begin
	(if (member_string (french_downcase_string na_word) (list "bien"))
	t))))

	
	
	
	
(define (is_exception_ADV->ART:ind na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))

(define (is_exception_ADV->AUX na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))

(define (is_exception_ADV->CON na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))

(define (is_exception_ADV->NAM na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))

(define (is_exception_ADV->NOM na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))

(define (is_exception_ADV->ONO na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))

;(define (is_exception_ADV->PRE na_word na_next_word)
;        (complement identity))

(define (is_exception_ADV->PRO:dem na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))

(define (is_exception_ADV->PRO:ind na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))

(define (is_exception_ADV->PRO:int na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))

;(define (is_exception_ADV->PRO:per na_word na_next_word)
;        (complement identity))

(define (is_exception_ADV->PRO:pos na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))

(define (is_exception_ADV->PRO:rel na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))

;(define (is_exception_ADV->VER na_word na_next_word)
;        (complement identity))

; "états_unis" "allemagne" "alsaciens" "alpes" "antilles" ...
(define (is_exception_ART:def->NAM na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t)) 

(define (is_exception_ART:def->ADJ:dem na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))

(define (is_exception_ART:def->ADJ:ind na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))

(define (is_exception_ART:def->ADJ:int na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))

(define (is_exception_ART:def->ADJ:num na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))

(define (is_exception_ART:def->ADJ:pos na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))

(define (is_exception_ART:def->ADV na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))

(define (is_exception_ART:def->ART:def na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))

(define (is_exception_ART:def->ART:ind na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))

(define (is_exception_ART:def->AUX na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))

(define (is_exception_ART:def->CON na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))

(define (is_exception_ART:def->ADJ na_word na_next_word)
    (if (member_string (french_downcase_string na_next_word) (list "autres"))
          t
          nil))

(define (is_exception_ART:def->NOM na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))

(define (is_exception_ART:def->ONO na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))

(define (is_exception_ART:def->PRE na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))

(define (is_exception_ART:def->PRO:dem na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))

(define (is_exception_ART:def->PRO:ind na_word na_next_word)
    (if (member_string (french_downcase_string na_next_word) (list "uns" "unes" "autres"))
          t
          nil))

(define (is_exception_ART:def->PRO:int na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))

(define (is_exception_ART:def->PRO:per na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))

(define (is_exception_ART:def->PRO:pos na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))

(define (is_exception_ART:def->PRO:rel na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))

(define (is_exception_ART:def->VER na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))
;;

(define (is_exception_ART:ind->ADJ na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))

(define (is_exception_ART:ind->ADJ:dem na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))

(define (is_exception_ART:ind->ADJ:ind na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))

(define (is_exception_ART:ind->ADJ:int na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))

(define (is_exception_ART:ind->ADJ:num na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))

(define (is_exception_ART:ind->ADJ:pos na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))

(define (is_exception_ART:ind->ADV na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))

(define (is_exception_ART:ind->ART:def na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))

(define (is_exception_ART:ind->ART:ind na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))

(define (is_exception_ART:ind->AUX na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))

(define (is_exception_ART:ind->CON na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))

(define (is_exception_ART:ind->NAM na_word na_next_word) 
        (complement identity))

;(define (is_exception_ART:ind->NOM na_word na_next_word)
;        (complement identity))

(define (is_exception_ART:ind->ONO na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))
(define (is_exception_ART:ind->PRE na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))
(define (is_exception_ART:ind->PRO:dem na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))
(define (is_exception_ART:ind->PRO:ind na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))
(define (is_exception_ART:ind->PRO:int na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))
(define (is_exception_ART:ind->PRO:per na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))
(define (is_exception_ART:ind->PRO:pos na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))
(define (is_exception_ART:ind->PRO:rel na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))
(define (is_exception_ART:ind->VER na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))
(define (is_exception_AUX->ADJ na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))
(define (is_exception_AUX->ADV na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))
(define (is_exception_AUX->AUX na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t)) 

;: chgt vérifier les addendas !
; ; entre les auxiliaires avoir et être et le participe passé 
; plus large !  à tester !
; nous les avons avertis : ok
; pas ok : elles sont armées armées vu comme ADJ
; pas ok elles sont arrivées sont vu comme VER arrivées ok .. 'essai (defvar is_exception_VER->VER plus périlleux ?
; voir résolution par token 

; je suis arrivée
(define (is_exception_AUX->VER na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))
;;
(define (is_exception_CON->ADJ na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))
(define (is_exception_CON->ADJ:dem na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))
(define (is_exception_CON->ADJ:ind na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))
(define (is_exception_CON->ADJ:int na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))
(define (is_exception_CON->ADJ:num na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))
(define (is_exception_CON->ADJ:pos na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))
(define (is_exception_CON->ADV na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))

(define (is_exception_CON->ART:def na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))


(define (is_exception_CON->ART:ind na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))
(define (is_exception_CON->AUX na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))
(define (is_exception_CON->CON na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))
(define (is_exception_CON->NAM na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))
(define (is_exception_CON->NOM na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))
(define (is_exception_CON->ONO na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))
(define (is_exception_CON->PRE na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))
(define (is_exception_CON->PRO:dem na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))
(define (is_exception_CON->PRO:ind na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))
(define (is_exception_CON->PRO:int na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))
(define (is_exception_CON->PRO:per na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))
(define (is_exception_CON->PRO:pos na_word na_next_word)
    (if (or (is_exclus*-> na_next_word)
            (is_exclus->* na_word))
        nil
        t))
(define (is_exception_CON->PRO:rel na_word na_next_word))
(define (is_exception_CON->VER na_word na_next_word))


(define (is_exception_NOM->ADJ:ind na_word na_next_word))
(define (is_exception_NOM->ADJ:int na_word na_next_word))
(define (is_exception_NOM->ADJ:num na_word na_next_word))
(define (is_exception_NOM->ADJ:pos na_word na_next_word))
(define (is_exception_NOM->ADV na_word na_next_word))

; liaison dites optionnelle pour "bien au contraire" quand bien est vu comme NOM
(define (is_exception_NOM->ART:def na_word na_next_word)
    (if (or (is_exclus*-> na_next_word) (is_exclus->* na_word))
            
	nil
	(begin
	(if (not (member_string (french_downcase_string na_next_word) (list "bien")) )
	t))))

(define (is_exception_NOM->ART:ind na_word na_next_word))
;(define (is_exception_NOM->AUX na_word na_next_word)
;        (complement identity))

; |melon| et chapeau rond
(define (is_exception_NOM->CON na_word na_next_word)
    (if (or (is_exclus*-> na_next_word) (is_exclus->* na_word))
        nil
    (begin
        (if (not (member_string (french_downcase_string na_next_word) (list "XXX")) )
            t)
            nil)))
; Néron et moi-même on veut (is_exception_NAM->CON "néron" "moi_même") à nil
(define (is_exception_NAM->CON na_word na_next_word)
    (if (or (is_exclus*-> na_next_word) (is_exclus->* na_word))
        nil
    (begin
        (if (not (member_string (french_downcase_string na_next_word) (list "XXX")) )
            t)
            nil)))


(define (is_exception_NOM->NAM na_word na_next_word))

;(define (is_exception_NOM->NOM na_word na_next_word)
;        (complement identity))

;(define (is_exception_NOM->NOM na_word na_next_word) nil)

(defvar is_exception_NOM->NOM (complement identity))


(define (is_exception_NOM->ONO na_word na_next_word)
        nil)

; font partie des liaisons dite optionnelles
; |bien| à vous ; tant que  |bien| est vu comme  NOM ; (is_exception_NOM->PRE "bien" "à") t
; la |raison| en est : (is_exception_NOM->PRE "raison" "en") t
(define (is_exception_NOM->PRE na_word na_next_word)
    (if (or (is_exclus*-> na_next_word) (is_exclus->* na_word))
        nil
	(begin
		(if (not (member_string (french_downcase_string na_next_word) (list "bien")) )
			t)
			nil)))


(define (is_exception_NOM->PRO:dem na_word na_next_word))
(define (is_exception_NOM->PRO:ind na_word na_next_word))
(define (is_exception_NOM->PRO:int na_word na_next_word))
(define (is_exception_NOM->PRO:per na_word na_next_word))
(define (is_exception_NOM->PRO:pos na_word na_next_word))
(define (is_exception_NOM->PRO:rel na_word na_next_word))
;(define (is_exception_NOM->VER na_word na_next_word)
;        (complement identity))

;;;
(define (is_exception_ONO->CON na_word na_next_word))
(define (is_exception_ONO->ONO na_word na_next_word))
(define (is_exception_ONO->ADV na_word na_next_word))
(define (is_exception_ONO->PRO:per na_word na_next_word))

(define (is_exception_PRE->ADJ na_word na_next_word))
(define (is_exception_PRE->ADJ:dem na_word na_next_word))
(define (is_exception_PRE->ADJ:ind na_word na_next_word)
  (if (or (member_string na_next_word list_exclus*->)
          (member_string na_word list_exclus->*)
          )
     (begin nil)
     (begin 
         (if (member_string na_word (list "dans"))
            nil
            t))))
(define (is_exception_PRE->ADJ:int na_word na_next_word))
(define (is_exception_PRE->ADJ:num na_word na_next_word))
(define (is_exception_PRE->ADJ:pos na_word na_next_word))
(define (is_exception_PRE->ADV na_word na_next_word))
(define (is_exception_PRE->ART:def na_word na_next_word))
(define (is_exception_PRE->ART:ind na_word na_next_word)
  (if (or (member_string na_next_word list_exclus*->)
          (member_string na_word list_exclus->*)
          )
     (begin nil)
     (begin 
          
         (if (member_string na_word (list "dans" "Dans")))
            t)
            nil))



(define (is_exception_PRE->AUX na_word na_next_word)
  (if (or (member_string na_next_word list_exclus*->)
          (member_string na_word list_exclus->*)
          )
     (begin nil)
     (begin 
          ; il y |en| a
         (if (member_string na_word (list "en")))
            t)
            nil))



(define (is_exception_PRE->CON na_word na_next_word))

(define (is_exception_PRE->NOM na_word na_next_word)
  (if (or (member_string na_next_word list_exclus*->)
          (member_string na_word list_exclus->*)
          )
     (begin nil)
     (begin 
          ; en avance, en Albanie
         (if (member_string na_word (list "sans" "Sans" "aux" "Aux" "en" "En" "chez" "Chez" "quant_aux" "Quant_aux")))
            t)
            nil))
(define (is_exception_PRE->NAM na_word na_next_word)
  (if (or (member_string na_word never_exception_list)
          ; en avance
          (member_string na_word (list "sans" "Sans" "aux" "Aux" "en" "En" "chez" "Chez" "quant_aux" "Quant_aux")))
      nil  t))

(define (is_exception_PRE->ONO na_word na_next_word))

(define (is_exception_PRE->PRE na_word na_next_word))

(define (is_exception_PRE->PRO:dem na_word na_next_word))

(define (is_exception_PRE->PRO:ind na_word na_next_word) 
    (if (member_string na_word never_exception_list)
        nil
        t))

(define (is_exception_PRE->PRO:int na_word na_next_word))

(define (is_exception_PRE->PRO:per na_word na_next_word)
      (if (or (member_string na_word never_exception_list)
          ; en avance
          (member_string na_word (list "en" "En" "chez" "Chez")))
      nil  t)) 
(define (is_exception_PRE->PRO:pos na_word na_next_word))
(define (is_exception_PRE->PRO:rel na_word na_next_word))

(define (is_exception_PRE->VER na_word na_next_word)
  (if (or (member_string na_next_word list_exclus*->)
          (member_string na_word list_exclus->*)
          )
     (begin nil)
     (begin 
          ; il y |en| a;  |en| avez-vous ?
         (if (member_string na_word (list "en")))
            t)
            nil))
;;;
(define (is_exception_PRO:dem->ADV na_word na_next_word))

(define (is_exception_PRO:dem->AUX na_word na_next_word))
;(define (is_exception_PRO:dem->CON na_word na_next_word)
;        (complement identity))

(define (is_exception_PRO:dem->PRE na_word na_next_word))

(define (is_exception_PRO:dem->VER na_word na_next_word))






(define (is_exception_PRO:ind->ADJ na_word na_next_word))
(define (is_exception_PRO:ind->ADJ:dem na_word na_next_word))
(define (is_exception_PRO:ind->ADJ:ind na_word na_next_word))
(define (is_exception_PRO:ind->ADJ:int na_word na_next_word))
(define (is_exception_PRO:ind->ADJ:num na_word na_next_word))
(define (is_exception_PRO:ind->ADJ:pos na_word na_next_word))
;(define (is_exception_PRO:ind->ADV na_word na_next_word)
;        (complement identity))
;(define (is_exception_PRO:ind->ART:def na_word na_next_word)
;        (complement identity))
(define (is_exception_PRO:ind->ART:ind na_word na_next_word))
;(define (is_exception_PRO:ind->AUX na_word na_next_word)
;        (complement identity))
(define (is_exception_PRO:ind->CON na_word na_next_word)  
      (if (member_string na_word never_exception_list)
        nil
        (if (member_string (french_downcase_string na_word) (list "et"))
            nil
          t)))   ; un et demi
(define (is_exception_PRO:ind->NAM na_word na_next_word))
(define (is_exception_PRO:ind->NOM na_word na_next_word))
(define (is_exception_PRO:ind->ONO na_word na_next_word))
;(define (is_exception_PRO:ind->PRE na_word na_next_word)
;        (complement identity))
(define (is_exception_PRO:ind->PRO:dem na_word na_next_word))
(define (is_exception_PRO:ind->PRO:ind na_word na_next_word))
(define (is_exception_PRO:ind->PRO:int na_word na_next_word))
(define (is_exception_PRO:ind->PRO:per na_word na_next_word))
(define (is_exception_PRO:ind->PRO:pos na_word na_next_word))
(define (is_exception_PRO:ind->PRO:rel na_word na_next_word))
;(define (is_exception_PRO:ind->VER na_word na_next_word)
;        (complement identity))


(define (is_exception_PRO:int->ADJ na_word na_next_word)(if (member_string na_word never_exception_list)  nil  t))
(define (is_exception_PRO:int->ADJ:dem na_word na_next_word))
(define (is_exception_PRO:int->ADJ:ind na_word na_next_word))
(define (is_exception_PRO:int->ADJ:int na_word na_next_word))
(define (is_exception_PRO:int->ADJ:num na_word na_next_word))
(define (is_exception_PRO:int->ADJ:pos na_word na_next_word))
(define (is_exception_PRO:int->ADV na_word na_next_word))
(define (is_exception_PRO:int->ART:def na_word na_next_word))
(define (is_exception_PRO:int->ART:ind na_word na_next_word))
(define (is_exception_PRO:int->AUX na_word na_next_word))
(define (is_exception_PRO:int->CON na_word na_next_word))
(define (is_exception_PRO:int->NAM na_word na_next_word))
(define (is_exception_PRO:int->NOM na_word na_next_word) 
      (if (member_string na_word never_exception_list)
        nil
        (if (member_string (french_downcase_string na_word) (list "quels" "quelles"))
            nil
          t)))   ; Q ?
(define (is_exception_PRO:int->ONO na_word na_next_word))
(define (is_exception_PRO:int->PRE na_word na_next_word))
(define (is_exception_PRO:int->PRO:dem na_word na_next_word))
(define (is_exception_PRO:int->PRO:ind na_word na_next_word))
(define (is_exception_PRO:int->PRO:int na_word na_next_word))
(define (is_exception_PRO:int->PRO:per na_word na_next_word))
(define (is_exception_PRO:int->PRO:pos na_word na_next_word))
(define (is_exception_PRO:int->PRO:rel na_word na_next_word))
(define (is_exception_PRO:int->VER na_word na_next_word))

;;;
(define (is_exception_PRO:per->ADJ na_word na_next_word))
(define (is_exception_PRO:per->ADJ:dem na_word na_next_word))
(define (is_exception_PRO:per->ADJ:ind na_word na_next_word))
(define (is_exception_PRO:per->ADJ:int na_word na_next_word))
(define (is_exception_PRO:per->ADJ:num na_word na_next_word))
(define (is_exception_PRO:per->ADJ:pos na_word na_next_word))  

; nous y venons, nous y sommes
(define (is_exception_PRO:per->ADV na_word na_next_word)  
      (if (member_string na_word never_exception_list)
        nil
        (if (member_string na_next_word (list "y"))
            t
            nil))) ; vous y croyez ?  
  
  
(define (is_exception_PRO:per->ART:def na_word na_next_word))
(define (is_exception_PRO:per->ART:ind na_word na_next_word))
;(define (is_exception_PRO:per->AUX na_word na_next_word)
;        (complement identity))
(define (is_exception_PRO:per->CON na_word na_next_word))
(define (is_exception_PRO:per->NAM na_word na_next_word))
(define (is_exception_PRO:per->NOM na_word na_next_word))
(define (is_exception_PRO:per->ONO na_word na_next_word))
;(define (is_exception_PRO:per->PRE na_word na_next_word)
;        (complement identity))
(define (is_exception_PRO:per->PRO:dem na_word na_next_word))
(define (is_exception_PRO:per->PRO:ind na_word na_next_word))
(define (is_exception_PRO:per->PRO:int na_word na_next_word))
(define (is_exception_PRO:per->PRO:per na_word na_next_word)
      (if (member_string na_word never_exception_list)
        nil
        (if (member_string na_next_word (list "y"))
            t
            nil))) ; vous y croyez ?
(define (is_exception_PRO:per->PRO:pos na_word na_next_word))
(define (is_exception_PRO:per->PRO:rel na_word na_next_word))
;(define (is_exception_PRO:per->VER na_word na_next_word)
;        (complement identity))


(define (is_exception_PRO:rel->ADJ na_word na_next_word))
(define (is_exception_PRO:rel->ADJ:dem na_word na_next_word))
(define (is_exception_PRO:rel->ADJ:ind na_word na_next_word))
(define (is_exception_PRO:rel->ADJ:int na_word na_next_word))
(define (is_exception_PRO:rel->ADJ:num na_word na_next_word))
(define (is_exception_PRO:rel->ADJ:pos na_word na_next_word))
(define (is_exception_PRO:rel->ADV na_word na_next_word))
(define (is_exception_PRO:rel->ART:def na_word na_next_word))
(define (is_exception_PRO:rel->ART:ind na_word na_next_word))
(define (is_exception_PRO:rel->AUX na_word na_next_word))
(define (is_exception_PRO:rel->CON na_word na_next_word))
(define (is_exception_PRO:rel->NAM na_word na_next_word))
(define (is_exception_PRO:rel->NOM na_word na_next_word))
(define (is_exception_PRO:rel->ONO na_word na_next_word))
(define (is_exception_PRO:rel->PRE na_word na_next_word))
(define (is_exception_PRO:rel->PRO:dem na_word na_next_word))
(define (is_exception_PRO:rel->PRO:ind na_word na_next_word))
(define (is_exception_PRO:rel->PRO:int na_word na_next_word))
(define (is_exception_PRO:rel->PRO:per na_word na_next_word))
(define (is_exception_PRO:rel->PRO:pos na_word na_next_word))
(define (is_exception_PRO:rel->PRO:rel na_word na_next_word))
(define (is_exception_PRO:rel->VER na_word na_next_word))


;;;
(define (is_exception_VER->ADJ na_word na_next_word))
(define (is_exception_VER->ADJ:dem na_word na_next_word))
(define (is_exception_VER->ADJ:ind na_word na_next_word))
(define (is_exception_VER->ADJ:int na_word na_next_word))
(define (is_exception_VER->ADJ:num na_word na_next_word))
(define (is_exception_VER->ADJ:pos na_word na_next_word))
(define (is_exception_VER->ADV na_word na_next_word)  
  (if (member_string na_word never_exception_list)  nil  t))

(set! toujours_exception_list (list "maintenant" "jeun"))

(define (is_exception_VER->ART:def na_word na_next_word)
        (if(member_string na_word toujours_exception_list)  nil  t))

; c'est un peu fort ! 
(define (is_exception_VER->ART:ind na_word na_next_word)
      (if (member_string na_word never_exception_list)
        nil
        (if (member_string na_next_word (list "un"))
            t
            nil))) 

; c'est un peu fort !    même si  c_est est vu comme AUX          
(define (is_exception_AUX->ART:ind na_word na_next_word)
      (if (member_string na_word never_exception_list)
        nil
        (if (member_string na_next_word (list "un"))
            t
            nil)))             
            
(define (is_exception_VER->AUX na_word na_next_word))
(define (is_exception_VER->CON na_word na_next_word))
(define (is_exception_VER->NAM na_word na_next_word))
(define (is_exception_VER->NOM na_word na_next_word))
(define (is_exception_VER->ONO na_word na_next_word))

(define (is_exception_VER->PRO:dem na_word na_next_word))
(define (is_exception_VER->PRO:ind na_word na_next_word))
(define (is_exception_VER->PRO:int na_word na_next_word))
(define (is_exception_VER->PRO:per na_word na_next_word)
      (if (member_string na_word never_exception_list)
        nil
        ; ex (if (member_string (french_downcase_string na_word) (list "est" "ont" "devrait" "devraient" "devront")); normalement on doit mettre un tiret
        t)) 
(define (is_exception_VER->PRO:pos na_word na_next_word))
(define (is_exception_VER->PRO:rel na_word na_next_word))
(define (is_exception_VER->VER na_word na_next_word))


(define (is_exception_SENT->ADJ na_word na_next_word))
(define (is_exception_SENT->ADJ:dem na_word na_next_word))
(define (is_exception_SENT->ADJ:ind na_word na_next_word))
(define (is_exception_SENT->ADJ:int na_word na_next_word))
(define (is_exception_SENT->ADJ:num na_word na_next_word))
(define (is_exception_SENT->ADJ:pos na_word na_next_word))
(define (is_exception_SENT->ADV na_word na_next_word))
(define (is_exception_SENT->ART:def na_word na_next_word))
(define (is_exception_SENT->ART:ind na_word na_next_word))
(define (is_exception_SENT->AUX na_word na_next_word))
(define (is_exception_SENT->CON na_word na_next_word))
(define (is_exception_SENT->NAM na_word na_next_word))
(define (is_exception_SENT->NOM na_word na_next_word))
(define (is_exception_SENT->ONO na_word na_next_word))
(define (is_exception_SENT->PRE na_word na_next_word))
(define (is_exception_SENT->PRO:dem na_word na_next_word))
(define (is_exception_SENT->PRO:ind na_word na_next_word))
(define (is_exception_SENT->PRO:int na_word na_next_word))
(define (is_exception_SENT->PRO:per na_word na_next_word))
(define (is_exception_SENT->PRO:pos na_word na_next_word))
(define (is_exception_SENT->PRO:rel na_word na_next_word))
(define (is_exception_SENT->VER na_word na_next_word))
(define (is_exception_SENT->SENT na_word na_next_word)); incidemment rencontré avec 20,56 kg

; étrange
; TODO XXXX à éliminer
(define (is_exception_ADJ->SENT na_word na_next_word))
(define (is_exception_ADJ:dem->SENT na_word na_next_word))
(define (is_exception_ADJ:ind->SENT na_word na_next_word))
(define (is_exception_ADJ:int->SENT na_word na_next_word))
(define (is_exception_ADJ:num->SENT na_word na_next_word))
(define (is_exception_ADJ:pos->SENT na_word na_next_word))
(define (is_exception_ADV->SENT na_word na_next_word))
(define (is_exception_ART:def->SENT na_word na_next_word))
(define (is_exception_ART:ind->SENT na_word na_next_word))
(define (is_exception_AUX->SENT na_word na_next_word))
(define (is_exception_CON->SENT na_word na_next_word))
(define (is_exception_NAM->SENT na_word na_next_word))
(define (is_exception_NOM->SENT na_word na_next_word))
(define (is_exception_ONO->SENT na_word na_next_word))
(define (is_exception_ONO->ADJ na_word na_next_word))
(define (is_exception_PRE->SENT na_word na_next_word))
(define (is_exception_PRO:dem->SENT na_word na_next_word))
(define (is_exception_PRO:ind->SENT na_word na_next_word))
(define (is_exception_PRO:int->SENT na_word na_next_word))
(define (is_exception_PRO:per->SENT na_word na_next_word))
(define (is_exception_PRO:pos->SENT na_word na_next_word))
(define (is_exception_PRO:rel->SENT na_word na_next_word))
(define (is_exception_VER->SENT na_word na_next_word))
(provide 'INST_LANG_words_exceptions)
