def reverse_diagonal_multiplier:
  if .y1 > .y2 then -1 else 1 end;

def vents_to_coordinates($include_diagonals): (
  . | split("\\D"; "ig")
    | map(select(. != ""))
    | map(tonumber)
    | [[.[0], .[1]],[.[2], .[3]]]
    | sort
    | { x1: .[0][0], y1: .[0][1], x2: .[1][0], y2: .[1][1] }
    | if
        .y1 == .y2 then [ . as $pairs | range(.x1;.x2+1) | [., $pairs.y1 ]]
      elif
        .x1 == .x2 then [ . as $pairs | range(.y1;.y2+1) | [ $pairs.x1 ,.]]
      elif
        $include_diagonals then reverse_diagonal_multiplier as $rdm
            | [ [range(.x1 ; .x2 + 1) ], [ range(.y1 ;.y2 + $rdm ;$rdm) ] ] | transpose
      else
        []
      end
  );

def duplicate_points:
  . | group_by(.) | map(select(. | length > 1)) | map(.[0]) ;

def total_crossover_points($include_diagonals):
  [ .[] | vents_to_coordinates($include_diagonals) ] | flatten(1) | duplicate_points | length;

def part1:
   [ inputs ] | total_crossover_points(false);

def part2:
   [ inputs ] | total_crossover_points(true);