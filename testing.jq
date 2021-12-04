module {
	name: "testing",
	version: "0.0.0"
};

## Assertions

def assert_that($value; $matcher):
  $value | $matcher as $result | if $result.match then "ok" else "not ok # \($value) \($result.description) \($result.expected)" end;

def assert_that($description; $value; $matcher):
  $value | $matcher as $result | if $result.match then "ok # \($description)" else "not ok # \($description)\n\($value) \($result.description) \($result.expected)" end;

## Matchers

def is($value):
    { match: (. == $value), expected: $value, description: "is" };

def has_length($value):
    { match: ((.|length) == $value), expected: $value, description: "has length" };


