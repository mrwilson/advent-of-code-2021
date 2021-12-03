def binary_to_number:
  . | reverse | reduce .[] as $digit (
        [0,0] ;
        [.[0]+1, .[1]+($digit*pow(2;.[0]))]
  ) | .[1];

def parse_binary:
  . | split("") | map(tonumber);

def gamma:
  . | length as $digits | transpose | map(add) | map(if . < $digits/2 then 0 else 1 end) | binary_to_number;

def part1:
  [ inputs | parse_binary ] | (.[0] | length) as $digits | gamma | . * (pow(2; $digits) - (.+1)) ;