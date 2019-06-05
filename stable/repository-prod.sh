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
  sed -i 's#\(repository:\) file://../.*#\1 https://onedata.github.io/charts/#' $f ;
done < <(find . -name requirements.yaml)
