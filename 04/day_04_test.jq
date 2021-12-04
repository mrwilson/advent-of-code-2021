import "testing" as t;
import "day_04" as day4;

def has_nth_board($player; $board):
  { match: (.[$player].board == $board), expected: $board, description: "has board" };

def test_input: (
    "7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1",
    "",
    "22 13 17 11  0",
    " 8  2 23  4 24",
    "21  9 14 16  7",
    " 6 10  3 18  5",
    " 1 12 20 15 19",
    "",
    " 3 15  0  2 22",
    " 9 18 13 17  5",
    "19  8  7 25 23",
    "20 11 10 24  4",
    "14 21 16 12  6",
    "",
    "14 21 17 24  4",
    "10 16 15  9 19",
    "18  8 23 26 20",
    "22 11 13  6  5",
    " 2  0 12  3  7"
  );

def should_extract_called_numbers:
  [ test_input ] | day4::called_numbers | ( t::assert_that( . ; t::is(
    [7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1]
  )));

def should_extract_boards:
  [ test_input ] | day4::boards | (
    t::assert_that( . ; t::has_length(3)),
    t::assert_that( . ; has_nth_board(0 ; [
        [22,13,17,11,0], [8,2,23,4,24], [21,9,14,16,7], [6,10,3,18,5], [1,12,20,15,19]
    ])),
    t::assert_that( . ; has_nth_board(1 ; [
        [3,15,0,2,22], [9,18,13,17,5], [19,8,7,25,23], [20,11,10,24,4], [14,21,16,12,6]
    ])),
    t::assert_that( . ; has_nth_board(2 ; [
        [14,21,17,24,4],[10,16,15,9,19],[18,8,23,26,20],[22,11,13,6,5],[2,0,12,3,7]
    ]))
  );

def run:
    (
        should_extract_called_numbers,
        should_extract_boards
    );