import "testing" as t;
import "day_14" as day14;

def is_equivalent_to($value): (
    ($value/"" | [ .[:-1], .[1:] ] | transpose | map(join("")) | group_by(.) | map({(first|tostring): length}) | add) as $expected | {
        match: (. == $expected),
        expected: ($expected + {"test":2}),
        description: "is"
});

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
    t::assert_that("parse input - template"; t::has_entry("template" ; {
        "NN":1,"NC":1,"CB":1
    })),
    t::assert_that("parse input - last character"; t::has_entry("last_character" ; "B")),
    t::assert_that("parse input - pairs"; t::has_entry("pairs" ; {
        "CH":["CB","BH"],"HH":["HN","NH"],"CB":["CH","HB"],"NH":["NC","CH"],
        "HB":["HC","CB"],"HC":["HB","BC"],"HN":["HC","CN"],"NN":["NC","CN"],
        "BH":["BH","HH"],"NC":["NB","BC"],"NB":["NB","BB"],"BN":["BB","BN"],
        "BB":["BN","NB"],"BC":["BB","BC"],"CC":["CN","NC"],"CN":["CC","CN"]
    }))
);

def should_insert_pairs: (
  [ test_input ] | day14::parse_input |
    (day14::insert_pairs(1) | t::assert_that("after one insertion"; is_equivalent_to(
        "NCNBCHB"
    ))),
    (day14::insert_pairs(2) | t::assert_that("after two insertions"; is_equivalent_to(
        "NBCCNBBBCBHCB"
    ))),
    (day14::insert_pairs(3) | t::assert_that("after three insertions"; is_equivalent_to(
        "NBBBCNCCNBBNBNBBCHBHHBCHB"
    ))),
    (day14::insert_pairs(4) | t::assert_that("after four insertions"; is_equivalent_to(
        "NBBNBNBBCCNBCNCCNBBNBBNBBBNBBNBBCBHCBHHNHCBBCBHCB"
    )))
);

def should_score_polymers: (
  [ test_input ]
    | day14::parse_input
    | day14::insert_pairs(10)
    | day14::score_polymer("B")
    | t::assert_that("score after ten steps"; t::is(1749 - 161))
);

def should_score_polymers_large: (
  [ test_input ]
    | day14::parse_input
    | day14::insert_pairs(40)
    | day14::score_polymer("B")
    | t::assert_that("score after forty steps"; t::is(2192039569602 - 3849876073))
);

def run:
    t::run_tests([
        should_parse_input,
        should_insert_pairs,
        should_score_polymers,
        should_score_polymers_large
    ]);