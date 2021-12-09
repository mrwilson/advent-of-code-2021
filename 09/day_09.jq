def parse_input:
  map(split("") | map(tonumber));

def neighbours($x; $y): (
  (.[0] | length) as $size
  | [
   ( if $y == 0 then -1 else .[$x][$y-1] end ),
   ( if $y == $size-1 then -1 else .[$x][$y+1] end),
   ( if $x == 0 then -1 else .[$x-1][$y] end),
   ( if $x == $size-1 then -1 else .[$x+1][$y] end)
 ]) | map(select(. >= 0)) | sort;

def low_points: (
    (.[0] | length) as $x_length | (. | length) as $y_length | . as $grid
    | [ [range(0; $y_length)], [range(0;$x_length)] ]
    | [combinations]
    | map(. as $point | $grid | [$grid[$point[0]][$point[1]], neighbours($point[0]; $point[1])])
    | map(select(.[0] < (.[1]|min)))
    | map(.[0])
  );

def total_risk_levels:
  low_points | map(.+1) | add;

def part1:
  [inputs] | parse_input | total_risk_levels;