import "testing" as t;
import "day_07" as day7;

def test_input: "16,1,2,0,4,2,7,1,2,14";

def should_parse_inputs_as_depths:
  test_input | day7::parse_input | t::assert_that("parsed input to array"; t::is([16,1,2,0,4,2,7,1,2,14]));

def should_map_to_distances_from_each_point:
  [0,1,2] | day7::distances_from_points | (t::assert_that("distances from points" ; t::is([
    [0,1,2], [1,0,1], [2,1,0]
  ])));

def should_map_to_cumulative_distances_from_each_point:
  [1,2,3] | day7::cumulative_distances_from_points | (t::assert_that("cumulative distances from points" ; t::is([
    [0,1,3], [1,0,1], [3,1,0]
  ])));

def should_calculate_shortest_distance_from_points: (
  test_input
    | day7::parse_input
    | day7::shortest_distance_from_points
    | t::assert_that("example distance"; t::is(37))
  );

def should_calculate_cumulative_shortest_distance_from_points: (
  test_input
    | day7::parse_input
    | day7::shortest_cumulative_distance_from_points
    | t::assert_that("example cumulative distance"; t::is(168))
  );


def run:
    t::run_tests([
        should_parse_inputs_as_depths,
        should_map_to_distances_from_each_point,
        should_calculate_shortest_distance_from_points,
        should_map_to_cumulative_distances_from_each_point,
        should_calculate_cumulative_shortest_distance_from_points
    ]);