#!/bin/bash

source ./test.sh

while getopts ":d:p:t" opt; do
  case ${opt} in
    d ) DAY=$(printf "%02d\n" $OPTARG) ;;
    p ) PART=$OPTARG ;;
    t ) TESTS_ONLY="true" ;;
  esac
done

if [[ -z $DAY || ( -z $PART && -z $TESTS_ONLY ) ]]; then
  echo "Usage: run.sh [-d (day)] [-p (part)] [-t (tests only)]"
  exit 0
fi

run_tests_for_day ${DAY}

if [[ $TESTS_ONLY != "true" ]]; then
  echo -e "\n### Executing ${DAY}.${PART}\n"

  cat $DAY/input.txt | \
    jq -r \
      --null-input \
      --raw-input \
      -L. \
      -L${DAY} \
      "import \"day_$DAY\" as d; \"Part ${PART} : \(d::part${PART})\""
fi



