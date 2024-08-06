#!/bin/bash

main() {
  TYPES=$1
  FILE=$2
  CSV=$(cat $FILE | tr '\n' ' ')
  CSV=${CSV:-1}
  INPUTS=$(echo $CSV | sed 's/ /),(/g')
  cast abi-encode "_(($TYPES)[])" "[($INPUTS)]"
}

main $@
