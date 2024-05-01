(defvar verbose_addendas)
(if verbose_addendas (format t "addenda_refractaire.scm loaded"))

(lex.add.entry '("des_ART:ind" "ART:ind" (((d e)0))))

(lex.add.entry '("adj" NOM ((("a") 0) (("d" "zh" "eh" "k") 0) (("t" "i" "f") 0))))
(lex.add.entry '("fr" nil ((( "eh" "f")0) ((eh "rh") 0))))
(lex.add.entry '("http" nil (((a sh)0) ((t e)0)((t e)0)((p e)0))))
(lex.add.entry '("https" nil (((a sh)0) ((t e)0)((t e)0)((p e)0) (eh s)0)))
(lex.add.entry '("ftp" nil (((eh f)0) ((t e)0) ((p e)0))))
(lex.add.entry '("ftps" nil (((eh f)0) ((t e)0) ((p e)0) ((eh s)0))))
(lex.add.entry '("mail" nil (((m eh l)0))))
(lex.add.entry '("axe" nil (((a k s)0)))); et non  ("a" "g" "z"
(lex.add.entry '("etc" nil (((eh t)0) ((s e)0) ((t e)0) ((rh a)0))))
(lex.add.entry '("Ier" NOM (((p rh ae)0) ((m j e)0))))

(lex.add.entry '("Ière" NOM (((p rh ae)0) ((m j eh rh)0))))
(lex.add.entry '("B" NOM (((b e)0)))); vitamine B12
(lex.add.entry '("prends_en" nil (((p rh ahn)0) ((z ahn)0))))
(lex.add.entry '("." SENT (((pau)0))))
(lex.add.entry '("_o" nil (((d ae)0)((g rh e)0))))
(lex.add.entry '("RATP" nil (((eh rh)0)((a)0 ) ((t e)0) ((p e)0))))
(lex.add.entry '("dix_NOM" NOM (((d i s)0))))
(lex.add.entry '("supporter_NOM" NOM (((s y)0)((p oh rh)0) ((t oe rh)0))))
(lex.add.entry '("(" nil (((pau pau pau)0))))
(lex.add.entry '(")" nil (((pau pau pau)0))))
;(lex.add.entry '("(" nil (((z y t)0))))
(lex.add.entry '("messieur" nil (((m e)0)((s j eu)0))))

(lex.add.entry '("tous_PRO:ind" PRO:ind (((t u s)0))))
(lex.add.entry '("obscure" nil ((("oh" "p") 0) (("s" "k" "y" "rh") 0))))

(lex.add.entry '("êtes_vou" nil ((("eh" "t") 0) (("v" "u") 0)))); et non pas t eh s v u
(lex.add.entry '("aigres_dou" nil ((("eh" "g" "rh") 0) (("d" "u") 0)))); et non eh" "g" "rh" "eh" "s" "d" "u
(lex.add.entry '("escient" nil (((eh)0)((s j ahn)0))))
(lex.add.entry '("n_est_ce_pas" nil (((n eh s)0) ((p a)0)))) 
(lex.add.entry '("gloup" nil (((g l u p s)0))))
(lex.add.entry '("innocent" ADJ ((("i")0) (("n" "oh")0) (( "s" "ahn")0))))
(lex.add.entry '("bonheur" nil ((("b" "oh")0) (( "n" "oe" "rh")0))))
(lex.add.entry '("sphinx" nil (((s f ehn k s)0))))
(lex.add.entry '("lynx" nil (((l ehn k s)0))))
(lex.add.entry '("larynx" nil ((("l" "a")0) (( rh ehn k s)0))))

(lex.add.entry '("Hz" nil (((eh rh t z)0))))
(lex.add.entry '("kHz" nil (((k i)0)((l o)0)((eh rh t z)0))))

(lex.add.entry '("août" nil (((u t)0))))
(lex.add.entry '("poecile" nil (((p eh)0)((s i l)0))))
(lex.add.entry '("carousel" nil ((("k" "a") 0) (("rh" "u") 0) (("s" "eh" "l") 0))))
(lex.add.entry '("carrousel" nil ((("k" "a") 0) (("rh" "u") 0) (("s" "eh" "l") 0))))
(lex.add.entry '("sans_PRE" "PRE" (((s ahn)0)))) 
(lex.add.entry '("ok" nil (((o)0) ((k eh)0))))
(lex.add.entry '("huit" "PRO:ind" ((( hw i t)0))))
(lex.add.entry '("ces_ADJ:dem" ADJ:dem ((( s e )0))))
(lex.add.entry '("n_o" nil (((n y)0) ((m e )0) (( rh o)0))))
(lex.add.entry '("dessu" nil (((d ae)0) ((s y) 0))))
(lex.add.entry '("pardessu" nil (((p a rh)0) ((d ae)0) ((s y) 0))))
(lex.add.entry '("par_dessu" nil ((("p" "a" "rh") 0) (("d" "ae") 0) (("s" "y") 0))))
(lex.add.entry '("d_argent" nil (((d a rh)0) ((zh ahn)0))))

(lex.add.entry '("l_argent" nil (((l a rh)0) ((zh ahn)0))))

(lex.add.entry '("d_argent_VER" VER (((d a rh)0) ((zh ahn)0)))); erreur tokenizer ???
(lex.add.entry '("c_est_à_dire" nil ((( s eh)0) ((t a )0) (( d i rh)0))))
(lex.add.entry '("quant_à_PRE" "PRE" (((k ahn)0) ((t a) 0))))
(lex.add.entry '("fils_fis_NOM" "NOM" (((f i s)0))))
(lex.add.entry '("sens_NOM" NOM ((("s" "ahn" "s") 0))))
(lex.add.entry '("sens_VER" VER ((("s" "ahn") 0))))
(lex.add.entry '("les" "ADJ:def" (((l e)0))))
; insuffisant à cause du s final (lex.add.entry '("les" "PRO:per" (((l e)0))))
; il nous faut
(lex.add.entry '("les_PRO:per" "PRO:per" (((l e)0))))


; mots pour lesquels on ne recherchera pas à accomoder la lts
; à intégrer dans le dico si pas de homographes
(lex.add.entry '("vient_VER" "VER" (((v j ehn)0)))); pb homographes ;(
(lex.add.entry '("advient_VER" "VER" (((a d)0)((v j ehn)0)))); pb homographes ;(
(lex.add.entry '("revient_VER" "VER" (((rh ae)0)((v j ehn)0))))
(lex.add.entry '("qu_obtient_on" nil (((k oh p)0)((t j ehn)0)((t ohn)0))))
(lex.add.entry '("qu_obtient_il" nil (((k oh p)0) ((t j ehn)0) ((t i l)0))))
(lex.add.entry '("qu_obtient_elle" nil (((k oh p)0)((t j ehn)0)((t eh l)0))))
(lex.add.entry '("obtient_VER" "VER" (((oh b)0)((t j ehn)0))))
(lex.add.entry '("devient_VER"  "VER" (((d ae)0)((v j ehn)0))))
(lex.add.entry '("tient_VER"  "VER" (((t j ehn)0))))
(lex.add.entry '("soutient_VER"  "VER" (((s u)0)((t j ehn)0))))
(lex.add.entry '("retient_VER"  "VER" (((rh ae)0)((t j ehn)0))))
(lex.add.entry '("obtient_VER"  "VER" (((oh b)0)((t j ehn)0))))
(lex.add.entry '("maintient_VER"  "VER" (((m ehn)0)((t j ehn)0))))
(lex.add.entry '("détient_VER"  "VER" (((d e)0)((t j ehn)0))))
(lex.add.entry '("contient_VER"  "VER" (((k ohn)0)((t j ehn)0))))
(lex.add.entry '("appartient_VER"  "VER" (((a)0)((p a rh)0)((t j ehn)0))))
(lex.add.entry '("devient_VER"  "VER" (((d ae)0)((t j ehn)0))))
(lex.add.entry '("vient_VER"  "VER" (((v j ehn)0))))
(lex.add.entry '("circonvient_VER"  "VER" (((s i rh)0)((k ohn)0)((v j ehn)0))))
(lex.add.entry '("contrevient_VER"  "VER" (((k ohn)0)((t rh ae)0)((v j ehn)0))))
(lex.add.entry '("convient_VER"  "VER" (((k ohn)0)((v j ehn)0)))); pb homographes ;'
(lex.add.entry '("intervient_VER"  "VER" (((ehn)0)((t eh rh)0)((v j ehn)0))))
(lex.add.entry '("parvient_VER"  "VER" (((p a rh)0)((v j ehn)0))))
(lex.add.entry '("provient_VER"  "VER" (((p rh o)0)((v j ehn)0))))
(lex.add.entry '("prévient_VER"  "VER" (((p rh e)0)((v j ehn)0))))
(lex.add.entry '("redevient_VER"  "VER" (((rh ae)0)((d ae)0)((v j ehn)0))))
(lex.add.entry '("revient_VER"  "VER" (((rh ae)0)((v j ehn)0))))
(lex.add.entry '("souvient_VER"  "VER" (((s u)0)((v j ehn)0))))
(lex.add.entry '("subvient_VER"  "VER" (((s y b)0)((v j ehn)0))))
(lex.add.entry '("survient_VER"  "VER" (((s y rh)0)((v j ehn)0))))
(lex.add.entry '("abstient_VER"  "VER" (((a b s)0)((t j ehn)0))))
(lex.add.entry '("appartient_VER"  "VER" (((a)0)((p a rh)0)((t j ehn)0))))
(lex.add.entry '("contient_VER"  "VER" (((k ohn)0)((t j ehn)0))))

(lex.add.entry '("fier_ADJ" "ADJ" ((("f" "j" "eh" "rh")0))))
(lex.add.entry '("as_NOM" "NOM" (((a s)0))))
(lex.add.entry '("mécontent" "ADJ" (((m e)0)((k ohn)0)((t ahn)0))))
(lex.add.entry '("d_argent" nil (((d "a" "rh") 0)(("zh" "ahn") 0))))
(lex.add.entry '("heure" NOM ((("oe" "rh")0)))); pourquoi pas dans le dico ?
(lex.add.entry '("l_hiver" NOM (((l i)0)((v eh rh)0))))
(lex.add.entry '("oeuf_NOM" NOM  ((("oe" "f") 0))))
(lex.add.entry '("un" "ART:ind" ((("oen")0))))

(lex.add.entry '("oeufs_NOM" NOM  ((("eu") 0))))
(lex.add.entry '("boeufs_NOM" "NOM"  (((b "eu") 0))))
(lex.add.entry '("neuf_ADJ" "ADJ" ((("n" "oe" f) 0))))

(lex.add.entry '("maïs" nil (((m a)0)((i s)0))))
(lex.add.entry '("haï" nil ((( a )0)((i)0))))
; etc ..
; où: PRO:REL ou CON
; pas suffisant
;(lex.add.entry '("jusqu_où_nil" nil (((zh y s)0)((k u)0))))
(lex.add.entry '("jusqu_où_CON" "CON" (((zh y s)0)((k u)0))))
(lex.add.entry '("jusqu_à_PRE" "PRE" (((zh y s)0)((k a)0))))

(lex.add.entry '("jusqu_où_PRO:rel" "PRO:rel" (((zh y s)0)((k u)0)))); hmm ?


(lex.add.entry '("À" nil (((a)0)))); ou norm
(lex.add.entry '("adam" nil ((("a")0)(("d" "ahn")0))))


(lex.add.entry '("clef" nil (((k l e)0))))
(lex.add.entry '("yeu" nil ((("z" "j" "eu")0))));;MAGOUILLE

; ne suffit pas (lex.add.entry '("ceux-ci" nil ((("s" "eu")0)(("s" "i")0))))
(lex.add.entry '("ceux-ci_PRO:dem" PRO:dem ((("s" "eu")0)(("s" "i")0))))
; plus variante
; recoup INST_LANG_foreign
; faire distingo ? francisé ou calqué 
; Certains patronymes ne prennent pas l’accent aigu sur le e, en dépit
; de la prononciation [é] à ajouter dans l'adenda spécialisé "NOM" propre (actuellement foreign)
(lex.add.entry '("Etat" nil (((e)0)((t a)0))))
(lex.add.entry '("Ecole" nil (((e)0)((k oh l)0))))
(lex.add.entry '("Emile" nil (((e)0)((m i l)0))))
(lex.add.entry '("Eve" nil (((eh v)0))))
(lex.add.entry '("Eva" nil (((e)0)((v a)0))))


; I (lex.add.entry '("gens" nil ((("zh" "ahn") 0))))
(lex.add.entry '("gen" nil ((("zh" "ahn") 0))))

(lex.add.entry '("pays" nil (((p eh)0)((i)0))))
; (lex.add.entry '("et_CON" CON (((e)0))))
(lex.add.entry '("et" nil (((e)0))))

(lex.add.entry '("addenda" nil (((a)0) ((d ehn)0) ((d a)0))))

(lex.add.entry '("dan" "NOM" ((("d" "a" n) 0))))
(lex.add.entry '("dans" "NOM" ((("d" "a" n) 0))))

(lex.add.entry '("en" "PRE" ((("ahn")0))))
(lex.add.entry '("eut" "VER" ((("y")0))))
(lex.add.entry '("eut" "AUX" ((("y")0))))

(lex.add.entry '("c" "PRO:dem"  nil))
(lex.add.entry '("d" "PRE" nil))
(lex.add.entry '("l" "ART:def" nil))
(lex.add.entry '("s" "PRO:per" nil))

(lex.add.entry '("c_est" nil  ((("s" "eh") 0))))
(lex.add.entry '("qu_est_ce" "VER" (((k eh s)0))))
(lex.add.entry '("qu_es" "VER" (((k eh)0)))); à cause du s final

(lex.add.entry '("qu_aucun" nil (((k o)0)((k oen)0))))
(lex.add.entry '("qu_un_PRO:per" PRO:per (((k oen)0))))


; (lex.add.entry '("j" nil nil))
; (lex.add.entry '("l" nil nil))
; (lex.add.entry '("m" nil nil))

(lex.add.entry '("t" nil nil))

(lex.add.entry '("où" nil (((u)0))))

; s finaux
(lex.add.entry '("s_NOM" "NOM" (((eh s)0))))
(lex.add.entry '("hélas_ONO" "ONO" (((e)0)((l a s)0)))); hélas VER

(lex.add.entry '("redevient_VER" "VER" (((rh ae)0)((d ae)0)((v j ehn)0))));  sans avoir besoin d'un wordroot spécial

;; seul nom en question se prononçant t j ohn
(lex.add.entry '("question" nil ((("k" "eh" "s") 0) (("t" "j" "ohn") 0))))


; artifice pour les mots singulier se terminant par us et se prononçant y s
; tant que les pluriels ne sont pas cherchés ! donc pour un certain temps...
; au contraire ceux se prononçant u seront (en général) trouvés par la lts bien entrainée
; HYPOTHÈSE1 du lex
(lex.add.entry '("processu" nil  ((("p" "rh" "oh")0)(("s" e)0)(("s" "y" s)0))))
(lex.add.entry '("prospectu" nil  ((("p" "rh" "oh" s)0)(("p" eh k)0)(("t" "y" s)0))))
(lex.add.entry '("détritu" nil  (((d e)0)((t rh i)0)(("t" "y" s)0)))); mot singulier
(lex.add.entry '("infarctu" nil  (((ehn)0)((f a rh k)0)(("t" "y" s)0))));
(lex.add.entry '("versu" nil(((v eh rh)0)((s y s)0)))) ; 
(lex.add.entry '("hiatu" nil(((j a)0)((t y s)0))))
(lex.add.entry '("bibliobu" nil(((b i)0)((b l j o)0)((b y s)0))))
(lex.add.entry '("bus_NOM" "NOM" (((b y s)0))))
(lex.add.entry '("consensu" nil((("k" "ohn")0)(("s" "ahn")0)(("s" "y" "s")0))))
(lex.add.entry '("blocu" nil(((b l oh)0)((k y s)0))))
(lex.add.entry '("campu" nil(((k ahn)0)((p y s)0))))
(lex.add.entry '("choru" nil(((k oh)0)((rh y s)0))))
(lex.add.entry '("crocu" nil(((k rh oh)0)((k y s)0))))
(lex.add.entry '("phallu" nil(((f a)0)((l y s)0))))
(lex.add.entry '("clausu" nil(((k l o)0)((z y s)0))))
(lex.add.entry '("collapsu" nil(((k oh)0)((l a "p")0)((s y s)0))))
(lex.add.entry '("cubitu" nil(((k y)0)((b i)0)((t y s)0))))
(lex.add.entry '("cirru" nil(((s i)0)((rh y s)0))))
(lex.add.entry '("mésu" nil(((m e)0)((z y s)0))))
(lex.add.entry '("bonu" nil(((b oh)0)((n y s)0))))
(lex.add.entry '("nimbu" nil(((n ehn)0)((b y s)0))))
(lex.add.entry '("cactu" nil(((k a k)0)((t y s)0))))


(lex.add.entry '("les" nil (((l e)0))))
(lex.add.entry '("des" nil (((d e)0))))
(lex.add.entry '("ces" nil (((s e)0))))

; contredisant les ess initiaux et les ess* finaux

(lex.add.entry '("ressource" "NOM" ((("rh" "ae") 0) (("s" "u" "rh" "s") 0))))


; non respect VsV
(lex.add.entry '("parasol" "NOM" (((p a)0)((rh a)0) ((s oh l )0))))
(lex.add.entry '("aérosol" "NOM" (((a)0) ((e)0) ((rh o)0) ((s oh l )0))))
; prime-sautier
(lex.add.entry '("primesautier_ADJ" ADJ (((p rh i m)0)((s o)0)((t j e)0))))
(lex.add.entry '("primesautière_ADJ" ADJ (((p rh i m)0)((s o)0)((t j eh rh)0))))

(lex.add.entry '("tous_ADJ:ind" "ADJ:ind" (((t u s) 0))))


; exceptions notoires
(lex.add.entry '("femme" "NOM" ((("f" "a" "m") 0))))
(lex.add.entry '("monsieur_NOM" "NOM"  (((m ae)0)((s j eu)0))))

(lex.add.entry '("chefs_d_oeuvre" nil ((("sh" "eh") 0) (("d" "oe" "v" "rh") 0)))); et non sh" "e" "f" "z
(lex.add.entry '("chef_d" nil ((("sh" "eh" "f" "d")0)))) ; pour chef-d'oeuvre

(lex.add.entry '("examen" "NOM" (((eh g)0)((z a)0)((m ehn)0))))
(lex.add.entry '("lumbago" "NOM" (((l oe m)0)((b a)0)((g o)0))))
(lex.add.entry '("réexamen_NOM" nil (((rh e)0)((eh g)0)((z a)0)((m ehn)0))))
(lex.add.entry '("antienne_NOM" nil (((ahn)0)((s j eh n)0))))
(lex.add.entry '("lundi" "NOM" (((l oen)0)((d i)0))))
(lex.add.entry '("faciès" "NOM" ((("f" "a") 0) (("s" "j" "eh" "s") 0))))
(lex.add.entry '("cul" "NOM" (((k y)0))))
(lex.add.entry '("cul_bas" nil ((("k" "y") 0) (("b" "a") 0))))
(lex.add.entry '("cul_nu" nil ((("k" "y") 0) ((n y) 0))))
(lex.add.entry '("cul_blanc" nil ((("k" "y") 0) (("b" "l" ahn) 0))))
; etc. cul-de-poule
(lex.add.entry '("assez_ADV" ADV (((a)0)((s e)0))))


; en dico pour simplification de lts *end: pas sûr

(lex.add.entry '("prend" nil (((p rh ahn) 0))))


(lex.add.entry '("weber" nil ((( v e)0)((b eh rh)0)))) 
(lex.add.entry '("panzer" nil(((p ahn)0)((z eh rh)0))))
(lex.add.entry '("corner" nil (((k oh rh)0)(( n eh rh)0))))
(lex.add.entry '("booster" "NOM" ((( b u )0)(( s t eh rh)0)))) 
(lex.add.entry '("cocker" nil (((k oh)0)((k eh rh)0))))
(lex.add.entry '("cosy" nil (((k oh)0)((z i)0))))
(lex.add.entry '("kaiser" nil (((k a j)0)((z eh rh)0))))
(lex.add.entry '("cuiller" "NOM" (((k hw i)0)((j eh rh)0))))
(lex.add.entry '("quaker" nil (((k w a)0)((k eh rh)0))))
(lex.add.entry '("docker" "NOM" (((d oh)0)((k eh rh)0))))
(lex.add.entry '("laser" nil (((l a )0)((z eh rh)0))))
(lex.add.entry '("gyrolaser" nil (((zh i)0)((rh o)0)((l a )0)((z eh rh)0))))
(lex.add.entry '("tanker" "NOM" (((t ahn)0)((k eh rh)0))))
(lex.add.entry '("hier" "NOM" (((j eh rh)0))))
(lex.add.entry '("bécher" "NOM" (((b e sh eh rh)0))))
(lex.add.entry '("junker" "NOM" (((d zh oen)0)((k eh rh)0))))

(lex.add.entry '("essuietout" nil (((e)0)((s hw i)0)((t u)0))))
(lex.add.entry '("guerilla" "NOM" (((g e)0)((rh i)0)((j a)0))))
(lex.add.entry '("abbaye" nil (((a)0)((b e)0)((i)0))))


(lex.add.entry '("acupuncteur" nil (((a)0)((k y)0)((p ohn k)0)((t oe rh)0))))

;; comme au singulier
(lex.add.entry '("douce_amère_nil" nil ((("d" "u" "s") 0) (("a") 0) (("m" "eh" "rh") 0)))) ; exc mais avec tiret
(lex.add.entry '("douces_amères_ADJ" "ADJ" ((("d" "u" "s") 0) (("a") 0) (("m" "eh" "rh") 0)))) 

(lex.add.entry '("doux_amer" nil ((("d" "u" ) 0) (("a") 0) (("m" "eh" "rh") 0)))) 
(lex.add.entry '("balsamique_ADJ" "ADJ" ((("b" "a" "l") 0) (("z" "a") 0) (("m" "i" "k") 0)))); exc

(lex.add.entry '("agenda" nil (((a)0)((zh ehn)0)((d a)0)))); exc 
(lex.add.entry '("antarctique" nil (((ahn)0)((t a rh k)0)((t i k)0))))
(lex.add.entry '("antitabac" nil (((ahn)0)((t i)0)((t a)0)((b a)0))))
(lex.add.entry '("baby" nil (((b e b i)0)))); papy
(lex.add.entry '("banjo" nil (((b ahn)0)(( d zh o)0))))
(lex.add.entry '("boomerang" nil (((b u m)0)((rh ahn g)0))))
(lex.add.entry '("bowling" nil (((b u)0)((l i n g)0))))
(lex.add.entry '("break" nil (((b rh eh k)0)))) ; tie break breakfast
(lex.add.entry '("building" nil (((b y l)0)((d i n g)0))))
(lex.add.entry '("bungalow" nil (((b oen)0)((g a)0)((l o)0))))
(lex.add.entry '("clown" nil (((k l u n)0))))
(lex.add.entry '("clownerie" nil (((k l u n)0)((rh i)0))))
(lex.add.entry '("clownesse" nil (((k l u)0)((n eh s)0))))
(lex.add.entry '("crawl" nil (((k rh o l)0))))
;
(lex.add.entry '("daim" "NOM" (((d ehn)0))))
(lex.add.entry '("essaim" nil (((e s ehn)0))))
(lex.add.entry '("faim" "NOM" (((f ehn)0))))
(lex.add.entry '("haim" "NOM" (((h ehn)0))))
;
(lex.add.entry '("express" nil (((eh k s)0)((p rh eh s)0)))); express

(lex.add.entry '("flamenco" nil (((f l a)0)((m eh n)0)((k o)0))))
(lex.add.entry '("fuchsia" nil (((f y)0)((sh j a)0))))
(lex.add.entry '("goal" nil (((g o l)0))))
(lex.add.entry '("hindi" nil (((i n)0)((d i)0))))
(lex.add.entry '("igloo" nil (((i)0)((g l u)0))))
(lex.add.entry '("interview" nil (((ehn)0)((t eh rh)0)((v j u)0))))
(lex.add.entry '("jaguar" nil (((zh a)0)((g w a rh)0))))
(lex.add.entry '("kayak" nil (((k a j a k)0))))
(lex.add.entry '("lady" nil (((l e d i)0))))
(lex.add.entry '("mademoiselle" nil (((m a d)0)((m w a)0)((z eh l)0))))
(lex.add.entry '("mesdame" nil (((m e)0)((d a m)0))))
(lex.add.entry '("milady" nil (((m i)0)((l e)0)((d i)0))))
(lex.add.entry '("parvien" nil (((p a rh v j ehn)0))))

(lex.add.entry '("puy" nil (((p hw i)0))))
(lex.add.entry '("quaternaire" nil (((k w a)0)((t eh rh)0)((n eh rh)0))))
(lex.add.entry '("scrabble" nil (((s k rh a)0)((b oe l)0))))
(lex.add.entry '("solennel" nil (((s oh)0)((l a)0)((n eh l)0))))
(lex.add.entry '("solennelle" nil (((s oh)0)((l a)0)((n eh l)0))))
(lex.add.entry '("speakerine" nil (((s p i)0)((k rh i n)0))))
(lex.add.entry '("stand" nil (((s t ahn d)0))))
(lex.add.entry '("steak" nil (((s t eh k)0))))
(lex.add.entry '("surf" nil (((s oe rh f)0))))

(lex.add.entry '("thym" nil (((t ehn)0))))
(lex.add.entry '("toast" nil (((t o s t)0))))
(lex.add.entry '("tomahawk" nil (((t oh)0)((m a)0)((o k)0))))
(lex.add.entry '("travelling" nil (((t rh a)0)((v l i n g)0))))
(lex.add.entry '("varech" nil (((v a)0)((rh eh k)0))))
(lex.add.entry '("zinc" nil (((z ehn g)0))))

(lex.add.entry '("enfer" nil (((ahn)0)((f eh rh)0))))
(lex.add.entry '("éther" nil (((e)0)((t eh rh)0)))) ; TODO
(lex.add.entry '("machefer" nil (((m a sh)0)((f eh rh)0))))

(lex.add.entry '("outremer" nil (((u t rh)0)((m eh rh)0))))
(lex.add.entry '("lever" nil (((l ae)0)((v e)0))))

(lex.add.entry '("secreta" nil (((s ae)0)((k rh ae)0)(( t a)0))))


(lex.add.entry '("brayant" nil (((b rh a)0)((j ahn)0))))
(lex.add.entry '("oseille" nil (((o)0)((z eh j)0))))
(lex.add.entry '("techtonique" nil (((t eh k)0)((t o)0)((n i k)0))))


(lex.add.entry '("penalty" nil (((p e)0)((n a l)0)((t i)0))))
(lex.add.entry '("ailé" nil (((eh )0)((l e)0))))
(lex.add.entry '("ailée" nil (((eh )0)((l e)0))))

(lex.add.entry '("auroch" nil (((o)0)((rh oh k)0))))
(lex.add.entry '("l_auroch" nil (((l o)0)((rh oh k)0))))
(lex.add.entry '("abrupt" nil (((a)0)((b rh y p t)0))))

(lex.add.entry '("gadget" nil (((g a d)0)((zh eh t)0))))
(lex.add.entry '("yaourt" nil (((j a )0)((u rh t)0))))


(lex.add.entry '("j_en" "PRO:ind" ((("zh" "ahn") 0))))
(lex.add.entry '("m_en" "PRO:ind" ((("m" "ahn") 0)))); et non m ehn
(lex.add.entry '("t_en" "PRO:ind" ((("t" "ahn") 0))))
(lex.add.entry '("s_en" "PRO:ind" ((("s" "ahn") 0))))
(lex.add.entry '("l_en" "PRO:ind" ((("l" "ahn") 0))))


(lex.add.entry '("c_est" "VER" ((("s" "eh") 0))))
(lex.add.entry '("n_est" "VER" ((("n" "eh") 0))))

;; chef_d_oeuvre


; orthographe incorrecte


; essai 

 (lex.add.entry '("l_atlas" nil ((("l" "a") 0) (("t" "l" "a") 0)))); à cause du s
 
 (lex.add.entry '("corps_et_âmes" nil ((("k" "oh" "rh") 0) ((z e) 0) (("a" "m") 0))))
  (lex.add.entry '("corps_et_âme" nil ((("k" "oh" "rh") 0) ((e) 0) (("a" "m") 0)))) ; subtils !
