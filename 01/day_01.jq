def pairs:
  [.[1:], .[:-1] ] | transpose;

def window_of_three:
  [ .[2:], .[1:-1], .[:-2] ] | transpose | map(add);

def drops:
  . | pairs | map(select(.[0] > .[1])) | length;

def part1:
  [ inputs | tonumber ] | drops;

def part2:
  [ inputs | tonumber ] | window_of_three | drops;

