import "testing" as t;
import "day_00" as day0;

def should_perform_fuel_calculation:
  14 | day0::fuel | t::assert_that("fuel required for 14 weight" ; t::is(2));

def should_create_list_of_require_weights_1:
  [ 14 ] | day0::required_weights | t::assert_that("recursive fuel for 14 weight" ; t::is([14, 2]));

def should_create_list_of_require_weights_2:
  [ 1969 ] | day0::required_weights | (
    t::assert_that("recursive fuel for 1969 weight" ; t::is([1969, 654, 216, 70, 21, 5]))
  );

def run:
  (
    should_perform_fuel_calculation,
    should_create_list_of_require_weights_1,
    should_create_list_of_require_weights_2
  );