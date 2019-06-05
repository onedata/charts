#!/usr/bin/env bash

aliases() {
  case $( uname -s ) in
    Linux)
          _sed=sed
          ;;
    Darwin)
          _sed=gsed
          ;;
  esac
}
aliases

while read f ; do
  while read l ; do
    sed  -i '/- name: '$l'/,/repository/{s#\(repository:\).*onedata.*#\1 file://../'$l'#}'  $f ;
  done < <(sed -n 's/- name: \(.*\)/\1/p' $f)
done < <(find . -name requirements.yaml)