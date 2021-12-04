def called_numbers:
  .[0] | split(",") | map(tonumber);

def boards:
  [[], .[2:]] | until(.[1] | length == 0 ; (
    .[1][0:5] as $lines
    | { board: [ $lines[] | split("\\s+";"ig") | map(select(. != "")) | map(tonumber) ], has_won: false } as $board
    | [ .[0] + [$board], .[1][6:] ]
  ))[0];

def cross_out($number):
  (.board | flatten | index($number)) as $index | (
    if $index < -1 then . else
        { board: (.board | .[$index / 5 | floor][$index % 5] = "X"), has_won: .has_won, completed: .completed }
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

def log_win_data($number ; $turn):
   (. | is_winner) as $winner | (
     if $winner and (.has_won|not) then . + { has_won: true, completed: [$number, $turn] } else . end
   );

def play_bingo(number_of_winners):
  . | [ called_numbers, boards, 0 ] | until( .[1] | map(is_winner) | number_of_winners  ; (
      .[0][0] as $next_number
      | .[2] as $turn
      | (.[1] | map(cross_out($next_number)) | map(log_win_data($next_number; $turn)))  as $next_boards
      | [ .[0][1:], $next_boards, .[2] + 1]
  )) | .[1] | max_by(.completed[1]) | score_board as $score | $score * .completed[0];

def part1:
  [inputs] | play_bingo(any);

def part2:
  [inputs] | play_bingo(all);