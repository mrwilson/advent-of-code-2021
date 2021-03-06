def parse_input: (
  map(split("-"))
    | map([., reverse])
    | flatten(1)
    | map(select(first != "end" and last != "start"))
    | group_by(first)
    | map({ "\(.[0][0])": map(.[1])})
    | add
);

def no_backtracking($allowed_single_cave_repeats): (
  map(select("a" <= . and . <= "z"))
    | group_by(.)
    | map_values(length)
    | map(select(. != 1))
    | length == 0 or (all(. == 2) and length == $allowed_single_cave_repeats)
);

def all_paths_ended:
  map(last) | unique == ["end"];

def traverse_caves($allowed_single_cave_repeats):
  def _descend($caves):
    if all_paths_ended then
        .
    else
      [ .[]
        | if last == "end" then . else (. as $path | $caves[$path | last][] | $path + [.]) end ]
        | map(select(no_backtracking($allowed_single_cave_repeats)))
        | _descend($caves)
    end;

  . as $caves | [["start"]] | _descend($caves);

def paths_without_backtracking($allowed_single_cave_repeats):
  parse_input | traverse_caves($allowed_single_cave_repeats) | length;

def part1:
  [ inputs ] | paths_without_backtracking(0);

def part2:
  [ inputs ] | paths_without_backtracking(1);