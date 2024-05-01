;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                                                                     ;;;
;;;                     Carnegie Mellon University                      ;;;
;;;                  and Alan W Black and Kevin Lenzo                   ;;;
;;;                      Copyright (c) 1998-2000                        ;;;
;;;                        All Rights Reserved.                         ;;;
;;;                                                                     ;;;
;;; Permission is hereby granted, free of charge, to use and distribute ;;;
;;; this software and its documentation without restriction, including  ;;;
;;; without limitation the rights to use, copy, modify, merge, publish, ;;;
;;; distribute, sublicense, and/or sell copies of this work, and to     ;;;
;;; permit persons to whom this work is furnished to do so, subject to  ;;;
;;; the following conditions:                                           ;;;
;;;  1. The code must retain the above copyright notice, this list of   ;;;
;;;     conditions and the following disclaimer.                        ;;;
;;;  2. Any modifications must be clearly marked as such.               ;;;
;;;  3. Original authors' names are not deleted.                        ;;;
;;;  4. The authors' names are not used to endorse or promote products  ;;;
;;;     derived from this software without specific prior written       ;;;
;;;     permission.                                                     ;;;
;;;                                                                     ;;;
;;; CARNEGIE MELLON UNIVERSITY AND THE CONTRIBUTORS TO THIS WORK        ;;;
;;; DISCLAIM ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING     ;;;
;;; ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT  ;;;
;;; SHALL CARNEGIE MELLON UNIVERSITY NOR THE CONTRIBUTORS BE LIABLE     ;;;
;;; FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES   ;;;
;;; WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN  ;;;
;;; AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION,         ;;;
;;; ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF      ;;;
;;; THIS SOFTWARE.                                                      ;;;
;;;                                                                     ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Phoneset for net_fr
;;;

;;;  Feel free to add new feature values, or new features to this
;;;  list to make it more appropriate to your language


; When you modify this file to adapt it to your voice, keep in mind that
; whatever you call your phones here should be consistent with two things: i)
; the label files you have provided above for creating the utterances: you need
; phone level label files where every label that occurs in your label file
; corresponds to a phone name in your phone set. And ii) the phone names have to
; be consistent with what comes from the lexicon we will use for lookup. In
; theory it doesn't really matter which of the three things you change (lexicon,
; phone set, label files) – they only have to be consistent.


; ex si oubli d'un nouveau phonème disons "ol" pb au niveau de build_clunits 
; dans le catalogue il n'y sera pas !
; Phoneme: ol has no duration info
; CLUNITS: no Naively assumes that vowels in phoneset start with (upper or lower english letter vowels)
; $3 ~ /^[AaEeIiOoUu@]   we took $3 ~ /^[aeiouy].*
; predicted class for ol
; pas de feats/ol.feats
; rien déjà dans festival/dur/data/dur.data
; attention intervient aussi dans find_powerfactors pour make_lpc 

; usage de pau
; Also pau can be used as a replacement of missing diphone or can be
; inserted by pre_synth_hook which postprocess diphone names.

