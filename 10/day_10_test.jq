import "testing" as t;
import "day_10" as day10;

def test_input: (
    "[({(<(())[]>[[{[]{<()<>>",
    "[(()[<>])]({[<{<<[]>>(",
    "{([(<{}[<>[]}>{[]{[(<()>",
    "(((({<>}<{<{<>}{[]{[]{}",
    "[[<[([]))<([[{}[[()]]]",
    "[{[{({}]{}}([{[{{{}}([]",
    "{<[[]]>}<{[{[{[]{()[[[]",
    "[<(<(<(<{}))><([]([]()",
    "<{([([[(<>()){}]>(<<{{",
    "<{([{{}}[<[[[<>{}]]]>[]]"
  );

def should_parse_input:
  [test_input] | day10::parse_input | .[0] | ( t::assert_that("parse input"; t::is(
      ["[","(","{","(","<","(","(",")",")","[","]",">","[","[","{","[","]","{","<","(",")","<",">",">"]
  )));

def should_extract_corrupted_lines: (
    ["{","(","[","(","<","{","}","[","<",">","[","]","}",">","{","[","]","{","[","(","<","(",")",">"]
    | day10::is_corrupted
    | t::assert_that("corrupted lines only"; t::has_entry("corrupted" ; true)),
      t::assert_that("corrupted lines only - bad char"; t::has_entry("first_bad_character" ; "}"))
  );

def should_score_corruptions:
  [ test_input ] | day10::score_corruptions | t::assert_that("corruption score"; t::is(6+57+1197+25137));

def should_score_completions:
  [ test_input ] | day10::score_completions | t::assert_that("completion score"; t::is(288957));

def run:
    t::run_tests([
        should_parse_input,
        should_extract_corrupted_lines,
        should_score_corruptions,
        should_score_completions
    ]);