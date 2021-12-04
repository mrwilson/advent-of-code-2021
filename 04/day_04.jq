def called_numbers:
  .[0] | split(",") | map(tonumber);

def boards:
  [[], .[2:]] | until(.[1] | length == 0 ; (
    .[1][0:5] as $lines
    | { board: [ $lines[] | split("\\s+";"ig") | map(select(. != "")) | map(tonumber) ], checked_numbers: [] } as $board
    | [ .[0] + [$board], .[1][6:] ]
  ))[0];

def cross_out($number):
  (.board | flatten | bsearch($number)) as $index | (
    if $index < -1 then . else
        { board: (.board | .[$index / 5 | floor][$index % 5] = "X") }
    end
  );