def pairs:
  [.[1:], .] | transpose | .[:-1];

def drops:
  . | pairs | map(.[0] - .[1]) | map(select(. > 0)) | length;

def part1:
  [ .[] | tonumber ] | drops;

