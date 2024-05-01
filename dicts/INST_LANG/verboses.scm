

(set! lev 10000)

(set! verbose_INST_LANG_token t)
(set! verbose_INST_LANG_token_to_word t); pour INST_LANG_token_to_word_full ou INST_LANG_token_to_word_tes
(set! verbose_norm) ; INST_LANG_norm

(set! verbose_addendas t) ; communs à tous les addendas (affiche l'addenda chargé)

;; /dicts_INST_LANG/verboses.scm
(set! verbose_correction_lts t)
(set! verbose_supra_lts t)
(set! verbose_INST_LANG_lex t)
(set! verbose_postlex t)
(set! verbose_phoneutils t)
(set! verbose_words_exceptions t); INST_LANG_words_exceptions

; définis dans dicts/INST_LANG_utils.scm 
(set! debuglevel lev)
(set! phonedebuglevel lev)
(set! tokendebuglevel lev)
(set! posdebuglevel lev)
(set! phonedebuglevel lev)

(set! lexdebuglevel lev)
(set! postlexdebuglevel lev)
(set! ltsdebuglevel lev)
(set! pausedebuglevel lev)

(set! testlevel 1)
