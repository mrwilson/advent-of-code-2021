def parse_input: ({
  template: (first/"" | [
        [.[:-1],.[1:]]
            | transpose
            | map(join(""))
            | group_by(.)[]
            | { (.[0]|tostring): length }
        ] | add),
  last_character: (first/""|last),
  pairs: [
        .[2:][]/" -> "
            | first as $pair
            | last as $middle
            | first/""
            | { ($pair): [[first,$middle],[$middle,last]] | map(join("")) }
  ] | add
});

def insert_pairs($steps): (
  .pairs as $pairs | reduce range($steps) as $n (.template ;
    . as $state | (
        [ keys[] as $key | $pairs[$key][] | { key: ., amount: $state[$key] }]
        | flatten(1)
        | group_by(.key)
        | map({ (.[0].key): (map(.amount)|add) })
        | add
    )
  )
);

def score_polymer($last): (
  [ to_entries[] | { key: (.key/""|first), value: .value}]
    | reduce .[] as $count ({}; .[$count.key] += $count.value)
    | .[$last] += 1
    | to_entries
    | map(.value)
    | (max - min)
);


def part1:
  [ inputs ] | parse_input | .last_character as $last | insert_pairs(10) | score_polymer($last);

def part2:
  [ inputs ] | parse_input | .last_character as $last | insert_pairs(40) | score_polymer($last);