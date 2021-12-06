def parse_input:
  . | split(",") | map(tonumber) | group_by(.) | map(length) | [0] + .;