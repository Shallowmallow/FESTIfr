(defvar verbose_addendas)
(if verbose_addendas (format t "INST_LANG_addenda_locutions.scm loaded"))

(lex.add.entry '("chefs_lieu" nil ((("sh" "e" "f") 0) (("l" "j" "eu") 0))))
(lex.add.entry '("chef_lieu" nil ((("sh" "e" "f") 0) (("l" "j" "eu") 0))))

; TODO XXX p.e distinguer locutions dont la prise en considération ne change que le POS et pas seulement la prononciation 
(lex.add.entry '("ad_hoc" nil ((("a") 0) (("d" "oh" "K") 0))))
(lex.add.entry '("années_homme" nil ((("a") 0) (("n" "e") 0) (("oh" "m") 0))))
; ex acquit_à_caution, after_shave
(lex.add.entry '("best_seller" NOM ((("b" "eh" "s" "t") 0) (("s" "eh") 0) (("l" "eh" "rh") 0))))
(lex.add.entry '("boxer_short" nil ((("b" "oh" "k") 0) (("s" "eh" "rh") 0) (("sh" "oh" "rh" "t") 0))))
(lex.add.entry '("procès_verbal" nil ((("p" "rh" "oh") 0) (("s" "eh") 0) (("v" "eh" "rh") 0) (("b" "a" "l") 0))))
(lex.add.entry '("être_là" nil (((eh) 0) ((t rh ae)0) ((l a)0))))
; pour voir
(lex.add.entry '("être-ci" nil (((eh) 0) ((t rh ae)0) ((k w a)0))))

(lex.add.entry '("beaux_enfant" nil ((("b" "o")0) (("z" "ahn")0) (("f" "ahn")0))))
(lex.add.entry '("beaux_fil" nil ((("b" "o")0) (("f" "i" "s")0))))
(lex.add.entry '("beaux_art" nil ((("b" "o")0) (("z" "a" "rh")0))))

(lex.add.entry '("yeu" nil ((("z" "j" "eu")0))));;MAGOUILLE pare le pb de y non voyelle, exclus de ref TODO

(lex.add.entry '("doux_jésus" nil ((("d" "u" ) 0) (("zh" "e") 0) (("z" "y") 0)))); et non pas d u k s
; doux-amer est dans poslex.scm comme ADJ
(lex.add.entry '("doux-amer_ADJ" "ADJ" (((d u)0)((a)0)((m eh rh)0))))

(lex.add.entry '("un_à_un" nil (((oen) 0) ((n a)0) ((oen)0))))

;;; ex netlex_addenda_locutions
;; locutions hors grammaticales
;; attention aux liaisons saint-esprit à 
;; pour les locutions finissant avec un "s" sonore, inscription nécessaire dans le liste 
;; list_sx_exist_and_not_always_mute de INST_LANG_token_to_words_lists
(lex.add.entry '("neuf" nil (((n oe)0))))

(lex.add.entry '("neuf_an" nil (((n oe)0)((v ahn)0))))
(lex.add.entry '("neuf_heures" nil (((n oe)0)((v oe rh)0))))
(lex.add.entry '("bons_à_rien" nil ((("b" "ohn") 0) (("a") 0) (("rh" "j" "ehn") 0))))
;; AREVOIR
(lex.add.entry '("de_plu" "ADV" (((d ae)0)((p l y)0))))


;;
(lex.add.entry '("huis_clos" nil  (((hw i)0)((k l o)0))))
(lex.add.entry '("mieux_être" nil  (((m j eu)0) ((z eh t rh)0))))


(lex.add.entry '("cinq_ADJ:num" "ADJ:num"  (((s ehn)0))))

(lex.add.entry '("nor_nor_est" ADV ((("n" "oh" "rh") 0) (("n" "oh") 0) (("rh" "eh" "s" "t") 0))))


(lex.add.entry '("a_fortiori" ADV (((a)0)((f oh rh)0)((s j oh)0)((rh i)0))))
(lex.add.entry '("en_avant" ADV (((ahn)0)((n a)0)((v ahn)0))))
(lex.add.entry '("en_suspens_ADV" "ADV" (((ahn)0)((s y s)0)((p ahn)0))))
(lex.add.entry '("en_suspens_ADJ" "ADJ" (((ahn)0)((s y s)0)((p ahn)0))))

(lex.add.entry '("acquit_à_caution" NOM (((a)0)((k i)0)((t a)0)((k o)0)((s j ohn)0))))


(lex.add.entry '("ab_initio" ADV (((a) 0) ((b i) 0) ((n i) 0) ((s j o) 0))))
(lex.add.entry '("ab_irato" ADV (((a) 0) ((b i) 0) ((rh a) 0) ((t o) 0))))
(lex.add.entry '("ab_ovo" ADV (((a) 0) ((b o) 0) ((v o) 0)))) 
;Todo
(lex.add.entry '("ad_honores" ADV (((o)0)((n o )0)((rh eh s)0))))
 ;(lex.add.entry '("ad_infinitum" ((ADV -5.907) ) () ))
 ;(lex.add.entry '("ad_libitum" ((ADV -5.297) ) () ))
 
;(lex.add.entry '("ad_patres" ADV (((a d) 0)((p a)0)((t rh eh s) 0)))); dico
  ;(lex.add.entry '("ad_rem" ((ADJ -5.297) ) () ))
  ;(lex.add.entry '("ad_usum" ((ADV -5.297) ) () ))
  ;(lex.add.entry '("ad_valorem" ((ADV -5.297) ) () ))
  

(lex.add.entry '("after_shave" NOM (((a f) 0)((t oe rh) 0)((sh eh v) 0))))

  ;(lex.add.entry '("agnus_castus" ((NOM -6.163) ) () ))
  ;(lex.add.entry '("agnus_dei" ((NOM -6.163) ) () ))

(lex.add.entry '("air_bag" NOM (((eh rh) 0) ((b a g) 0))))
(lex.add.entry '("al_dente" ADV (((a l)0) ((d ahn)0) ((t e)0))))
  ;(lex.add.entry '("al_dente" ((ADV -5.571) ) () ))
 
(lex.add.entry '("alea_jacta_est" ONO (((a) 0) ((l e) 0)((a) 0) ((zh a k) 0) ((t a) 0) ((eh s t) 0))))

  ;(lex.add.entry '("all_right" ((ADV -4.766) ) () ))
(lex.add.entry '("ampli_tuner" NOM (((ahn) 0) ((p l i) 0) ((t y )0)((n eh rh)0))))

  ;(lex.add.entry '("alter_ego" ((NOM -5.371) ) () ))
  ;(lex.add.entry '("am_stram_gram" ((ONO -4.574) ) () ))
  ;(lex.add.entry '("au_fur_et_à_mesure" ((ADV -4.794) ) () ))
(lex.add.entry '("avant_hier" ADV (((a) 0) ((v ahn) 0)((t i)0)((j eh rh)0))))
(lex.add.entry '("aux_aguet" "ADV" (((o)0) ((z a)0) ((g eh)0)))) ; pour aux aguets
  ;(lex.add.entry '("ayants_droit" ((NOM -6.561) ) () ))
  ;(lex.add.entry '("back_up" ((NOM -5.908) ) () ))
  ;(lex.add.entry '("beat_generation" ((NAM -4.889) ) () ))
  ;(lex.add.entry '("bel_canto" ((NOM -6.163) ) () ))
  ;(lex.add.entry '("belle_lurette" ((ADV -5.540) ) () ))
  ;(lex.add.entry '("best_of" ((NOM -5.632) ) () ))
  ;(lex.add.entry '("big_band" ((NOM -6.084) ) () ))
  ;(lex.add.entry '("big_bang" ((NOM -5.431) ) () ))
  ;(lex.add.entry '("birth_control" ((NOM -6.561) ) () ))
  ;(lex.add.entry '("bla_bla" ((ONO -6.038)(NOM -5.318) ) () ))
  ;(lex.add.entry '("bloody_mary" ((NOM -4.908) ) () ))
  ;(lex.add.entry '("blue_jeans" ((NOM -6.561) ) () ))
  ;(lex.add.entry '("blue_note" ((NOM -6.385) ) () ))
  ;(lex.add.entry '("boat_people" ((NOM -6.385) ) () ))
(lex.add.entry '("boat_people" nil (((b oh t) 0) ((p i)0) ((p oh l)0))))
  ;(lex.add.entry '("bubble_gum" ((NOM -6.561) ) () ))
(lex.add.entry '("by_night" nil (((b a j )0)((n a j t)0))))
  ;(lex.add.entry '("call_girl" ((NOM -6.017) ) () ))
  ;(lex.add.entry '("call_girls" ((NOM -6.385) ) () ))
  ;(lex.add.entry '("casus_belli" ((NOM -6.163) ) () ))

;(lex.add.entry '("ch_l" NOM (((sh eh f) 0) ((l j eu) 0))))
(lex.add.entry '("chef_d_oeuvre" NOM (((sh eh)0)((d eu)0)((v rh ae)0))))
(lex.add.entry '("chefs_d_oeuvre" NOM (((sh eh)0)((d eu)0)((v rh ae)0)))); pas correct mais courant
  ;(lex.add.entry '("chop_suey" ((NOM -5.716) ) () ))
  ;(lex.add.entry '("citizen_band" ((NOM -6.561) ) () ))
(lex.add.entry '("coffee_shop" NOM (((k o) 0) ((f i) 0) ((sh oh p) 0))))

  ;(lex.add.entry '("comic_book" ((NOM -6.561) ) () ))
  ;(lex.add.entry '("commedia_dell'arte" ((NOM -6.385) ) () ))
  ;(lex.add.entry '("corn_flakes" ((NOM -5.716) ) () ))
  ;(lex.add.entry '("corpus_delicti" ((NOM -6.260) ) () ))
(lex.add.entry '("cot_cot_codec" ONO (((k oh t)0)((k oh t)0)((k o)0)((d eh k)0))))
  ;(lex.add.entry '("d'ores_et_déjà" ((ADV -5.731) ) () ))
  ;(lex.add.entry '("d_abord" ((ADV -2.783) ) () ))
  ;(lex.add.entry '("d_autres" ((ADJ:ind -1.348)(PRO:ind -2.008) ) () ))
  ;(lex.add.entry '("d_emblée" ((ADV -4.937) ) () ))
  ;(lex.add.entry '("d_ores_et_déjà" ((ADV -5.731) ) () ))
  ;(lex.add.entry '("dare_dare" ((ADV -5.986) ) () ))
  ;(lex.add.entry '("de_bric_et_de_broc" ((ADV -6.083) ) () ))
  ;(lex.add.entry '("de_facto" ((ADV -5.509) ) () ))
  ;(lex.add.entry '("de_guingois" ((ADV -6.384) ) () ))
  ;(lex.add.entry '("de_plano" ((ADV -5.986) ) () ))
  ;(lex.add.entry '("de_profundis" ((NOM -6.017) ) () ))
  ;(lex.add.entry '("de_santis" ((NAM -4.646)(NOM -6.561) ) () ))
  ;(lex.add.entry '("de_traviole" ((ADV -5.363) ) () ))

(lex.add.entry '("de_visu" ADV (((d ae)0)((v i)0)((z y)0)))) 
  ;(lex.add.entry '("delirium_tremens" ((NOM -5.959) ) () ))
  ;(lex.add.entry '("della_francesca" ((NOM -5.959) ) () ))
  ;(lex.add.entry '("deo_gratias" ((NOM -6.561) ) () ))
(lex.add.entry '("deus_ex_machina" NOM (((d e)0)((u s)0)((eh k s)0)((m a)0)((sh i)0)((n a)0))))
  ;(lex.add.entry '("dies_irae" ((NOM -6.163) ) () ))
(lex.add.entry '("en_tête" ADV (((ahn) 0) ((t eh)0))))

 ; éliminé denatphon de postlex a maintenant 2 paramètres 
;;(lex.add.entry '("divin_enfant" NOM (((d i)0)((v i)0)((n ahn)0)((f ahn)0))))
 
  ;(lex.add.entry '("dream_team" ((NOM -6.017) ) () ))
  ;(lex.add.entry '("east_river" ((NAM -3.819) ) () ))
  ;(lex.add.entry '("ecce_homo" ((NOM -6.208) ) () ))
  ;(lex.add.entry '("en_catimini" ((ADV -5.571) ) () ))
  ;(lex.add.entry '("en_loucedé" ((ADV -6.083) ) () ))
(lex.add.entry '("en_catimini"  ADV (((ahn)0)((k a) 0) ((t i) 0) ((m i) 0) ((n i) 0))))
(lex.add.entry '("en_tapinois" ADV (((ahn)0)((t a) 0) ((p i) 0) ((n w a) 0))))
(lex.add.entry '("eh_bien" ONO (((eh)0)((b j ehn)0)))) 
(lex.add.entry '("est_à_dire" nil (((eh) 0) ((t a) 0) ((d i rh) 0))))
(lex.add.entry '("et_caetera" ADV (((eh t)0)((t s e)0)((t e)0)((rh a)0))))
(lex.add.entry '("et_cetera" ADV  (((eh t)0)((t s e)0)((t e)0)((rh a)0))))
(lex.add.entry '("guet_apen" NOM (((g e)0)((t a) 0) ((p ahn) 0))))


(lex.add.entry '("en_étant"  ADV (((ahn)0)((n e) 0) ((t ahn) 0))))

;(lex.add.entry '("fast_food" ((NOM -5.431) ) () ))
; (lex.add.entry '("ficatve_o'clock" ((NOM -6.561) ) () ))
; (lex.add.entry '("foreign_office" ((NAM -4.315) ) () ))
; (lex.add.entry '("gengis_khan" ((NAM -4.076) ) () ))
; (lex.add.entry '("girl_friend" ((NOM -6.561) ) () ))
; (lex.add.entry '("gna_gna" ((ONO -5.000) ) () ))
; (lex.add.entry '("grosso_modo" ((ADV -5.406) ) () ))
; (lex.add.entry '("happy_end" ((NOM -5.229) ) () ))
; (lex.add.entry '("happy_ends" ((NOM -6.084) ) () ))
; (lex.add.entry '("hard_edge" ((NOM -6.561) ) () ))
; (lex.add.entry '("has_been" ((NOM -5.318)(ADJ -5.060)( ) () ))
; (lex.add.entry '("high_life" ((NOM -6.017) ) () ))
; (lex.add.entry '("high_tech" ((ADJ -5.737) ) () ))
; (lex.add.entry '("hold_up" ((NOM -5.862) ) () ))
; (lex.add.entry '("homo_erectus" ((NOM -6.260) ) () ))
; (lex.add.entry '("hong_kong" ((NAM -3.163)(NOM -6.385) ) () ))
; (lex.add.entry '("honoris_causa" ((ADV -5.782) ) () ))
; (lex.add.entry '("hot_dog" ((NOM -4.841) ) () ))
; (lex.add.entry '("house_music" ((NOM -6.561) ) () ))
; (lex.add.entry '("ice_cream" ((NOM -6.385) ) () ))
; (lex.add.entry '("in_absentia" ((ADV -6.208) ) () ))
; (lex.add.entry '("in_extremis" ((ADV -5.782) ) () ))
; (lex.add.entry '("in_memoriam" ((ADV -5.907) ) () ))
; (lex.add.entry '("in_pace" ((NOM -6.260) ) () ))
; (lex.add.entry '("in_utero" ((ADJ -5.640)(ADV -5.986) ) () ))
; (lex.add.entry '("in_vino_veritas" ((ADV -5.907) ) () ))
; (lex.add.entry '("in_vitro" ((ADJ -5.060)(ADV -6.384) ) () ))
; (lex.add.entry '("inch_allah" ((ONO -5.000) ) () ))
(lex.add.entry '("intra_muro" "ADV" ((("ehn") 0) (("t" "rh" "a") 0) (("m" "y") 0) (("rh" "o" "s") 0))))

; (lex.add.entry '("ipso_facto" ((ADV -5.731) ) () ))
  ; (lex.add.entry '("irish_coffee" ((NOM -6.017) ) () ))


(lex.add.entry '("j._c" NOM (((zh e) 0) ((z y) 0)((k rh i s t) 0)))) ; truc
(lex.add.entry '("messieurs_dames" NOM (((m e) 0) ((s j oe) 0) ((d a m) 0))))
(lex.add.entry '("nota_bene" NOM (((n o)0)((t a)0)((b e)0)((n e)0)))) 
(lex.add.entry '("pic_vert" NOM (((p i) 0) ((v eh rh) 0))))
(lex.add.entry '("post_scriptum" NOM (((p oh s t) 0) ((s k rh i p) 0) ((t oh m) 0))))
;(lex.add.entry '("ques_aco" ADV (((k eh) 0) ((z a) 0) ((k o) 0))));  mettre en locution ADV
(lex.add.entry '("saint_esprit" NOM (((s ehn)0)((t eh s)0)((p rh i)0)))) ; pour voir
(lex.add.entry '("saint_paul" NAM (((s ehn) 0) ((p o l) 0))))
(lex.add.entry '("tchin_tchin" ONO  (((t sh i n) 0) ((sh i n) 0))))

(lex.add.entry '("tout_au_plus" ADV (((t u)0)((t o)0)((p l y s)0))))
(lex.add.entry '("tout_ou-rien" ADJ (((t u) 0) ((t u) 0) ((rh j ehn) 0))))
(lex.add.entry '("tout_à_chacun" ADV (((t u)0)((t a)0)((sh a)0)((k oen)0))))
(lex.add.entry '("tout_à_coup" ADV (((t u)0)((t a)0)((k u)0))))
(lex.add.entry '("tout_à_l'heure" ADV (((t u)0)((t a)0)((l eu rh)0))))

(lex.add.entry '("vingt_et_un" ADJ (((v ehn) 0) ((t e) 0) ((oen) 0))))
(lex.add.entry '("à_la_saint-glinglin" ADV (((a) 0) ((l a) 0) ((s ehn) 0) ((g l ehn) 0) ((g l ehn) 0))))
(lex.add.entry '("à_leur_encontre" ADV (((a) 0) ((l oe) 0) ((rh ahn) 0) ((k ohn t rh) 0))))
(lex.add.entry '("à_mon_encontre" ADV (((a) 0) ((m ohn) 0) ((n ahn) 0) ((k ohn t rh) 0))))
(lex.add.entry '("à_notre_encontre" ADV (((a) 0) ((n oh) 0) ((t rh ahn) 0) ((k ohn t rh) 0))))
(lex.add.entry '("à_priori" ADV  (((a) 0) ((p rh i)0) ((j oh) 0) ((rh i) 0))))
(lex.add.entry '("à_son_encontre" ADV (((a) 0) ((s ohn) 0) ((n ahn) 0) ((k ohn t rh) 0))))
(lex.add.entry '("à_ton_encontre" ADV (((a) 0) ((t ohn) 0) ((n ahn) 0) ((k ohn t rh) 0))))
(lex.add.entry '("à_tous_égards" ADV ((((a)0)(t u)0)((z e)0)((g a rh)0))))
(lex.add.entry '("à_tout_hasard" ADV (((a)0)((t u)0)((t a)0)((z a rh)0))))
(lex.add.entry '("à_tâtons" ADV  (((a) 0) ((t a) 0) ((t ohn) 0))))
(lex.add.entry '("à_votre_encontre" ADV (((a) 0) ((v oh) 0) ((t rh ahn) 0) ((k ohn t rh) 0))))
;  ;   925: ("c'est-à-dire" ? (s eh)0)((t a)0)((d i rh)0)))
;  ; 86001: ("tiers-état" NOM 
;  ; 9915:(lex.add.entry '("états-unis_NAM" "NAM" (((e)0)((t a)0)((z y)0)((n i)0))))
;  ; pied-à-terre QT_3 ok mais vu comme VER
;(lex.add.entry '(
;(lex.add.entry '( 
;(lex.add.entry '(  
;(lex.add.entry '("acid_jazz" NOM 
(lex.add.entry '("ad_hoc" ADV (((a)0)((d oh k)0)))) ; ADV Littré, la question se pose ADJ
;(lex.add.entry '("ad_hoc_et_ab_hac" ADV 
(lex.add.entry '("ad_hominem" ADV (((a d)0)((oh)0)((m i)0)((n eh m)0))))
;(lex.add.entry '("ad_honores" ADV 
;(lex.add.entry '("ad_infinitum" ADV 
;(lex.add.entry '("ad_libitum" ADV 
;(lex.add.entry '("ad_rem" ADJ 
;(lex.add.entry '("ad_usum" ADV 
;(lex.add.entry '("agnus_castus" NOM 
;(lex.add.entry '("agnus_dei" NOM 
;(lex.add.entry '("al_dente" ADV 
;(lex.add.entry '("all_right" ADV 
;(lex.add.entry '("alter_ego" NOM 
;(lex.add.entry '("am_stram_gram" ONO 
;(lex.add.entry '("au_fur_et_à_mesure" ADV 
;(lex.add.entry '("aux_aguets" ADV 
;(lex.add.entry '("ayants_droit" NOM 
;(lex.add.entry '("back_up" NOM 
;(lex.add.entry '("beat_generation" NAM 
;(lex.add.entry '("bel_canto" NOM 
;(lex.add.entry '("belle_lurette" ADV 
;(lex.add.entry '("best_of" NOM 
;(lex.add.entry '("big_band" NOM 
;(lex.add.entry '("big_bang" NOM 
;(lex.add.entry '("birth_control" NOM 
;(lex.add.entry '("bla_bla" ONO 
;(lex.add.entry '("bloody_mary" NOM 
;(lex.add.entry '("blue_jeans" NOM 
;(lex.add.entry '("blue_note" NOM 
;(lex.add.entry '("boat_people" NOM 
;(lex.add.entry '("bric_et_de_broc" NOM 
;(lex.add.entry '("bubble_gum" NOM 
;(lex.add.entry '("by_night" ADJ 
;(lex.add.entry '("call_girl" NOM 
;(lex.add.entry '("call_girls" NOM 
;(lex.add.entry '("casus_belli" NOM 
(lex.add.entry '("check_up" NOM (((sh eh k)0)((oe p)0))))
(lex.add.entry '("chef_d_oeuvre" "NOM" ((("sh" "e") 0) (("d" "oe" "v" "rh") 0))))

;(lex.add.entry '("chop_suey" NOM 
;(lex.add.entry '("citizen_band" NOM 
;(lex.add.entry '("comic_book" NOM 
;(lex.add.entry '("comic_books" NOM 
;(lex.add.entry '("commedia_dell'arte" NOM 
;(lex.add.entry '("corn_flakes" NOM 
;(lex.add.entry '("corpus_delicti" NOM 
;(lex.add.entry '("cot_cot_codec" ONO 
;(lex.add.entry '("curriculum_vitae" NOM 
;(lex.add.entry '("d_emblée" ADV 
;(lex.add.entry '("dare_dare" ADV 
;(lex.add.entry '("de_facto" ADV 
;(lex.add.entry '("de_guingois" ADV 
;(lex.add.entry '("de_plano" ADV 
;(lex.add.entry '("de_profundis" NOM 
;(lex.add.entry '("de_santis" NAM 
;(lex.add.entry '("de_traviole" ADV 
;(lex.add.entry '("delirium_tremens" NOM 
;(lex.add.entry '("della_francesca" NOM 
;(lex.add.entry '("deo_gratias" NOM 
;(lex.add.entry '("deus_ex_machina" NOM 
;(lex.add.entry '("dies_irae" NOM 
;(lex.add.entry '("dream_team" NOM 
;(lex.add.entry '("east_river" NAM 
;(lex.add.entry '("ecce_homo" NOM 
;(lex.add.entry '("en_catimini" ADV 
;(lex.add.entry '("en_loucedé" ADV 
;(lex.add.entry '("en_tapinois" ADV 
(lex.add.entry '("et_hop_ONO" "ONO" (((e)0) (( oh p) 0)))); hh 
;(lex.add.entry '("fast_food" NOM 
;(lex.add.entry '("five_o'clock" NOM 
;(lex.add.entry '("foreign_office" NAM 
;(lex.add.entry '("gengis_khan" NAM 
;(lex.add.entry '("girl_friend" NOM 
;(lex.add.entry '("gna_gna" ONO 
;(lex.add.entry '("grosso_modo" ADV 
;(lex.add.entry '("happy_end" NOM 
;(lex.add.entry '("happy_ends" NOM 
;(lex.add.entry '("hard_edge" NOM 
(lex.add.entry '("has_been" NOM (((a s)0)((b i n)0)))) 
;(lex.add.entry '("high_life" NOM 
;(lex.add.entry '("high_tech" ADJ 
;(lex.add.entry '("hold_up" NOM 
;(lex.add.entry '("homo_erectus" NOM 
;(lex.add.entry '("hong_kong" NAM 
;(lex.add.entry '("honoris_causa" ADV 
;(lex.add.entry '("hot_dog" NOM 
;(lex.add.entry '("hot_dogs" NOM 
;(lex.add.entry '("house_music" NOM 
;(lex.add.entry '("ice_cream" NOM 
;(lex.add.entry '("in_absentia" ADV 
;(lex.add.entry '("in_extremis" ADV 
;(lex.add.entry '("in_memoriam" ADV 
;(lex.add.entry '("in_pace" NOM 
;(lex.add.entry '("in_utero" ADJ 
;(lex.add.entry '("in_vino_veritas" ADV 
;(lex.add.entry '("in_vitro" ADJ 
; TODO locution
(lex.add.entry '("inch_allah_ONO" ONO ((("i" "n")0)(("sh" "a")0) (("l" "a")0))))
(lex.add.entry '("intra_muros" ADV (((i n)0)((t rh a)0)((m y)0)((rh oh s)0))))
(lex.add.entry '("jusque_devant" PRE (((zh y s)0)((k ae)0)((d ae)0)((v ahn)0))))
;(lex.add.entry '("ipso_facto" ADV 
;(lex.add.entry '("irish_coffee" NOM 
;(lex.add.entry '("kung_fu" NOM 
;(lex.add.entry '("la_plata" NAM 
(lex.add.entry '("madre_de_dios" NAM (((m a)0)((d rh e)0)((d e)0)((d j oh s)0))))
;(lex.add.entry '("manu_militari" ADV 
;(lex.add.entry '("mass_media" NOM 
;(lex.add.entry '("mea_culpa" NOM 
;(lex.add.entry '("melting_pot" NOM 
;(lex.add.entry '("milk_shake" NOM 
;(lex.add.entry '("modern_style" NOM 
;(lex.add.entry '("modus_operandi" NOM 
(lex.add.entry '("mobilis_in_mobile" NOM (((m oh)0)((b i)0)((l i s)0)((i n)0)((m o)0)((b i)0)((l e)0))))
(lex.add.entry '("moi_même" PRO:per (((m w a) 0)((m eh m)0))))
;(lex.add.entry '("modus_vivendi" NOM 
;(lex.add.entry '("music_hall" NOM 
;(lex.add.entry '("negro_spiritual" NOM 
;(lex.add.entry '("night_club" NOM 
;(lex.add.entry '("no_man's_land" NOM 
;(lex.add.entry '("osso_buco" NOM 
;(lex.add.entry '("par_mégarde" ADV 
;(lex.add.entry '("paso_doble" NOM 
;(lex.add.entry '("pater_familias" NOM 
;(lex.add.entry '("pater_noster" NOM 
;(lex.add.entry '("pax_americana" NOM 
;(lex.add.entry '("persona_grata" NOM 
;(lex.add.entry '("persona_non_grata" NOM 
;(lex.add.entry '("peu_ou_prou" ADV 
(lex.add.entry '("pit_bull" NOM (((p i t)0)((b u l)0)))) 
;(lex.add.entry '("play_back" NOM 
;(lex.add.entry '("pom-pom_girl" NOM 
;(lex.add.entry '("pom-pom_girls" NOM 
(lex.add.entry '("post_it" NOM (((p oh s t)0)((i t)0)))) 
;(lex.add.entry '("post_mortem" ADV 
;(lex.add.entry '("prime_time" NOM                                                                                                                                                                                                                                                                                                                                                                                                                     
;(lex.add.entry '("punching_ball" NOM 
(lex.add.entry '("quant_à" nil (((k ahn)0)((t a)0))))
(lex.add.entry '("quant_au" nil (((k ahn)0)((t o)0))))

(lex.add.entry '("quelques_uns" PRO:ind (((k eh l)0)((k ae)0)((z oen)0))))

;(lex.add.entry '("red_river" NAM 
;(lex.add.entry '("rhythm_and_blues" NOM 
;(lex.add.entry '("roast_beef" NOM 
;(lex.add.entry '("rocking_chair" NOM 
;(lex.add.entry '("sainte_nitouche" NAM 
;(lex.add.entry '("san_francisco" NAM 
;(lex.add.entry '("self-made_man" NOM 
;(lex.add.entry '("sex_appeal" NOM 
;(lex.add.entry '("sex_shop" NOM 
;(lex.add.entry '("sex_shops" NOM 
;(lex.add.entry '("sic_transit_gloria_mundi" ADV 
(lex.add.entry '("sine_qua_non" ADJ (((s i) 0)((n e)0)((k w a)0)((n oh n)0))))
;(lex.add.entry '("soap_opéra" NOM 
;(lex.add.entry '("sri_lankais" ADJ 
;(lex.add.entry '("statu_quo" NOM 
;(lex.add.entry '("story_board" NOM 
;(lex.add.entry '("stricto_sensu" ADV 
;(lex.add.entry '("sui_generis" ADJ 
;(lex.add.entry '("tandis_qu" CON 
;(lex.add.entry '("tandis_que" CON 
;(lex.add.entry '("taï_chi" NOM 
;(lex.add.entry '("te_deum" NAM 
;(lex.add.entry '("terra_incognita" NOM 
(lex.add.entry '("too_much" ADJ (((t u)0)((m y sh)0)))) 
;(lex.add.entry '("top_models" NOM 
;(lex.add.entry '("traveller's_chèques" NOM 
;(lex.add.entry '("tutti_frutti" ADV 
;(lex.add.entry '("tutti_quanti" ADV 
;(lex.add.entry '("urbi_et_orbi" ADV 
(lex.add.entry '("vis_à_vis" PRE (((v i)0)((z a)0)((v i)0))))
(lex.add.entry '("vade_retro" ADV (((v a)0)((d e)0)((rh e)0)((t rh o)0))))
;(lex.add.entry '("vae_victis" ADV 
;(lex.add.entry '("vomito_negro" NOM 
;(lex.add.entry '("vox_populi" ADV 
;(lex.add.entry '("vulgum_pecus" NOM 
(lex.add.entry '("wait_and_see" NOM (((w eh)0)((t eh n)0)((s i)0))))
;(lex.add.entry '("wall_street" NAM 
(lex.add.entry '("way_of_life" NOM (((w eh)0)((oh v)0)((l a j f)0)))) 
(lex.add.entry '("week_end" NOM (((w i)0)((k eh n d)0)))) 
;(lex.add.entry '("world_music" NOM 
;(lex.add.entry '("yom_kippour" NOM 
;(lex.add.entry '("yom_kippur" NOM 
;(lex.add.entry '("à_croupetons" ADV 
;(lex.add.entry '("à_fortiori" ADV 
(lex.add.entry '("à_jeun" ADV (((a)0) ((zh oen)0)))) 
;(lex.add.entry '("à_posteriori" ADV 
; ;("deutsche_mark" ADJ 

; ;("la_plupart" PRO:ind 
; ;("la_plupart_de" ADJ:ind 
; ;("la_plupart_des" ADJ:ind 
; ;("la_plupart_du" ADJ:ind 
; ;("made_in" ADV 
; ;("près_de" ADV 
; ;;; 
; ;_("n'est-ce_pas" ADV 
; QT3(lex.add.entry '("chat_en-jambes" nil (((sh a) 0) ((t ahn)0)((zh ahn b) 0))));
; QT3(lex.add.entry '("peut_être_VER" VER (((p eu) 0) ((t eh t rh) 0))))
; à mettre dddansenglish
;QT3(lex.add.entry '("saint_yon" NAM (((s ehn) 0) ((t j ohn) 0)))); Saint-Yon

(lex.add.entry '("va_te_laver" NOM (((v a)0)((t ae)0)((l a)0)((v e)0))))
(lex.add.entry '("va_t_en_guerre" NOM (((v a)0)((t ahn)0)((g eh rh)0))))
(provide 'INST_LANG_addenda_locutions)

