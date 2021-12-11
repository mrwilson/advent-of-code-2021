def parse_input:
  ./"" | map(tonumber);

def flashing_octopodes:
  (first|length) as $size | flatten | indices(9) | map([ ./$size|floor, .%$size ]);