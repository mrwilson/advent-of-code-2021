module {
	name: "testing",
	version: "0.0.0"
};

## Runner

def run_tests($tests):
  ($tests | length) as $test_count | [ "1..\($test_count)" ] + $tests | .[];

## Matchers

def is($value):
    { match: (. == $value), expected: $value, description: "is" };

def is_sorted($value):
    { match: (sort == ($value|sort)), expected: $value, description: "is" };

def has_length($value):
    { match: ((.|length) == $value), expected: $value, description: "has length" };

def has_entry($key; $value):
    { match: (.[$key] == $value), expected: "\($key) -> \($value)", description: "has key with value" };

## Assertions

def assert_that($description; $matcher):
 (. | $matcher) as $result | (
    if $result.match then
        "ok - \($description)"
    else
        "not ok - \($description)\n# \(.) \($result.description) \($result.expected)"
    end
  );

def assert_true($description):
  assert_that($description; is(true));

def assert_false($description):
  assert_that($description; is(false));
