import "testing" as t;
import "day_05" as day5;

def test_input: (
    "0,9 -> 5,9",
    "8,0 -> 0,8",
    "9,4 -> 3,4",
    "2,2 -> 2,1",
    "7,0 -> 7,4",
    "6,4 -> 2,0",
    "0,9 -> 2,9",
    "3,4 -> 1,4",
    "0,0 -> 8,8",
    "5,5 -> 8,2"
  );

def should_parse_vents_to_coordinates:
  ("1,1 -> 1,3" | day5::vents_to_coordinates | t::assert_that("x-axis vents"; t::is(
    [ [1,1], [1,2], [1,3] ] | sort
  ))),
  ("9,7 -> 7,7" | day5::vents_to_coordinates | t::assert_that("y-axis vents"; t::is(
    [ [9,7], [8,7], [7,7] ] | sort
  ))),
  ("1,1 -> 2,2" | day5::vents_to_coordinates | t::assert_that("no diagonal vents"; t::is([])));



def run:
    (
        should_parse_vents_to_coordinates
    );