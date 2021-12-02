def parse_instruction:
  . | split("") | [.[0], (.[-1] | tonumber)] | (
        if .[0] == "u" then [0, -.[1]]
        elif .[0] == "d" then [0, .[1]]
        else [.[1], 0]
        end
    )
  ;

def total_displacement:
  reduce .[] as $move ([0,0] ; [.[0] + $move[0], .[1] + $move[1]]);

def total_displacement_with_aim:
  reduce .[] as $move ([0,0,0] ; ([
    .[0] + $move[0],             # Forward position
    .[1] + (.[2] * $move[0]),    # Depth + aim*forward
    .[2] + $move[1]]             # Aim
  )) | [.[0], .[1]] ;

def part1:
  [ inputs | parse_instruction ] | total_displacement | .[0] * .[1];

def part2:
  [ inputs | parse_instruction ] | total_displacement_with_aim | .[0] * .[1];
