import "util" as u;

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

def non_boundary_neighbours($points):
  [ $points[] as $pair | . | neighbours($pair.x;$pair.y) | map(select(.value != 9)) ] | flatten | unique;

def basin_at($x; $y): (
  . as $grid
      | { next: [{ x: $x, $y, value: $grid[$x][$y]}], basin: [] }
      | until(.next | length == 0; {
            next: ((.next as $next | $grid | non_boundary_neighbours($next))-.basin),
            basin: (.basin + .next) | unique
      })
      | .basin
      | map(.value)
  );

def three_largest_basins:
  [low_points[] as $low | basin_at($low.x; $low.y) ] | map(length) | sort | .[-3:];

def total_risk_levels:
  low_points | map(.value | .+1) | add;

def part1:
  [inputs] | parse_input | total_risk_levels;

def part2:
  [inputs] | parse_input | three_largest_basins | u::product;