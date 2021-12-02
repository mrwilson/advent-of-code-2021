import "testing" as t;
import "day_02" as day2;

def should_parse_directions_into_coordinates:
  [["up 1", "down 1", "forward 1"][] | day2::parse_instruction ]| t::assert_that( . ; t::is([ [0,-1], [0,1], [1,0] ]));

def should_calculate_total_displacement:
  [ [0,1], [1,2], [2,4] ] | day2::total_displacement | t::assert_that( . ; t::is([3,7]));

def run:
    (
        should_parse_directions_into_coordinates,
        should_calculate_total_displacement
    );