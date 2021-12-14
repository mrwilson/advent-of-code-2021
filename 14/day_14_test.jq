import "testing" as t;
import "day_14" as day14;

def test_input: (
    "NNCB",
    "",
    "CH -> B", "HH -> N", "CB -> H", "NH -> C",
    "HB -> C", "HC -> B", "HN -> C", "NN -> C",
    "BH -> H", "NC -> B", "NB -> B", "BN -> B",
    "BB -> N", "BC -> B", "CC -> N", "CN -> C"
);

def should_parse_input: (
  [ test_input ] | day14::parse_input |
    t::assert_that("parse input - template"; t::has_entry("template" ; "NNCB")),
    t::assert_that("parse input - pairs"; t::has_entry("pairs" ; {
        CH: "B", HH: "N", CB: "H", NH: "C",
        HB: "C", HC: "B", HN: "C", NN: "C",
        BH: "H", NC: "B", NB: "B", BN: "B",
        BB: "N", BC: "B", CC: "N", CN: "C"
    }))
);

def should_insert_pairs: (
  [ test_input ] | day14::parse_input |
    (day14::insert_pairs(1) | t::assert_that("after one insertion"; t::is("NCNBCHB"))),
    (day14::insert_pairs(2) | t::assert_that("after two insertions"; t::is("NBCCNBBBCBHCB"))),
    (day14::insert_pairs(3) | t::assert_that("after three insertions"; t::is(
        "NBBBCNCCNBBNBNBBCHBHHBCHB"
    ))),
    (day14::insert_pairs(4) | t::assert_that("after four insertions"; t::is(
        "NBBNBNBBCCNBCNCCNBBNBBNBBBNBBNBBCBHCBHHNHCBBCBHCB"
    )))
);

def should_score_polymers: (
  [ test_input ]
    | day14::parse_input
    | day14::insert_pairs(10)
    | day14::score_polymer
    | t::assert_that("score after ten steps"; t::is(1749 - 161))
);


def run:
    t::run_tests([
        should_parse_input,
        should_insert_pairs,
        should_score_polymers
    ]);