function run_tests_for_day() {
  DAY=$1

  TEST_OUTPUT=$(jq -r \
    --null-input \
    --raw-input \
    -L. \
    -L${DAY} \
    "import \"day_${DAY}_test\" as t; t::run")

  echo "$TEST_OUTPUT"
  echo

  if [[ "$TEST_OUTPUT" == *"not ok"* ]]; then
    exit 1
  fi

}