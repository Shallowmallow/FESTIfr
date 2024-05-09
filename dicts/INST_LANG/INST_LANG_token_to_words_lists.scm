;/*************************************************************************/
;/*       influencé par :  Mark Breitenbuecher                            */
;/*-----------------------------------------------------------------------*/
;/*                                                                       */
;/* This file contains all tables, lists and trees used in the            */
;/* token-to-words rules                                                  */
;/*  à ajuster dans la voix    !  d'où les defvar                         */
;/*                                                                       */
;/*=======================================================================*/

; TODO comment est résolu les liaisons du type syndicats_ t muet liaison sur s ??
; TODO pour chaque liste construire is_..
; et migrer ver INST_LANG_token_to_words_tools data/lists versus function/tool
(require 'INST_LANG_utils);; french_downcase_string notamment
(require 'INST_LANG_words_exceptions)

;; ABOUT

;; currency
;; number words and words followed by a number ;; à réintégrer TODO
;; calendar : month day
;; characters other than letters : symbols, digits 
;; letters
;; abréviation, sigle, unité, dimension

;; VER
;; NAM
;; ONO, interjerction

;; composition : prefixe, apostrophe, terminaison s/x
;; locution
;; titres
;; phrase 


; _cent _yen _pound mis pour les symboles utf-8 complexes
; à renseigner dans le dico !

; TODO singulier pluriel pour les symboles ¥ , ¢, PTA etc.
; TODO disamb  "cent"  "cents"

; moyennant  "€" "¥" "£" "¢" -> Euro _yen pound _cent dans norm de token et ajout dans addenda
; cause de utf8
; TODO check norms
  ; l'ajout de "_" interdit les liaisons ! ????????????
(set! fre_abbr_currency_tab_default
  '(("EUR"  . ("Euro")                       )
    ("EURO" . ("Euro")                       )
    ;("€" . ("Euro")                          ); resolu dans norm
    ("DM"   . ("deutsche" "Mark")            )
    ;;     ("ÖS"   . ("österreichische" "Schilling"))bug regex currencies
    ("sfr"  . ("Franc" "suisse")             )
    ("FF"   . ("Franc" "français" "_")       )
    ("bfr"  . ( "Franc" "belge")             )
    ("Y"    . ("Yen")                        )
    ; ("¥"   . ("Yen")                       ); resolu dans norm
    ("_yen"   . ("Yen")                      )
    ("US$"  . ("Dollar" "américain" "_")     )
    ("$"    . ("Dollar")                     )
    ("EUR"  . ("Euro")                       )
    ("E"    . ("Euro")                       )
    ;("Dk"   . ("Dukaten")                    )
    ;("TL"   . ("Taler")                      )
    ("can$" . ("Dollar" "canadien" "_")      )
    ("kan$" . ("Dollar" "canadien" "_")      )
    ("Kan$" . ("Dollar" "canadien" "_")      )
    ("Can$" . ("Dollar" "canadien" "_")      )
    ("dkr"  . ("couronne" "danoise")         )
    ("_pound"    . ("Livre")                 ); L pour espérer féminin
    ("L"    . ("Lire")                       ); à distinguerde L ART:def et de L choiffre romain
    ("ptas" . ("Pesetas")                    )
    ("pta" . ("Peseta")                      )
    ("PTA" . ("Peseta")                      )
    ;("cent" . ("cèn" "_")                   )
    ;("cents" . ("cèns" "_")                 )
    ("sen" . ("sèn")                         )
  ;  ("sens" . ("sèns" "_")                   ) ; NON
    ("esc"  . ("Escudos" "_")                )))

(defvar fre_abbr_currency_tab fre_abbr_currency_tab_default
 "fre_abbr_currency_tab
   Is an assoc list that associates currency like $ with the full form
   (Dollar).")


(set! tok_section_name_cardinal_default
  (list 
      "section"
      "article"
      "acte"
      "livre"
      "verset"
      "volume"
      "chapitre"
      "scène"
      "an"))

(defvar tok_section_name_cardinal tok_section_name_cardinal_default)

;; ********************
;; calendar : month day

(set! fre_abbr_months_tab_default
  '(("Jan"   . ("janvier"))
    ("Fev"   . ("février"))
    ("Fév"   . ("février"))    
    ("Mar"   . ("mars"))
    ("Avr"   . ("avril"))
    ("Mai"   . ("mai"))
    ("Juin"  . ("juin"))
    ("Juil"  . ("juillet"))
    ("Août"  . ("août"))
    ("Sep"   . ("septembre"))
    ("Oct"   . ("octobre"))
    ("Nov"   . ("novembre"))
    ("Dec"   . ("décembre"))
    ("Déc"   . ("décembre"))))

(defvar fre_abbr_months_tab fre_abbr_months_tab_default
  "fre_abbr_months_tab
   Is an assoc list that associates abbreviations of french
   month-names with the full form.
   use: (fre_abbr_lookup \"Jan\" fre_abbr_months_tab)")


(set! fre_abbr_days_tab_default
  '(
    ("Lu"  . ("lundi"))
    ("Ma"  . ("mardi"))
    ("Me"  . ("mercredi"))
    ("Je"  . ("jeudi"))
    ("Ven" . ("vendredi"))
    ("Sa"  . ("samedi"))
    ("Dim" . ("dimanche"))))

(defvar fre_abbr_days_tab fre_abbr_days_tab_default
  "fre_abbr_days_tab
   is an assoc list that associates abbreviations of french weekday-names
   with the full form.
   try: (fre_abbr_lookup \"So\" fre_abbr_days_tab)")

(set! french_year_indicator_default
  '(Depuis depuis années année En en après Après Noël 
     Premier premier automne hiver été printemps
     Printemps à Pour fin Fin jusqu début printemps an))

(defvar french_year_indicator french_year_indicator_default
  "french_year_indicator
   A list of french words that often stand before years.")

; (defvar german_satzanfang nil
(defvar french_sos nil
  "List of words that imply beginning of french sentences.")

(set! french_sos_default
  '("À" "Ce" "Que" "Qui" "Pourquoi" "Où" "Parce" "Comment" "C'est" "C'était"
    "C'étaient" "Je" "J" "Tu" "Vous" "Nous" "Il" "Ils" "Un" "Une" "De" "Du" "Des" "Certain" "Certaine" "Certaines"
    "Certains" "Elles" "Elle" "Où"
    "Donc" "Ô" "En" "On" "Hein" "Ainsi" "L" "Le" "Les" "Personne" "S" "Si" "Or" "Dans" "Qu" "Quand" "Quant"
    "Quelque" "Quelques" "Oh" "Ah"))

(defvar french_sos french_sos_default
  "List of words that imply beginning of french sentences.")



;; ********************
;; characters other than letters 
;; /!\ pb de recoupement, redondance, mise en oeuvre !
;;  intérrêt lever des ambiguités, lecture avec ponctuation (voir mode ? TODO)
(set! fre_symbols_tab_default
  '(
    (" "  . ("espace"))
    ("."  . ("point"))
    (","  . ("virgule"))
    (":"  . ("deux" "points"))
    (";"  . ("point" "virgule"))
    (">"  . ("supérieur" "à"))
    ("<"  . ("inférieur" "à"))
    ("/"  . ("barre" "oblique"))
    ("?"  . ("point" "d'interrogation"))
    ("-"  . ("tiret")) ; homo .... /§\
         ;  ("_"  . ("tiret")) NON special character
    ("="  . ("est" "égal" "à"))
    ("$"  . ("dollar"))
    ("¢" . ("cents")); 
    ("%"  . ("pourcent"))
    ("§"  . ("paragraphe"))
    ("#"  . ("dièse"))
    ("+"  . ("plus_ﬂ_plu"))
    ("*"  . ("astérique"))
    ("~"  . ("tilde"))
    ("^"  . ("Dach"))
    ("@"  . ("arobase"))
    ("&"  . ("et" "commercial"))
    ("|"  . ("barre" "verticale"))
    ("\\" . ("backslash"))
    ("\"" . ("guillemet")) ;"
    ("«"  . ("ouvrer les guillemets")) ; ouvert 
    ("»"  . ("fermer les guillemets"))
    ("{"  . ("accolade" "ouvrante"))
    ("}"  . ("accolade" "fermante"))
    ("]"  . ("crochet" "fermant"))
    ("["  . ("crochet" "ouvrant"))
    (")"  . ("parenthèse" "fermante"))
    ("("  . ("parenthèse" "ouvrante"))
    ("!"  . ("point" "d'exclamation"))
    ("`"  . ("Quote"))
    ("¸"  . ("Quote"))
    ("'"  . ("Backquote"))
    ("£"  . ("Livre" "sterling"))
    ("°"  . ("Degré"))
    ("¹"  . ("hoch" "eins"))
    ("²"  . ("hoch" "zwei"))
    ("³"  . ("hoch" "drei"))
    ("±"  . ("plus_ﬂ_plus" "ou" "moins"))
    ("¼"  . ("un" "quart"))
    ("½"  . ("un" "demi"))
    ("¾"  . ("trois" "quart"))
    ("©"  . ("Copyright"))
    ("h"  . ("heure")); pas entièrement convaincu
    ("®"  . ("marque" "déposée"))))


(defvar fre_symbols_tab fre_symbols_tab_default
  "fre_symbols_tab
   Is an assoc list that contains most symbols like & ^ @ *... and the
   corresponding full form.")


(defvar fre_digits_tab nil
  "fre_digits_tab
   Is an assoc list that contains all french digits (0, 1, 2, 3...) and
   the corresponding full form.")

(set! fre_digits_tab
  '(
    ("0" . ("zéro"))
    ("1" . ("un"))
    ("2" . ("deux"))
    ("3" . ("trois"))
    ("4" . ("quatre"))
    ("5" . ("cinq"))
    ("6" . ("six"))
    ("7" . ("sept"))
    ("8" . ("huit"))
    ("9" . ("neuf"))))


;; ********************
;; letters

(defvar with_accent_letter_tab nil
  "  à -> a accent grave " )
    ; à á â â ä å æ ç è é ê ë ì í í î ï ñ ò ò ô ö ù ú ü ā œ 
(set! with_accent_letter_tab
  '(
    ("à" . ("a" "accent" "grave")) 
    ("á" . ("a" "accent" "aigu")) 
    ("â" . ("a" "accent" "circonflexe")) 
    ("ä" . ("a" "tréma")) 
    ("å" . ("a" "angstrom")) 
    ("ç" . ("c" "cédille"))                                 
    ("è" . ("e" "accent" "grave")) 
    ("é" . ("e" "accent" "aigu")) 
    ("ê" . ("e" "accent" "circonflexe")) 
    ("ë" . ("e" "tréma")) 
    ("ì" . ("i" "accent" "grave")) 
    ("í" . ("i" "accent" "aigu")) 
    ("î" . ("i" "accent" "circonflexe")) 
    ("ï" . ("i" "tréma")) 
    ("ò" . ("o" "accent" "grave")) 
    ("ó" . ("o" "accent" "aigu")) 
    ("ô" . ("o" "accent" "circonflexe")) 
    ("ö" . ("o" "tréma")) 
    ("ù" . ("u" "accent" "grave")) 
    ("ú" . ("u" "accent" "aigu")) 
    ("û" . ("u" "accent" "circonflexe")) 
    ("ü" . ("u" "tréma"))
    ("ñ" . ("n" "tilde"))))

(set! substitute_lts_letter_tab
  '(
      ("ñ" . "n")
      ("á" . "a")
      ("ā" . "a")
      ("ú" . "u")
      ("ì" . "i")
      ("í" . "n")
      
      ("î" . "i")))

