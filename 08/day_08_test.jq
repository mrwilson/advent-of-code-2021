import "testing" as t;
import "day_08" as day8;

def should_parse_inputs: (
    "be fdcge agebfd fecdb fabcd edb | fdgacbe gcbe" | day8::parse_input | t::assert_that("parsed input digits and display"; t::is({
      digits: ["be", "fdcge", "agebfd", "fecdb", "fabcd", "edb"], display: ["fdgacbe", "gcbe"]
    }))
  );

def run:
    t::run_tests([
        should_parse_inputs
    ]);