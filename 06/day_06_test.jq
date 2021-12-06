import "testing" as t;
import "day_06" as day6;

def test_input: "3,4,3,1,2";

def should_collapse_input_to_days:
  test_input | day6::parse_input | t::assert_that("parsed input to array"; t::is([0,1,1,2,1]));

def run:
    (
        should_collapse_input_to_days
    );