(set! without_accent_letter_tab
  '(
    ("c" . ("sé"))
    ("d" . ("dé"))
    ("e" . ("e"))

    ("f" . ("èfe"))  
    ("g" . ("jé"))    
    ("h" . ("hache"))    ; essai debug was hache

    ("i" . ("i"))         
    ("j" . ("ji"))
    ("k" . ("ka"))    
    ("l" . ("èle"))
    ("m" . ("ème"))
    ("n" . ("ène"))

    ("p" . ("pé"))
    ("q" . ("ku"))      
    ("r" . ("ère"))  
    ("s" . ("esse"))

    ("t" . ("té"))    
    ("u" . ("u"))     
    ("v" . ("vé"))   
    ("w" . ("double" "vé"))   

    ("x" . ("iks"))     
   
    ("y" . ("i" "grec"))  
    ("z" . ("zèd"))     

   ; todo voir si nécessaire..   versus dict with pos NOM 
    ("C" . ("sé"))
    ("D" . ("dé"))
    ("J" . ("ji"))
    ("L" . ("èle"))
    ("M" . ("ème"))
    ("N" . ("ène"))
    ("S" . ("esse"))

    ("T" . ("té"))    
    ("Y" . ("i" "grec"))))        
    

(defvar fre_char_tab nil
  "fre_char_tab
   Assoc list that contains all characters stored in fre_digits_tab and
   fre_symbols_tab; and the corresponding full form.")

(set! fre_char_tab
  (append
    without_accent_letter_tab; /!\ pb with lookup "c" nn 
    with_accent_letter_tab
    fre_digits_tab
    fre_symbols_tab))
    ; si include dico .. seul risque homo
(defvar fre_abbr_without_point_tab nil
  "fre_abbr_without_point_tab
   Is an assoc list that associates abbreviations with the full form.
   Abbreviations without a period")
   ; not very useful for acronym with capitalize letters
   ; TODO or not XXL ..
    ; testé  CNN   BNP NRJ...ADN 
    ; pb avec C se ou k ? 
    ;remplir l'addenda
(set! fre_abbr_without_point_tab
  '(
    ("UNESCO"   . ("Unesko")           )
    ("UNICEF"   . ("Unicef")           )    
    ("MBROLA"   . ("MBROLA")           ) ; pron. is in the lexicon
    ("FIAT" . ("fiat")                 ) 
    ("FIFA"     . ("Fifa")             )    
    ;  ("RATP" . ("r" "a" "t" "p"))
    ;   ("SVP" . ("s" "v" "p"))
    ("Mr"   . ("mister"))
    ;; ("ENA"  . ("éna")) ; ÉNA pb avec les apostrophes ! on passe par norm
    ("PMUC" . ("pmuk"))
    ; ("AFNOR" . ("association" "française" "de" "normalisation"))
    ;  ("USA"  . ("y" eh "s" "a"))  
    ("bcp" . ("beaucoup"))
    ("etc"     . ("et_caetera"))
    ("J.-C"      . ("Jésus" "Christ"))
    ("Mlle"      . ("Madmoiselle"))
    ("Mlles"      . ("Mesdemoiselles"))
    ("Mmes"      . ("Mesdames"))
    ("Me"      . ("Maître"))  
    ("d°"       . ("dito")) 
    ; primo, secundo, tertio : 1°, 2°, 3°
    ("n°"       . ("numéro")) 
    ("f°"       . ("folio"))
    ("r°"       . ("recto")) 
    ("ft"       . ("feuillet"))     
    ("Mgr"      . ("Monseigneur"))
    ("Mgrs"      . ("Messeigneurs")) 
    ("Mio"      . ("Million"))
    ("Mrd"      . ("Milliard"))
    ("Mr"       . ("Mister"))
    ("Mrs"      . ("Misses"))
    ("OPEC"     . ("Opek"))
    ; NE, NO, SE, SO ou SW, NNE, NNO, SSE, SSO ou SSW, NNE-SSE,


    ))    


;; ********************
;; abréviation, sigle, unité
(defvar fre_char_with_point_tab nil
  "an assoc list ... that can be followed by a point ")

(if (null? fre_char_with_point_tab)
  (set! fre_char_with_point_tab
        '( 
          ("M"  . ("monsieur"))
          ("p"  . ("page"))
          ("f"  . ("feuillet")) ; /!\
          ("l"  . ("largeur"))
          ("t"  . ("tome")); tomaison
          
          )))

;;; ======== abréviations ========
;; règles ?

; Seules les abréviations reprenant les premières lettres (dans l’ordre) d’un mot prennent un "." 
; fre_abbr_with_point_tab

; Une abréviation qui se termine par la dernière lettre du mot ne comporte pas ce point final : boulevard => bd
; fre_abbr_without_point_tab

