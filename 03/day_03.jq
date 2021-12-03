def binary_to_number:
  . | reverse | reduce .[] as $digit (
        [0,0] ;
        [.[0]+1, .[1]+($digit*pow(2;.[0]))]
  ) | .[1];

def parse_binary:
  . | split("") | map(tonumber);

def gamma:
  . | length as $digits | transpose | map(add) | map(if . < $digits/2 then 0 else 1 end) | binary_to_number;

def most_common_digit_in_position:
  .[1] as $position | .[0] | length as $length | transpose | .[$position] | add | if . < $length/2 then 0 else 1 end;

def entry_with_digits_matching(filter): (
  [0, .] | until( (.[1] | length) == 1;
    (.[1] | length) as $remaining
    | .[0] as $index
    | ([.[1], $index] | filter) as $digit
    | [ .[0] + 1, (.[1] | map(select(.[$index] == $digit)))]
  )[1][0] | binary_to_number
);

def oxygen:
  . | entry_with_digits_matching(most_common_digit_in_position);

def carbon_dioxide:
  . | entry_with_digits_matching(most_common_digit_in_position | if . == 1 then 0 else 1 end);

def part1:
  [ inputs | parse_binary ] | (.[0] | length) as $digits | gamma | . * (pow(2; $digits) - (.+1)) ;

def part2:
  [ inputs | parse_binary ] | [oxygen, carbon_dioxide] | .[0] * .[1];