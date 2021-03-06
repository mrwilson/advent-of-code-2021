def fuel:
  ./3 | floor | .-2;

def required_weights:
  if (.[-1] | fuel) <= 0 then . else (. + [.[-1] | fuel] | required_weights) end;

def part1:
  [ inputs | tonumber | fuel] | add;

def part2:
  [ inputs | [tonumber] | required_weights | .[1:] ] | flatten | add;
