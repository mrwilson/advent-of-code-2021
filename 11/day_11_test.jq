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
  [ [10,0], [10,10] ]
    | day11::flashing_octopodes
    | t::assert_that("flashing octopodes in test input"; t::is([[0,0],[1,0],[1,1]]))
);

def should_get_neighbouring_octopodes: (
  [ test_input | day11::parse_input ] |
    ( day11::neighbouring_octopodes(0; 0; length) | t::assert_that("corner"; t::is_sorted([[0,1],[1,0], [1,1]]))),
    ( day11::neighbouring_octopodes(0; 1; length) | t::assert_that("side"; t::is_sorted([[0,0],[1,0], [1,1], [0,2], [1,2]]))),
    ( day11::neighbouring_octopodes(1; 1; length) | t::assert_that("middle"; t::is_sorted([
        [0,0], [0,1], [0,2], [1,0], [1,2], [2,0], [2,1], [2,2]
    ]))),
    ( day11::neighbouring_octopodes(9; 9; length) | t::assert_that("opposite corner"; t::is_sorted([
        [8,9], [9,8], [8,8]
    ])))
);

def should_tick: (
  [ "11111", "19991", "19191", "19991", "11111" | day11::parse_input ] |
    (day11::tick | t::assert_that("flashed octopodes after 1 tick"; t::is([
        [3,4,5,4,3],[4,0,0,0,4],[5,0,0,0,5],[4,0,0,0,4],[3,4,5,4,3]
    ])))
    ,
    (day11::tick | day11::tick | t::assert_that("flashed octopodes after 2 ticks"; t::is([
        [4,5,6,5,4],[5,1,1,1,5],[6,1,1,1,6],[5,1,1,1,5],[4,5,6,5,4]
    ])))
);

def should_tick_test_input: (
  [ test_input | day11::parse_input ] |
    (day11::tick | t::assert_that("flashed octopodes test after 1 tick"; t::is([
        [6,5,9,4,2,5,4,3,3,4],
        [3,8,5,6,9,6,5,8,2,2],
        [6,3,7,5,6,6,7,2,8,4],
        [7,2,5,2,4,4,7,2,5,7],
        [7,4,6,8,4,9,6,5,8,9],
        [5,2,7,8,6,3,5,7,5,6],
        [3,2,8,7,9,5,2,8,3,2],
        [7,9,9,3,9,9,2,2,4,5],
        [5,9,5,7,9,5,9,6,6,5],
        [6,3,9,4,8,6,2,6,3,7]
    ])))
    ,(day11::tick | day11::tick | t::assert_that("flashed octopodes test after 2 ticks"; t::is([
        [8,8,0,7,4,7,6,5,5,5],
        [5,0,8,9,0,8,7,0,5,4],
        [8,5,9,7,8,8,9,6,0,8],
        [8,4,8,5,7,6,9,6,0,0],
        [8,7,0,0,9,0,8,8,0,0],
        [6,6,0,0,0,8,8,9,8,9],
        [6,8,0,0,0,0,5,9,4,3],
        [0,0,0,0,0,0,7,4,5,6],
        [9,0,0,0,0,0,0,8,7,6],
        [8,7,0,0,0,0,6,8,4,8]
    ])))
);

def should_count_flashes: (
  [ test_input | day11::parse_input ] |
    (day11::count_flashes(1) | t::assert_that("flashes after 1 tick"; t::is(0))),
    (day11::count_flashes(2) | t::assert_that("flashes after 2 ticks"; t::is(35))),
    (day11::count_flashes(10) | t::assert_that("flashes after 10 ticks"; t::is(204))),
    (day11::count_flashes(100) | t::assert_that("flashes after 10 ticks"; t::is(1656)))
  );


def run:
    t::run_tests([
        should_parse_input,
        should_test_if_any_octopodes_ready_to_flash,
        should_get_neighbouring_octopodes,
        should_tick,
        should_tick_test_input,
        should_count_flashes
    ]);