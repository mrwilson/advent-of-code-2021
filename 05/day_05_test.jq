import "testing" as t;
import "day_05" as day5;

def test_input: (
    "0,9 -> 5,9", "8,0 -> 0,8", "9,4 -> 3,4", "2,2 -> 2,1",
    "7,0 -> 7,4", "6,4 -> 2,0", "0,9 -> 2,9", "3,4 -> 1,4",
    "0,0 -> 8,8", "5,5 -> 8,2"
  );

def should_parse_vents_to_coordinates:
  ("1,1 -> 1,3" | day5::vents_to_coordinates(false) | t::assert_that("x-axis vents"; t::is(
    [ [1,1], [1,2], [1,3] ] | sort
  ))),
  ("9,7 -> 7,7" | day5::vents_to_coordinates(false) | t::assert_that("y-axis vents"; t::is(
    [ [9,7], [8,7], [7,7] ] | sort
  ))),
  ("1,1 -> 2,2" | day5::vents_to_coordinates(false) | t::assert_that("no diagonal vents"; t::is([])));

def should_parse_vents_to_coordinates_with_diagonals:
  ("1,1 -> 3,3", "3,3 -> 1,1" | day5::vents_to_coordinates(true) | t::assert_that("diagonal vents"; t::is(
    [ [1,1], [2,2], [3,3] ]
  ))),
  ("9,7 -> 7,9" | day5::vents_to_coordinates(true) | t::assert_that("diagonal vents reversed"; t::is(
      [ [9,7], [8,8], [7,9] ] | sort
  )));

def should_identify_duplicate_points:
  ([[1,2], [1,2]] | day5::duplicate_points | t::assert_that("duplicate points"; t::is([[1,2]]))),
  ([[1,2], [2,1]] | day5::duplicate_points | t::assert_that("no duplicate points"; t::is([]))),
  ([] | day5::duplicate_points | t::assert_that("no points passed"; t::is([])));

def should_calculate_number_of_overlapping_points:
  [ test_input ] | day5::total_crossover_points(false) | t::assert_that("crossover points for test input"; t::is(5));

def should_calculate_number_of_overlapping_points_with_diagonals:
  [ test_input ] | day5::total_crossover_points(true) | t::assert_that("crossover points for test input with diagonals"; t::is(12));

def run:
    (
        should_parse_vents_to_coordinates,
        should_parse_vents_to_coordinates_with_diagonals,
        should_identify_duplicate_points,
        should_calculate_number_of_overlapping_points,
        should_calculate_number_of_overlapping_points_with_diagonals
    );