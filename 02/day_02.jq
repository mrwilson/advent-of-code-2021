def parse_instruction:
  . | capture("(?<direction>[a-z]+) (?<distance>[0-9]+)") | (
        if .direction == "up" then
            [0, - (.distance|tonumber)]
        elif .direction == "down" then
            [0, .distance|tonumber]
        else
            [ .distance|tonumber,0]
        end
    )
  ;

def total_displacement:
  reduce .[] as $move ([0,0] ; [.[0] + $move[0], .[1] + $move[1]]);

def part1:
  [ inputs | parse_instruction ] | total_displacement | .[0] * .[1];

def part2:
  [ inputs | [tonumber] | required_weights | .[1:] ] | flatten | add;
