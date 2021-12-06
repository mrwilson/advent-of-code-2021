import "testing" as t;
import "day_06" as day6;

def test_input: "3,4,3,1,2";

def should_collapse_input_to_days:
  test_input | day6::parse_input | t::assert_that("parsed input to array"; t::is([0,1,1,2,1]));

def should_calculate_next_step: (
    ([0,1,1,2,1] | day6::tick | t::assert_that("no new fish"; t::is([1,1,2,1,0,0,0,0,0]))),
    ([5,1,1,2,1] | day6::tick | t::assert_that("some new fish"; t::is([1,1,2,1,0,0,5,0,5])))
  );

def should_spawn_lanternfish_on_test_input:
  test_input | (
    (day6::spawn_lanternfish(5) | t::assert_that("after 5 days"; t::is(10))),
    (day6::spawn_lanternfish(18) | t::assert_that("after 18 days"; t::is(26)))
  );

def run:
    (
        should_collapse_input_to_days,
        should_calculate_next_step,
        should_spawn_lanternfish_on_test_input
    );