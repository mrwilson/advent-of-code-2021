def parse_input: (
  join("#")/"##"
   | map(split("#"))
   | {
        points: [ first[]/"," | map(tonumber) ],
        folds: [ last[]/" " | last/"=" | { axis: first, value: (last|tonumber) }]
    }
);

def flip($original; $line):
  ($original - 2*($original/$line|floor)*($original - $line)) % line;

def fold($axis; $value):
  map({ y: [first, flip(last;$value)], x: [flip(first;$value),last]}[$axis]) | unique;

def fold_instructions($points; $folds):
  reduce $folds[] as $fold ($points ; fold($fold.axis;$fold.value) );

def render_image:
  reduce .[] as $point ([]; setpath($point;"█")) | map(.//[] | map( . //  " " ) | join("")) + [""] | join("\n");

def part1:
  [ inputs ] | parse_input | fold_instructions(.points; [.folds|first]) | length;

def part2:
  [ inputs ] | parse_input | fold_instructions(.points; .folds) | render_image;