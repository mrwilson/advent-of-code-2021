import "util" as u;

def parse_input:
  split(",") | map(tonumber) ;

def linear: .;
def triangle: 0.5 * . * (.+1);

def distances_from_points(metric): (
  . as $input
    | [ min, max ] as $edges
    | [ range($edges[0] ; $edges[1] + 1) | [ . | $input[] as $i | u::abs($i - .) | metric] ]
  );

def shortest_distance_from_points(metric):
  distances_from_points(metric) | map(add) | min;

def part1:
  inputs | parse_input | shortest_distance_from_points(linear);

def part2:
  inputs | parse_input | shortest_distance_from_points(triangle);