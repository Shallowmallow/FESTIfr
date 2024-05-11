(defvar verbose_addendas)
(if verbose_addendas (format t "addenda_fautif.scm loaded"))
; /!\ bizarrerie de wordroot
; (wordroot "États_généraux" nil) -> États_générau
; (wordroot "états_généraux" nil) -> états_générau"
; mais (lex.lookup "états_généraux") et (lex.lookup "États_généraux")   )
; donne (((e)0) ((t a)0) ((zh e)0) ((n e)0) ((rh o)0))))
; si on voulait différencier, il faudrait créer une entrée dans poslex
; ex dans l'addenda(lex.add.entry '("États_générau" ((NAM 0))())); ; juste pour test
; puis ure entrée dans le lex par exemple ici
;(lex.add.entry '("états_générau_NAM" NAM (((e)0) ((t a)0) ((zh e)0) ((n e)0) ((rh eu)0))))
;(lex.add.entry '("États_générau_NAM" NAM (((e)0) ((t a)0) ((zh e)0) ((n e)0) ((rh eu)0))))
; et ça ne marcherait pas !! TODO
; MAIS cela marche pour des mots non composés
; voir le cas de "ranger" (SayText "le ranger se mit à ranger")
(lex.add.entry '("en_quoi" nil ((("ahn") 0) (("k" "w" "a") 0)))); et non ahn n 

(lex.add.entry '("idiot" nil ((("i") 0) (("d" "j" "o") 0)))); et non "i" "d" "i" "j" "o"

(lex.add.entry '("elles_même" nil ((("eh" l) 0) (("m" "eh" "m") 0))));; et non ("eh" "l" "eh" "s" "m" "eh" "m")

(lex.add.entry '("lui_même" nil (((l hw i)0) ((m eh m)0)))) ; et non pas ("l" "hw" "m" "eh" "m")
(lex.add.entry '("vienne" nil (((v j eh n)0)))) ; "v" "j" "n
(lex.add.entry '("démesuré" nil (((d ae)0) ((m ae)0) ((z y)0) (( rh e)0)))) ; et non pas "d" "e" "m" "eh" "s" "y" "rh" "e"
(lex.add.entry '("contenu" nil ((("k" "ohn") 0) (( t ae)0) (("n" "y") 0)))) ; et non  ((("k" "ohn" "t") 0) (("n" "y") 0))
(lex.add.entry '("trente_et_une" nil ((("t" "rh" "ahn" "t") 0) (( e)0) (("y" "n") 0)))); et non  ("t" "rh" "ahn" "t" "t" "y" "n")
(lex.add.entry '("pion" nil ((("p" "j" "ohn") 0)))); et non ((("p" "j" "oh") 0))
(lex.add.entry '("furieuse" nil ((("f" "y") 0) (("rh" "j" "eu" "z") 0)))); et non pas ("f" "y" "rh" "i" "eu" "z")
(lex.add.entry '("furieu" nil ((("f" "y") 0) (("rh" "j" "eu") 0))))
(lex.add.entry '("inter_états" nil (((ehn)0) ((t eh rh)0) ((e)0) ((t a)0)))) ; et non ("ehn" "t" "eh" "rh" "e" "t" "a" "t"
(lex.add.entry '("États_générau" nil (((e)0) ((t a)0) ((zh e)0) ((n e)0) ((rh o)0)))) ; et non ("e" "t" "a" "t" "z" "zh" "e" "n" "e" "rh" "o"
(lex.add.entry '("serf" nil ((( s eh rh)0)))); et non ("s" "eh" "rh" "f")
(lex.add.entry '("hors_circuit" nil ((( oh rh)0) (( s i rh)0) ((k hw i)0)))); et non pas ("oh" "rh" "s" "s" "i" "rh" "k" "hw")
(lex.add.entry '("blanc_seing" nil (((b l ahn)0) ((s ehn)0))));
(lex.add.entry '("blancs_seing" nil (((b l ahn)0) ((s ehn)0)))); en plus abandon du phoneme "ng" ; et non "b" "l" "ahn" "k" "z" "z" "ng"

(lex.add.entry '("seing" nil (((s ehn)0)))); en plus abandon du phoneme "ng"
(lex.add.entry '("n_est_ce" nil ((( "n" "eh" "s" )0) )));
(lex.add.entry '("emmène" nil ((( ahn)0) ((m eh n)0) )));
(lex.add.entry '("emmené" nil ((( ahn)0) ((m ae)0) ((n e)0))));

(lex.add.entry '("dites_le" nil ((("d" "i" "t")0) (("l" "oe")0)))); et non  ("d" "i" "t" "eh" "s" "l"); inutile QTpos2, kuste pour lts
(lex.add.entry '("prené" nil ((( p rh ae)0) (( n e)0)))); et non "p" "rh" "ahn" "n" "e")
(lex.add.entry '("prenez_les_VER" VER ((( p rh ae)0) (( n e)0) ((l e)0)))); et non "p" "rh" "ae" "n" "l"; inutile QTpos2, juste pour lts
(lex.add.entry '("prenez_le" nil ((( p rh ae)0) (( n e)0) ((l oe)0)))); et non "p" "rh" "ae" "n" "l"; inutile QTpos2, kuste pour lts
(lex.add.entry '("de_quoi" nil ((( d ae)0) ((k w a)0))))
(lex.add.entry '("faits" nil (((f eh)0)))); VER et non f eh t
(lex.add.entry '("dis_je" nil ((("d" "i" "zh") 0)))); et non "d" "i" "z" "zh"
(lex.add.entry '("acronyme" nil ((("a") 0) (("k" "rh" "o") 0) (("n" "i" "m") 0)))); et non "a" "k" "rh" "ohn" "ehn" "m"
(lex.add.entry '("celui_ci" nil ((("s" "ae")0) (("l" "hw" "i")0) (("s" "i")0))))
(lex.add.entry '("donnez_moi" nil ((("d" "oh")0) (("n" "e")0) (("m" "w" "a")0)))); inutile QTpos2, kuste pour lts
(lex.add.entry '("projet" nil ((("p" "rh" "oh")0) (("zh" "eh") 0)))); et non ((("p" "rh" "oh" "zh" "t") 0))
;(lex.add.entry '("qu_obtient_on" nil ((("k" "oh" "p") 0) (("t" "j" "ehn") 0) (("t" "ohn") 0))))
(lex.add.entry '("qu_obtient_il" nil ((("k" "oh" "p") 0) (("t" "j" "ehn") 0) (("t" "i" "l") 0))))
(lex.add.entry '("qu_obtient_elle" nil ((("k" "oh" "p") 0) (("t" "j" "ehn") 0) (("t" "elle") 0))))
(lex.add.entry '("qu_obtiennent_elles" nil ((("k" "oh" "p") 0) (("t" "j" "eh" "n") 0) (("t" "eh" "l") 0))))
(lex.add.entry '("qu_obtiennent_ils" nil ((("k" "oh" "p") 0) (("t" "j" "eh" "n") 0) (("t" "i" "l") 0))))
(lex.add.entry '("obtient" nil ((("oh" "p") 0) (("t" "j" "ehn") 0))))
(lex.add.entry '("années_lumière" nil ((("a") 0) (("n" "e") 0) (("l" "y") 0) (("m" "j" "eh" "rh") 0)))); et non ("a" "n" "e" "eh" "s" "l" "y" "m" "j" "eh" "rh")

(lex.add.entry '("année_lumière" nil ((("a") 0) (("n" "e") 0) (("l" "y") 0) (("m" "j" "eh" "rh") 0)))); et non ("a" "n" "e" "eh" "s" "l" "y" "m" "j" "eh" "rh")
(lex.add.entry '("oh" nil ((("oh")0))))
(lex.add.entry '("devenè" nil ((("d" "ae")0) (("v" "ae")0) (("n" "eh")0))))
(lex.add.entry '("loin_d" nil ((("l" "w" "ehn" d)0)))) ; TODO mais liaison hmm
(lex.add.entry '("s_enivrent" nil ((("s" "ahn")0) (("n" "i" "v" "rh"))))); et non pas s" "n" "i" "v" "rh"
(lex.add.entry '("quatre_vingt" nil ((("k" "a" "t" "rh")0) (("v" "ehn")0)))); et non v ehn g
(lex.add.entry '("vingt_cinq" nil ((("v" "ehn" "t")0)((s ehn k)0))))
(lex.add.entry '("soixante_et_une" nil ((("s" "w" "a") 0) (("s" "ahn" "t") 0) ((e)0)(("y" "n") 0)))); et non "s" "w" "a" "g" "z" "ahn" "t" "t" "y" "n"
(lex.add.entry '("un_unau" nil ((("ehn")0) (("y")0) (("n" "o")0)))); et non pas "y" "n" "y" "n" "o"
(lex.add.entry '("y_en" nil (((j ahn)0)))); et non pas "i" "ehn"
(lex.add.entry '("est_il" nil ((("eh")0) (("t" "i" "l")0))))
(lex.add.entry '("nuit_et_jour" nil (((n hw i)0) (("t" "e") 0)((zh u rh)0)))); et non pas   n hw  t  t  zh  u  rh 
(lex.add.entry '("ceux_et_celle" nil (((s eu)0) (( "e")0) (("s" "eh" "l")0)))); et non pas s" "eu" "k" "s" "t" "s" "eh" "l
(lex.add.entry '("manège" nil ((("m" "a")0)(("n" "eh" "zh")0)))); et non m ahn 
(lex.add.entry '("en_moins_de" nil ((("ahn") 0) (("m" "w" "ehn") 0) (("d" "ae")0)))); et non ahn n "m" "w" "ehn" "s"..

(lex.add.entry '("en_moins_de_rien" nil ((("ahn") 0) (("m" "w" "ehn") 0) (("d" "ae")0) (("rh" "j" "ehn") 0)))); et non ahn n "m" "w" "ehn" "s".. d rh j ehn
(lex.add.entry '("t_on" nil (((t ohn)0))))
(lex.add.entry '("afriolant" nil (((a)0)((f rh j oh)0) ((l ahn)0))))
(lex.add.entry '("votr_individu" nil ((("v" "oh") 0) (("t" "rh" "ehn") 0) (("d" "i") 0) (("v" "i") 0) (("d" "y") 0))))
(lex.add.entry '("quatr_saisons" nil ((("k" "a" "t" "rh") 0) (("s" "eh") 0) (("z" "ohn") 0)))) ; et non z eh 

(lex.add.entry '("succè" nil (((s y k)0) ((s eh)0)))); et non pas s y k eh
(lex.add.entry '("ex_agent" nil ((( eh k s)0)((a)0) ((zh ahn)0))));et non pas eh g
(lex.add.entry '("ferè" nil (((f ae)0) ((rh eh)0))))
(lex.add.entry '("feré" nil (((f ae)0) ((rh e)0))))
(lex.add.entry '("broc" nil (((b rh oh k)0))))
(lex.add.entry '("oreille" nil ((("oh")0) (("rh" "eh" "j")0)))); et non pas e j
(lex.add.entry '("famille" nil ((("f" "a")0) (("m" "i" "j")0)))); plutôtrécalcitrant 
(lex.add.entry '("donne_m_en" nil ((("d" "oh" "n")0) (("m" "ahn")0)))); plutôtrécalcitrant 

(lex.add.entry '("satisfaits" nil ((("s" "a") 0) (("t" "i" "s") 0) (("f" "eh") 0)))); et non eh t  TODO êtes-vous satisfaits VER VER

(lex.add.entry '("satisfait" nil ((("s" "a") 0) (("t" "i" "s") 0) (("f" "eh") 0))))
(lex.add.entry '("satisfé" nil ((("s" "a") 0) (("t" "i" "s") 0) (("f" "e") 0)))); et non pas t i z
(lex.add.entry '("satisfè" nil ((("s" "a") 0) (("t" "i" "s") 0) (("f" "eh") 0))))

(lex.add.entry '("avon" nil ((("a")0) (("v" "ohn")0)))); et non a v oh
(lex.add.entry '("prends" nil ((("p" "rh" "ahn")0)))); et non "p" "rh" "ahn" "d"
(lex.add.entry '("rends" nil ((("rh" "ahn")0)))); et non "rh" "ahn" "d"
(lex.add.entry '("tends" nil ((("t" "ahn")0)))); et non  "ahn" "d"
(lex.add.entry '("rends" nil ((("rh" "ahn")0)))); et non  "ahn" "d"
(lex.add.entry '("vends" nil ((("v" "ahn")0)))); et non  "ahn" "d"
(lex.add.entry '("entends" nil ((("ahn")0) (("t" "ahn")0)))); et  "ahn" "d"
(lex.add.entry '("liaison" nil ((("l" "j" "eh")0) (("z" "ohn")0)))); et non l eh 
; indépendamment du pos gu 
(lex.add.entry '("épiloguié" nil ((("e") 0) (("p" "i") 0) (("l" "oh") 0) (("g" "j" "e") 0)))); et non (("g" "ehn") 0) (("e") 0))
(lex.add.entry '("épiloguâte" nil ((("e") 0) (("p" "i") 0) (("l" "oh") 0) (("g" "a" "t") 0))))

(lex.add.entry '("peine" nil ((("p" "eh" "n")0))))
(lex.add.entry '("dépecié" nil ((("d" "e")0) ((p ae)0) ((s j e)0)))); et non pas "d" "e" "p" "s" "j" "e")
(lex.add.entry '("quinze" nil ((("k" "ehn" "z")0)))); et non pas "k" "ehn" "n" "z"
(lex.add.entry '("queneau" nil ((( k ae)0) ((n o)0)))); et non pas k n o lts
(lex.add.entry '("combattant" nil ((("k" "ohn") 0) (("b" "a") 0) (("t" "ahn") 0)))); et non ps t t ?
(lex.add.entry '("sous_marin" nil ((("s" "u" ) 0) (("m" "a") 0) (("rh" "ehn") 0))))

(lex.add.entry '("anti_sous_marin" nil ((("ahn") 0) (("t" "i") 0) (("s" "u" ) 0) (("m" "a") 0) (("rh" "ehn") 0))))
(lex.add.entry '("aide_infirmière" nil ((("eh")0)(("d" "ehn") 0) (("f" "i" "rh") 0) (("m" "j" "eh" "rh") 0))))
(lex.add.entry '("aide_infirmier" nil ((("eh")0)(("d" "ehn") 0) (("f" "i" "rh") 0) (("m" "j" "e") 0))))
(lex.add.entry '("infirmier" nil ((("ehn") 0) (("f" "i" "rh") 0) (("m" "j" "e") 0))))

(lex.add.entry '("suivi" nil ((("s" "hw" i) 0) ((v i)0)))) ; et non pas s hw
(lex.add.entry '("sui" nil ((("s" "hw" i) 0)))) ; et non pas s hw
(lex.add.entry '("pui" nil ((("p" "hw" i) 0)))); et non pas p hw
(lex.add.entry '("depui" nil ((("d" "ae")0) (("p" "hw" i) 0))))
(lex.add.entry '("puisse" nil ((("p" "hw" i s) 0)))); et non pas p hw
(lex.add.entry '("cuisse" nil ((("k" "hw" i s) 0)))); et non pas p hw
(lex.add.entry '("cuisine" nil ((("k" "hw" i ) 0) ((z i n)0)))); et non pas p hw
(lex.add.entry '("après_coup" nil ((( a)0) ((p rh eh)0) ((k u)0))))
(lex.add.entry '("-" nil nil))
(lex.add.entry '("procè" nil ((("p" "rh" "o")0) ((s eh)0)))) 
(lex.add.entry '("enfants_ci" nil ((("ahn") 0) (("f" "ahn") 0) (("s" "i") 0))))
(lex.add.entry '("immoral" nil ((("i") 0) (("m" "oh") 0) (("rh" "a" "l") 0))))
(lex.add.entry '("immoralité" nil ((("i") 0) (("m" "oh") 0) (("rh" "a") 0) (("l" "i") 0) (("t" "e") 0))))
;;;(lex.add.entry '("prends-en_VER" VER ((("p" "rh" "ahn") 0) (("z" "ahn") 0))))
(lex.add.entry '("prends-en" nil ((("p" "rh" "ahn") 0) (("z" "ahn") 0))))
(lex.add.entry '("sers-en" nil ((("s" "eh" "rh") 0) (("z" "ahn") 0))))

; à entraîner
(lex.add.entry '("deu" ADJ:num ((("d" "eu") 0))))
(lex.add.entry '("cabus" nil(((k a)0)((b y)0)))) ; chou

(lex.add.entry '("française" nil ((("f" "rh" "ahn")0)(("s" "eh" "z")0))))
(lex.add.entry '("français" nil ((("f" "rh" "ahn")0)(("s" "eh")0))))
(lex.add.entry '("soeur" nil ((("s" "oe" "rh") 0))))
(lex.add.entry '("coeur" nil ((("k" "oe" "rh") 0))))

(lex.add.entry '("trop" nil ((("t" "rh" "o") 0))))

; dont les apostrophes
;(lex.add.entry '("votr_ami" nil ((("v" "oh") 0) (("t" "rh" "a") 0) (("m" "i") 0))))
(lex.add.entry '("n_importe_quoi" nil  (((n ehn)0) ((p oh rh)0) ((t ae)0) ((k w a)0))))
(lex.add.entry '("gagne_t_il" nil ((("g" "a") 0) (("jg" "ae") 0) (("t" "i" "l") 0))))
(lex.add.entry '("t_il" nil ((("t" "i" l)0))))
    ; prime-sautier 
(lex.add.entry '("prime_sautier" nil (((p rh i m)0)((s o)0)((t j e)0))))
(lex.add.entry '("prime_sautière" nil (((p rh i m)0)((s a)0)((t j eh rh)0))))
(lex.add.entry '("quelques_un" nil (((k e l)0)((k ae)0)((z ehn)0))))
; les tirets
; s'assurer d'une lts correcte
; wordroot de livre-ci ou l'imposer 
;(lex.add.entry '("livre_ci" nil ((("l" "i") 0) (("v" "rh" "ae") 0) (("s" "i") 0))));
(lex.add.entry '("celle_ci" nil ((("s" "eh" "l")0)(("s" "i")0))))
(lex.add.entry '("enfant_ci" nil ((("ahn")0)((f ahn)0)(("s" "i")0))))

(lex.add.entry '("crois-moi" nil  (((k rh w a)0) ((m w a)0))))
(lex.add.entry '("donne-moi" nil  (((d oh n)0) ((m w a)0))))

; incorrect mais courant
(lex.add.entry '("votera-t-il" nil (((v oh)0)((t ae)0)((rh a)0)((t i l)0))))
; ....

(lex.add.entry '("soixante_et_un" nil ((("s" "w" "a") 0) (("s" "ahn") 0) (("t" "e")0)(("oen") 0))))
(lex.add.entry '("quelqu_un" nil ((("k" "e" "l") 0) (("k" "ehn") 0))))



(lex.add.entry '("manquerè" nil ((("m" "ahn") 0) (("k" "ae") 0) (("rh" "eh") 0))))
(lex.add.entry '("resterè" nil ((("rh" "eh" "s") 0) (("t" "ae") 0) (("rh" "eh") 0))))
(lex.add.entry '("serè" nil (((s ae) 0) (("rh" "eh") 0))))

;; pour voir
(lex.add.entry '("rations_nou" nil ((("rh" "a") 0) (("t" "j" "ohn") 0) (("n" "u") 0))))
(lex.add.entry '("portions_nou" nil ((("p" "oh" "rh") 0) (("t" "j" "ohn") 0) (("n" "u") 0))))
(lex.add.entry '("ration_VER" "VER" ((("rh" "a") 0) (("t" "j" "ohn") 0))))


(lex.add.entry '("tout_autant" ADV (((t u)0)((t o)0)((t ahn)0))))
(lex.add.entry '("qui" nil ((("k" "i") 0))))

(lex.add.entry '("jeu" nil ((("zh" "eu") 0))))
; fautif voire récalcitrant
(lex.add.entry '("abrupti" nil ((("a") 0) (("b" "rh" "y") 0) (("t" "i") 0))))
(lex.add.entry '("a_t_il" nil ((("a") 0) ((t "i" "l") 0))))
(lex.add.entry '("y_a_t_il" nil ((("j"  "a") 0) (("t" "i" "l") 0))))

(lex.add.entry '("d_oeil" nil ((("d" "oe" "j" pau) 0))))
(lex.add.entry '("oeil" nil ((("oe" "j" pau) 0))))


(lex.add.entry '("C"  "NOM" ((("s" "e")0))))
      
(lex.add.entry '("gêne" nil (((zh eh n)0))))


; pour va-t-en-guerre
(lex.add.entry '("t_en_guerre" nil ((("t" ahn )0) (("g" "eh" "rh") 0))))

; dû bug (ex) postlex moyen moyen orient
(lex.add.entry '("moyen_orient" nil ((("m" "w" "a") 0) (("j" "eh") 0) (("n" "oh") 0) (("rh" "j" "ahn") 0))))



(lex.add.entry '("corps_NOM" NOM ((("k" "oh" "rh") 0))))
