def parse_input:
  split(",") | map(tonumber) ;

def distances_from_points: (
  . as $input
    | [ min, max ] as $edges
    | [ range($edges[0] ; $edges[1] + 1) | [ . | $input[] as $i | $i - .  | if . < 0 then -. else . end ] ]
  );

def shortest_distance_from_points:
  distances_from_points | map(add) | min;