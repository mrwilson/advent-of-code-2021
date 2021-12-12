def parse_input: (
  map(split("-"))
    | map([., reverse])
    | flatten(1)
    | map(select(.[0] != "end" and .[-1] != "start"))
    | group_by(.[0])
    | map({ "\(.[0][0])": map(.[1])})
    | add
);

def no_backtracking:
  map(select("a" <= . and . <= "z")) | group_by(.) | map_values(length) | any(.>1) | not;

def all_paths_ended:
  map(.[-1]) | unique == ["end"];

def traverse_caves:
  def _descend($caves):
    if all_paths_ended then
        .
    else
      [ .[]
        | if .[-1] != "end" then (. as $path | $caves[$path[-1]][] | $path + [.]) else . end ]
        | map(select(no_backtracking))
        | _descend($caves)
    end;

  . as $caves | [["start"]] | _descend($caves);

def paths_without_backtracking:
  parse_input | traverse_caves | length;
