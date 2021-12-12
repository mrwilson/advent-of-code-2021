import "testing" as t;
import "day_12" as day12;

def test_input:
  "start-A", "start-b", "A-c", "A-b", "b-d", "A-end", "b-end";

def medium_test_input: (
  "dc-end", "HN-start", "start-kj", "dc-start", "dc-HN",
  "LN-dc", "HN-end", "kj-sa", "kj-HN", "kj-dc"
);

def should_parse_input: (
  [ test_input ] | day12::parse_input | t::assert_that("parse input"; t::is(
    {"A":["b","end","c"],"b":["end","A","d"],"c":["A"],"d":["b"],"start":["b","A"]}
  ))
);

def should_identify_backtracking: (
  (["a", "a", "B"] | day12::no_backtracking | t::assert_that("backtracking"; t::is(false))),
  (["a", "b", "B"] | day12::no_backtracking | t::assert_that("no backtracking"; t::is(true)))
);

def should_identify_all_paths_ended: (
  ([["a", "end"], ["b","end"]] | day12::all_paths_ended | t::assert_that("all paths ended"; t::is(true))),
  ([["a", "end"], ["b","B"]]   | day12::all_paths_ended | t::assert_that("paths remaining"; t::is(false)))
);

def should_traverse_caves: (
  [ test_input ]
    | day12::parse_input
    | day12::traverse_caves
    | t::assert_that("cave traversal"; t::is_sorted([
        ["start","A","b","A","c","A","end"],
        ["start","A","b","A","end"],
        ["start","A","b","end"],
        ["start","A","c","A","b","A","end"],
        ["start","A","c","A","b","end"],
        ["start","A","c","A","end"],
        ["start","A","end"],
        ["start","b","A","c","A","end"],
        ["start","b","A","end"],
        ["start","b","end"]
    ]))
);

def should_count_paths_without_backtracking_through_small_caves: (
  ([ test_input ]        | day12::paths_without_backtracking | t::assert_that("small paths without backtracking"; t::is(10))),
  ([ medium_test_input ] | day12::paths_without_backtracking | t::assert_that("medium paths without backtracking"; t::is(19)))
);

def run:
    t::run_tests([
        should_parse_input,
        should_identify_backtracking,
        should_identify_all_paths_ended,
        should_traverse_caves,
        should_count_paths_without_backtracking_through_small_caves
    ]);