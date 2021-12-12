def parse_input:
  ./"" | map(tonumber);

def flashing_octopodes: [paths(numbers > 9)];

def neighbouring_octopodes($x; $y; $n):
  [1,0,-1] | [ map(.+$x), map(.+$y) ] | [ combinations | select(min >= 0 and max < $n and . != [$x, $y])];

def flashes($octopodes):
  $octopodes | flatten | map(select(. == 0)) | length;

def tick: (
  length as $size |
  map(map(.+1)) |
    until((flashing_octopodes | length) == 0 ;
     flashing_octopodes as $flashes
     | ($flashes | map(neighbouring_octopodes(.[0]; .[1]; $size)) | flatten(1) | group_by(.) | map([.[0], length])) as $neighbours
     | reduce $flashes[] as $flash (. ; .[$flash[0]][$flash[1]] |= "X")
     | reduce $neighbours[] as $pair (. ; .[$pair[0][0]][$pair[0][1]] |= (if . == "X" then "X" else .+$pair[1] end))
    ) | map(map(if . == "X" then 0 else . end))
);

def count_flashes($ticks): (
  [$ticks, ., 0] | until(.[0] == 0 ; (.[1] | tick) as $next | [ (.[0]-1), $next, (.[2] + flashes($next))])[2]
);

def first_simultaneous_flash:
   [0, .] | until(flashes(.[1]) == 100 ; (.[1] | tick) as $next | [ (.[0] + 1), $next ])[0];

def part1:
  [ inputs | parse_input ] | count_flashes(100);

def part2:
  [ inputs | parse_input ] | first_simultaneous_flash;