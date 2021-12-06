import "testing" as t;
import "day_01" as day1;

def should_make_pairs:
  [1, 2, 3] | day1::pairs | t::assert_that("make adjacent value pairs" ; t::is([ [2,1], [3,2] ]));

def should_count_number_of_drops:
  [1, 2, 1, 3] | day1::drops | t::assert_that("count number of decreases in sequence"; t::is(2));

def should_create_three_measurement_window:
  [1, 2, 1, 3] | day1::window_of_three | (
    t::assert_that("count number of decrease over three value window" ; t::is([4, 6]))
  );

def run:
  t::run_tests([
    should_make_pairs,
    should_count_number_of_drops,
    should_create_three_measurement_window
  ]);