def parse_input:
  map(split(""));

def reverse($char):
  if $char == "]" then "[" elif $char == "}" then "{" elif $char == ")" then "(" else "<" end;

def is_corrupted: (
  def _loop:
    .remaining[0] as $next
    | if (["[","{","(","<"] | index($next)) != null then
      { foo: $next, remaining: .remaining[1:], stack: ([.remaining[0]] + .stack) } | _loop
    elif reverse(.remaining[0]) == .stack[0] then
      { remaining: .remaining[1:], stack: .stack[1:] } | _loop
    else
      .
    end;
  { remaining: ., stack: [] }
    | _loop
    | if (.remaining | length) == 0 then
        { corrupted: false }
      else
        { corrupted: true, first_bad_character: .remaining[0] }
      end
);