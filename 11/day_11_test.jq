import "testing" as t;
import "day_11" as day11;

def test_input: (
    "5483143223",
    "2745854711",
    "5264556173",
    "6141336146",
    "6357385478",
    "4167524645",
    "2176841721",
    "6882881134",
    "4846848554",
    "5283751526"
);

def should_parse_input: (
  [ test_input | day11::parse_input ] | 
    (t::assert_that("parse input :: size"; t::has_length(10))),
    (.[0] | t::assert_that("parse input :: first entry"; t::is(
      [5,4,8,3,1,4,3,2,2,3]
    )))
  );

def should_test_if_any_octopodes_ready_to_flash: (
  [ [9,0], [1,9] ]
    | day11::flashing_octopodes
    | t::assert_that("flashing octopodes in test input"; t::is([[0,0],[1,1]]))
);

def should_get_neighbouring_octopodes: (
  [ test_input | day11::parse_input ] |
    ( day11::neighbouring_octopodes(0; 0) | t::assert_that("corner"; t::is_sorted([[0,1],[1,0], [1,1]]))),
    ( day11::neighbouring_octopodes(0; 1) | t::assert_that("side"; t::is_sorted([[0,0],[1,0], [1,1], [0,2], [1,2]]))),
    ( day11::neighbouring_octopodes(1; 1) | t::assert_that("middle"; t::is_sorted([
        [0,0], [0,1], [0,2], [1,0], [1,2], [2,0], [2,1], [2,2]
    ])))
);


def run:
    t::run_tests([
        should_parse_input,
        should_test_if_any_octopodes_ready_to_flash,
        should_get_neighbouring_octopodes
    ]);