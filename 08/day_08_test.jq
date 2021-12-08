import "testing" as t;
import "day_08" as day8;

def should_parse_inputs: (
    "be fdcge agebfd fecdb fabcd edb | fdgacbe gcbe" | day8::parse_input | t::assert_that("parsed input digits and display"; t::is({
      digits: ["be", "fdcge", "agebfd", "fecdb", "fabcd", "edb"], display: ["fdgacbe", "gcbe"]
    }))
  );

def should_count_known_digits_in_display: (
    "be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe"
     | day8::parse_input
     | day8::known_digits_in_display
     | t::assert_that("known digits in display"; t::is(2))
  );

def should_enumerate_all_possible_wirings:
  day8::all_possible_wirings | (
    t::assert_that("has correct number of entries"; t::has_length(5040)),
    (.[0] | t::assert_that("first permutation"; t::is([
          "abcefg",
          "cg",
          "bcdef",
          "bcdfg",
          "acdg",
          "abdfg",
          "abdefg",
          "bcg",
          "abcdefg",
          "abcdfg"
        ]))
    )
  );

def run:
    t::run_tests([
        should_parse_inputs,
        should_count_known_digits_in_display,
        should_enumerate_all_possible_wirings
    ]);