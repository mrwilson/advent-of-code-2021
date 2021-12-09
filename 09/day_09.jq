def parse_input:
  map(split("") | map(tonumber));

def neighbours($x; $y): (
  (.[0] | length) as $y_length
  | (. | length) as $x_length
  | [
   ( if $y == 0 then null else {x: $x, y:($y-1), value: .[$x][$y-1]} end ),
   ( if $y == $y_length-1 then null else {x: $x, y:($y+1), value: .[$x][$y+1]} end),
   ( if $x == 0 then null else {x: ($x-1), y:$y, value: .[$x-1][$y]} end),
   ( if $x == $x_length-1 then null else {x: ($x+1), y:$y, value: .[$x+1][$y]} end)
 ]) | map(select(. != null)) | sort_by(.value);

def low_points: (
    (.[0] | length) as $x_length | (. | length) as $y_length | . as $grid
    | [ [range(0; $y_length)], [range(0;$x_length)] ]
    | [combinations]
    | map(. as $point | $grid | [$grid[$point[0]][$point[1]], (neighbours($point[0]; $point[1]) | map(.value))])
    | map(select(.[0] < (.[1]|min)))
    | map(.[0])
  );

def total_risk_levels:
  low_points | map(.+1) | add;

def part1:
  [inputs] | parse_input | total_risk_levels;