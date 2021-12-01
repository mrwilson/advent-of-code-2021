import "testing" as t;
import "day_01" as day1;

def should_make_pairs:
  [1, 2, 3] | day1::pairs | t::assert_that( . ; t::is([ [2,1], [3,2] ]));

def should_count_number_of_drops:
  [1, 2, 1, 3] | day1::drops | t::assert_that( . ; t::is(2));

def run:
  (
    should_make_pairs,
    should_count_number_of_drops
  );