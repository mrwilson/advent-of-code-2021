import "testing" as t;
import "day_08" as day8;

def test_input: (
      "be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe",
      "edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc",
      "fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg",
      "fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb",
      "aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea",
      "fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb",
      "dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe",
      "bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef",
      "egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb",
      "gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce"
  );

def should_parse_inputs: (
    "be fdcge agebfd fecdb fabcd edb | fdgacbe gcbe" | day8::parse_input | t::assert_that("parsed input digits and display"; t::is({
      "digits":["be","cdefg","abdefg","bcdef","abcdf","bde"], "display":["abcdefg","bceg"]
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
    t::assert_that("first permutation"; t::has_entry(0 ; [
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
        ])
    )
  );

def should_calculate_value_from_known_wirings: (
  day8::all_possible_wirings as $wirings
  | "acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf"
  | day8::derive_value_from_wiring($wirings)
  | t::assert_that("correct value from unique wiring"; t::is(5353))
);

def should_calculate_all_displays_and_derivations: (
  day8::all_possible_wirings as $wirings
    | [test_input]
    | map(day8::derive_value_from_wiring($wirings))
    | add
    | t::assert_that("sum of all displays"; t::is(61229))
  );

def run:
    t::run_tests([
        should_parse_inputs,
        should_count_known_digits_in_display,
        should_enumerate_all_possible_wirings,
        should_calculate_value_from_known_wirings,
        should_calculate_all_displays_and_derivations
    ]);