; L’abréviation des groupes de mots ne comporte pas de point final : s’il vous plaît : SVP ou svp

; et bien sûr il y a cependant des exceptions consacrées par l’usage.

; il y a des abréviations comprenant des espaces
; il y a des abréviations comprenant des points *C.trav.* pour code du travail

(defvar fre_abbr_with_point_tab nil
  "fre_abbr_with_point_tab
   Is an assoc list that associates abbreviations (beginning normally) 
   with the full form,with a period at the end (which is not listed here).")
  ;exemple : pour *etc* le point final n'est pas noté dans le tableau
  ; les abbréviations contenant des espaces doivent être repérées
  ; utilisez norm de INST_LANG_norm.scm
  ; /!\
  ; peut créer des homonymies non résolue volt. VOLT. : volt  Volt et Voltaire

(set! fre_abbr_with_point_tab    
  '(
    ("Acad"      . ("académie"))
    ("Admin"      . ("administration"))
    ("Antiq"      . ("Antiquité"))
    ("Arch"      . ("Archives"))    
    ("Cass"     . ("Cassation"))
    ("Cie"     . ("Compagnie"))
    ("Dr"      . ("docteur"))
    ("Impr"      . ("imprimerie"))
    ("LL.A.A"       . ("Leurs" "Altesses"))      
    ("LL.M.M"       . ("Leurs" "Majestés"))      
    ("MM"       . ("messieurs"))    
    ("Mgr"       . ("monseigneur"))
    ("N.B"      . ("nota_bene")); pas OK TODO
    ("N.D.A"      . ("note" "de" "l'auteur"))
    ("N.D.E"      . ("note" "de" "l'éditeur"))
    ("N.D.I.R"      . ("note" "de" "la" "rédaction"))
    ("N.D.T"      . ("note" "du" "traducteur"))
    ("Oeuv"       . ("oeuvres"))
    ("Pr"       . ("professeur"))
    ("Rem"       . ("remarque"))
    ("S.Exc"       . ("Son" "Excellence"))       
    ("S.M"       . ("Sa" "Majesté"))    ; pas OK TODO ce qui marche
    ("S.T.P"       . ("s'il" "te" "plait")) ; pas OK TODO
    ;    ("VOLT"       . ("voltaire"))
    ("volt"       . ("voltaire"))
    ("abstr"       . ("abstrait"))
    ("adj"      . ("adjectif"))
    ("anc"      . ("ancien"))
    ("ann"      . ("annexe"))
    ("append"      . ("appendice"))
    ("apr"      . ("après"))
    ("apr._J.-C"      . ("après" "jésus" "christ"))
    ("arch"      . ("archives"))
    ("archéol"      . ("archéologie")) 
    ("arithm"      . ("arithmétique"))
    ("arr"      . ("arrondissement"))
    ("astron"      . ("astronomie"))
    ("av"      . ("avant"))
    ("av._J.-C"      . ("avant" "jésus" "christ"));  ce qui marche .. c'est la décomposition  "j._c" NOM
    ("bd"      . ("boulevard"))
    ("bdc"      . ("bas" "de" "casse"))
    ("biblio"      . ("bibliographie"))
    ("bibliogr"      . ("bibliographie"))
    ("biol"      . ("biologie"))
    ("bot"      . ("botanique"))
    ("boul"      . ("boulevard"))
    ("br"      . ("broché"))
    ("bull"      . ("bulletin"))
      ; ("cap"     . ("capitale")) ; homonymie 
    ("cart"     . ("cartonné"))
    ("cf"      . ("confer"))
    ("ch"     . ("chant"))
    ("ch.-l"      . ("chef-lieu")); ok
    ("chap"     . ("chapitre"))
    ("chronol"     . ("chronologie"))
    ("circ"     . ("circulaire"))
    ("circons"     . ("circonscription"))
    ("col"      . ("colonne"))
    ("coll"      . ("collaborateur"))
    ("coll"      . ("collection"))
    ("compl"       . ("complément"))
    ("del"      . ("delineavit"))
    ("dict"      . ("dictionnaire"))
    ; ("doc"      . ("document")) ; /!\ Doc ; homonymie 
    ("dép"      . ("département"));  
    ("env"      . ("environ"))
    ("etc"     . ("et_caetera"))
    ; ("ex"      . ("exemple")) ; ; homonymie "..à son ex." /!\
    ("fasc"      . ("fascicule"))
    ("fg"      . ("faubourg"))
    ("fig"      . ("figure"))
    ; ("fol"      . ("folio")); /!\ fol fou ; homonymie 
    ("fém"      . ("féminin"))
    ("graph"      . ("graphique"))
    ("grav"      . ("gravure"))
    ("gén"       . ("généralement"))
    ("géogr"      . ("géographie"))
    ("géol"      . ("géologie"))
    ("géom"      . ("géométrie"))

    ("hab"      . ("habitant"))
    ; ("haut"      . ("hauteur")) ; homonymie 

    ("ibid"      . ("ibidem"))
    ("iconogr"      . ("iconographie"))
    ("illust"      . ("illustration"))
    ("inf"      . ("inférieur"))
    ("introd"      . ("introduction"))
    ("inv"      . ("invenit"))
    ("invar"      . ("invariable"))
    ("ital"      . ("italique"))
    ("jur"      . ("juridique"))
    ("jur"      . ("jurisprudence")) ; /!\
    ("lat"      . ("latitude"))
    ("libr"      . ("librairie"))
    ("liv"      . ("livre"))
    ("loc"      . ("locution"))

    ; ("long"      . ("longitude")); /!\ satzende  pas bon
    ("masc"      . ("masculin"))
    ("math"      . ("mathématique"))
    ("max"   . ("maximum"))
    ("ms"      . ("manuscrit"))
    ; ("mus"      . ("musique")) ; homonymie  VER mouvoir
    ("myth"      . ("mythologie"))
    ("mécan"      . ("mécanique"))
    ("mém"      . ("mémoire"))
    ("nat"      . ("national"))
    ("nouv"      . ("nouveau"))
    ("nouv"      . ("nouvelle"))
    ("ouvr"      . ("ouvrage"))
    ("p"      . ("page"))
    ("pl"      . ("planche"))    
    ("pp"      . ("pages"))  ; proscrit   
    ("ÉO"      . ("édition" "originale"))
    ("ÉOF"      . ("édition" "originale" "française"))
    ("Éts"      . ("établissements"))
    ("éd"      . ("édition"))
    ("ép"      . ("épître")) ; /!\ épouse
    ("épil"      . ("épilogue"))
    ("étym"      . ("étymologie"))
    ; ("max"   . ("maximal")) ; /!\
    ; entrée "S.M"
    ;("art"      . ("article")) ; homonymie "..à son art." /!\
    ;;
    ;;
    ; ("volt"       . ("voltaire")) ; ; homonymie 
    ("malh"       . ("malherbes"))
    ; sans garantie du gouvernement, par SGDG ou sgdg
    ; société, par sté ou Sté
    ; société anonyme, par SA
    ; société à responsabilité limitée, par SARL
    ("RAC"        . ("Racine"))))
;;;  



(define (is_abbr_with_point name)
  (assoc_string name fre_abbr_with_point_tab))

(defvar fre_abbr_with_point_after_one_char_tab
   "Is an assoc list that associates abbreviations beginning with a single character
    but not reduce at a single one
    with the full form.
    Abbreviations with a period at the end (which is not listed here)."
    '(
      ; ("C._civ"     . ("Code" "civil")); pas OK TODO chgt norm plus d'espace après.
      ("C.civ"     . ("Code" "civil")); pas OK TODO
      ("C.comm"     . ("Code" "de" "commerce")); pas OK TODO
      ("C.just.mil"     . ("Code" "de" "justice" "militaire"))  ; pas OK TODO  
      ("C.trav"      . ("Code" "du" "travail"))
      ("C.civ"     . ("Code" "civil")); pas OK TODO
      ("C.comm"     . ("Code" "de" "commerce"));
      ("C.just.mil"     . ("Code" "de" "justice" "militaire"))  ; 
      ("C.trav"      . ("Code" "du" "travail"))
      ("J.O"  .   ("jeux olympiques")) ; ok
      ("P.-S"      . ("post-scriptum")) ; ok
      ("c.-à-d"      . ("c_est_à_dire"))
      ("e.t.c"     . ("et_caetera")); ok
      ("h.t"      . ("hors" "texte"))
      ("h.-t"      . ("hors" "texte"))
      ("i.e"      . ("id" "_est"))
      ("p.ex"      . ("par" "exemple"))    
      ("p.p"      . ("pages"))    ; proscrit
      ("S.V.P"       . ("s'il" "vous" "plait"))))


