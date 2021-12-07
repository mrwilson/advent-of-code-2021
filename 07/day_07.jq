import "util" as u;

def parse_input:
  split(",") | map(tonumber) ;

def distances_from_points: (
  . as $input
    | [ min, max ] as $edges
    | [ range($edges[0] ; $edges[1] + 1) | [ . | $input[] as $i | u::abs($i - .) ] ]
  );

def cumulative_distances_from_points: (
  . as $input
    | [ min, max ] as $edges
    | [ range($edges[0] ; $edges[1] + 1) | [ . | $input[] as $i | u::abs($i - .) | 0.5 * . * (. + 1) ] ]
  );

def shortest_distance_from_points:
  distances_from_points | map(add) | min;

def shortest_cumulative_distance_from_points:
  cumulative_distances_from_points | map(add) | min;

def part1:
  inputs | parse_input | shortest_distance_from_points;

def part2:
  inputs | parse_input | shortest_cumulative_distance_from_points;