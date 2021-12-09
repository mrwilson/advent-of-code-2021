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
    | map(. as $point | $grid | {
        x: $point[0],
        y: $point[1],
        value: $grid[$point[0]][$point[1]],
        neighbour_values: (neighbours($point[0]; $point[1]) | map(.value))
    })
    | map(select(.value < (.neighbour_values|min)))
    | map({ x: .x, y: .y, value: .value})
  );

def basin_at($x; $y): (
  . as $grid
  | { level: $grid[$x][$y], next: ($grid | neighbours($x; $y)), basin: [$grid[$x][$y]] }
  | until(.next | length == 0; (.level as $level | .next | map(select(.value == ($level+1) and .value != 9))) as $candidates
  | {
    level: (.level+1),
    next: ([ $candidates[] as $pair | $grid | neighbours($pair.x;$pair.y)] | flatten | unique),
    basin: (.basin + ($candidates | map(.value)))
  }
  )) | .basin;

def three_largest_basins:
  [low_points[] as $low | basin_at($low.x; $low.y) ] | map(length) | sort | .[-3:];

def total_risk_levels:
  low_points | map(.value | .+1) | add;

def part1:
  [inputs] | parse_input | total_risk_levels;