def parse_input:
  ./"" | map(tonumber);

def flashing_octopodes:
  (first|length) as $size | flatten | indices(9) | map([ ./$size|floor, .%$size ]);

def neighbouring_octopodes($x; $y):
  [1,0,-1] | [ map(.+$x), map(.+$y) ] | [ combinations | select(min >= 0 and . != [$x, $y])];