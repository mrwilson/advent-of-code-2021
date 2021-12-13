def parse_input: (
  join("#")/"##"
   | {
        points: [ first/"#" | map(./",")[] | map(tonumber) ],
        folds:  ( last/"#" | map(./" " | last) | map(./"") | map({ axis: first, value: (last|tonumber) }))
    }
);

def flip($original; $line):
  ($original - 2*($original/$line|floor)*($original - $line)) % line;

def fold($axis; $value):
  map({ y: [first, flip(last;$value)], x: [flip(first;$value),last]}[$axis]) | unique;

def fold_instructions($points; $folds):
  reduce $folds[] as $fold ($points ; fold($fold.axis;$fold.value) );

def part1:
  [ inputs ] | parse_input | fold_instructions(.points; [.folds|first]) | length;