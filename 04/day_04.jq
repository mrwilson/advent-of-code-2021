def called_numbers:
  .[0] | split(",") | map(tonumber);

def boards:
  [[], .[2:]] | until(.[1] | length == 0 ; (
    .[1][0:5] as $lines
    | { board: [ $lines[] | split("\\s+";"ig") | map(select(. != "")) | map(tonumber) ], checked_numbers: [] } as $board
    | [ .[0] + [$board], .[1][6:] ]
  ))[0];

def cross_out($number):
  (.board | flatten | index($number)) as $index | (
    if $index < -1 then . else
        { board: (.board | .[$index / 5 | floor][$index % 5] = "X") }
    end
  );

def is_winner:
  .board as $board
  | (.board[0] | length) as $size
  | ([.board[] | map(select(. == "X"))] | map(length) | any(. == $size)) as $horizontal_win
  | ([.board | transpose[] | map(select(. == "X"))] | map(length) | any(. == $size))  as $vertical_win
  | [$horizontal_win, $vertical_win]
  | any
  ;

def score_board:
  .board | flatten | map(select(. != "X")) | add;

def play_bingo:
  . | [ called_numbers, boards ] | until( .[1] | map(is_winner) | any  ; (
      .[0][0] as $next_number
      | (.[1] | map(cross_out($next_number))) as $next_boards
      | [ .[0][1:], $next_boards, $next_number]
  )) | .[2] as $multiplier | (.[1] | map(select(is_winner))[0] | score_board) as $score | $multiplier * $score ;

def part1:
  [inputs] | play_bingo;