import "testing" as t;
import "day_12" as day12;

def test_input: (
    "start-A",
    "start-b",
    "A-c",
    "A-b",
    "b-d",
    "A-end",
    "b-end"
);

def should_parse_input: (
  [ test_input ] | day12::parse_input | t::assert_that("parse input"; t::is(
    {"A":["b","end","c"],"b":["end","A","d"],"c":["A"],"d":["b"],"start":["b","A"]}
  ))
);


def run:
    t::run_tests([
        should_parse_input
    ]);