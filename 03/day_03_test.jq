import "testing" as t;
import "day_03" as day3;

def test_input: (
    "00100", "11110", "10110",
    "10111", "10101", "01111",
    "00111", "11100", "10000",
    "11001", "00010", "01010"
  );

def should_transform_binary_to_number:
  [0,1,1,0,0] | day3::binary_to_number | t::assert_that( . ; t::is(12));

def should_parse_binary:
  "01100" | day3::parse_binary | t::assert_that( . ; t::is([0,1,1,0,0]));

def should_extract_gamma:
  [ test_input | day3::parse_binary ] | day3::gamma | t::assert_that( . ; t::is(22));

def run:
    (
        should_transform_binary_to_number,
        should_parse_binary,
        should_extract_gamma
    );