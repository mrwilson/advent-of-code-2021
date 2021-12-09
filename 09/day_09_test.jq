import "testing" as t;
import "day_09" as day9;

def test_input: (
    "2199943210",
    "3987894921",
    "9856789892",
    "8767896789",
    "9899965678"
  );

def should_parse_input:
  [test_input] | day9::parse_input | ( t::assert_that("parse input"; t::is([
    [2,1,9,9,9,4,3,2,1,0],[3,9,8,7,8,9,4,9,2,1],[9,8,5,6,7,8,9,8,9,2],[8,7,6,7,8,9,6,7,8,9],[9,8,9,9,9,6,5,6,7,8]
  ])));

def run:
    t::run_tests([
        should_parse_input
    ]);