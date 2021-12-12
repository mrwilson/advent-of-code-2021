def parse_input: (
  map(split("-"))
    | map([., reverse])
    | flatten(1)
    | map(select(.[0] != "end" and .[-1] != "start"))
    | group_by(.[0])
    | map({ "\(.[0][0])": map(.[1])})
    | add
);