; TODO avec espace
; pose pb même en ajoutant à multiple expression 
; car norm enléve les _, en mettre 2 et surveiller norm
; ("gr._cap"      . ("grandes" "capitales")) ; TODO multiple expression 
; ("hist. nat"      . ("histoire" "naturelle")) ; TODO multiple expression 
; ("loc._cit"      . ("loco_citato"))
; ("loc._laud"      . ("loco_laudato"))
; ("op._laud"      . ("opere_laudato"))
; ("la_font"       . ("La Fontaine"))


(defvar fre_abbr_unite_mesure_tab nil
  "fre_abbr_unite_mesure_tab
   Is an assoc list that associates units of measurement like g with the
   full form (Gramm).")

;ger_abbr_masseinheiten

; cd Candela; mol  mole; rad radian
(set! fre_abbr_unite_mesure_tab
  '(
    ("A"   . ("Ampère"))
    ("eV"  . ("électron" "Volt"))
    ("°C"  . ("degré" "Celsius"))
    ("C"   . ("Coulomb"))
    ("F"   . ("Farad"))
    ("g"   . ("gramme"))
    ("h"   . ("heure"))
    ("Hz"  . ("Hertz"))
    ("H"   . ("Henry"))
    ("J"   . ("Joule"))
    ("K"   . ("Kelvin"))
    ("l"   . ("litre")) ; 15l ->15 litres
    ("min" . ("minute"))
    ("m"   . ("mètre"))
    ("N"   . ("Newton"))
    ("Pa"   . ("Pascal"))
    ("s"   . ("seconde"))
    ("t"   . ("tonne"))
    ("W"   . ("Watt"))
    ("V"   . ("Volt"))
    ("cal" . ("calorie"))
    ("Wh"  . ("Watt" "heure"))
    ("mol" . ("môle"))
    ("a" . ("are"))    
    ; new entries, in the right place? ou a commme are pb A ampère?
    ("ha"  . ("hectare")); non SI hecto-are
    ; new entries, in the right place? ou h3?

    ("km2" . ("kilomètre" "carré"))
    ("cm2" . ("centimètre" "carré"))
    ("m2" . ("mètre" "carré"))
    ("m3" . ("mètre" "cube"))
    ("cm3" . ("centimètre" "cube"))))

(defvar fre_unit_time_name nil
    "list ...")
(set! fre_unit_time_name 
    (list "h" "heure" "heures" "min" "minute" "minutes" "s" "seconde" "secondes"))


(defvar fre_abbr_unite_mesure_tab_sg nil
  "fre_abbr_unite_mesure_tab_sg
   Is an assoc list that associates units of measurement like g with the
   full singular form (Gramm).")

; (necessary e.g. for km/h -> Stunde instead of Stunden)
; ger_abbr_masseinheiten_tab_sg p.e km2 
(set! fre_abbr_unite_mesure_tab_sg
  '(
    ("A"   . ("Ampère"))
    ("eV"  . ("électron" "Volt"))
    ("°C"  . ("degré" "Celsius"))
    ("C"   . ("Coulomb"))
    ("F"   . ("Farad"))
    ("g"   . ("gramme"))
    ("h"   . ("heure"))
    ("Hz"  . ("Herz"))
    ("H"   . ("Henry"))
    ("J"   . ("Joule"))
    ("K"   . ("Kelvin"))
    ("l"   . ("litre"))
    ("min" . ("minute"))
    ("m"   . ("mètre"))
    ("N"   . ("Newton"))
    ("Pa"   . ("Pascal"))
    ("s"   . ("seconde"))
    ("t"   . ("tonne"))
    ("W"   . ("Watt"))
    ("V"   . ("Volt"))
    ("cal" . ("calorie"))
    ("Wh"  . ("Watt" "heure"))

    ; new entries, in the right place?
    ("ha"  . ("hectare"))
    ("km2" . ("kilomètre" "carré"))
    ("cm2" . ("centimètre" "carré"))
    ("m2" . ("mètre" "carré"))
    ("m3" . ("mètre" "cube"))
    ("cm3" . ("centimètre" "cube"))))

(defvar fre_abbr_unite_mesure_dim_tab nil
  "fre_abbr_unite_mesure_dim_tab
   Contains the dimension of german Masseinheiten.")
; ger_abbr_masseinheiten_dim_tab
(set! fre_abbr_unite_mesure_dim_tab
  '(
    ("°" . ("numéro")) ;-1
    ("d" . ("déci")) ;-1
    ("c" . ("centi"))
    ("m" . ("milli"));
    ("µ" . ("micro"));-6
    ("n" . ("nano")); -9
    ("p" . ("pico")); -12


    ("da" . ("déca")) ;  +1
    ("h" . ("hecto"))
    ("k" . ("kilo"))

    ("M" . ("mega"))
    ("G" . ("giga"))
    ("T" . ("tera"))))

