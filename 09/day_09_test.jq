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

def should_get_neighbours:
  [test_input] | day9::parse_input | (
    (day9::neighbours(0;1) | t::assert_that("side"; t::is(
        [{"x":0,"y":0,"value":2},{"x":0,"y":2,"value":9},{"x":1,"y":1,"value":9}]
    ))),
    (day9::neighbours(0;9) | t::assert_that("corner"; t::is(
        [{"x":0,"y":8,"value":1},{"x":1,"y":9,"value":1}]
    ))),
    (day9::neighbours(2;2) | t::assert_that("middle"; t::is(
        [{"x":2,"y":3,"value":6},{"x":3,"y":2,"value":6},{"x":2,"y":1,"value":8},{"x":1,"y":2,"value":8}]
    ))),
    (day9::neighbours(4;6) | t::assert_that("other side"; t::is(
        [{"x":4,"y":5,"value":6},{"x":4,"y":7,"value":6},{"x":3,"y":6,"value":6}]
    )))
  );

def should_find_basin_from_low_point:
  [test_input] | day9::parse_input | (
   (day9::basin_at(0;1) | t::assert_that("basin side"; t::is([1,2,3]))),
   (day9::basin_at(0;9) | t::assert_that("basin corner"; t::is([0,1,1,2,2,2,3,4,4]))),
   (day9::basin_at(2;2) | t::assert_that("basin middle"; t::is([5,6,6,7,7,7,7,8,8,8,8,8,8,8]))),
   (day9::basin_at(4;6) | t::assert_that("basin other corner"; t::is([5,6,6,6,7,7,8,8,8])))
);

def should_find_low_points:
  [test_input] | day9::parse_input | day9::low_points | (
    t::assert_that("low points"; t::is([
        {"x":0,"y":1,"value":1},{"x":0,"y":9,"value":0},{"x":2,"y":2,"value":5},{"x":4,"y":6,"value":5}
    ]))
  );

def should_calculate_risk:
  [test_input] | day9::parse_input | day9::total_risk_levels | t::assert_that("total risk levels"; t::is(15));

def run:
    t::run_tests([
        should_parse_input,
        should_get_neighbours,
        should_find_low_points,
        should_calculate_risk,
        should_find_basin_from_low_point
    ]);