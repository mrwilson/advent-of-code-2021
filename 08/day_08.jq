def permutations:
  if length == 0 then [] else range(0;length) as $i | [.[$i]] + (del(.[$i])|permutations) end ;

# Map a permutation of "abcdefg" to a placement of wires using an array
#  1
# 0 2
#  3
# 4 6
#  5

def all_possible_wirings:
  [ "abcdefg" | split("") | permutations ] | map((
         [
         del(.[3]),
         [ .[2], .[6] ],
         del(.[0,6]),
         del(.[0,4]),
         del(.[1,4,5]),
         del(.[2,4]),
         del(.[2]),
         del(.[0,3,4,5]),
         .,
         del(.[4])
         ] | map(sort | join("")
      ) )
    ) ;

def parse_input:
  split(" | ") | { digits: (.[0] | split(" ")), display: (.[1] | split(" ")) } | map_values([.[] | split("") | sort | join("")]);


def known_digits_in_display:
  .display | map(length) | map(select(. == 2 or . == 3 or . ==4 or . == 7)) | length;

def part1:
  [ inputs | parse_input | known_digits_in_display ] | add;