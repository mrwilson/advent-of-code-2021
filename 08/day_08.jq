def parse_input:
  split(" | ") | { digits: (.[0] | split(" ")), display: (.[1] | split(" ")) };