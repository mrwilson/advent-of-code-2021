def parse_input:
  map(split(""));

def reverse($char):
  if $char == "]" then "[" elif $char == "}" then "{" elif $char == ")" then "(" else "<" end;

def is_corrupted: (
  def _loop:
    .remaining[0] as $next
    | if (.remaining | length) == 0 then
        .
      elif (["[","{","(","<"] | index($next)) != null then
        { remaining: .remaining[1:], stack: ([.remaining[0]] + .stack) } | _loop
      elif reverse(.remaining[0]) == .stack[0] then
        { remaining: .remaining[1:], stack: .stack[1:] } | _loop
      else
        .
      end;

  { remaining: ., stack: [] }
    | _loop
    | if (.remaining | length) == 0 then
        { corrupted: false, remaining: .stack }
      else
        { corrupted: true, first_bad_character: .remaining[0] }
      end
);

def score_corruptions: (
  parse_input
  | map(is_corrupted)
  | map(select(.corrupted == true))
  | map({")": 3,"]": 57,"}": 1197,">": 25137}[.first_bad_character])
  | add
);

def score_completions: (
  [ parse_input[]
    | is_corrupted
    | select(.corrupted == false)
    | .remaining
    | map({"(": 1,"[": 2,"{": 3,"<": 4}[.])
    | reduce .[] as $char (0; (5*.) + $char)
  ]
  | sort
  | .[length/2|floor]
);

def part1:
  [ inputs ] | score_corruptions;

def part2:
  [ inputs ] | score_completions;