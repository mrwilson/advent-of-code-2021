def parse_input:
  map(split("") | map(tonumber));

def neighbours($x; $y): (
  (.[0] | length) as $size
  | [
   ( if $y == 0 then -1 else .[$x][$y-1] end ),
   ( if $y == $size-1 then -1 else .[$x][$y+1] end),
   ( if $x == 0 then -1 else .[$x-1][$y] end),
   ( if $x == $size-1 then -1 else .[$x+1][$y] end)
 ]) | map(select(. >= 0)) | sort;
