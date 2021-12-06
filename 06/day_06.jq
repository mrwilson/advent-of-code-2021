def parse_input:
  . | split(",") | map(tonumber) | group_by(.) | map(length) | [0] + . ;

def tick: (
    .[0] as $new_fish
        | .[1:]
        | .[8] = .[8] + ($new_fish // 0)
        | .[6] = .[6] + ($new_fish // 0)
        | map(if . == null then 0 else . end)
  );

def spawn_lanternfish($days):
  . | [$days, parse_input] | until(.[0] == 0 ; [ (.[0] - 1), (.[1] | tick) ])[1] | add;