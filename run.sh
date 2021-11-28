#!/bin/bash

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

echo -e "### Executing tests for day ${DAY}\n"
  jq -r \
    --null-input \
    --raw-input \
    -L. \
    -L${DAY} \
    "import \"day_${DAY}_test\" as t; t::run"

if [[ $TESTS_ONLY != "true" ]]; then
  echo -e "\n### Executing ${DAY}.${PART}\n"

  cat $DAY/input.txt | \
    jq -r \
      --null-input \
      --raw-input \
      -L. \
      -L${DAY} \
      "import \"day_$DAY\" as d; \"Part ${PART} : \([inputs] | d::part${PART})\""
fi