(defPhoneSet "INST_LANG"
  ; 3 arguments PHONESETNAME net_fr,  FEATURES PHONEDEFS
  ; Define a new phoneset named PHONESETNAME.  Each phone is described with a
  ; set of features as described in FEATURES.  Some of these FEATURES may
  ; be significant in various parts of the system. 
  ;;  FEATURES  
  ( 
    (vc + - 0)  ;; vowel or consonant
    ;; festvox/src/ldom/all.desc
    ;; vowel length: short long diphthong schwa
    (vlng 0 a d l s) 
    
    ;; vowel height: high mid low
    (vheight 0 1 2 3)
    
    ;; vowel frontness: front mid back
    (vfront  0 1 2 3 )
    
    ;; lip rounding
    
    (vrnd + -)

    ;; consonant type: stop fricative affricative nasal liquid  

    ; mode d'articulation 
    ;occlusive -> stop -> [s  p – b – t – d – k –g]
    ;fricatives (ou constrictives, spirantes) : un rétrécissement des parois produit un frottement, mais l’air passe, et ces consonnes peuvent durer :
    ; [f – v – s – z]
    ;l : Consonne fricative latérale apico-alvéolaire (la pointe de la langue pose sur les alvéoles, mais l'air passe par les côtés),
    ; fricative  ?
    (ctype 0 a f l n r s) 

    ;; place of articulation: labial alveolar palatal labio-dental  dental velar

    ;; C'est l'endroit où se situe l'obstacle : les lèvres / les dents / ou le dessous des dents : les alvéoles / 
    ; le palais (la partie dure, centrale) / le voile du palais (le fond, la partie molle),
    (cplace  0 a b d g l p v) ; dans f0.desc on a cplace 0 a b d l p v g -) g?

    ;; consonant voicing
    (cvox + - 0))
  ;; CHGT !! dans ldom on avait   (cvox + - 0) je le mets à cause des rh
  ;; PHONEDEFS / Phone set members 
  (
    ;; !! better to use "safe" names :
    ;; not beginning with a number python
    ;; differentiable without case sphinx
    ;; giving safe name for files as it will be created eponym files ex ph.tree
    (i   + 0 1 1 - 0 0 +)  ;i dans "vie"  close front unrounded vowel
    ;<vowel ph i ipa i l 1 1 - /> [i]         il, vie, lys
    (il + l 2 1 - 0 0 +) ; ??  0 high mid low
    (iw + s 1 1 - 0 0 +) ; précédé de hw
    (e   + l 2 1 - 0 0 +)  ;e dans "dé"   close mid-front unrounded vowel
    ;<vowel ph e ipa e l 2 1 - /> [e]        blé, nager, été

    (eh  + l 2 1 -   0 0 +)  ;E dans "dette"  open mid-front unrounded vowel
     ;<vowel ph E ipa ɛ l 2 1 - />  [ɛ]        paix, bleuet, persil, baleine
    (a   + l 3 2 -    0 0 +)  ; 1905 mid non low a dans "ma"  open central unrounded vowel
     ;<vowel ph a ipa a l 3 2 - />  [a]        table, patte, moral
    (al   + l 2 2 -    0 0 +)  ; al exclamation
    ;voyelles longues
    (oe  + s 2 2 +   0 0 +)  ;9 dans "peur" open mid-front rounded vowel
    ;<vowel ph 9 ipa œ s 2 2 + /> [œ]       beurre, meuble, œuf
    (ae  + a 2 2 -   0 0 +)  ; 1905 schwa et non pas long close open mid-central rounded vowel
    ;<vowel ph @ ipa ə a 2 2 - />  [ə]        le, denier, menuet
    (eu  + l 2 2 +   0 0 +)  ;2 dans "jeu" close mid-front rounded vowel
    ;<vowel ph 2 ipa ø l 2 2 + />
    (y   + l 2 1 +    0 0 +)  ;y dans "lutte" close front rounded vowel
     ;<vowel ph y ipa y l 1 2 + />
    (u   + l 1 3 +    0 0 +)  ;u dans "doux" close back rounded vowel
     ;<vowel ph u ipa u l 1 3 + />
    (o   + l 2 3 -    0 0 +)  ;o dans "do" close mid-back rounded vowel
    ;<vowel ph o ipa o l 2 3 + />
    (ol   + l 2 3 -    0 0 +)  ; neut_book_s01_0020, neut_book_s08_0104
    (oh  + s 2 3 +   0 0 +)  ;O dans "lotte" open mid-back rounded vowel
     ;<vowel ph O ipa ɔ s 2 3 + />
    ;voyelles longues
    (ah  + l 1 1 -     0 0 +)  ;a dans "âne"
     ;<vowel ph 3 ipa ɜ l 1 1 - />
    ;diphtongues     no description :(
    (ehn + l 2 1 -     n 0 +)  ;En dans "plainte"  [ɛ̃]        matin, plein, main
     ;<vowel ph e~ ipa ẽ l 2 1 - ctype n />
    (oen + l 2 1 +     n 0 +)  ;9n dans "junte"
     ;<vowel ph 9~ ipa œ̃ l 2 2 + ctype n />
    (ohn + l 2 3 -     n 0 +)  ;On dans "fond"
     ;<vowel ph o~ ipa õ l 2 3 + ctype n />
    (ahn + l 3 2 -     n 0 +)  ;An dans "lent"
     ;<vowel ph a~ ipa ã l 3 2 - ctype n />

    (bd 0 0 0 0 - 0 0 -) ; bidon poussière pitchée essai

    ;semi-voyelles    inspiré de la version catalane; mis en consonne car sinon perturbe is_vowel
    (w   - d 3 3 -    0 l +)  ; glide labial ? CHGT ?? 0 0 - en 0 l +  ou ??  voiced labio-velar approximant CHGT2 diphtongue
    ;  <consonant ph w ipa w r  l  + />  [w]    oui, toit, jouet
    (j   - s 3 1 -    r p +)  ; glide palatal CHGT ?? 0 0 - en 0 p - yeux  palatal approximant
    ;<consonant ph j ipa j r  p  + /> [j]      yeux, caille, pied, vrille
    (hw  - d 3 1 -   r l +)  ; glide labial CHGT 0 0 - en 0 l -  huile[ɥ]     tuile, luire, nuit  labial palatal approximant()  CHGT2 diphtongue 


    ;<consonant ph H ipa ɥ r  l  + />
    ; 
    ;consonnes     https://fr.wiktionary.org/wiki/Annexe:Prononciation/fran%C3%A7ais
    ;; roa.rutgers.edu/files/474-1101/474-1101-FERY-0-0.PDF

    (n   - 0 0 0 +    n a +)  ; nasal alveolar OK  
    ;<consonant ph n ipa n n  a  + />
    (jg  - 0 0 0 +    n p +)
    ;;  (ng  - 0 0 0 +    n p +)  ; retroflex nasal ? ABANDONNE  
    ;<consonant ph J ipa ɲ n  p  + />
    (g   - 0 0 0 +    s v +)   ; plosive voiced velar  OK 
    ;<consonant ph g ipa ɡ s  v  + />
    (k   - 0 0 0 +    s v -)   ; plosive voiceless velar OK ipa k s  v  -
    (m   - 0 0 0 +    n l +) ; nasal labial  OK    <consonant ph m ipa m n  l  + />
    (b   - 0 0 0 +    s l +) ; plosive voiced labial voiced -1 +  OK pa b s  l  +
    (p   - 0 0 0 +    s l -) ; plosive voiceless labial OK  ipa p  s  l  -
    ;; -3 s as plosive  consonant type: stop fricative affricative nasal liquid    (ctype s f a n l 0)
    ;; -2 l as labial              cplace     ;; place of articulation: labial alveolar-palatal labio-dental dental velar (cplace l a p b d v 0)

    (v   - 0 0 0 +    f b +)  ; fricative voiced labial CHGT b -> l  
    ;<consonant ph v ipa v f  b  + />

    (f   - 0 0 0 +    f b -)  ; fricative voiceless labial  CHGT b -> l 7
    ;<consonant ph f ipa f f  b  - />
    (d   - 0 0 0 +    s a +)  ; plosive voiced alveolar CHGT d -> p 
    ;<consonant ph d ipa d s  a  + />
    (t   - 0 0 0 +    s a -)  ; plosive voiceless alveolar CHGT d -> a ? ipa t s  a  -
    (sh  - 0 0 0 +    f p -)  ; voiceless palato alveolar sibilant  
    ;<consonant ph S ipa ʃ f  p  - />

    (zh  - 0 0 0 +    f p -)  ; palato alveolar sibilant  
    ;<consonant ph Z ipa ʒ f  p  - />

    (z   - 0 0 0 +    f a +)  ; fricative voiced alveolar CHGT p-> a voiced alveolar sibilant  
    ;<consonant ph z ipa z f  a  + />

    (s   - 0 0 0 +    f a -)  ; fricative voiceless alveolar CHGT OK voiceless alveolar sibilant   
    ;<consonant ph s ipa s f  a  - />

    (rh  - 0 0 0 +    l 0 +) ; tempo 23/10 
    ;<consonant ph R ipa ʁ f  u  - />

    (rhx - 0 0 0 +    f 0 +) ; pour distinguer quoi ? les r non suivi de voyelle ou de schwa ? et non précédé de  d'un stop ?
    ;; ??? ...- mis en liquide pour les règles ??? f = fricative !    
    ;; ex frère  [X ] fricative voiceless  ; ex vrai [ʁ] R à l'envers voiced fricative  ;  ex : ruine, rien  R liquid ;  les 3 uvular  
    ; (of a consonant) articulated with the back of the tongue close to or touching the uvula, as the r-sound of Parisian French. 
    ; X vélaire sourde = jota espagnol ... sinon fricative sourde ou sonore suivant le contexte
    ; -2 ??? uvular 0 ???
    ;; je choisis 2 r fricative distingués par cvox 
    ;; non embrigué plus avant dans une syllabe  "ahn t rhx l e" versus "ahn t rh ae l e"
    (l   - 0 0 0 +  l a +)  ;  liquid alveolar OK alveolar lateral approximant 
    ;; cvox + ? pas voisé mais nécessitant une voyelle pour être voisé
    ;; pas "voiced consonant" mais  "consonant voicing"



    ;;; 
    ;; distinguo liquide non liquide ... plus une question de b rh comme b l  peuvent coexister dans 
    ;; une même syllabe
    ;;  contrairement à b k , b d ; b f ; b g; 
    ;;  
    ;<consonant ph l ipa l l  a  + />
    (hh  - 0 0 0 +   f a -)  ; voiceless glottal fricative         h haspiré
    (hs  - 0 0 0 -   0 0 -) ;  h Simple mémno 
    (pau - 0 0 0 -   0 0 -)
    (#   - 0 0 0 -   0 0 -)  ;; silence ... ; for multisyn and ? lts_testset
    (##   - 0 0 0 -   0 0 -) ; phrase break essai finnish
    ("" - 0 0 0 -   0 0 -)  ; TODO bug s'était 
    ))

(PhoneSet.silences '(pau hh))
(provide 'INST_LANG_phones)


;; glide semi-consonne ou glissée 
;; j physiquement une fricative

; voiceless k p t f sh zh s rhx hh hs 

; voyelle longue 
;  suivant la règle qui est que l's du pluriel rend la voyelle longue ou fermée littré à propos de abricot ..
