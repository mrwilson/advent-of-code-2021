import "testing" as t;
import "day_03" as day3;

def test_input: (
    "00100", "11110", "10110",
    "10111", "10101", "01111",
    "00111", "11100", "10000",
    "11001", "00010", "01010"
  );

def should_transform_binary_to_number:
  [0,1,1,0,0] | day3::binary_to_number | t::assert_that("transform bit array into base10 number" ; t::is(12));

def should_parse_binary:
  "01100" | day3::parse_binary | t::assert_that("parse binary string into bit array" ; t::is([0,1,1,0,0]));

def should_extract_gamma:
  [ test_input | day3::parse_binary ] | day3::gamma | t::assert_that("extract gamma value from input" ; t::is(22));

def should_extract_oxygen_value:
  [ test_input | day3::parse_binary ] | day3::oxygen | t::assert_that("extract o2 value from input" ; t::is(23));

def should_extract_carbon_dioxide_value:
  [ test_input | day3::parse_binary ] | day3::carbon_dioxide | t::assert_that("extract co2 value from input" ; t::is(10));

def should_find_most_common_digit:
  [[ test_input | day3::parse_binary ], 0] | day3::most_common_digit_in_position | (
    t::assert_that( "find most common digit in bit array" ; t::is(1))
  );

def run:
    t::run_tests([
        should_transform_binary_to_number,
        should_parse_binary,
        should_extract_gamma,
        should_find_most_common_digit,
        should_extract_oxygen_value,
        should_extract_carbon_dioxide_value
    ]);