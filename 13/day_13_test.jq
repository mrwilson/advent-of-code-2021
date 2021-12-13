import "testing" as t;
import "day_13" as day13;

def test_input: (
    "6,10", "0,14", "9,10", "0,3",
    "10,4", "4,11", "6,0", "6,12",
    "4,1", "0,13", "10,12", "3,4",
    "3,0", "8,4", "1,10", "2,14",
    "8,10", "9,0",
    "",
    "fold along y=7", "fold along x=5"
);

def should_parse_input: (
  [ test_input ] | day13::parse_input |
    t::assert_that("parse input - points"; t::has_entry("points" ; [
        [6,10], [0,14], [9,10], [0,3],
        [10,4], [4,11], [6,0], [6,12],
        [4,1], [0,13], [10,12], [3,4],
        [3,0], [8,4], [1,10], [2,14],
        [8,10], [9,0]
    ])),
    t::assert_that("parse input - folds"; t::has_entry("folds" ; [
        {axis:"y", value:7},{axis:"x", value:5}
    ]))
);


def run:
    t::run_tests([
        should_parse_input
    ]);