(defvar fre_unite_mesure_teststring nil
  "fre_unite_mesure_teststring
   Check on membership of the amount of units of measurements.")

; 1 letter dimension .. 2 letters for da déca..
(set! list_k (list "p" "n" "µ" "m" "c" "d" "h" "k" "M" "G" "T"))
; TODO voir autre solution km2 Wh
; TODO pb utf8 °C résolu par lexicon contexte pas de préfixe da°C
(set! list_g (list "A" "C" "cal" "eV" "g" "h" "ha" "Hz" "J" "K" "l" "m" "mol" "min" "N" "P" "Pa" "s" "t" "V" "°C"))

; list_kg ..
; to be maintained ...
(set! fre_unite_mesure_teststring "{[p\\|n\\|µ\\|\\m\\|c\\|d\\|h\\|k\\|M\\|G\\T]}{[A\\|C\|cal\\|eV\\|g\\|h\\|ha\\|Hz\\|J\\|K\\|l\\|m\\|min\\|mol\\|N\\|P\\|Pa\|s\\|t\\|V\\|\"°C\"]+}")
(set! fre_unite_mesure_teststring1 "{da}{[A\\|C\\|cal\\|eV\\|g\\|h\\|ha\\|Hz\\|J\\|K\\|l\\|m\\|min\\|mol\\|N\\|P\\|Pa\\|s\\|t\\|V\\|\"°C\"]+}")

(define (is_unit name)
  (or 
    (member_string name  list_g)
    (and (member_string (string-car name ) list_k) (member_string (string-cdr name ) list_g))
    (and (string-matches name "^da.*") (member_string (string-cdr (string-cdr name)) list_g))))



(defvar fre_unite_mesure_teststring2 nil
  "fre_unite_mesure_teststring2
   Check on membership of the amount of units
   of measurements, but without thez dimensions. (milli, hecto ... ).")

;(set! fre_unite_mesure_teststring2
;  (string-append
;    "\\(A\\|eV\\|°C\\|C\\|F\\|g\\|ha\\|Hz\\|H\\|J\\|K\\|l\\|min\\|N\\|P\\|s"
;    "\\|t\\|W\\|V\\|cal\\|m\\|Wh\\|h\\|qkm\\|qcm\\|qm\\|ccm\\)")
;)
(set! fre_unite_mesure_teststring2
  "(A\\|C\\|cal\\|eV\\|g\\|h\\|ha\\|Hz\\|J\\|K\\|l\\|m\\|min\\|N\\|P\\|Pa\|s\\|t\\|V\\|°C)")



;; ********************
;; VER

;; verbs 
(set! verbes_etat ; état, possession, perception, pour mémoire
  (list 
      "être"
      "se trouver"
      "rester"
      "avoir"
      "trouver"
      "voir"
      "remarquer"))

(set! ppasse
  (list
      "redouté"
        "entouré"))
; pour mémoire
(set! infinitif_verbes_nir
  (list 
    "venir"
    "circonvenir" ; 23 T aux avoir
    "contrevenir"
    "convenir"
    "devenir"
    "intervenir"
    "parvenir"
    "provenir"
    "prévenir"
    "redevenir"
    "revenir"
    "souvenir"
    "subvenir"
    "survenir"
    "abstenir"
    "appartenir"
    "contenir"
    "détenir"
    "maintenir"
    "obtenir"
    "retenir"
    "soutenir"
    "tenir"))

; formes à radical "tordus": wordroot non générique
(set! verbes_ient
    (list 
        "vient"; pb homographes ;(
        "convient"; pb homographes ;(
        "devient";
        "tient";
        "soutient";
        "retient";
        "obtient";
        "maintient";
        "détient";
        "contient";
        "appartient";
        "devient";
        "devient";
        "devient";
            ))

(set! verbes_éer
  (list "créer"
        "recréer"
        "béer"
        "sier"
        "suppléer"
        "toréer"
        "agréer"
        "énucléer")) 
(set! verbes_eent
  (list "eeeeeebéer"))

;; ********************
; NAM
(defvar fre_NAM_homo_tab nil
    "les NAM doivent être déclarés dans freeling
    les 2 prononciations dans le dico même si une suit la lts 
    à moins que l'une suit la lts et l'autre est épelée exemple SPA
    en minuscules")


(set! fre_NAM_homo_tab
  '(
    ("aimable"   .  ("ADJ"))
    ("arc" . ("NOM"))    
    ("arcs" . ("NOM"))
    ("cheval"  . ("NOM"))    
    ("conseil"  . ("NOM"))
    ("duras"  . ("VER"))
    ("gorges" . ("VER" "NOM")); SIWIS
    ("chartres" . ("NOM"))
    ("grand" . ("ADJ"))
    
    ("fort" . ("ADJ"))
    ("grand" . ("ADJ"))
    ("griffe"   .  ("NOM")); siwis
    ("jean"   .  ("NOM"))
    ("jésus" . ("NOM"))
    ("li"   . ("NOM"))
    ("macron" . ("NOM"))
    ("marc"  . ("NOM"))
    ("mars"  . ("NOM"))
    ("new"   . ("NOM")) ; New York
    ("paris"    . ("NOM"))
    ("privas"  . ("VER"))
    ("savarin"  . ("NOM"))
    ("sens" . ("VER" "NOM"))
    ("raye" .("VER"))
    ("spa"  . ("NOM"))
    ("suez"   .  ("VER"))
    ("top"   . ("NOM"))
    ("usa"  . ("VER"))))

;; ********************
;; ONO, interjerction


; plus des interjections que des onomatopées ONO
;"dernière verif poslex 02/2023 partielle -> da 
; vérifier aussi les expressions
(set! fre_ONO_homo
  (list
    "adieu"; pos
    "ah"; pos
    "ah_mais"; pos
    "alea_jacta_est" ;; pos
    "alerte"; pos
    "allo"; pos
    "alléluia"; pos
    "allô"; pos
    "am_stram_gram" ;; pos
    "amen"; pos
    "atchoum" ; pos
    "arrière" ; pos
    "attention"; pos
    "aïe"; pos ; pos
    "badaboum" ; pos
    "bah"; pos
    "banco"; pos
    "bang"; pos
    "basta"; pos
    "berk"; pos
    "beuark"; pos
    "beurk"; pos
    "beu"; pos
    "bigre"; pos
    "bis"; pos
    "bim"; pos
    "bing"; pos
    "bingo"; pos
    "bis"; pos
    "bla-bla"; pos
    "bof"; pos
    "bon"; pos
    "boudu"; pos
    "bouf"; pos
    "bougre"; pos
    "boum"; pos
    "broum"; pos
    "brrr"; pos
    "bravo"; pos
    "bye"; pos
    "bye_bye"; pos
    "bé"; pos
    "calmos"; pos
    "caramba"; pos
    "chic"; pos
    "chiche"; pos
    "chouette"; pos
    "chut"; pos
    "ciao"; pos
    "clac"; pos
    "clic"; pos
    "clic-clac"; pos
    "comment"; pos
    "cot_cot_codec"; pos
    "cristi"; pos
    "cré"; pos
    "crénom"; pos
    "da"; pos
    "dame"
    "dehors"
    "diable"
    "diantre"
    "doux_jésus";; pos
    "euh"
    "flop"
    "gare"
    "gloups"
    "goddam"
    "grâce"
    "halte"
    "hardi"
    "hisse"
    "hi" ; pos
    "hourra"
    "hue"
    "hélas"
    "merci"
    "merde"
    "mince"
    "oh"
    "ouh"
    "paf"
    "pardon"
    "peste"
    "plouf"
    "rien"
    "salut"
    "tiens"
    "tintin"))  

;; ********************
;; composition : prefixe, apostrophe, terminaison s/x
;; prefix

(defvar french_prefix_list nil
  "french_prefix
   List of words that are interesting prefixes.")

(set! french_prefix_list
  '( "auto" "neuro" "anti" "chol")
  ; neur-en plus de neuro ? pas en nombre suffisant  mais les mettre dans oald ..  ou en exceptions ..
  ; co éco andro contre dé éco entre extra hétéro homo hydro macro multi ortho

  ; Prononcé /mɔ.no/ devant 
  ;   une voyelle, /b/, /n/, ou /ʁ/. 
  ;   Presque toujours devant /i/ , /p/, ou /s/.
  ;    Parfois devant /k/. Rarement devant /m/ (-méta, -moteur) ou /t/ (-trace). 
  ; Prononcé /mɔ.nɔ/ devant
  ; /d/, /f/, /ɡ/, /ɲ/, /ʒ/, /l/, /v/, /z/. Presque toujours devant /m/ ou /t/. Parfois devant /k/
  ; (toujours devant /ks/). Rarement devant /i/ (monoïque), /p/ (-plégie, -pol, -pt), ou /s/ (-cyte,
  ; -saccha, -space).
; héter-+voyelle pas assez nombreux ! ni fréquent
; ou hétéro .. intéressant  *h muet*\e.te.ʁo\

; Les rectifications orthographiques de 1990 proposent la soudure du préfixe avec le mot principal, sauf en cas de
; formation de digramme ou trigramme indésirable oi, ou avec la voyelle initiale du mot principal et qui pourrait donner
; une prononciation défectueuse selon l’orthographe usuelle en français. Dans ce dernier cas seulement, l’usage du trait
; d’union est conservé pour tous les termes formés avec ce préfixe et tout mot commençant par i ou u  ex agro-industriel : il est alors
; préféré à l’ancien usage (rare) du tréma qui a pu apparaître parfois à la position de soudure dans d’anciens termes
; scientifiques (avec un placement incertain sur la première ou la seconde voyelle).

; euro wikipedia \ø largement majoritaire  \œ.ʁɔ 53  \ø.ʁɔ :255 vrai aussi pour eur+

)

; nord, est, sud, est ex: Nord-africain
; non non-dits, non-lieux
(define (is_french_prefix_of name prefix)
  " your choice to french_downcase_string beforehand .."
  (let (result)
    (cond 
        (( and
              (member_string prefix (list "auto"  "neuro" "anti" "arché" "broncho" "brachy" "schizo"))
              (string-matches  name (string-append prefix ".*"))
              ;(< 4 (string-length_utf8 (string-after name prefix)))
              )
              (set! result t))
              ; autour, automne
        (( and
          (member_string prefix (list "chol"))
          (string-matches  name (string-append prefix ".*")))
          (set! result t))
        (( and
          (member_string prefix (list "macro"))
          (string-matches  name (string-append prefix ".*"))
          (not (string-matches  name (string-append prefix "u" ".*"))))
          (set! result t))
        (( and
            (member_string prefix (list "chiro"))
            (string-matches  name (string-append prefix ".*"))
            (not (string-matches  name (string-append prefix "n" ".*"))))
            (set! result t))
        (t set! result nil))
    result))

;; apostrophes
; essai afin_qu
(defvar list_before_apo (list "c" "d" "j" "l" "m" "n" "s" "t" "qu" "quoiqu" "quelqu" "jusqu" "lorsqu"  "afin_qu" "alors_qu" "bien_qu" "parce_qu" "pendant_qu" "tandis_qu" "tant_qu" "puisqu"
           "afin_d" "loin_d" "quoi_qu"))

;; tiret grammatical
(defvar list_after_tiret 
  (list 
    ;"même" ; NON vus comme ADV 
    ;"ci" ;NON
    ;"là" ;NON
    ; "mêmes" ; NON
    "elle" ;; voit-elle ?
    "elles" 
    "en"  
    "il" 
    "ils" 
    "je" 
    "la" 
    "le" 
    "ce" ; fût-ce ...
    "les" 
    "leur"
    "lui" 
    "lui" 
    "moi" 
    "nous" 
    "on" 
    "toi" 
    "tu" 
    "vous" 
    "y"  
    "z_en"
    "en_lui"
    "en_moi"
    "en_nous"
    "en-toi"
    "en_vous"
    "en_elle"
    "en_elles"
    "t_elle"
    "t_elles"
    "t_il"
    "t_ils"
    "t_on"        
    ))

; pluriel et s/x finaux sonore

; general case s/x is mute
; separate list exceptions ex ananas, as, crocus, etc.
; s ou x non muet y compris ceux qui peuvent s'entendre  par liaison
; mais pas seulement ? 
; puisque les autres sont dans le dico !?
; ne serait-ce que pour pas oublier de les enlever pour entraînement nouvelle lts
; et ne pas les oublier dans le dico !
; corriger 
; qqchose comme
; (define pourdico
; (let (fd (fopen "pour_dico")
;      (liste list_sx_exist_and_not_always_mute))
;   (mapcar 
;     (lambda (fname)
;       ;
;      (format fd "%l\n" (lex.lookup fname)))
;     liste))
;   (fclose fd))
    
(defvar list_sx_exist_and_not_always_mute
  (list 
    "albinos"
    "albatros"
    "bus"; VER ou NOM
    "es" ; homo es sciences /tu es 
    "cassis" ; variante
    "faciès"
    "t_es" ; gloups XXX ?
    "chez"
    "corps" ; pour corps et biens ?   
    "aloès" ; variante
    "bis"; variante pain bis
    "ces"
    "chez"
    "des"
    "dans" ; dans un jardin
    "deux"
    "dix"
    "dix_dis" ; préfabriqué pour pausic
    "fils"
    "hélas"; VER ver "
    "elles"
    "ils"
    "les"
    "lis"
    "mes"
    "mis"
    "nous"
    "s_"
    "ses"
    "six"
    "six_sixs"
    "tes"
    "vis";VER ou NOM
    "vous")) 


(define (is_sx_exist_and_not_mute word)
   (member_string word list_sx_exist_and_not_mute))

(defvar list_sx_exist_and_not_mute
  (list 
    "ours"
    "index"
    "intra_muros"
    "bombyx"
    "autobus"
    "ad_patres"
    "alias"
    "alès"
    "arès"
    "atlas"
    "d_atlas"
    "l_atlas"
    "sphinx"
    "madre_de_dios"
    "versus"
    "blocus"
    "bibliobus"
    "bonus"
    "campus"
    "crocus"
    "cirrus"
    "nimbus"
    "clausus"
    "nimbus"
    "collapsus"
    "infarctus"
    "nimbus"
    "détritus"
    "cactus"
    ))

(define (is_prob_pluriel name)
    (member_string (string-last name) (list "x" "s")))

; pas de chgt au pluriel et ne se terminant pas par s
; des vol-au-vent

(set! list_quantifiable_fem
  (list 
      ; "Livre" ; stats
      "_pound"
      "pound"
      "Pound"
      "Lire"
      "année"
      "année_homme"
      "années_homme"
      "années_lumière"
      "année_lumière"
      "h" ; heure
      "s" ; seconde
      "bougie"
      "douzaine"
      "heure"
      "minute"
      "seconde"
      "poire"      
      ))

(define (is_quantifiable_fem name)
    (member_string (wordroot name "NOM") list_quantifiable_fem))

;; ********************
; locutions 
;; ********************
;; loc ne contient ni ponctuation ni preponctuation 
(defvar french_multiple_word_expressions nil
    "List of french locutions avec 1 espace")
; TODO read from a file
; TODO nécessité mettre la forme au pluriel ? 
; TODO vérifier freeling
; insensible à la casse .... pour simplifier !
; une casse conforme est suppposée  
; sinon changer INST_LANG_token_to_words...
(set! french_multiple_word_expressions
  (list 
    ; ;Rq n_importe_quoi est  ici car le premier _ correspond à une apostrophe; faire attention à conserver l'apostrophe dans norm !!

    "n_est_ce"; pos
   ; "n_est_pas"; TODO pas compris contrarie ( SayText "n'est-ce pas délirant") supprime le "pas" alorque n'importe quoi ne pose pas de pb !  ("QTbefapo" "QTpos2" "QTloc2m" "QTdel" "QTdelp" "QT24")
  
    "n_importe_quoi"; pos
    "n_importe_qui"; pos
    "n_importe_quel"; pos
    "n_importe_quelle"; pos
    "n_importe_comment"; pos
    "n_importe_où"; pos
    "n_importe_quand"; pos
    "n_importe_qui"; pos
    "n_importe_quoi"; pos
    "n_y_a" ; pos
    "n_y_en"; pos
    "jusqu_au_bout"; pos
    "tout_d_abord"; pos
    
    ; TODO y_a; y_en , y_eut, y_ait rule ?
    "mieux_être" ; pos
    ;"est_ce" ; essai pour corriger faute typo

    "ne_plus"
    "ne_plu"
    "en_plus"
    ; "y_a"  
    ; "y_eut"
    ; "y_ait"
    "z_en" ;; important car (norm "z_en") -> "z en" GLOUPS
    "m_en"
    "t_en"
    "s_en"
    "a_fortiori"; pos
    "ab_initio"; pos
    "ab_irato"; pos
    "ab_ovo"; pos
    "ad_hoc"; pos
    "ad_hominem" ; pos
    "ad_honores" ; pos
    "ad_infinitum" ; pos
    "ad_libitum" ; pos
    "ad_patres" ; pos
    "ad_rem" ; pos
    "ad_usum" ; pos
    "ad_valorem" ; pos
    "afin_de"
    "afin_que"
    "after_shave"
    "agnus_castus"
    "agnus_dei"
    "a_posteriori"
    "aujourd_hui"
    "air_bag"
    "al_dente"; pos
    "all_right"
    "alors_que"
    "alter_ego"
    "auquel_cas"
    "aux_aguets"
    "avant_hier"
    "ayants_droit"
    "back_up"
    "beat_generation"
    "bel_canto"
    "belle_lurette"
    "best_of"
    "big_band"
    "big_bang"
    "birth_control"
    "bla_bla"
    "black_out"
    "bloody_mary"
    "blue_jean"
    "blue_jeans"
    "blue_note"
    "box_office"
    "boat_people"
    "bubble_gum"
    "by_night"
    "call_girl"
    "call_girls"
    "casus_belli"
    "cep et"
    "check_up"
    "chop_suey"
    "citizen_band"
    "coffee_shop"
    "comic_book"
    "commissaire_adjoint"
    "commissaire_priseur" ; pos
    "commedia_dell'arte" ; pos hmm: ; TODO check
    "corn_flakes"
    "corpus_delicti"
    "curriculum_vitae"
    "d_abord"; homo 
    "d_ailleurs"
    "d_autres"
    "d_emblée"
    "d_arrache_pied"; pos
    "dare_dare"
    "de_facto"; pos
    "de_fait" ; pos verifier si utile voies de fait homo ADJ ?
    "de_guingois"; poS
    "de_plano" ;pos
    "de_plus"; pos
    "de_profundis"
    "de_quoi"; pos
    "de_rien" ; ADV Quant il de rien ne me conforte =aucunement
    "de_santis"; pos
    "de_traviole";pos
    "de_visu"; pos
    "delirium_tremens"
    "della_francesca"
    "deo_gratias"
    "des hululement"
    "deutsche_mark"
    "dies_irae"
    ;; "divin_enfant"  éliminé denatphon de postlex a maintenant 2 paramètres
    "douce_amère"; ADJ
    "doux_jésus"; pos
    "dream_team" ; pos
    "drive_in"; pos
    "drone_espion"; pos
    "d_ici_à"; pos
    "dix-neuf_ans";
    "dix-neuf_heures";
    "dure_mère"; pos
    "east_river"; pos
    "ecce_homo"; pos
    "eh_bien"; pos
    "elle_même"
    "elles_mêmes"
    "en_arrière"; pos
    "en_avant"; pos
    "en_bas"; pos
    "en_cas"; pos
    "en_catimini"; pos
    "en_cours"; pos; hmm
    "en_dehors"; pos
    "en_delà"; pos; hmm
    "en_effet"; pos
    "en_fait"; pos
    "en_haut"; pos
    "en_quoi"; pos
    "en_loucedé"; pos
    "en_outre"; pos
    "en_suspens"; pos
    "en_tapinois"; pos
    "en_tête"; pos
    "en_étant"; pos ; homo hmm
    "entre_autres"
    "est_elle"; pos
    ; est_il" ; si style relâché ou addenda neut_book_s01_0016
    "et_hop"; pos
    "et_caetera"
    "et_cetera"
    "eux_mêmes"; pos
    ; tous les ex nécessaires 
    "fait_maison"; pos
    "fast_food"
    "five_o'clock"
    "fret_express" ; pos
    "foreign_office"
    "gengis_khan"
    "girl_friend"
    "gna_gna"
    "grosso_modo"
    "happy_end"
    "happy_ends"
    "hard_edge"
    "has_been"
    "high_life"
    "high_tech"
    "hold_up"
    "homo_erectus"
    "hong_kong"
    "honoris_causa"
    "hot_dog"
    "house_music"
    "huis_clos"; h aspiré dans huis clos (subst.)
    "ice_cream"; pos
    "in_absentia"
    "in_extremis"
    "in_memoriam"
    "in_pace"
    "in_utero"
    "in_vitro"
    "inch_allah"
    "intra_muros"
    "ipso_facto"
    "irish_coffee"
    "jusqu_à"; pos
    "jusqu_ici"; pos
    "jusqu_alors"; pos
    "jusqu_où"; pos
    "jusque_devant"; erreur Poslex jusque vu comme VER
    "j._c"
    "kung_fu"
    "LA_FONT" 
    "La_Fontaine"
    "la_plata"
    "la_plupart"
    "loin_d" ; pos ; neut
    "longitude_N"
    "longitude_S"
    "latiude_E"
    "latitude_O"
    "lui_même"
    "made_in"
    "manu_militari"
    "mass_media"
    "mea_culpa"
    "mieux_être" ; pos; ADV+VER -> VER ou NOM
    "moi_même"
    "melting_pot"
    "messieurs_dames"
    "milk_shake"; pos
    "mille_feuille"; pos
    "mille_pattes"; pos
    "modern_style"
    "modus_operandi"
    "modus_vivendi"
    "music_hall"
    "negro_spiritual"
    ; "neuf_ans" NON ps le s final ?
    "neuf_an"
    "neuf_heures"
    "night_club"
    "no_comment"
    "nota_bene"
    "nous_mêmes"; token
    "osso_buco"
    "par_mégarde"
    "parce_que"
    "paso_doble"
    "pater_familias"
    "pater_noster"
    "pax_americana"
    "pendant_que"
    "persona_grata"
    "pic_vert"
    "pit_bull"
    "play_back"
    "plein_air"
    "pom-pom_girl"
    "pom-pom_girls"
    "post_it"
    "post_mortem"
    "post_scriptum"
    "presqu-ile"
    "prime_time"
    "punching_ball"
    "quant_au"
    "quant_aux"
    "quant_à"
    "quatre_vingt_un"
    "quelqu_un"
    "quelqu_une"
    "quelque chose"
    "quelques_unes"
    "quelques_uns"
    "quoi_que"
    "red_river"
    "roast_beef"
    "rocking_chair"
    "Saint_Esprit"
    "saint_esprit"    
    "saint_paul"
    "sainte_nitouche"
    "san_francisco"
    "self-made_man"
    "sex_appeal"
    "sex_shop"
    "sex_shops"
    "soi_même"; pos; token
    "soap_opéra"
    "sri_lankais"
    "statu_quo"
    "story_board"
    "stricto_sensu"
    "sui_generis"
    "t_shirt"
    "T_shirt"
    "tandis_que"
    "taï_chi"
    "tchin_tchin"
    "te_deum"
    "terra_incognita"
    "too_much"
    "top_model"
    "tout_autant"; pos
    "tout_autre"; pos

    "tous_les"; pos
    "tout_puissant"; pos
    "traveller's_chèque"
    "tutti_frutti"
    "tutti_quanti"
    "un_autre"
    "une_autre"
    "un_hérisson"
    "un_ulhan"
    "un_hululement"
    "un_unau"
    "vade_retro"
    "vae_victis"
    "vingt_cinq"
    "vingt_huit"
    "vomito_negro"
    "vous_mêmes"; TODO check
    "vous_même"
    "vox_populi"
    "vulgum_pecus"
    "wall_street"
    "week_end"
    "world_music"
    ; {(0 s  i  l )}{(0 i )}{(0 j  a )
    ; {(0 s  i  l )}{(0 j  a )}
    "Y_a"
    "y_a" ; permet prononc il y a différente niveau de langage ?
    ;;;"y_a-t_il" ; ("y_a-t-il" "VER" (((j a) 0) ((t i l)0))) à mettre dans le dico ; VER sans sujet apparent ça existe cf impératif
    "y_avait" ; pos
    ;;; "y_avait-t-il" ; ;; usage erroné
    ; NON "y_en" ; token ; pos
    "yom_kippour"
    "yom_kippur"
    "à_croupetons"; pos
    "à_demi"; pos
    "à_fortiori"; pos
    "à_jeun"; pos
    "à_présent"
    "à_posteriori" ; pos
    "à_priori"; pos
    "a_priori"            
    "à_tâtons"; pos

    "C._civ"))

(defvar french_multiple_word_expressions1 nil
    "List of french locutions1 terminée par une apostrophe")

(set! french_multiple_word_expressions1
 
  (list 
    "afin_d";  ; tous des CON à ficher dans le dico; afin d'être CON + infinitive     "afin_d" ; "liaison" obligatoire -> addenda (("afin_d" PRE (((a) 0) ((f ehn) 0))) sans le d 
    "afin_qu";  ; tous des CON à ficher dans le dico; afn qu'il soit CON + subord "normale"
    "alors_qu"
    "bien_qu"
    "loin_d"
    "parce_qu"
    "pendant_qu"
    "tandis_qu"
    ))

(set! french_multiple_word_expressions2 
  (list 
     ; le cas chef-d'oeuvre est réglé par QTchefd à l'instar des va-t'on
     "chef_d_oeuvre"
    "n_est_ce_pas"; pos 
    "alea_jacta_est" ; pos
    "am_stram_gram"; pos
    "bon_au_porteur"; pos
    "bon_à_rien";
    "bons_à_rien";
    "ceux_et_celles" ; pos
    "cinq_à_sept" ; pos
    "cnquante_et_un"; pos
    "cot_cot_codec"    ; pos
    "commedia_dell_arte"; pos
    "de_manière_à"; pos
    "corps_et_biens"; pos
    "deus_ex_machina"; pos
    "face_à_face"; pos
    "faute_de_quoi"
    "en_moins_de"
    "in_vino_veritas"
    "il_y_a"; pos
    "il_y_aura"; pos
    
    "la_plupart_des"
    "la_plupart_du"
    "madre_de_dios"
    "mobilis_in_mobile"
    "n_y_en_a"; pos
    "nuit_et_jour"
    "persona_non_grata"
    "peu_ou_prou"; pos
    "plus_et_plus"; pos
    "plus_ou_moins"; pos
    "quarante_et_un"
    "rhythm_and_blues"
    "sic_transit_gloria_mundi"
    "sine_qua_non"
    "temps_en_temps"
    "tout_au_plus"; ; pos
    "tout_ou_rien"; pos
    "tout_de_même"; pos
    "tout_à_chacun"; pos
    "tout_à_coup"; pos
    "tout_à_fait"; pos

    "un_à_un" ; à cause des liaisons
    "urbi_et_orbi"
    "vingt_et_un"

    "wait_and_see"
    "way_of_life"
    "à_la_saint-glinglin"; pos
    "à_leur_encontre"; pos
    "à_moins_de"; pos
    "à_moins_que"; pos
    "à_mon_encontre"; pos
    "à_notre_encontre"; pos
    "à_son_encontre"; pos
    "à_ton_encontre"; pos
    "à_tous_égards"
    "à_votre_encontre"; pos
    "à_leurs_encontres"; pos
    "d_ores_et_déjà"; pos; marche car 2 espaces
    "no_man_s_land"
    "no_man_s_land"
     "n_y_a" ; pos; si manque d'apostrophe (nécessité tempo _erreur addenda_ mais on peut laisser)
     
    
    ))

(set! french_multiple_word_expressions3 
  ; pour mémoire ne marche pas 
  (list 
    "tout_à_l_heure"; pos   
    "en_moins_de_rien" ; adv de temps
    "y_a_t_il"

    ))
(set! french_multiple_word_expressions3plus
  ; pour mémoire ne marche pas 
  (list 
    "ad_hoc_et_ab_hac"
    "au_fur_et_à_mesure"
    "de_bric_et_de_broc"))

(defvar french_multiple_word_expressions4 nil
    "List ")

(set! french_multiple_word_expressions4
 
  (list 
    "ce_dont"
    "ce_qu"    
    "ce_que"   
    "ce_qui"

    "celle_dont"
    "celle_qu"    
    "celle_que"   
    "celle_qui"

    "celles_dont"
    "celles_qu"    
    "celles_que"   
    "celles_qui"  

    "celui_dont"
    "celui_qu"    
    "celui_que"   
    "celui_qui"

    "ceux_dont"
    "ceux_qu"    
    "ceux_que"   
    ;"ceux_qui"
    
    ))

(defvar french_multiple_word_abbreviations nil
    "List of french abbreviations with whitespace")

(set! french_multiple_word_abbreviations 
      '("C cod. civ"  "C. just. mil"))
(define (is_french_multiple_word_abbreviations name)
  (member_string name french_multiple_word_abbreviations))

(defvar french_multiple_words nil
  "List of french multiple words abbreviations included")

(set! french_multiple_words
  (append french_multiple_word_abbreviations french_multiple_word_expressions))



;; ********************
; titres
(defvar french_king_title nil
  "french_king_title
   List of words that are german king-like titles.")

(set! french_king_title
  '("roi" "empereur" "baronnet" "baron" "pape" "vicomte" "lord" "comte"
    "prince" "duc"))


(defvar french_queen_title nil
  "french_queen_title
   List of words that are german queen-like titles.")

(set! french_queen_title
  '("reine" "impératrice" "duchesse" "baronne" "papesse" "comtesse" "princesse"
    "vicomtesse"))


(defvar french_king_name nil
  "french_king_name
   List of words that are german king names.")

(set! french_king_name
  '("louis" "henri"  "henry" "charles" "philippe" "george" "georg" "edward" "eduard" "françois"
    "pius" "william" "wilhelm" "richard" "Ptolémée" "john" "Paul" "peter" "Nicolas"
    "jean-paul" "nicholas" "nikolaus" "Alexandre" "frederick" "james" "Jean"
    "alfonso" "ivan" "napoléon" "leo" "gregory" "gregor" "ludwig" "otto"
    "friedrich" "karl" "Pierre" "Grégoire" "Charles"))



(defvar french_queen_name nil
  "french_queen_name
   List of words that are german queen names.")

(set! french_queen_name
  '("Catherine" "katharina" "alexandria" "Elizabeth" "mary" "maria" "anne" "Marie-Antoinette"
    "elisabeth" "Cléopatre"))



;; phrase

(defvar fre_abbr_at_eos_tab nil
  "fre_abbr_at_eos_tab
   is an assoc-list of abbreviations that occur almost ever at the end of a
   sentence. points at after this abbr. are recognized as periods.")

(set! fre_abbr_at_eos_tab 
  '(
    ("etc" . ("et_caetera"))))

; #followed by a period (and an upper-case word), does NOT indicate an end-of-sentence marker.
; eos marker
; # Special cases are included for prefixes that ONLY appear before 0-9 numbers.
; # any single upper case letter  followed by a period is not a sentence ender
; # usually upper case letters are initials in a name
; # no French words end in single lower-case letters, so we throw those in too?


(set! list_PRE_startvowel
  (list
    "afin_d"
    "afin_de"
    "après"
    "au_dedans"
    "au_dehors"
    "au_delà"
    "au_devant"
    "au_deçà"
    "au_fur_et_à_mesure"
    "auprès"
    "avant"
    "avec"
    "en"
    "entre"
    "envers"
    "excepté"
    "outre"
    "à"))


  (set! list_homo_VER_NOM
  ;  +4000  ; pe exclure forme infinitive ... si seulement utile pour sans *
    
      (list    
            "cause"
            "cesse"
            "couve"
            "couvent"
            "doute"
            "feinte"
            "ferme"
            "ferment"
            "frimas" ; le frimas
            "offense"
            "relâche"
            "relâches"
            "réserve"
            "rendez_vous" ; vu comme VER 
            ))
  
  ; (set! list_homo_VER_PRE
  ; es sciences
        
  ; ADV ou PRE, cas possibilité autre POS non traité exemple derrière, plein, vers etc.
  ; non traité dans tokenpos_fr      
(set! list_PRE_ADV 
  (list 
  ; "après" ; BUG core dump neut_parl_s01_0082
    "au_dedans"
    "au_dehors"
    "au_dessous"
    "au_dessus"
    "au_devant"
    "au_fur_et_à_mesure"
    "depuis" ; BUG core dump neut_parl_s01_0216
    "lez"
    "nonobstant"
    "par_dessus"
    "rez"))
              
;;   







  
;;;

; Cet arbre de prédiction permet d 'obtenir le suffixe d'un nombre ordinal
; Il est construit à la main, il aurait gagné à être réalisé à l'aide de l'outil wagon...
; Une stratégie plus efficace encore serait de déterminer la terminaison dans un module
; intervenant plus tard pour avoir plus d'informations contextuelles notamment sur le genre

(defvar french_ordinal_prediction_tree nil
  "french_ordinal_prediction_tree
   This tree is used to determine the suffix of french ordinals.")


; (set! french_ordinal_prediction_tree
;     '((case is masc_dat)
; TODO
; dans token_to_words
;   (item.set_feat (item.next token) "case" "masc_dat")
;       ...
; )


; ==========
; A.C.N
; A.M
; art
; ann
; apr
; av
; auj
; lib
; B.P
; boul
; ca
; c.-à-d
; cf
; ch.-l
; chap
; contr
; C.P.I
; C.Q.F.D
; C.N
; C.N.S
; C.S
; dir
; éd
; e.g
; env
; al
; etc
; E.V
; ex
; fasc
; fém
; fig
; fr
; hab
; ibid
; id
; i.e
; inf
; LL.AA
; LL.AA.II
; LL.AA.RR
; LL.AA.SS
; L.D
; LL.EE
; LL.MM
; LL.MM.II.RR
; loc.cit
; masc
; MM
; ms
; N.B
; N.D.A
; N.D.L.R
; N.D.T
; n/réf
; NN.SS
; N.S
; N.D
; N.P.A.I
; p.c.c
; pl
; pp
; p.ex
; p.j
; P.S
; R.A.S
; R.-V
; R.P
; R.I.P
; SS
; S.S
; S.A
; S.A.I
; S.A.R
; S.A.S
; S.E
; sec
; sect
; sing
; S.M
; S.M.I.R
; sq
; sqq
; suiv
; sup
; suppl
; tél
; T.S.V.P
; vb
; vol
; vs
; X.O
; Z.I


;;;==
; BN Bibliothèque Nationale


; abréviations bibliographiques
; coll.
; éd.
; abréviations chrétiennes

(provide 'INST_LANG_token_to_words_lists)
