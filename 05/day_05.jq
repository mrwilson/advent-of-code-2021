def reverse_diagonal_multiplier:
  if .[0][1] > .[1][1] then -1 else 1 end;

def vents_to_coordinates($include_diagonals): (
  . | split("\\D"; "ig")
    | map(select(. != ""))
    | map(tonumber)
    | [[.[0], .[1]],[.[2], .[3]]]
    | sort
    | if .[0][1] == .[1][1] then
        [ . as $pairs | range(.[0][0];.[1][0]+1) | [., $pairs[0][1] ]]
      elif .[0][0] == .[1][0] then
        [ . as $pairs | range(.[0][1];.[1][1]+1) | [$pairs[0][0], . ]]
      elif $include_diagonals then
        reverse_diagonal_multiplier as $rdm
            | [ [range(.[0][0];.[1][0]+1) ], [ range(.[0][1];.[1][1]+$rdm;$rdm) ] ] | transpose
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