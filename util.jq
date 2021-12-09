def abs($input):
  if $input < 0 then -$input else $input end;

def product:
  reduce .[] as $n (1; .*$n);