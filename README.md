# FESTfr


(Vous pouvez retrouvez ce readme ainsi que les docs dans le répertoire docs sous le format tiddly)

FESTifr est une voix française clustergen expérimentale.

Elle est fonctionnelle dans un environnement Linux: pour l'essayer il suffit de

- installer festival et festival-freebsoft-utils et de
- glisser les fichiers proposés dans  `/usr/share/festival`
- de lancer `festival --libdir /usr/share/festival`
- et à l'invite de festival:  `(SayText "Ne le nions pas, y a encore du boulot sur la planche")`

## Nos partis-pris

### le caractère expérimental

Cette voix, on lui a laissé le nom générique INST_LANG_VOX_cg, sans préciser INST, ni LANG, ni VOX. Cela offre de multiple avantages: on peut notamment créer un répertoire par variante Par défaut, il s'agira du répertoire scratch mais on a même prévu une variante vanilla, utilisant les fichiers vanilla de Festvox, et une variante scratch_clean utile comme référence

Pour la partie développement de VOX, on se dirigera vers : https://github.com/ddavout/theotherway_VOX.

Ici on développe la partie "LANG".

### légèreté au détriment du rendu

Pour être plus rapide, on ne s’embarrasse pas d'une VOX **lourde**: on se base sur un faible nombre de prompts, quasi **minimal** : le répertoire festival/trees de la voix a une taille de l'ordre de 1Mo.


### développement en phases

La LTS est loin d'être optimum. Elle sera améliorée dans un deuxième temps (elle y gagnera en cohérence et en légereté !)

Pour l'heure, la priorité étant donnée à l'amélioration des règles ''INST_LANG_token_to_words''**.

Le système qu'on a mis au point peut être d'un intérêt pour une autre langue : on utilise en effet des règles facilement débrayables (ce qui permet de voir leur réél impact) et on tente de pallier l'insuffisance des expressions régulières sous SIOD à la manière de ims_german (pattermatch ), ce qui rend INST_LANG_token_to_words gérable. Dès que nous y apportons une modification, on peut tester son effet sur des milliers de tests.

On n'a pas cru bon de recourir à **grapheme**, qu'utilise bon nombre de langues asiatiques, cependant on a fait le choix de utf8, en contournant les difficultés des characters codés sur 2 bytes, et en adaptant diverses procédures, pour n'en citer qu'une string-length_utf8. Rien d'insurmontable, puisque Festival dispose (déjà !) des fonctions comme utf8chr, utf8explode et utf8ord. (Le terminal de Festival, lui reste résolument utf8_non_friendly mais on s'y fait)

Notre voix peut servir aussi de piste quant à l'utilisation d'un hook optionnel INST_LANG_lex_pre_hook: le fait que nos verbes conjugués peuvent avoir jusqu'à 4 lettres muettes posait problème. Il aurait peut-être fallu augmenter le nombre de **features** au moins pour les verbes (par défaut pris à 5)

On a construit antérieurement en suivant l'exemple de festival-ca, un lexique **INST_LANG_freeling.poslex**, aujourd'hui on le construirait peut-être différemment, mais on en tire vraiment parti : on n'utilise d'ailleurs pos à la place de gpos dans nos fichiers de description *.desc à l'intention de wagon

Cependant, le français ne fait pas partie des langues pour lesquelles il suffit de connaitre la fonction grammaticale d'un mot et d'appliquer quelques règles pour lire n'importe quel mot, on a un gros problème à résoudre avec nos liaisons, sans compter, AMHO, que nos règles de grammaire gagneraient à être simplifiées.

Pour y faire face, on a mis au point un certain nombre de règles basées sur le pos des mots à lier ou pas, assez flexibles (peut-être trop !)

Le hook postlex, censé corriger les imperfections, une fois l'analyse de la phrase effectuée, est, nul doute, à reprendre (correction et allègement)

### Imperfections

Le code, BASH et SCHEME, est lui aussi loin d'être irréprochable, mais du coup est améliorable :)


## Buts

Le but ultime de ces deux projets est de développer une voix FLITE, bénéficiant d'un maximum de sophistications tentées dans la clustergen au niveau du tokenizer, tout en respectant nos spécificités ponctuation, liaisons, etc.

Présomptueux ? sans doute, nous n'avons aucun exemple de langue utilisant à la fois poslex et un INST_LANG_lex_pre_hook

En attendant, on peut d'ores et déjà intégrer une voix française aux dictionnaires français de http://goldendict.org. Ou une fois installée la voix localement, utiliser Foliate pour écouter-voir ses livres en français.


## Oublis coupables


### Non!

J'ai oublié de parler de l'avantage certain d'une voix basée sur Festival !!

Une fois installée sur l'ordinateur, nul besoin de posséder une connexion internet ! et quand on aura réhabilité notre voix Flite, on pourra travailler ... en français à l'abri d'investigation de grandes oreilles sur un smartphone ou une tablette, ou s'amuser, apprendre à l'abri des tentations et dangers de la toile.

Certes on ne pourra pas rivaliser avec les commerciales, mais on y gagne la quiétude du hors-ligne !

De plus, avec la technologie Festival, on peut développer une voix sans recourir au Cloud.

Cette nuit, mon ordinateur acheté à 10 euros, qualifié de Low Profile Desktop avec ses 2 core et 7916 Mega de mémoire, n'a mis que 4h30 pour pondre une voix basée sur 1990 prompts.

Qu'on se le dise, FESTIfr est une voix entièrement configurable et n'a pas vocation à rester franco-française.