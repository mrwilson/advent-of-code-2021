module {
	name: "testing",
	version: "0.0.0"
};

## Runner

def run_tests($tests):
  ($tests | length) as $test_count | [ "1..\($test_count)" ] + $tests | .[];

## Assertions

def assert_that($description; $matcher):
 (. | $matcher) as $result | if $result.match then "ok # \($description)" else "not ok # \($description)\n\(.) \($result.description) \($result.expected)" end;

## Matchers

def is($value):
    { match: (. == $value), expected: $value, description: "is" };

def has_length($value):
    { match: ((.|length) == $value), expected: $value, description: "has length" };


