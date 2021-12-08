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


def run:
    t::run_tests([
        should_parse_inputs,
        should_count_known_digits_in_display
    ]);