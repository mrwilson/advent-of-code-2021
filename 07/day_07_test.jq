import "testing" as t;
import "day_07" as day7;

def test_input: "16,1,2,0,4,2,7,1,2,14";

def should_parse_inputs_as_depths:
  test_input | day7::parse_input | t::assert_that("parsed input to array"; t::is([16,1,2,0,4,2,7,1,2,14]));

def run:
    t::run_tests([
        should_parse_inputs_as_depths
    ]);