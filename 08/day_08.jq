def parse_input:
  split(" | ") | { digits: (.[0] | split(" ")), display: (.[1] | split(" ")) };

def known_digits_in_display:
  .display | map(length) | map(select(. == 2 or . == 3 or . ==4 or . == 7)) | length;