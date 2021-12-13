def parse_input: (
  join("#")/"##"
   | {
        points: [ first/"#" | map(./",")[] | map(tonumber) ],
        folds:  ( last/"#" | map(./" " | last) | map(./"") | map({ axis: first, value: (last|tonumber) }))
    }
);