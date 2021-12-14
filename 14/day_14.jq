def parse_input:
  { template: first, pairs: [ .[2:][]/" -> " | { (first|tostring): last } ] | add };

def insert_pairs($steps): (
  .pairs as $pairs | reduce range($steps) as $n (.template/"" ;
    last as $last
      | [[.[:-1],.[1:]] | transpose[] | [first,$pairs[join("")]]]
      | add + [$last]
  ) | join("")
);