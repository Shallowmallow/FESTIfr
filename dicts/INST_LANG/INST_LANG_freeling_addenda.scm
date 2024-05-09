; pourquoi un load /home/yop7/Develop/festival/lib/dicts/INST_LANG_freeling_addenda.scm
; est-il nécessaire ?
;  ex pour (lex.add.entry '("Êtes-vous_VER" VER ((("eh" t) 0)((v a) 0))))


;; tous les mots avec majuscule avant de savoir les ranger dans le poslex: INST_LANG_freeling_poslex
;; seront mis ici
;; sachantnt aue
; un nom portant majuscule 
; les entrées dans INST_LANG_freeling_poslex sont ignorées ...

; si une entrée de INST_LANG_freeling_addenda.scm existe avec ou sans majuscule, elle fait foi
; (is_in_poslex "Allemagne") ou (is_in_poslex "allemagne") donnera 
; ((NAM 0)) prenant le pas sur un éventuel ("allemagne" ((NAM -2.506)(NOM -5.908))()) de INST_LANG_freeling_poslex

; attention au caractère codés sur 2 bits : norm les transforment d'entrée ex: À
; Àverell ne sera pas  trouvé que sous "àverell"

;; dans un deuxième temps on rangera les entrées dans INST_LANG_freeling__addenda
;; en les fusionnant
;; ex 

 ;; facilite la résolution des homographes
 ;; permet la résolution de la reconnaissance des mots dont l'initiale
 ;; en majuscule est souvent non accentuée : ex Etat Ecole etc.
 
;; Quid des mots portant un trait d'union
;; ils n'ont pas à figurer dans le poslex ou dans ses addendas
;; puisque c'est le mot de référence avec pos nil qui sera cherché
;; ex (wordroot "tout-puissant" nil) : "tout_puissant"
;; (wordroot "arc-bouter" "nil"): arc-bouter
;; (la prononciation utilisera, elle, le wordroot approprié )

; les blancs ne posent apparement pas de problème ici en tout cas
; (is_in_poslex "Jardin des Plantes")
; ((NAM 0))
; méfiance pour le dico ...

(lex.add.entry '("Àverell" ((NAM 0))())); juste pour test
(lex.add.entry '("États_généraux" ((NAM 0))())); ; juste pour test
(lex.add.entry '("Arthur" ((NAM 0))()));
(lex.add.entry '("êtes" ((AUX -1.987)(VER -2.257))())); pour satisfaire is_in_poslex ? erreur
(lex.add.entry '("fût_ce" ((VER 0))())); 
(lex.add.entry '("t_ils" ((PRO:per 0)) ())); QTpos2
(lex.add.entry '("t_elle" ((PRO:per 0)) ())); QTpos2
(lex.add.entry '("t_elles" ((PRO:per 0)) ())); QTpos2
(lex.add.entry '("t_il" ((PRO:per 0)) ())); QTpos2
(lex.add.entry '("t_ils" ((PRO:per 0)) ())); QTpos2
(lex.add.entry '("t_on" ((PRO:per 0)) ())); QTpos2
(lex.add.entry '("n_importe_qui" ((PRO:ind 0)) ()))
(lex.add.entry '("n_importe_quoi" ((PRO:ind 0)) ()))
(lex.add.entry '("est_il" ((AUX -1.535)(VER -2.212))())); encore besoin ??? QTpos2
(lex.add.entry '("sera_t_il" ((AUX -1.535)(VER -2.212))()));  pour sera-t'il  -> prehook sera_t_il VER
;et non ?(lex.add.entry '("sera-t_il" ((AUX -1.535)(VER -2.212))())); 
(lex.add.entry '("sera_t_elle" ((AUX -1.535)(VER -2.212))()));   
; bug poslex
(lex.add.entry '("être" ((AUX -1.535)(NOM -3.230)(VER -2.212))())); SIWIS
(lex.add.entry '("s_être" ((AUX -1.535)(NOM -3.230)(VER -2.212))())); SIWIS
(lex.add.entry '("j_espère" ((VER -2.912))())); SIWIS
(lex.add.entry '("d_autres" ((ADJ:ind -1.798)(PRO:ind -1.195))())); SIWIS
;(lex.add.entry '("y_a_t_il" ((VER -1.000)(aux -1.000))())); SIWIS
;(lex.add.entry '("y_a-t_il" ((VER -1.000)(aux -1.000))())); SIWIS

; Segmentation fault neut_parl_s01_0190
;(lex.add.entry '("tout_autre" ((ADJ -6.666)(ADJ_ind -6.666))())); SIWIS BUG !!!

(lex.add.entry '("Abraham" ((NAM 0))()))
(lex.add.entry '("Accoyer" ((NAM 0))()))
(lex.add.entry '("Adriatique" ((ADJ -6.038)(NAM -4.412))()))
(lex.add.entry '("Afghanistan" ((NAM 0))()))
(lex.add.entry '("Afrique" ((NAM 0))()))
(lex.add.entry '("Agatharchide" ((NAM 0))()))
(lex.add.entry '("Akim" ((NAM 0))()))
(lex.add.entry '("Albanie" ((NAM 0))()))
(lex.add.entry '("Albarello" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Alençon" ((NAM 0))()))
(lex.add.entry '("Alfortville" ((NAM 0))()))
(lex.add.entry '("Algérie" ((NAM 0))()))
(lex.add.entry '("Allain" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Allemagne" ((NAM 0))()))
(lex.add.entry '("Almona" ((NAM 0))()))
(lex.add.entry '("Alpes" ((NAM 0))()))
(lex.add.entry '("Alpha" ((NAM 0))()))
(lex.add.entry '("Alsace" ((NAM 0))()))
(lex.add.entry '("Altona" ((NAM 0))()))
(lex.add.entry '("Alès" ((NAM 0))()))
(lex.add.entry '("Amazon" ((NAM 0))()))
(lex.add.entry '("Ameline" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Amérique" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Anderson" ((NAM 0))()))
(lex.add.entry '("André" ((NAM 0))()))
(lex.add.entry '("Antilles" ((NAM 0))()))
(lex.add.entry '("Antoine" ((NAM 0))()))
(lex.add.entry '("Apparu" ((NAM 7) (VER -4.440))()))
(lex.add.entry '("Apple" ((NAM 0))()))
(lex.add.entry '("Arak" ((NAM 0))()))
(lex.add.entry '("Arbogad" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Arcachon" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Arcs" ((NAM 0))()))
(lex.add.entry '("Argus" ((NAM 0))()))
(lex.add.entry '("Arimaze" ((NAM 0))()))
(lex.add.entry '("Aristote" ((NAM 0))()))
(lex.add.entry '("Aronnax" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Arrien" ((NAM 0))()))
(lex.add.entry '("Artémidore" ((NAM 0))()))
(lex.add.entry '("Arès" ((NAM 0))())) ;
(lex.add.entry '("Ashton" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Astarté" ((NAM 0))()))
(lex.add.entry '("Astrolabe" ((NAM 0))()))
(lex.add.entry '("Atlantes" ((NAM 0))()))
(lex.add.entry '("Atlantide" ((NAM 0))()))
(lex.add.entry '("Atlantique" ((NAM 0))()))
(lex.add.entry '("Auber" ((NAM 0))())) ; 
(lex.add.entry '("Aubry" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Auerstaedt" ((NAM 0))()))
(lex.add.entry '("Augustus" ((NAM 0))()))
(lex.add.entry '("Austin" ((NAM 0))()))
(lex.add.entry '("Australie" ((NAM 0))()))
(lex.add.entry '("Autriche" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Av._J.-C" ((ADV 0))()))
(lex.add.entry '("Avicenne" ((NAM 0))()))
(lex.add.entry '("Avignon" ((NAM 0))()))
(lex.add.entry '("Avout" ((NAM -5.146))()))
(lex.add.entry '("Axel" ((NAM 0))()))
(lex.add.entry '("Ayrault" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Ayrton" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Azora" ((NAM 0))()))
(lex.add.entry '("Babylone" ((NAM 0))()))
(lex.add.entry '("Bachelot" ((NAM 0))()))
(lex.add.entry '("Bacon" ((NAM 0))()))
(lex.add.entry '("Baert" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Baffin" ((NAM 0))()))
(lex.add.entry '("Bahn" ((NAM 0))()))
(lex.add.entry '("Balkans" ((NAM 0))()))
(lex.add.entry '("Balzac" ((NAM 0))()))
(lex.add.entry '("Bardy" ((NAM 0))()))
(lex.add.entry '("Basse_normandie" ((NAM 0))()))
(lex.add.entry '("Baumel" ((NAM 0))()))
(lex.add.entry '("Bays" ((NAM 0))()))
(lex.add.entry '("Beaune" ((NAM 0))()))
(lex.add.entry '("Beaunes" ((NAM 0))()))
(lex.add.entry '("Bechtel" ((NAM 0))()))
(lex.add.entry '("Belgique" ((NAM 0))()))
(lex.add.entry '("Ben" ((ONO -6.789)(NAM -1.812))))
(lex.add.entry '("Benoit" ((NAM 0))()))
(lex.add.entry '("Bercy" ((NAM 0))()))
(lex.add.entry '("Berghem" ((NAM 0))()))
(lex.add.entry '("Bernard" ((NAM 0))()))
(lex.add.entry '("Bert" ((NAM 0))()))
(lex.add.entry '("Berthelot" ((NAM 0))()))
(lex.add.entry '("Bertrand" ((NAM 0))()))
(lex.add.entry '("Besson" ((NAM 0))()))
(lex.add.entry '("Bettencourt" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Bies" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Bière" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Blumenbach" ((NAM 0))()))
(lex.add.entry '("Bob" ((NAM 0))()))
(lex.add.entry '("Bob_Harvey" ((NAM 0))()))
(lex.add.entry '("Bonadventure" ((NAM 0))()))
(lex.add.entry '("Bonne-Espérance" ((NAM 0))()))
(lex.add.entry '("Bordeaux" ((NAM 0))()))
(lex.add.entry '("Bouillon" ((NAM 0))()))
(lex.add.entry '("Bouillonnec" ((NAM 0))()))
(lex.add.entry '("Bourgogne" ((NAM 0))()))
(lex.add.entry '("Bourgogne_franche_comté" ((NAM 0))()))
(lex.add.entry '("Boyer" ((NAM 0))()))
(lex.add.entry '("Braillard" ((NAM 0)(ADJ -5.339))())); SIWIS
(lex.add.entry '("Bred-Gade" ((NAM 0))()))
(lex.add.entry '("Bretagne" ((NAM 0))()))
(lex.add.entry '("Brian" ((NAM 0))()))
(lex.add.entry '("Bricq" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Bridgestone" ((NAM 0))()))
(lex.add.entry '("Brothers" ((NAM 0))()))
(lex.add.entry '("Bruno" ((NAM 0))()))
(lex.add.entry '("Bruxelles" ((NAM 0))()))
(lex.add.entry '("Bubaste" ((NAM 0))()))
(lex.add.entry '("Buffet" ((NAM 0))()))
(lex.add.entry '("Bur" ((NAM 0))())); SIWIS
(lex.add.entry '("Burkina" ((NAM 0))()))
(lex.add.entry '("Bussereau" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Butler" ((NAM 0))()))
(lex.add.entry '("Cadbury" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Cadix" ((NAM 0))()))
(lex.add.entry '("Cador" ((NAM 0))()))
(lex.add.entry '("Calabre" ((NAM 0))()))
(lex.add.entry '("Calcutta" ((NAM 0))()))
(lex.add.entry '("Canadien" ((NAM 0))()))
(lex.add.entry '("Cancun" ((NAM 0))()))
(lex.add.entry '("Capet" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Caïn" ((NAM 0))()))
(lex.add.entry '("Caresche" ((NAM 0))()))
(lex.add.entry '("Censi" ((NAM 0))()))
(lex.add.entry '("Ceuta" ((NAM 0))()))
(lex.add.entry '("Ceylan" ((NAM 0))()))
(lex.add.entry '("Chantal" ((NAM 0))()))
(lex.add.entry '("Chartres" ((NAM 0))()))
(lex.add.entry '("Chassaigne" ((NAM 0))()))
(lex.add.entry '("Chatel" ((NAM 0))()))
(lex.add.entry '("Chaussée des Géants" ((NAM 0))()))
(lex.add.entry '("Chauveau" ((NAM 0))()))
(lex.add.entry '("Cherki" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Cherpion" ((NAM 0))()))
(lex.add.entry '("Chevrollier" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Chine" ((NAM 0))()))
(lex.add.entry '("Chirac" ((NAM 0))()))
(lex.add.entry '("Christ" ((NAM -2.467))()))
(lex.add.entry '("Christian" ((NAM 0))()))
(lex.add.entry '("Christiane" ((NAM 0))()))
(lex.add.entry '("Christophe" ((NAM 0))()))
(lex.add.entry '("Château_Thierry" ((NAM 0))()))
(lex.add.entry '("Ciotti" ((NAM 0))()))
(lex.add.entry '("Clear" ((NAM 0))()))
(lex.add.entry '("Clermont" ((NAM 0))()))
(lex.add.entry '("Clermont_Tonnerre" ((NAM 0))()))
(lex.add.entry '("Cléopâtre" ((NAM 0))()))
(lex.add.entry '("Cochet" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Colomb" ((NAM 0))()))
(lex.add.entry '("Conseil" ((NOM -3.284)(NAM -5.284))()))
(lex.add.entry '("Cook" ((NAM 0))()))
(lex.add.entry '("Copenhague" ((NAM 0))()))
(lex.add.entry '("Corre" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Corée" ((NAM 0))()))
(lex.add.entry '("Courson" ((NAM 0))()))
(lex.add.entry '("Crespo" ((NAM 0))()))
(lex.add.entry '("Croatie" ((NAM 0))()))
(lex.add.entry '("Cuvier" ((NAM 0))()))
(lex.add.entry '("Cuvillier" ((NAM 0))()))
(lex.add.entry '("Cuvilliers" ((NAM 0))()))
(lex.add.entry '("Cyrus" ((NAM 0))()))
(lex.add.entry '("César" ((NAM 0))()))
(lex.add.entry '("Dakkar" ((NAM 0))()))
(lex.add.entry '("Dain" ((NAM 0))()))
(lex.add.entry '("Danemark" ((NAM 0))()))
(lex.add.entry '("Daniel" ((NAM 0))()))
(lex.add.entry '("Danielle" ((NAM 0))()))
(lex.add.entry '("Danièle" ((NAM 0))()))
(lex.add.entry '("Darius" ((NAM 0))()))
(lex.add.entry '("David" ((NAM 0))()))
(lex.add.entry '("Denain" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Diderot" ((NAM 0))()))
(lex.add.entry '("Dieudonné" ((NAM 0))()))
(lex.add.entry '("Dijon" ((NAM 0))()))
(lex.add.entry '("Dillon" ((NAM 0))()))
(lex.add.entry '("Dion" ((NAM 0))()))
(lex.add.entry '("Doha" ((NAM 0))()))
(lex.add.entry '("Dominique" ((NAM 0))()))
(lex.add.entry '("Door" ((NAM 0))()))
(lex.add.entry '("Dordogne" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Douillet" ((NAM 0))()))
(lex.add.entry '("Dubois" ((NAM 0))()))
(lex.add.entry '("Dumas" ((NAM 0))()))
(lex.add.entry '("Dumont" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Duncan" ((NAM 0))()))
(lex.add.entry '("Dupont" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Dupont-Aignan" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Dupont_Aignan" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Durand" ((NAM 0))()))
(lex.add.entry '("Dussopt" ((NAM 0))()))
(lex.add.entry '("East_River" ((NAM -3.819))()))
(lex.add.entry '("Eh" ((ONO -1.173))()))
(lex.add.entry '("Elbe" ((NAM 0))()))
(lex.add.entry '("Emirates" ((NAM 0))()))
(lex.add.entry '("Ena" ((NAM 0))()))
(lex.add.entry '("Enercoop" ((NAM 0))()))
(lex.add.entry '("Engel" ((NAM 0))()))
(lex.add.entry '("Equateur" ((NAM 0))()))
(lex.add.entry '("Espagne" ((NAM 0))()))
(lex.add.entry '("Estrosi" ((NAM 0))()))
(lex.add.entry '("Etat" ((NAM 0))()))
(lex.add.entry '("Etats" ((NAM 0))()))
(lex.add.entry '("Etats-Unis" ((NAM 0))()))
(lex.add.entry '("Etats_Unis" ((NAM 0))()))
(lex.add.entry '("Etna" ((NAM 0))()))
(lex.add.entry '("Europe" ((NAM 0))()))
(lex.add.entry '("Eva" ((NAM 0))()))
(lex.add.entry '("Eve" ((NAM 0))()))
(lex.add.entry '("Fabius" ((NAM 0))()))
(lex.add.entry '("Facebook" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Falls_river" ((NAM 0))())) ;; SIWIS
(lex.add.entry '("Falorni" ((NAM 0))()))
(lex.add.entry '("Far" ((NAM 0))()))
(lex.add.entry '("Far_West" ((NAM 0))()))
(lex.add.entry '("Farragut" ((NAM 0))()))   ; SIWIS
(lex.add.entry '("Faure" ((NAM 0))()))
(lex.add.entry '("Favennec" ((NAM 0))()))
(lex.add.entry '("Faxa" ((NAM 0))()))
(lex.add.entry '("Fenech" ((NAM 0))()))
(lex.add.entry '("Fillon" ((NAM 0))()))
(lex.add.entry '("Filoche" ((NAM 0))()))
(lex.add.entry '("Fingal" ((NAM 0))()))
(lex.add.entry '("Foi" ((NAM 0)(NOM -3.504))()))
(lex.add.entry '("Folliot" ((NAM 0))()))
(lex.add.entry '("Fontainebleau" ((NAM 0))()))
(lex.add.entry '("Forster" ((NAM 0))()))
(lex.add.entry '("Fougères" ((NAM 0))()))
(lex.add.entry '("Foulon" ((NAM 0))()))
(lex.add.entry '("Fourage" ((NAM 0))()))
(lex.add.entry '("Fragonard" ((NAM 0))()))
(lex.add.entry '("France" ((NAM 0))()))
(lex.add.entry '("Franklin" ((NAM 0))()))
(lex.add.entry '("François" ((NAM 0))()))
(lex.add.entry '("Françoise" ((NAM 0))()))
(lex.add.entry '("Fridriksson" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Fromion" ((NAM 0))()))
(lex.add.entry '("Frédéric" ((NAM 0))()))
(lex.add.entry '("Frédérikson" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Félix" ((NAM 0))())) ; 
(lex.add.entry '("Gad" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Gagnaire" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Galut" ((NAM 0))()))
(lex.add.entry '("Gaudin" ((NAM 0))()))
(lex.add.entry '("Geneviève" ((NAM 0))()))
(lex.add.entry '("Geoffroy" ((NAM 0))()))
(lex.add.entry '("George" ((NAM 0))()))
(lex.add.entry '("Georges" ((NAM 0))()))
(lex.add.entry '("Gers" ((NAM 0))()))
(lex.add.entry '("Gibraltar" ((NAM 0))()))
(lex.add.entry '("Girardin" ((NAM 0))()))
(lex.add.entry '("Glenarvan" ((NAM 0))()))
(lex.add.entry '("Goasguen" ((NAM 0))()))
(lex.add.entry '("Goldberg" ((NAM 0))()))
(lex.add.entry '("Gomes" ((NAM 0))()))
(lex.add.entry '("Google" ((NAM 0))()))
(lex.add.entry '("Gosselin" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Gosselin_Fleury" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Goujon" ((NAM -5.014)(NOM -5.716))())); SIWIS

(lex.add.entry '("Gozon" ((NAM 0))()))
(lex.add.entry '("Grande_Bretagne" ((NAM 0))()))
(lex.add.entry '("Grande_Vue" ((NAM 0))()))
(lex.add.entry '("Granite_House" ((NAM 0))()))
(lex.add.entry '("Grant" ((NAM 0))()))
(lex.add.entry '("Gratiolet" ((NAM 0))()))
(lex.add.entry '("Graüben" ((NAM 0))()))
(lex.add.entry '("Greenpeace" ((NAM 0))())) ; TODO
(lex.add.entry '("Greff" ((NAM 0))()))
(lex.add.entry '("Grenelle" ((NAM 0))()))
(lex.add.entry '("Griffe" ((NAM 0))()))
(lex.add.entry '("Grèce" ((NAM 0))()))
(lex.add.entry '("Guadeloupe" ((NAM 0))()))
(lex.add.entry '("Guaino" ((NAM 0))()))
(lex.add.entry '("Gueboroar" ((NAM 0))()))
(lex.add.entry '("Guen" ((NAM 0))()))
(lex.add.entry '("Guigou" ((NAM 0))()))
(lex.add.entry '("Gulf" ((NAM 0))()))
(lex.add.entry '("Guy" ((NAM 0))()))
(lex.add.entry '("Guy-Michel" ((NAM 0))()))
(lex.add.entry '("Guy_Michel" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Guyane" ((NAM 0))()))
(lex.add.entry '("Guéant" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Gédéon" ((NAM 0))()))
(lex.add.entry '("Gérard" ((NAM 0))()))
(lex.add.entry '("Hautes-Alpes" ((NAM 0))()))
(lex.add.entry '("HS" ((ADJ 0))()))
(lex.add.entry '("HT" ((ADJ 0))()))
(lex.add.entry '("Habib" ((NAM 0))()))
(lex.add.entry '("Hambourg" ((NAM 0))()))
(lex.add.entry '("Hammadi" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Hamon" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Hans" ((NAM 0))()))  ; SIWIS
(lex.add.entry '("Hans" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Harbert" ((NAM 0))()))  ; SIWIS
(lex.add.entry '("Harbert" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Harvey" ((NAM 0))()))  ; SIWIS
(lex.add.entry '("Harvey" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Hastigt" ((NAM 0))()))   ; SIWIS
;(lex.add.entry '("Haute-Garonne" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Haute_Garonne" ((NAM 0))())) ; SIWIS
;(lex.add.entry '("Haute_garonne" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Hautes_Alpes" ((NAM 0))())) ; SIWIS

(lex.add.entry '("Hazebrouck" ((NAM 0))()))
(lex.add.entry '("Heinrich" ((NAM 0))()))
(lex.add.entry '("Helvetia" ((NAM 0))()))
(lex.add.entry '("Henri" ((NAM 0))()))
(lex.add.entry '("Herald" ((NAM 0))()))     ; SIWIS 
(lex.add.entry '("Herth" ((NAM 0))()))
(lex.add.entry '("Hetzel" ((NAM 0))()))
(lex.add.entry '("Hermès" ((NAM 0))()))
(lex.add.entry '("Hirson" ((NAM 0))()))
(lex.add.entry '("Hobart" ((NAM 0))()))
(lex.add.entry '("Hollande" ((NAM 0))()))
(lex.add.entry '("Hong_Kong" ((NAM -3.163))()))
(lex.add.entry '("Hongkong" ((NAM -3.163))()))
(lex.add.entry '("Hongrie" ((NAM 0))()))
(lex.add.entry '("Horeb" ((NAM 0))()))    ; SIWIS
(lex.add.entry '("Houillon" ((NAM 0))()))
(lex.add.entry '("Huchon" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Hughe" ((NAM 0))()))
(lex.add.entry '("Hughes" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Hutin" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Huttin" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Hyrcanie" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Hystaspe" ((NAM 0))()))    ; SIWIS
(lex.add.entry '("Hébrides" ((NAM 0))()))
(lex.add.entry '("Hélène" ((NAM 0))()))
(lex.add.entry '("Hélénus" ((NAM 0))()))
(lex.add.entry '("Electre" ((NAM 0))()))
(lex.add.entry '("Électre" ((NAM 0))()))

(lex.add.entry '("Icade" ((NAM 0))()))
(lex.add.entry '("Ice_blinck" ((NAM 0))()))
(lex.add.entry '("Imaüs" ((NAM 0))()))
(lex.add.entry '("Ion" ((NAM 0))()))
(lex.add.entry '("Irax" ((NAM 0))()))
(lex.add.entry '("Irlande" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Islande" ((NAM 0))()))    ; SIWIS
(lex.add.entry '("Israël" ((NAM 0))()))
(lex.add.entry '("Istanbul" ((NAM 0))()))
(lex.add.entry '("Italie" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Itobad" ((NAM 0))()))   ; SIWIS
(lex.add.entry '("JF" ((NOM 0))()))
(lex.add.entry '("JH" ((NOM 0))()))
(lex.add.entry '("JO" ((NAM 0))()))
(lex.add.entry '("Jacamar" ((NAM 0))()))
(lex.add.entry '("Jacob" ((NAM 0))()))
(lex.add.entry '("Jacques" ((NAM 0))()))
(lex.add.entry '("Japon" ((NAM 0))()))
(lex.add.entry '("Jardin des Plantes" ((NAM 0))()))
(lex.add.entry '("Jaurès" ((NAM 0))()))
(lex.add.entry '("Jean" ((NAM 0))()))
(lex.add.entry '("Jean_Claude" ((NAM 0))()))
(lex.add.entry '("Jean_Luc" ((NAM 0))()))
(lex.add.entry '("Jean_Marc" ((NAM 0))()))
(lex.add.entry '("Jean_Marie" ((NAM 0))()))
(lex.add.entry '("Jean_Pierre" ((NAM 0))()))
(lex.add.entry '("Jean_Sébastien" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Jean_Yves" ((NAM 0))()))
(lex.add.entry '("Jibrayel" ((NAM 0))()))
(lex.add.entry '("Jospin" ((NAM 0))()))
(lex.add.entry '("Joséphine" ((NAM 0))()))
(lex.add.entry '("Jouanno" ((NAM 0))()))
(lex.add.entry '("Joyce" ((NAM 0))()))
(lex.add.entry '("Jubal" ((NAM 0))()))
(lex.add.entry '("Juncker" ((NAM 0))()))
(lex.add.entry '("Jup" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Jupiter" ((NAM 0))()))
(lex.add.entry '("Kaboul" ((NAM 0))()))
(lex.add.entry '("Karoutch" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Keeling" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Kiel" ((NAM 0))()))
(lex.add.entry '("Kobané" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Königstrasse" ((NAM 0))())) ; SIWIS
(lex.add.entry '("L_Afghanistan" ((NAM 0))()))
(lex.add.entry '("L_Europe" ((NAM 0))()))
(lex.add.entry '("La_Fontaine" ((NAM 0))()))
(lex.add.entry '("Laguiole" ((NAM 0))()))  ;
(lex.add.entry '("Lamour" ((NAM 0))()))
(lex.add.entry '("Land" ((NAM 0))()))
(lex.add.entry '("Lang" ((NAM 0))()))
(lex.add.entry '("Languedoc" ((NAM 0))()))
(lex.add.entry '("Languedoc_Roussillon" ((NAM 0))()))
(lex.add.entry '("Larrivé" ((NAM 0))()))
(lex.add.entry '("Launay" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Laurent" ((NAM 0))()))
(lex.add.entry '("Leboeuf" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Lebranchu" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Lefebvre" ((NAM 0))()))
(lex.add.entry '("Lehman" ((NAM 0))()))
(lex.add.entry '("Leipzig" ((NAM 0))()))  ; SIWIS
(lex.add.entry '("Leipzig" ((NAM 0))())) ;; SIWIS
(lex.add.entry '("Lellouche" ((NAM 0))()))
(lex.add.entry '("Leonetti" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Lequiller" ((NAM 0))())) ;SIWIS
(lex.add.entry '("Lesage" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Liban" ((NAM 0))()))
(lex.add.entry '("Lidenbrock" ((NAM 0))()))
(lex.add.entry '("Lincoln" ((NAM 0))()))
(lex.add.entry '("Linky" ((NAM 0))()))
(lex.add.entry '("Lionel" ((NAM 0))()))
(lex.add.entry '("Liverpool" ((NAM 0))()))
(lex.add.entry '("Loffoden" ((NAM 0))()))
(lex.add.entry '("Luc" ((NAM 0))()))
(lex.add.entry '("Lulle" ((NAM 0))()))
(lex.add.entry '("Luxembourg" ((NAM 0))()))
(lex.add.entry '("Lyon_Turin" ((NAM 0))()))
(lex.add.entry '("Magellan" ((NAM 0))()))
(lex.add.entry '("Malouines" ((NAM 0))()))
(lex.add.entry '("Mamère" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Manaar" ((NAM 0))()))
(lex.add.entry '("Mandibule" ((NAM 0))()))
(lex.add.entry '("Maoris" ((NAM 0))()))
(lex.add.entry '("Marie_Françoise" ((NAM 0))()))
(lex.add.entry '("Marie_Line" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Mariton" ((NAM 0))()))
(lex.add.entry '("Marleix" ((NAM 0))()))
(lex.add.entry '("Maroc" ((NAM 0))()))
(lex.add.entry '("Marseille" ((NAM 0))()))
(lex.add.entry '("Martin" ((NAM 0))()))
(lex.add.entry '("Martinique" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Massonneau" ((NAM 0))()))
(lex.add.entry '("Mathis" ((NAM 0))()))
(lex.add.entry '("Matignon" ((NAM 0))()))
(lex.add.entry '("Maubeuge" ((NAM 0))()))
(lex.add.entry '("Mauroy" ((NAM 0))()))
(lex.add.entry '("Mayennais" ((NAM -6.038)(NOM -6.038)(ADJ -6.038))()))
(lex.add.entry '("Mayotte" ((NAM 0))()))
(lex.add.entry '("Melbourne" ((NAM 0))()))
(lex.add.entry '("Mencroff" ((NAM 0))()))   ; SIWIS
(lex.add.entry '("Mercy" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Meuse" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Michel" ((NAM 0))()))
(lex.add.entry '("Micromégas" ((NAM 0))()))
(lex.add.entry '("Mistour" ((NOM 0))())) ; SIWIS
(lex.add.entry '("Mollac" ((NAM 0))()))
(lex.add.entry '("Monique" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Montebourg" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Morin" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Moscou" ((NAM 0))()))
(lex.add.entry '("Moscovici" ((NAM 0))()))
(lex.add.entry '("Moselle" ((NAM 0))()))
(lex.add.entry '("Moyen_Orient" ((NAM 0))()))
(lex.add.entry '("Muet" ((NAM 0))()))
(lex.add.entry '("Mulhouse" ((NAM 0))()))
(lex.add.entry '("Myard" ((NAM 0))()))
(lex.add.entry '("Médie" ((NAM 0))()))
(lex.add.entry '("Méditerranée" ((NAM 0))()))
(lex.add.entry '("N_en" ((ADV -2.384))())); SIWIS
(lex.add.entry '("Nab" ((NAM 0))()))    ; SIWIS
(lex.add.entry '("Nabussan" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Nad" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Nagoya" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Nantes" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Napoléon" ((NAM 0))()))
(lex.add.entry '("Nautilus" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Navigo" ((NAM 0))()))
(lex.add.entry '("Ned" ((NAM 0))()))
(lex.add.entry '("Nemo" ((NAM 0))()))
(lex.add.entry '("Nemo" ((NAM 0))()))    ; SIWIS
(lex.add.entry '("Neptune" ((NAM 0))()))
(lex.add.entry '("New" ((NAM 0))()))
(lex.add.entry '("Nicolas" ((NAM 0))()))
(lex.add.entry '("Nicole" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Nicolin" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Nil" ((NAM 0))()))
(lex.add.entry '("Norfolk" ((NAM 0))()))
(lex.add.entry '("Nouvelle" ((ADJ -2.415)(NAM -5.014)(NOM -3.607))())); SIWIS

(lex.add.entry '("Nouvelle-Galle" ((NAM 0))()))
(lex.add.entry '("Nouvelle_Guinée" ((NAM 0))()))
(lex.add.entry '("Nouvelle_Zélande" ((NAM 0))()))
(lex.add.entry '("Néron" ((NAM 0))()))
(lex.add.entry '("Océanie" ((NAM 0))()))
(lex.add.entry '("Oedipe" ((NAM 0))()))
(lex.add.entry '("Oise" ((NAM 0))()))
(lex.add.entry '("Ollier" ((NAM 0))()))
(lex.add.entry '("Orcan" ((NAM 0))()))
(lex.add.entry '("Orizaba" ((NAM 0))()))
(lex.add.entry '("Otame" ((NAM 0))()))
(lex.add.entry '("Ouloug" ((NAM 0))()))
(lex.add.entry '("Pacifique" ((NAM 0))()))
(lex.add.entry '("Panama" ((NAM 0))()))
(lex.add.entry '("Pandore" ((NAM 0))()))
(lex.add.entry '("Papouasie" ((NAM 0))()))
(lex.add.entry '("Paracelse" ((NAM 0))()))
(lex.add.entry '("Paul" ((NAM 0))()))
(lex.add.entry '("Pays-Bas" ((NAM 0))()))
(lex.add.entry '("Peillon" ((NAM 0))()))
(lex.add.entry '("Pencroff" ((NAM 0))()))
(lex.add.entry '("Peterman" ((NAM 0))())) ;; SIWIS
(lex.add.entry '("Petersburg" ((NAM 0))()))
(lex.add.entry '("Peugeot" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Philippe" ((NAM 0))()))
(lex.add.entry '("Phoenix" ((NAM 0))()))
(lex.add.entry '("Pierre_Alain" ((NAM 0))()))
(lex.add.entry '("Pierre_et_Miquelon" ((NAM 0))()))
(lex.add.entry '("Pilet" ((NOM 0))()))
(lex.add.entry '("Pires" ((NAM 0))()))
(lex.add.entry '("Piron" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Platon" ((NAM 0))()))
(lex.add.entry '("Plisson" ((NAM 0))()))
(lex.add.entry '("Poletti" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Pologne" ((NAM 0))()))
(lex.add.entry '("Polynésie" ((NAM 0))()))
(lex.add.entry '("Pontoppidan" ((NAM 0))())) ;
(lex.add.entry '("Popocatepelt" ((NAM 0))()))
(lex.add.entry '("Port_Graüben" ((NAM 0))()))
(lex.add.entry '("Port_Saïd" ((NAM 0))()))
(lex.add.entry '("Portugal" ((NAM 0))()))
(lex.add.entry '("Potier" ((NAM 0))()))
(lex.add.entry '("Prism" ((NAM 0))()))
(lex.add.entry '("Ptolémée" ((NAM 0))()))
(lex.add.entry '("Pérouse" ((NAM 0))()))
(lex.add.entry '("Pyrrhus" ((NAM 0))()))
(lex.add.entry '("Qu_est_ce" ((VER 0))()))
(lex.add.entry '("Quevilly" ((NAM 0))())) ; ; SIWIS
(lex.add.entry '("Rabin" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Rebsamen" ((NAM 0))()))
(lex.add.entry '("Reims" ((NAM 0))()))
(lex.add.entry '("Reiss" ((NAM 0))()))
(lex.add.entry '("Reykjawik" ((NAM 0))()))
(lex.add.entry '("Reykjawik" ((NAM 0))()))  ;
(lex.add.entry '("Reynaud" ((NAM 0))()))
(lex.add.entry '("Reynier" ((NAM 0))()))
(lex.add.entry '("Reynès" ((NAM 0))()))
(lex.add.entry '("Rhin" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Rhodes" ((NAM 0))()))
(lex.add.entry '("Rhône-Alpes" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Rima" ((NAM 0))()))
(lex.add.entry '("Robiliard" ((NAM 0))()))
(lex.add.entry '("Roger" ((NAM 0))()))
(lex.add.entry '("Roig" ((NAM 0))()))
(lex.add.entry '("Rome" ((NAM 0))()))
(lex.add.entry '("roman" ((ADJ -4.631)(NOM -4.062)(NAM -5.062))())); SIWIS

(lex.add.entry '("Rotti" ((NAM 0))()))
(lex.add.entry '("Royal" ((NAM 0))()))
(lex.add.entry '("Royaume_Uni" ((NAM 0))()))
(lex.add.entry '("Rugy" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Ruhmkorff" ((NAM 0))()))
(lex.add.entry '("Saint-Louis" ((NAM 0))()))
(lex.add.entry '("Saint-Étienne" ((NAM 0))()))
(lex.add.entry '("Saint_Michel" ((NAM 0))()))
(lex.add.entry '("Saint_Michel" ((NAM 0))()))    ;
(lex.add.entry '("Saint_Pierre_et_Miquelon" ((NAM 0))()))
(lex.add.entry '("Saint_Vincent" ((NAM 0))()))
(lex.add.entry '("Saknussemm" ((NAM 0))()))
(lex.add.entry '("Sandwich" ((NAM 0))()))
(lex.add.entry '("Sapin" ((NAM 0))()))
(lex.add.entry '("Sarkozy" ((NAM 0))()))
(lex.add.entry '("Savarin" ((NAM 0))()))
(lex.add.entry '("Savigny" ((NAM 0))()))
(lex.add.entry '("Savoie" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Schneider" ((NAM 0))()))
(lex.add.entry '("Schröder" ((NAM 0))()))
(lex.add.entry '("Schweppes" ((NAM -3) (NOM -3))())) ; SIWIS
(lex.add.entry '("Scotia" ((NAM 0))()))
(lex.add.entry '("Serpentine" ((NAM 0))()))
(lex.add.entry '("Servilia" ((NAM 0))()))
(lex.add.entry '("Setoc" ((NAM 0))()))
(lex.add.entry '("Sevran" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Shannon" ((NAM 0))()))
(lex.add.entry '("Sicard" ((NAM 0))()))
(lex.add.entry '("Sirr" ((NAM 0))()))
(lex.add.entry '("Smith" ((NAM 0))()))
(lex.add.entry '("Sneffels" ((NAM 0))()))
(lex.add.entry '("Sophie" ((NAM 0))()))
(lex.add.entry '("Spilett" ((NAM 0))()))
(lex.add.entry '("Stapi" ((NAM 0))()))
(lex.add.entry '("Stella" ((NAM 0))()))
(lex.add.entry '("Stop" ((ONO 0))()))
(lex.add.entry '("Strabon" ((NAM 0))()))
(lex.add.entry '("Strasbourg" ((NAM 0))()))
(lex.add.entry '("Stream" ((NAM 0))()))
(lex.add.entry '("Stéphane" ((NAM 0))()))
(lex.add.entry '("Syrie" ((NAM 0))()))
(lex.add.entry '("Ségolène" ((NAM 0))()))
(lex.add.entry '("Sémire" ((NAM 0))()))
(lex.add.entry '("Séralini" ((NAM 0))()))
(lex.add.entry '("Sésostris" ((NAM 0))()))
(lex.add.entry '("Suisse" ((ADJ -4.163)(NAM -2.884)(NOM -5.908))())); SIWIS
(lex.add.entry '("Tabor" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Tardy" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Thaïlande" ((NAM 0))()))
(lex.add.entry '("Thierry" ((NAM 0))()))
(lex.add.entry '("Thérèse" ((NAM 0))()))
(lex.add.entry '("Tian" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Tibet" ((NAM 0))()))
(lex.add.entry '("Tonnerre" ((NAM 0))()))
(lex.add.entry '("Top" ((NAM 0))()))
(lex.add.entry '("Tor" ((NAM 0))()))
(lex.add.entry '("Torrès" ((NAM 0))()))
(lex.add.entry '("Tourret" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Toyota" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Tsukuba" ((NAM 0))()))
(lex.add.entry '("Tyr" ((NAM 0))()))
(lex.add.entry '("USA" ((NAM 0))()))
(lex.add.entry '("Ugues" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Ulysse" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Urville" ((NAM 0))()))
(lex.add.entry '("Valls" ((NAM 0))()))
(lex.add.entry '("Valognes" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Valérie" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Vanikoro" ((NAM 0))()))
(lex.add.entry '("Veran" ((NAM 0))()))
(lex.add.entry '("Vercamer" ((NAM 0))()))
(lex.add.entry '("Verdun" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Vialatte" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Vian" ((NAM 0))()))
(lex.add.entry '("Vigier" ((NAM 0))()))
(lex.add.entry '("Villers" ((NAM 0))()))
(lex.add.entry '("Vincent" ((NAM 0))()))
(lex.add.entry '("Virlandaise" ((NAM 0))()))
(lex.add.entry '("Viti" ((NAM 0))()))
(lex.add.entry '("Véran" ((NAM 0))()))
(lex.add.entry '("Wagner" ((NAM 0))()))
(lex.add.entry '("Wallis" ((NAM 0))()))
(lex.add.entry '("Washington" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Wauquiez" ((NAM 0))()))
(lex.add.entry '("West" ((NAM 0))()))
(lex.add.entry '("Yann" ((NAM 0))()))
(lex.add.entry '("Yannick" ((NAM 0))()))
(lex.add.entry '("Yves" ((NAM 0))())) ; SIWIS
(lex.add.entry '("Zadig" ((NAM 0))()))
(lex.add.entry '("Zend" ((NAM 0))()))
(lex.add.entry '("Zélande" ((NAM 0))()))
(lex.add.entry '("akim" ((NAM 0))()))
(lex.add.entry '("chapdelaine" ((NAM 0))())) ; SIWIS
(lex.add.entry '("d'Urville" ((NAM 0))()))
(lex.add.entry '("d_Abraham" ((NAM 0))()))
(lex.add.entry '("d_Accoyer" ((NAM 0))()))
(lex.add.entry '("d_Afghanistan" ((NAM 0))()))
(lex.add.entry '("d_Afrique" ((NAM 0))()))
(lex.add.entry '("d_Agatharchide" ((NAM 0))()))
(lex.add.entry '("d_Akim" ((NAM 0))()))
(lex.add.entry '("d_Albanie" ((NAM 0))()))
(lex.add.entry '("d_Albarello" ((NAM 0))())) ; SIWIS
(lex.add.entry '("d_Alençon" ((NAM 0))()))
(lex.add.entry '("d_Alfortville" ((NAM 0))()))
(lex.add.entry '("d_Algérie" ((NAM 0))()))
(lex.add.entry '("d_Allain" ((NAM 0))())) ; SIWIS
(lex.add.entry '("d_Allemagne" ((NAM 0))()))
(lex.add.entry '("d_Almona" ((NAM 0))()))
(lex.add.entry '("d_Alpes" ((NAM 0))()))
(lex.add.entry '("d_Alpha" ((NAM 0))()))
(lex.add.entry '("d_Alsace" ((NAM 0))()))
(lex.add.entry '("d_Altona" ((NAM 0))()))
(lex.add.entry '("d_Amazon" ((NAM 0))()))
(lex.add.entry '("d_Ameline" ((NAM 0))())) ; SIWIS
(lex.add.entry '("d_Amérique" ((NAM 0))())) ; SIWIS
(lex.add.entry '("d_Anderson" ((NAM 0))()))
(lex.add.entry '("d_André" ((NAM 0))()))
(lex.add.entry '("d_Antilles" ((NAM 0))()))
(lex.add.entry '("d_Antoine" ((NAM 0))()))
(lex.add.entry '("d_Apple" ((NAM 0))()))
(lex.add.entry '("d_Arak" ((NAM 0))()))
(lex.add.entry '("d_Arbogad" ((NAM 0))())) ; SIWIS
(lex.add.entry '("d_Arcachon" ((NAM 0))())) ; SIWIS
(lex.add.entry '("d_Arcs" ((NAM 0))()))
(lex.add.entry '("d_Argus" ((NAM 0))()))
(lex.add.entry '("d_Arimaze" ((NAM 0))()))
(lex.add.entry '("d_Aristote" ((NAM 0))()))
(lex.add.entry '("d_Aronnax" ((NAM 0))())) ; SIWIS
(lex.add.entry '("d_Arrien" ((NAM 0))()))
(lex.add.entry '("d_Artémidore" ((NAM 0))()))
(lex.add.entry '("d_Arès" ((NAM 0))())) ;
(lex.add.entry '("d_Ashton" ((NAM 0))())) ; SIWIS
(lex.add.entry '("d_Astarté" ((NAM 0))()))
(lex.add.entry '("d_Astrolabe" ((NAM 0))()))
(lex.add.entry '("d_Atlantes" ((NAM 0))()))
(lex.add.entry '("d_Atlantide" ((NAM 0))()))
(lex.add.entry '("d_Atlantique" ((NAM 0))()))
(lex.add.entry '("d_Aubry" ((NAM 0))())) ; SIWIS
(lex.add.entry '("d_Augustus" ((NAM 0))()))
(lex.add.entry '("d_Austin" ((NAM 0))()))
(lex.add.entry '("d_Australie" ((NAM 0))()))
(lex.add.entry '("d_Autriche" ((NAM 0))())) ; SIWIS
(lex.add.entry '("d_Avicenne" ((NAM 0))()))
(lex.add.entry '("d_Avignon" ((NAM 0))()))
(lex.add.entry '("d_Avout" ((NAM 0))()))
(lex.add.entry '("d_Axel" ((NAM 0))()))
(lex.add.entry '("d_Ayrault" ((NAM 0))())) ; SIWIS
(lex.add.entry '("d_Ayrton" ((NAM 0))())) ; SIWIS
(lex.add.entry '("d_Azora" ((NAM 0))()))
(lex.add.entry '("d_Enercoop" ((NAM 0))())); SIWIS
(lex.add.entry '("d_Europe" ((NAM 0))()))
(lex.add.entry '("d_Hazebrouck" ((NAM 0))())) ; SIWIS
(lex.add.entry '("d_Hystaspe" ((NAM -7.658))())) ; SIWIS
(lex.add.entry '("d_Urville" ((NAM 0))()))
(lex.add.entry '("d_Évian" ((NAM 0))()))
(lex.add.entry '("d’Urville" ((NAM 0))()))
(lex.add.entry '("l_Afghanistan" ((NAM 0))()))
(lex.add.entry '("l_Allemagne" ((NAM 0))()))
(lex.add.entry '("l_Australie" ((NAM 0))()))
(lex.add.entry '("l_Autriche" ((NAM 0))())) ; SIWIS
(lex.add.entry '("l_Est" ((AUX -0.926)(NAM -2.181)(NOM -4.201)(VER -1.018))())); SIWIS
(lex.add.entry '("l_Europe" ((NAM 0))()))
(lex.add.entry '("l_Irak" ((NAM 0))()))
(lex.add.entry '("l_Iran" ((NAM 0))()))
(lex.add.entry '("l_Irlande" ((NAM 0))()))
(lex.add.entry '("l_Italie" ((NAM 0))()))
(lex.add.entry '("Olivier" ((NAM -3.462)(NOM -5.357))())); SIWIS
(lex.add.entry '("Urbain" ((ADJ -4.513)(NAM -4.792))())); C
(lex.add.entry '("À" ((PRE -0.804)(NOM -6.017))())) ; C
(lex.add.entry '("Écofin" ((NAM 0))()))
(lex.add.entry '("États-Unis" ((NAM 0))()))
(lex.add.entry '("États_Unis" ((NAM 0))()))
(lex.add.entry '("Étienne" ((NAM 0))()))
(lex.add.entry '("Évian" ((NAM 0))()))
(lex.add.entry '("Êtes-vous" ((VER 0))()))
;(lex.add.entry '("Ça" ((PRO:dem -0.614))())); SIWIS

