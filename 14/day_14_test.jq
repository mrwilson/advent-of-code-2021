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


def run:
    t::run_tests([
        should_parse_input
    ]);