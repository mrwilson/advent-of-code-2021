def pairs:
  [.[1:], .] | transpose | .[:-1];

def window_of_three:
  [.[2:], .[1:], .] | transpose | .[:-2] | map(add);

def drops:
  . | pairs | map(.[0] - .[1]) | map(select(. > 0)) | length;

def part1:
  [ .[] | tonumber ] | drops;

def part2:
  [ .[] | tonumber ] | window_of_three | drops;

