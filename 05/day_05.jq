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

