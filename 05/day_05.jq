def vents_to_coordinates: (
  . | split("\\D"; "ig")
    | map(select(. != ""))
    | map(tonumber)
    | [[.[0], .[1]],[.[2], .[3]]]
    | sort
    | if .[0][1] == .[1][1] then
        [ . as $pairs | range(.[0][0];.[1][0]+1) | [., $pairs[0][1] ]]
      elif .[0][0] == .[1][0] then
        [ . as $pairs | range(.[0][1];.[1][1]+1) | [$pairs[0][0], . ]]
      else
        []
      end
  );

def duplicate_points:
  . | group_by(.) | map(select(. | length > 1)) | map(.[0]) ;

def total_crossover_points:
  [ .[] | vents_to_coordinates ] | flatten(1) | duplicate_points | length;

def part1:
   [ inputs ] | total_crossover_points;