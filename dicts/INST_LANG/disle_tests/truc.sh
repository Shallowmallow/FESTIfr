#!/usr/bin/env bash
 FESTIVALDIR="/home/dop7/Develop/festival"
 tests_dir="$FESTIVALDIR/lib/dicts/INST_LANG/disle_tests/"
 rm -i "${tests_dir}"/tests
 myarr=()
 mapfile -t myarr < <(find "${tests_dir}" -maxdepth 1 -name "'tests-'*" | sort -r)
 echo "${myarr[0]}"; # /home/dop7/Develop/festival/lib/dicts/INST_LANG/disle_tests/tests-4
 echo tentative archivage du dernier en tests-$(( "${#myarr[@]}" + 1 )); # 5
 nouvelle_archive="${tests_dir}"/tests-$(( "${#myarr[@]}" + 1 )); # echo $nouvelle_archive /home/dop7/Develop/festival/lib/dicts/INST_LANG/disle_tests//tests-5
 mkdir -p "${nouvelle_archive}"
 mv  "${tests_dir}"/tests1/* "${nouvelle_archive}"
 # on reprend le dernier ttd
 cp "${nouvelle_archive}"/ttd "${tests_dir}"/tests1
ln -s -L -r  -v  -T  "${tests_dir}"/tests1 "${tests_dir}"/tests; # cible nom de lien relatif
    
cp -b "$FESTIVALDIR"/lib/INST_LANG/INST_LANG_token_to_words_autre.scm "${tests_dir}"/tests/
cp -b "$FESTIVALDIR"/lib/INST_LANG/INST_LANG_norm.scm "${tests_dir}"/tests/
cp -b "$FESTIVALDIR"/lib/dicts/INST_LANG/INST_LANG_token_to_words_lists.scm "${tests_dir}"/tests/

if [[ ! -s "${tests_dir}"/tests/ttd ]]; then 
echo no non empty "${tests_dir}"/tests/ttd generated; exit 1;
else
echo working with "$(wc -l <"${tests_dir}"/tests/ttd)" texts
fi
# exit 0
"$FESTIVALDIR"/bin/festival -b "${tests_dir}"/check.scm '(begin  (check "'"${tests_dir}/tests/ttd"'"))' || echo better to clean ...
echo the last completed test is to be compared to tests-$(( "${#myarr[@]}" + 1 ))
